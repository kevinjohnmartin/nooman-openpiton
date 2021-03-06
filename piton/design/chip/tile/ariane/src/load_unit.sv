// Copyright 2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
//
// Author: Florian Zaruba    <zarubaf@iis.ee.ethz.ch>, ETH Zurich
//         Michael Schaffner <schaffner@iis.ee.ethz.ch>, ETH Zurich
// Date: 15.08.2018
// Description: Load Unit, takes care of all load requests

module load_unit import ariane_pkg::*; #(
    parameter ariane_pkg::ariane_cfg_t ArianeCfg = ariane_pkg::ArianeDefaultConfig
) (
    input  logic                     clk_i,    // Clock
    input  logic                     rst_ni,   // Asynchronous reset active low
    input  logic                     flush_i,
    // load unit input port
    input  logic                     valid_i,
    input  lsu_ctrl_t                lsu_ctrl_i,
    output logic                     pop_ld_o,
    // load unit output port
    output logic                     valid_o,
    output logic [TRANS_ID_BITS-1:0] trans_id_o,
    output logic [63:0]              result_o,
    output exception_t               ex_o,
    // MMU -> Address Translation
    output logic                     translation_req_o,   // request address translation
    output logic [riscv::VLEN-1:0]   vaddr_o,             // virtual address out
    input  logic [riscv::PLEN-1:0]   paddr_i,             // physical address in
    input  exception_t               ex_i,                // exception which may has happened earlier. for example: mis-aligned exception
    input  logic                     dtlb_hit_i,          // hit on the dtlb, send in the same cycle as the request
    // address checker
    output logic [11:0]              page_offset_o,
    input  logic                     page_offset_matches_i,
    input  logic                     store_buffer_empty_i, // the entire store-buffer is empty
    input  logic [TRANS_ID_BITS-1:0] commit_tran_id_i,
    // D$ interface
    input dcache_req_o_t             req_port_i,
    output dcache_req_i_t            req_port_o,
    input  logic                     dcache_wbuffer_empty_i
);
    /*enum logic [3:0] { IDLE, WAIT_GNT, SEND_TAG, WAIT_PAGE_OFFSET,
                       ABORT_TRANSACTION, ABORT_TRANSACTION_NC, WAIT_TRANSLATION, WAIT_FLUSH,
                       WAIT_WB_EMPTY
                     } state_d, state_q;
    */

    // -------- Printf ignore implementation -----------
    // Added one more state in the FSM = IGNORE_PRINTF
    enum logic [3:0] { IDLE, IGNORE_PRINTF, WAIT_GNT, SEND_TAG, WAIT_PAGE_OFFSET,
                       ABORT_TRANSACTION, ABORT_TRANSACTION_NC, WAIT_TRANSLATION, WAIT_FLUSH,
                       WAIT_WB_EMPTY
                     } state_d, state_q;
    // -------- End printf ignore implementation -----------

    // in order to decouple the response interface from the request interface we need a
    // a queue which can hold all outstanding memory requests
    struct packed {
        logic [TRANS_ID_BITS-1:0] trans_id;
        logic [2:0]               address_offset;
        fu_op                     operator;
    } load_data_d, load_data_q, in_data;

    // page offset is defined as the lower 12 bits, feed through for address checker
    assign page_offset_o = lsu_ctrl_i.vaddr[11:0];
    // feed-through the virtual address for VA translation
    assign vaddr_o = lsu_ctrl_i.vaddr;
    // this is a read-only interface so set the write enable to 0
    assign req_port_o.data_we = 1'b0;
    assign req_port_o.data_wdata = '0;
    // compose the queue data, control is handled in the FSM
    assign in_data = {lsu_ctrl_i.trans_id, lsu_ctrl_i.vaddr[2:0], lsu_ctrl_i.operator};
    // output address
    // we can now output the lower 12 bit as the index to the cache
    assign req_port_o.address_index = lsu_ctrl_i.vaddr[ariane_pkg::DCACHE_INDEX_WIDTH-1:0];
    // translation from last cycle, again: control is handled in the FSM
    assign req_port_o.address_tag   = paddr_i[ariane_pkg::DCACHE_TAG_WIDTH     +
                                              ariane_pkg::DCACHE_INDEX_WIDTH-1 :
                                              ariane_pkg::DCACHE_INDEX_WIDTH];
    // directly output an exception
    assign ex_o = ex_i;

    logic stall_nc;  // stall because of non-empty WB and address within non-cacheable region.
    // should we stall the request e.g.: is it withing a non-cacheable region
    // and the write buffer (in the cache and in the core) is not empty so that we don't forward anything
    // from the write buffer (e.g. it would essentially be cached).
    assign stall_nc = (~(dcache_wbuffer_empty_i | store_buffer_empty_i) & is_inside_cacheable_regions(ArianeCfg, paddr_i))
                    // this guards the load to be executed non-speculatively (we wait until our transaction id is on port 0
                    | (commit_tran_id_i != lsu_ctrl_i.trans_id & is_inside_nonidempotent_regions(ArianeCfg, paddr_i));

    // -------- Printf ignore implementation -----------
    // Created one intermediary signal, that is used to drive result_o. First, this signal replaces result_o in the 
    // 'result mux'. Second, the result_o is left to be set inside the FSM. By default it receives the value of 'result_o_partial'.
    // However, when a load in UART is detected, the FSM goes to the state IGNORE_PRINTF, and in this state, the result_o is set
    // with a value that I observed that was being provided by UART = 64'h000....00EF. But I belive that any value except zero will
    // work, since in sofware the while(!((*(uartAddr+5)) & 0x20)); of syscalls.c can be break.
    logic [63:0] result_o_partial;
    // -------- End printf ignore implementation -----------

    // ---------------
    // Load Control
    // ---------------
    always_comb begin : load_control
        // default assignments
        state_d              = state_q;
        load_data_d          = load_data_q;
        translation_req_o    = 1'b0;
        req_port_o.data_req  = 1'b0;
        // tag control
        req_port_o.kill_req  = 1'b0;
        req_port_o.tag_valid = 1'b0;
        req_port_o.data_be   = lsu_ctrl_i.be;
        req_port_o.data_size = extract_transfer_size(lsu_ctrl_i.operator);
        pop_ld_o             = 1'b0;
        result_o             = result_o_partial;

        case (state_q)
            IDLE: begin
                // we've got a new load request
                if (valid_i) begin
                    // -------- Printf ignore implementation -----------
                    if ((lsu_ctrl_i.vaddr == 64'h000000fff0c2c005) ) begin    
                        state_d = IGNORE_PRINTF;
                        translation_req_o = 1'b1;
                        pop_ld_o = 1'b1;
                    end else begin
                    // -------- End printf ignore implementation -----------
                        // start the translation process even though we do not know if the addresses match
                        // this should ease timing
                        translation_req_o = 1'b1;
                        // check if the page offset matches with a store, if it does then stall and wait
                        if (!page_offset_matches_i) begin
                            // make a load request to memory
                            req_port_o.data_req = 1'b1;
                            // we got no data grant so wait for the grant before sending the tag
                            if (!req_port_i.data_gnt) begin
                                state_d = WAIT_GNT;
                            end else begin
                                if (dtlb_hit_i && !stall_nc) begin
                                    // we got a grant and a hit on the DTLB so we can send the tag in the next cycle
                                    state_d = SEND_TAG;
                                    pop_ld_o = 1'b1;
                                // translation valid but this is to NC and the WB is not yet empty.
                                end else if (dtlb_hit_i && stall_nc) begin
                                    state_d = ABORT_TRANSACTION_NC;
                                end else begin
                                    state_d = ABORT_TRANSACTION;
                                end
                            end
                        end else begin
                            // wait for the store buffer to train and the page offset to not match anymore
                            state_d = WAIT_PAGE_OFFSET;
                        end
                    end // -------- Printf ignore implementation (remove this end when not using this printf ignore) -----------
                end
            end

            // -------- Printf ignore implementation -----------
            // As we don't want the load execute anything when a printf is detected, we just return to IDLE
            IGNORE_PRINTF: begin
                state_d = IDLE;
                result_o = 64'h00000000000000EF;//This results is breaking the while of syscall.c = while(!((*(uartAddr+5)) & 0x20));
            end
            // -------- End printf ignore implementation -----------

            // wait here for the page offset to not match anymore
            WAIT_PAGE_OFFSET: begin
                // we make a new request as soon as the page offset does not match anymore
                if (!page_offset_matches_i) begin
                    state_d = WAIT_GNT;
                end
            end

            // abort the previous request - free the D$ arbiter
            // we are here because of a TLB miss, we need to abort the current request and give way for the
            // PTW walker to satisfy the TLB miss
            ABORT_TRANSACTION, ABORT_TRANSACTION_NC: begin
                req_port_o.kill_req  = 1'b1;
                req_port_o.tag_valid = 1'b1;
                // either re-do the request or wait until the WB is empty (depending on where we came from).
                state_d = (state_q == ABORT_TRANSACTION_NC) ? WAIT_WB_EMPTY :  WAIT_TRANSLATION;
            end

            // Wait until the write-back buffer is empty in the data cache.
            WAIT_WB_EMPTY: begin
                // the write buffer is empty, so lets go and re-do the translation.
                if (dcache_wbuffer_empty_i) state_d = WAIT_TRANSLATION;
            end

            WAIT_TRANSLATION: begin
                translation_req_o = 1'b1;
                // we've got a hit and we can continue with the request process
                if (dtlb_hit_i)
                    state_d = WAIT_GNT;
            end

            WAIT_GNT: begin
                // keep the translation request up
                translation_req_o = 1'b1;
                // keep the request up
                req_port_o.data_req = 1'b1;
                // we finally got a data grant
                if (req_port_i.data_gnt) begin
                    // so we send the tag in the next cycle
                    if (dtlb_hit_i && !stall_nc) begin
                        state_d = SEND_TAG;
                        pop_ld_o = 1'b1;
                    // translation valid but this is to NC and the WB is not yet empty.
                    end else if (dtlb_hit_i && stall_nc) begin
                        state_d = ABORT_TRANSACTION_NC;
                    end else begin
                    // should we not have hit on the TLB abort this transaction an retry later
                        state_d = ABORT_TRANSACTION;
                    end
                end
                // otherwise we keep waiting on our grant
            end
            // we know for sure that the tag we want to send is valid
            SEND_TAG: begin
                req_port_o.tag_valid = 1'b1;
                state_d = IDLE;
                // we can make a new request here if we got one
                if (valid_i) begin
                    // start the translation process even though we do not know if the addresses match
                    // this should ease timing
                    translation_req_o = 1'b1;
                    // check if the page offset matches with a store, if it does stall and wait
                    if (!page_offset_matches_i) begin
                        // make a load request to memory
                        req_port_o.data_req = 1'b1;
                        // we got no data grant so wait for the grant before sending the tag
                        if (!req_port_i.data_gnt) begin
                            state_d = WAIT_GNT;
                        end else begin
                            // we got a grant so we can send the tag in the next cycle
                            if (dtlb_hit_i && !stall_nc) begin
                                // we got a grant and a hit on the DTLB so we can send the tag in the next cycle
                                state_d = SEND_TAG;
                                pop_ld_o = 1'b1;
                            // translation valid but this is to NC and the WB is not yet empty.
                            end else if (dtlb_hit_i && stall_nc) begin
                                state_d = ABORT_TRANSACTION_NC;
                            end else begin
                                state_d = ABORT_TRANSACTION;// we missed on the TLB -> wait for the translation
                            end
                        end
                    end else begin
                        // wait for the store buffer to train and the page offset to not match anymore
                        state_d = WAIT_PAGE_OFFSET;
                    end
                end
                // ----------
                // Exception
                // ----------
                // if we got an exception we need to kill the request immediately
                if (ex_i.valid) begin
                    req_port_o.kill_req = 1'b1;
                end
            end

            WAIT_FLUSH: begin
                // the D$ arbiter will take care of presenting this to the memory only in case we
                // have an outstanding request
                req_port_o.kill_req  = 1'b1;
                req_port_o.tag_valid = 1'b1;
                // we've killed the current request so we can go back to idle
                state_d = IDLE;
            end
        endcase

        // we got an exception
        if (ex_i.valid && valid_i) begin
            // the next state will be the idle state
            state_d = IDLE;
            // pop load - but only if we are not getting an rvalid in here - otherwise we will over-write an incoming transaction
            if (!req_port_i.data_rvalid)
                pop_ld_o = 1'b1;
        end

        // save the load data for later usage -> we should not clutter the load_data register
        if (pop_ld_o && !ex_i.valid) begin
            load_data_d = in_data;
        end

        // if we just flushed and the queue is not empty or we are getting an rvalid this cycle wait in a extra stage
        if (flush_i) begin
            state_d = WAIT_FLUSH;
        end
    end

    // ---------------
    // Retire Load
    // ---------------
    // decoupled rvalid process
    always_comb begin : rvalid_output
        valid_o = 1'b0;
        // -------- Printf ignore implementation -----------
        if (state_q == IGNORE_PRINTF) begin
            valid_o = 1'b1; //Set valid to 1, indicating that the load UART was done sucessifuly
            trans_id_o = load_data_q.trans_id; //This I are not sure if is needed but I kept since all load set it
        end else begin
            // -------- End printf ignore implementation -----------
            // output the queue data directly, the valid signal is set corresponding to the process above
            trans_id_o = load_data_q.trans_id;
            // we got an rvalid and are currently not flushing and not aborting the request
            if (req_port_i.data_rvalid && state_q != WAIT_FLUSH) begin
                // we killed the request
                if(!req_port_o.kill_req)
                    valid_o = 1'b1;
                // the output is also valid if we got an exception
                if (ex_i.valid)
                    valid_o = 1'b1;
            end
            // an exception occurred during translation (we need to check for the valid flag because we could also get an
            // exception from the store unit)
            // exceptions can retire out-of-order -> but we need to give priority to non-excepting load and stores
            // so we simply check if we got an rvalid if so we prioritize it by not retiring the exception - we simply go for another
            // round in the load FSM
            if (valid_i && ex_i.valid && !req_port_i.data_rvalid) begin
                valid_o    = 1'b1;
                trans_id_o = lsu_ctrl_i.trans_id;
            // if we are waiting for the translation to finish do not give a valid signal yet
            end else if (state_q == WAIT_TRANSLATION) begin
                valid_o = 1'b0;
            end
        end // -------- Printf ignore implementation ---------
    end


    // latch physical address for the tag cycle (one cycle after applying the index)
    always_ff @(posedge clk_i or negedge rst_ni) begin
        if (~rst_ni) begin
            state_q     <= IDLE;
            load_data_q <= '0;
        end else begin
            state_q     <= state_d;
            load_data_q <= load_data_d;
        end
    end

    // ---------------
    // Sign Extend
    // ---------------
    logic [63:0] shifted_data;

    // realign as needed
    assign shifted_data   = req_port_i.data_rdata >> {load_data_q.address_offset, 3'b000};

/*  // result mux (leaner code, but more logic stages.
    // can be used instead of the code below (in between //result mux fast) if timing is not so critical)
    always_comb begin
        unique case (load_data_q.operator)
            LWU:        result_o = shifted_data[31:0];
            LHU:        result_o = shifted_data[15:0];
            LBU:        result_o = shifted_data[7:0];
            LW:         result_o = 64'(signed'(shifted_data[31:0]));
            LH:         result_o = 64'(signed'(shifted_data[15:0]));
            LB:         result_o = 64'(signed'(shifted_data[ 7:0]));
            default:    result_o = shifted_data;
        endcase
    end  */

    // result mux fast
    logic [7:0]  sign_bits;
    logic [2:0]  idx_d, idx_q;
    logic        sign_bit, signed_d, signed_q, fp_sign_d, fp_sign_q;


    // prepare these signals for faster selection in the next cycle
    assign signed_d  = load_data_d.operator  inside {ariane_pkg::LW,  ariane_pkg::LH,  ariane_pkg::LB};
    assign fp_sign_d = load_data_d.operator  inside {ariane_pkg::FLW, ariane_pkg::FLH, ariane_pkg::FLB};
    assign idx_d     = (load_data_d.operator inside {ariane_pkg::LW,  ariane_pkg::FLW}) ? load_data_d.address_offset + 3 :
                       (load_data_d.operator inside {ariane_pkg::LH,  ariane_pkg::FLH}) ? load_data_d.address_offset + 1 :
                                                                                          load_data_d.address_offset;


    assign sign_bits = { req_port_i.data_rdata[63],
                         req_port_i.data_rdata[55],
                         req_port_i.data_rdata[47],
                         req_port_i.data_rdata[39],
                         req_port_i.data_rdata[31],
                         req_port_i.data_rdata[23],
                         req_port_i.data_rdata[15],
                         req_port_i.data_rdata[7]  };

    // select correct sign bit in parallel to result shifter above
    // pull to 0 if unsigned
    assign sign_bit       = signed_q & sign_bits[idx_q] | fp_sign_q;

    // result mux
    /*
    always_comb begin
        unique case (load_data_q.operator)
            ariane_pkg::LW, ariane_pkg::LWU, ariane_pkg::FLW:    result_o = {{32{sign_bit}}, shifted_data[31:0]};
            ariane_pkg::LH, ariane_pkg::LHU, ariane_pkg::FLH:    result_o = {{48{sign_bit}}, shifted_data[15:0]};
            ariane_pkg::LB, ariane_pkg::LBU, ariane_pkg::FLB:    result_o = {{56{sign_bit}}, shifted_data[7:0]};
            default:    result_o = shifted_data;
        endcase
    end*/
    // -------- Printf ignore implementation ---------
    // Replace the original mux (see commented code above), by this new one, that sets result_o_partial
    always_comb begin
        unique case (load_data_q.operator)
            ariane_pkg::LW, ariane_pkg::LWU, ariane_pkg::FLW:    result_o_partial = {{32{sign_bit}}, shifted_data[31:0]};
            ariane_pkg::LH, ariane_pkg::LHU, ariane_pkg::FLH:    result_o_partial = {{48{sign_bit}}, shifted_data[15:0]};
            ariane_pkg::LB, ariane_pkg::LBU, ariane_pkg::FLB:    result_o_partial = {{56{sign_bit}}, shifted_data[7:0]};
            default:    result_o_partial = shifted_data;
        endcase
    end
    // -------- End printf ignore implementation ---------

    always_ff @(posedge clk_i or negedge rst_ni) begin : p_regs
        if (~rst_ni) begin
            idx_q     <= 0;
            signed_q  <= 0;
            fp_sign_q <= 0;
        end else begin
            idx_q     <= idx_d;
            signed_q  <= signed_d;
            fp_sign_q <= fp_sign_d;
        end
    end
    // end result mux fast

///////////////////////////////////////////////////////
// assertions
///////////////////////////////////////////////////////

//pragma translate_off
`ifndef VERILATOR
    // check invalid offsets
    addr_offset0: assert property (@(posedge clk_i) disable iff (~rst_ni)
        valid_o |->  (load_data_q.operator inside {ariane_pkg::LW, ariane_pkg::LWU}) |-> load_data_q.address_offset < 5) else $fatal (1,"invalid address offset used with {LW, LWU}");
    addr_offset1: assert property (@(posedge clk_i) disable iff (~rst_ni)
        valid_o |->  (load_data_q.operator inside {ariane_pkg::LH, ariane_pkg::LHU}) |-> load_data_q.address_offset < 7) else $fatal (1,"invalid address offset used with {LH, LHU}");
    addr_offset2: assert property (@(posedge clk_i) disable iff (~rst_ni)
        valid_o |->  (load_data_q.operator inside {ariane_pkg::LB, ariane_pkg::LBU}) |-> load_data_q.address_offset < 8) else $fatal (1,"invalid address offset used with {LB, LBU}");
`endif
//pragma translate_on

endmodule
