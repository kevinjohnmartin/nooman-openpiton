// Modified by Princeton University on June 9th, 2015
// ========== Copyright Header Begin ==========================================
//
// OpenSPARC T1 Processor File: cmp_l15_messages_mon.v
// Copyright (c) 2006 Sun Microsystems, Inc.  All Rights Reserved.
// DO NOT ALTER OR REMOVE COPYRIGHT NOTICES.
//
// The above named program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public
// License version 2 as published by the Free Software Foundation.
//
// The above named program is distributed in the hope that it will be
// useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// General Public License for more details.
//
// You should have received a copy of the GNU General Public
// License along with this work; if not, write to the Free Software
// Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA.
//
// ========== Copyright Header End ============================================
////////////////////////////////////////////////////////

`include "sys.h"
`include "iop.h"
`include "define.tmp.h"
`include "cross_module.tmp.h"
`include "l15.tmp.h"

module cmp_l15_messages_mon (
    input wire clk
    );

reg [511:0] pcx;
reg [511:0] noc2;
reg [511:0] cpx;
reg [511:0] noc1;
reg [511:0] noc3;

reg [1:0] pcx_interrupt_type;
reg [13:0] pcx_interrupt_dst_chipid;
reg [7:0] pcx_interrupt_dst_y;
reg [7:0] pcx_interrupt_dst_x;
reg  pcx_interrupt_threadid;
reg [5:0] pcx_interrupt_vector;


// /home/ruaro/openpiton/piton/verif/env/manycore/devices_ariane.xml


task decode_predecode_reqtype;
input [`L15_REQTYPE_WIDTH-1:0] reqtype;
begin
    case (reqtype)
        `L15_REQTYPE_LOAD:
            $display("L15_REQTYPE_LOAD");
        `L15_REQTYPE_IFILL:
            $display("L15_REQTYPE_IFILL");
        `L15_REQTYPE_STORE:
            $display("L15_REQTYPE_STORE");
        `L15_REQTYPE_CAS:
            $display("L15_REQTYPE_CAS");
        `L15_REQTYPE_SWP_LOADSTUB:
            $display("L15_REQTYPE_SWP_LOADSTUB");
        `L15_REQTYPE_INVALIDATION:
            $display("L15_REQTYPE_INVALIDATION");
        `L15_REQTYPE_DOWNGRADE:
            $display("L15_REQTYPE_DOWNGRADE");
        `L15_REQTYPE_ACKDT_LD_NC:
            $display("L15_REQTYPE_ACKDT_LD_NC");
        `L15_REQTYPE_ACKDT_IFILL:
            $display("L15_REQTYPE_ACKDT_IFILL");
        `L15_REQTYPE_ACKDT_LD:
            $display("L15_REQTYPE_ACKDT_LD");
        `L15_REQTYPE_ACKDT_ST_IM:
            $display("L15_REQTYPE_ACKDT_ST_IM");
        `L15_REQTYPE_ACKDT_ST_SM:
            $display("L15_REQTYPE_ACKDT_ST_SM");
        `L15_REQTYPE_ACK_WRITETHROUGH:
            $display("L15_REQTYPE_ACK_WRITETHROUGH");
        `L15_REQTYPE_ACK_PREFETCH:
            $display("L15_REQTYPE_ACK_PREFETCH");
        `L15_REQTYPE_ACK_ATOMIC:
            $display("L15_REQTYPE_ACK_ATOMIC");
        `L15_REQTYPE_ICACHE_INVALIDATION:
            $display("L15_REQTYPE_ICACHE_INVALIDATION");
        `L15_REQTYPE_PCX_INTERRUPT:
            $display("L15_REQTYPE_PCX_INTERRUPT");
        `L15_REQTYPE_LOAD_NC:
            $display("L15_REQTYPE_LOAD_NC");
        `L15_REQTYPE_LOAD_PREFETCH:
            $display("L15_REQTYPE_LOAD_PREFETCH");
        `L15_REQTYPE_WRITETHROUGH:
            $display("L15_REQTYPE_WRITETHROUGH");
        `L15_REQTYPE_L2_INTERRUPT:
            $display("L15_REQTYPE_L2_INTERRUPT");
        `L15_REQTYPE_IGNORE:
            $display("L15_REQTYPE_IGNORE");
        `L15_REQTYPE_INT_VEC_DIS:
            $display("L15_REQTYPE_INT_VEC_DIS");
        `L15_REQTYPE_WRITE_CONFIG_REG:
            $display("L15_REQTYPE_WRITE_CONFIG_REG");
        `L15_REQTYPE_LOAD_CONFIG_REG:
            $display("L15_REQTYPE_LOAD_CONFIG_REG");
        `L15_REQTYPE_DIAG_LOAD:
            $display("L15_REQTYPE_DIAG_LOAD");
        `L15_REQTYPE_DIAG_STORE:
            $display("L15_REQTYPE_DIAG_STORE");
        `L15_REQTYPE_LINE_FLUSH:
            $display("L15_REQTYPE_LINE_FLUSH");
        `L15_REQTYPE_HMC_FILL:
            $display("L15_REQTYPE_HMC_FILL");
        `L15_REQTYPE_HMC_DIAG_LOAD:
            $display("L15_REQTYPE_HMC_DIAG_LOAD");
        `L15_REQTYPE_HMC_DIAG_STORE:
            $display("L15_REQTYPE_HMC_DIAG_STORE");
        `L15_REQTYPE_HMC_FLUSH:
            $display("L15_REQTYPE_HMC_FLUSH");
        `L15_REQTYPE_ICACHE_SELF_INVALIDATION:
            $display("L15_REQTYPE_ICACHE_SELF_INVALIDATION");
        `L15_REQTYPE_DCACHE_SELF_INVALIDATION:
            $display("L15_REQTYPE_DCACHE_SELF_INVALIDATION");
        `L15_REQTYPE_AMO_LR:
            $display("L15_REQTYPE_AMO_LR");
        `L15_REQTYPE_AMO_SC:
            $display("L15_REQTYPE_AMO_SC");
        `L15_REQTYPE_AMO_ADD:
            $display("L15_REQTYPE_AMO_ADD");
        `L15_REQTYPE_AMO_AND:
            $display("L15_REQTYPE_AMO_AND");
        `L15_REQTYPE_AMO_OR:
            $display("L15_REQTYPE_AMO_OR");
        `L15_REQTYPE_AMO_XOR:
            $display("L15_REQTYPE_AMO_XOR");
        `L15_REQTYPE_AMO_MAX:
            $display("L15_REQTYPE_AMO_MAX");
        `L15_REQTYPE_AMO_MAXU:
            $display("L15_REQTYPE_AMO_MAXU");
        `L15_REQTYPE_AMO_MIN:
            $display("L15_REQTYPE_AMO_MIN");
        `L15_REQTYPE_AMO_MINU:
            $display("L15_REQTYPE_AMO_MINU");
        `L15_REQTYPE_ACKDT_LR:
            $display("L15_REQTYPE_ACKDT_LR");    
        default:
            $display("UNKNOWN_ERROR_OPERATION");
    endcase
end
endtask

// task decode_dcache_op;
// input [`L15_DCACHE_OP_WIDTH-1:0] op;
// begin
//     case (op)
//         `L15_DCACHE_READ_TAGCHECK_WAY_IF_M:
//             $display("L15_DCACHE_READ_TAGCHECK_WAY_IF_M");
//         `L15_DCACHE_READ_TAGCHECK_WAY_IF_MES:
//             $display("L15_DCACHE_READ_TAGCHECK_WAY_IF_MES");
//         `L15_DCACHE_READ_LRU_WAY_IF_M:
//             $display("L15_DCACHE_READ_LRU_WAY_IF_M");
//         `L15_DCACHE_WRITE_TAGCHECK_WAY_IF_ME_FROM_MSHR:
//             $display("L15_DCACHE_WRITE_TAGCHECK_WAY_IF_ME_FROM_MSHR");
//         `L15_DCACHE_WRITE_LRU_WAY_FROM_NOC2:
//             $display("L15_DCACHE_WRITE_LRU_WAY_FROM_NOC2");
//         `L15_DCACHE_WRITE_LRU_WAY_FROM_NOC2_AND_MSHR:
//             $display("L15_DCACHE_WRITE_LRU_WAY_FROM_NOC2_AND_MSHR");
//         `L15_DCACHE_WRITE_MSHR_WAY_FROM_MSHR:
//             $display("L15_DCACHE_WRITE_MSHR_WAY_FROM_MSHR");
//         default:
//             $display("");
//     endcase
// end
// endtask

// task decode_s3mesi_op;
// input [`L15_S3_MESI_OP_WIDTH-1:0] op;
// begin
//     case (op)
//         `L15_S3_MESI_INVALIDATE_TAGCHECK_WAY_IF_MES:
//             $display("L15_S3_MESI_INVALIDATE_TAGCHECK_WAY_IF_MES");
//         `L15_S3_MESI_WRITE_TAGCHECK_WAY_S_IF_ME:
//             $display("L15_S3_MESI_WRITE_TAGCHECK_WAY_S_IF_ME");
//         `L15_S3_MESI_WRITE_TAGCHECK_WAY_M_IF_E:
//             $display("L15_S3_MESI_WRITE_TAGCHECK_WAY_M_IF_E");
//         `L15_S3_MESI_WRITE_LRU_WAY_ACK_STATE:
//             $display("L15_S3_MESI_WRITE_LRU_WAY_ACK_STATE");
//         default:
//             $display("");
//     endcase
// end
// endtask

// task decode_wmc_read_op;
// input [`L15_WMC_OP_WIDTH-1:0] op;
// begin
//     case (op)
//         `L15_WMC_READ_TAGCHECK_WAY_IF_MES_AND_DEMAP_ENTRY:
//             $display("L15_WMC_READ_TAGCHECK_WAY_IF_MES_AND_DEMAP_ENTRY");
//         `L15_WMC_READ_TAGCHECK_WAY_IF_MES:
//             $display("L15_WMC_READ_TAGCHECK_WAY_IF_MES");
//         `L15_WMC_READ_MSHR_WAY:
//             $display("L15_WMC_READ_MSHR_WAY");
//         `L15_WMC_READ_LRU_WAY_IF_MES_AND_DEMAP_ENTRY:
//             $display("L15_WMC_READ_LRU_WAY_IF_MES_AND_DEMAP_ENTRY");
//         `L15_WMC_WRITE_LRU_WAY_L1_REPL_AND_DEMAP_ENTRY:
//             $display("L15_WMC_WRITE_LRU_WAY_L1_REPL_AND_DEMAP_ENTRY");
//         `L15_WMC_WRITE_TAGCHECK_WAY_L1_REPL_IF_TAGCHECK_MES_AND_DEMAP_ENTRY:
//             $display("L15_WMC_WRITE_TAGCHECK_WAY_L1_REPL_IF_TAGCHECK_MES_AND_DEMAP_ENTRY");
//         default:
//             $display("");
//     endcase
// end
// endtask

// task decode_wmc_write_op;
// input [`L15_WMC_OP_WIDTH-1:0] op;
// begin
//     case (op)
//         `L15_WMC_READ_TAGCHECK_WAY_IF_MES_AND_DEMAP_ENTRY:
//             $display("L15_WMC_READ_TAGCHECK_WAY_IF_MES_AND_DEMAP_ENTRY");
//         `L15_WMC_READ_TAGCHECK_WAY_IF_MES:
//             $display("L15_WMC_READ_TAGCHECK_WAY_IF_MES");
//         `L15_WMC_READ_MSHR_WAY:
//             $display("L15_WMC_READ_MSHR_WAY");
//         `L15_WMC_READ_LRU_WAY_IF_MES_AND_DEMAP_ENTRY:
//             $display("L15_WMC_READ_LRU_WAY_IF_MES_AND_DEMAP_ENTRY");
//         `L15_WMC_WRITE_LRU_WAY_L1_REPL_AND_DEMAP_ENTRY:
//             $display("L15_WMC_WRITE_LRU_WAY_L1_REPL_AND_DEMAP_ENTRY");
//         `L15_WMC_WRITE_TAGCHECK_WAY_L1_REPL_IF_TAGCHECK_MES_AND_DEMAP_ENTRY:
//             $display("L15_WMC_WRITE_TAGCHECK_WAY_L1_REPL_IF_TAGCHECK_MES_AND_DEMAP_ENTRY");
//         default:
//             $display("");
//     endcase
// end
// endtask

task decode_s3mshr_op;
input [`L15_S3_MESI_OP_WIDTH-1:0] op;
begin
    case (op)
        `L15_S3_MSHR_OP_DEALLOCATION:
            $display("L15_S3_MSHR_OP_DEALLOCATION");
        `L15_S3_MSHR_OP_DEALLOCATION_IF_TAGCHECK_MES:
            $display("L15_S3_MSHR_OP_DEALLOCATION_IF_TAGCHECK_MES");
        `L15_S3_MSHR_OP_DEALLOCATION_IF_TAGCHECK_M_E_ELSE_UPDATE_STATE_STMSHR:
            $display("L15_S3_MSHR_OP_DEALLOCATION_IF_TAGCHECK_M_E_ELSE_UPDATE_STATE_STMSHR");
        `L15_S3_MSHR_OP_UPDATE_ST_MSHR_IM_IF_INDEX_TAGCHECK_WAY_MATCHES:
            $display("L15_S3_MSHR_OP_UPDATE_ST_MSHR_IM_IF_INDEX_TAGCHECK_WAY_MATCHES");
        `L15_S3_MSHR_OP_UPDATE_ST_MSHR_IM_IF_INDEX_LRU_WAY_MATCHES:
            $display("L15_S3_MSHR_OP_UPDATE_ST_MSHR_IM_IF_INDEX_LRU_WAY_MATCHES");
        default:
            $display("");
    endcase
end
endtask

task decode_pcx_op;
input [`PCX_REQTYPE_WIDTH-1:0] op;
input [`L15_AMO_OP_WIDTH-1:0] amo_op;
begin
    case (op)
        `PCX_REQTYPE_LOAD:
            $write("PCX_REQTYPE_LOAD");
        `PCX_REQTYPE_IFILL:
            $write("PCX_REQTYPE_IFILL");
        `PCX_REQTYPE_STORE:
            $write("PCX_REQTYPE_STORE");
        `PCX_REQTYPE_AMO:
            case (amo_op)
                `L15_AMO_OP_LR:
                    $write("PCX_REQTYPE_AMO - L15_AMO_OP_LR");
                `L15_AMO_OP_SC:
                    $write("PCX_REQTYPE_AMO - L15_AMO_OP_SC");
                `L15_AMO_OP_SWAP:
                    $write("PCX_REQTYPE_AMO - L15_AMO_OP_SWAP");
                `L15_AMO_OP_ADD:
                    $write("PCX_REQTYPE_AMO - L15_AMO_OP_ADD");
                `L15_AMO_OP_AND:
                    $write("PCX_REQTYPE_AMO - L15_AMO_OP_AND");
                `L15_AMO_OP_OR:
                    $write("PCX_REQTYPE_AMO - L15_AMO_OP_OR");
                `L15_AMO_OP_XOR:
                    $write("PCX_REQTYPE_AMO - L15_AMO_OP_XOR");
                `L15_AMO_OP_MAX:
                    $write("PCX_REQTYPE_AMO - L15_AMO_OP_MAX");
                `L15_AMO_OP_MAXU:
                    $write("PCX_REQTYPE_AMO - L15_AMO_OP_MAXU");
                `L15_AMO_OP_MIN:
                    $write("PCX_REQTYPE_AMO - L15_AMO_OP_MIN");
                `L15_AMO_OP_MINU:
                    $write("PCX_REQTYPE_AMO - L15_AMO_OP_MINU");
                `L15_AMO_OP_CAS1:
                    $write("PCX_REQTYPE_AMO - L15_AMO_OP_CAS1");
                `L15_AMO_OP_CAS2:
                    $write("PCX_REQTYPE_AMO - L15_AMO_OP_CAS2");
            endcase
        //`PCX_REQTYPE_CAS1:
        //    $write("PCX_REQTYPE_CAS1");
        //`PCX_REQTYPE_CAS2:
        //    $write("PCX_REQTYPE_CAS2");
        //`PCX_REQTYPE_SWP_LOADSTUB:
        //    $write("PCX_REQTYPE_SWP_LOADSTUB");
        `PCX_REQTYPE_INTERRUPT:
            $write("PCX_REQTYPE_INTERRUPT");
        `PCX_REQTYPE_FP1:
            $write("PCX_REQTYPE_FP1");
        `PCX_REQTYPE_FP2:
            $write("PCX_REQTYPE_FP2");
        `PCX_REQTYPE_STREAM_LOAD:
            $write("PCX_REQTYPE_STREAM_LOAD");
        `PCX_REQTYPE_STREAM_STORE:
            $write("PCX_REQTYPE_STREAM_STORE");
        `PCX_REQTYPE_FWD_REQ:
            $write("PCX_REQTYPE_FWD_REQ");
        `PCX_REQTYPE_FWD_REPLY:
            $write("PCX_REQTYPE_FWD_REPLY");
        default:
            $write("PCX_UNKNOWN");
    endcase
end
endtask

integer i;


// CORE0

reg do_print_stage_TILE0;
integer i_TILE0;
wire [63:0] dtag_tag_way0_s2_TILE0;
wire [63:0] dtag_tag_way1_s2_TILE0;
wire [63:0] dtag_tag_way2_s2_TILE0;
wire [63:0] dtag_tag_way3_s2_TILE0;

assign dtag_tag_way0_s2_TILE0 = (`L15_PIPE0.dtag_tag_way0_s2 << 11);
assign dtag_tag_way1_s2_TILE0 = (`L15_PIPE0.dtag_tag_way1_s2 << 11);
assign dtag_tag_way2_s2_TILE0 = (`L15_PIPE0.dtag_tag_way2_s2 << 11);
assign dtag_tag_way3_s2_TILE0 = (`L15_PIPE0.dtag_tag_way3_s2 << 11);
reg [`L15_CACHE_TAG_WIDTH-1:0] tag_data_TILE0 [0:3];
reg [3:0] tag_val_TILE0;
reg [`L15_WMT_ENTRY_MASK] wmt_read_data_TILE0 [0:3];
integer j_TILE0;
reg is_csm_mshrid_TILE0;

reg wmt_read_val_s3_TILE0;
always @ (posedge clk)
    wmt_read_val_s3_TILE0 <= `L15_PIPE0.l15_wmt_read_val_s2;

always @ (negedge clk)
begin
    if(!$test$plusargs("disable_l15_mon"))
    begin

    // monitoring outgoing noc1/noc3 messages
    if (`L15_TOP0.noc1encoder.sending)
    begin
        $display($time);
        $display("TILE0 noc1 flit raw: 0x%x", `L15_TOP0.noc1encoder.flit);
        $display("   srcX: %d, srcY: %d", `L15_TOP0.noc1encoder.msg_src_xpos, `L15_TOP0.noc1encoder.msg_src_ypos);
        $display("   destX: %d, destY: %d", `L15_TOP0.noc1encoder.msg_dest_l2_xpos, `L15_TOP0.noc1encoder.msg_dest_l2_ypos);
        if ( ^`L15_TOP0.noc1encoder.flit === 1'bx)
        begin
            $display("%d : Simulation -> FAIL(TILE0 noc1 sends X data 0x%x)", $time, `L15_TOP0.noc1encoder.flit);
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("l15_mon: TILE0 noc1 sends X data");
        end

    end




    if (`L15_PIPE0.pcxdecoder_l15_val && `L15_PIPE0.val_s1 && !`L15_PIPE0.stall_s1 && !`L15_PIPE0.noc2decoder_l15_val
        && `L15_PIPE0.fetch_state_s1 == `L15_FETCH_STATE_NORMAL)
    begin
        $write("%0d TILE0 L1.5 th%d: Received PCX ", $time, `L15_PIPE0.pcxdecoder_l15_threadid); decode_pcx_op(`L15_PIPE0.pcxdecoder_l15_rqtype, `L15_PIPE0.pcxdecoder_l15_amo_op);
        $display("   Addr 0x%x, nc %d, size %d, invalall %d, pf %d, bs %d, bsi %d, l1way %d",
                                `L15_PIPE0.pcxdecoder_l15_address, `L15_PIPE0.pcxdecoder_l15_nc, `L15_PIPE0.pcxdecoder_l15_size, `L15_PIPE0.pcxdecoder_l15_invalidate_cacheline,
                                `L15_PIPE0.pcxdecoder_l15_prefetch, `L15_PIPE0.pcxdecoder_l15_blockstore, `L15_PIPE0.pcxdecoder_l15_blockinitstore, `L15_PIPE0.pcxdecoder_l15_l1rplway);
        $display("   Data: 0x%x", `L15_PIPE0.pcxdecoder_l15_data);
        if (`L15_PIPE0.pcxdecoder_l15_csm_data[`TLB_CSM_STATE] == `TLB_CSM_STATE_LOCAL)
        begin
            $display("   CSM HDID: %d, HD_SIZE: %d, SDID: %d, LSID: %d", `L15_PIPE0.pcxdecoder_l15_csm_data[`TLB_CSM_HDID], `L15_PIPE0.pcxdecoder_l15_csm_data[`TLB_CSM_HD_SIZE],
            `L15_PIPE0.pcxdecoder_l15_csm_data[`TLB_CSM_SDID], `L15_PIPE0.pcxdecoder_l15_csm_data[`TLB_CSM_LSID]);
        end
        else if (`L15_PIPE0.pcxdecoder_l15_csm_data[`TLB_CSM_STATE] == `TLB_CSM_STATE_GLOBAL)
        begin
            $display("   CSM CHIPID: %d, X: %d, Y: %d", `L15_PIPE0.pcxdecoder_l15_csm_data[`TLB_CSM_CHIPID], `L15_PIPE0.pcxdecoder_l15_csm_data[`TLB_CSM_X],`L15_PIPE0.pcxdecoder_l15_csm_data[`TLB_CSM_Y]);
        end
        $display("   CSM Data: 0x%x", `L15_PIPE0.pcxdecoder_l15_csm_data);
        /*
        if (noc2decoder_l15_reqtype == `PCX_REQTYPE_STORE)
        if (noc2decoder_l15_reqtype == `PCX_REQTYPE_CAS1)
        begin
        $display("   Cmp.data: 0x%x", `L15_PIPE0.pcxdecoder_l15_data);
        $display("   Swp.data: 0x%x", `L15_PIPE0.pcxdecoder_l15_data_next_entry);
        end
        if (noc2decoder_l15_reqtype == `PCX_REQTYPE_SWP_LOADSTUB)
        begin
        $display("   Swp.data: 0x%x", `L15_PIPE0.pcxdecoder_l15_data);
        end
        */
        if (`L15_PIPE0.pcxdecoder_l15_rqtype == `PCX_REQTYPE_INTERRUPT && `L15_PIPE0.pcxdecoder_l15_data[63] == 1'b0)
        begin
            pcx_interrupt_type = `L15_PIPE0.pcxdecoder_l15_data[17:16];
            pcx_interrupt_dst_chipid = `L15_PIPE0.pcxdecoder_l15_data[31:18];
            pcx_interrupt_dst_y = `L15_PIPE0.pcxdecoder_l15_data[14:12];
            pcx_interrupt_dst_x = `L15_PIPE0.pcxdecoder_l15_data[11:9];
            pcx_interrupt_threadid = `L15_PIPE0.pcxdecoder_l15_data[8];
            pcx_interrupt_vector = `L15_PIPE0.pcxdecoder_l15_data[5:0];
            $display("Interrupt info:");
            $write("    Type: ");
            case(pcx_interrupt_type)
                2'b00:
                    $display("hw int");
                2'b01:
                    $display("reset");
                2'b10:
                    $display("idle");
                2'b11:
                    $display("resume");
            endcase

            $display("    Dst CHIP ID: %d", pcx_interrupt_dst_chipid);
            $display("    Dst X: %d", pcx_interrupt_dst_x);
            $display("    Dst Y: %d", pcx_interrupt_dst_y);
            $display("    Thread ID: %d", pcx_interrupt_threadid);
            $display("    Vector: %d", pcx_interrupt_vector);
        end
    end

    if (`L15_PIPE0.noc2decoder_l15_val && `L15_PIPE0.val_s1 && !`L15_PIPE0.stall_s1)
    begin
        noc2 = 0;
        case(`L15_PIPE0.noc2decoder_l15_reqtype)
        `MSG_TYPE_RESERVED:
            noc2 = "MSG_TYPE_RESERVED";
        `MSG_TYPE_LOAD_FWD:
            noc2 = "MSG_TYPE_LOAD_FWD";
        `MSG_TYPE_STORE_FWD:
            noc2 = "MSG_TYPE_STORE_FWD";
        `MSG_TYPE_INV_FWD:
            noc2 = "MSG_TYPE_INV_FWD";
        `MSG_TYPE_NODATA_ACK:
            noc2 = "MSG_TYPE_NODATA_ACK";
        `MSG_TYPE_DATA_ACK:
            noc2 = "MSG_TYPE_DATA_ACK";
        `MSG_TYPE_NC_LOAD_MEM_ACK:
            noc2 = "MSG_TYPE_NC_LOAD_MEM_ACK";
        `MSG_TYPE_NC_STORE_MEM_ACK:
            noc2 = "MSG_TYPE_NC_STORE_MEM_ACK";
        `MSG_TYPE_INTERRUPT:
            noc2 = "MSG_TYPE_L2_INTERRUPT";
        default:
        begin
            noc2 = "MSG_TYPE_UNKNOWN_ERROR";
            $display("%d : Simulation -> FAIL(%0s)", $time, "L15 mon: error message type from L2");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("L15 mon: error message type from L2");
        end
        endcase

        $write("%0d TILE0 L1.5: Received NOC2 %s", $time, noc2);
        $display("   mshrid %d, l2miss %d, f4b %d, ackstate %d, address 0x%x",
                    `L15_PIPE0.noc2decoder_l15_mshrid, `L15_PIPE0.noc2decoder_l15_l2miss, `L15_PIPE0.noc2decoder_l15_f4b,
                    `L15_PIPE0.noc2decoder_l15_ack_state, `L15_PIPE0.noc2decoder_l15_address);
        $display("   Data1: 0x%x", `L15_PIPE0.noc2decoder_l15_data_0);
        $display("   Data2: 0x%x", `L15_PIPE0.noc2decoder_l15_data_1);
        $display("   Data3: 0x%x", `L15_PIPE0.noc2decoder_l15_data_2);
        $display("   Data4: 0x%x", `L15_PIPE0.noc2decoder_l15_data_3);
    end

    if (`L15_PIPE0.l15_cpxencoder_val && !`L15_PIPE0.stall_s3)
    begin
        cpx = 0;
        case(`L15_PIPE0.l15_cpxencoder_returntype)
            `LOAD_RET:
                cpx = "LOAD_RET";
            `INV_RET:
                cpx = "INV_RET";
            `ST_ACK:
                cpx = "ST_ACK";
            `AT_ACK:
                cpx = "AT_ACK";
            `INT_RET:
                cpx = "INT_RET";
            `TEST_RET:
                cpx = "TEST_RET";
            `FP_RET:
                cpx = "FP_RET";
            `IFILL_RET:
                cpx = "IFILL_RET";
            `EVICT_REQ:
                cpx = "EVICT_REQ";
            `ERR_RET:
                cpx = "ERR_RET";
            `STRLOAD_RET:
                cpx = "STRLOAD_RET";
            `STRST_ACK:
                cpx = "STRST_ACK";
            `FWD_RQ_RET:
                cpx = "FWD_RQ_RET";
            `FWD_RPY_RET:
                cpx = "FWD_RPY_RET";
            `RSVD_RET:
                cpx = "RSVD_RET";
            4'b1110:
                cpx = "ATOMIC_ACK";
            default:
                cpx = "CPX_UNKNOWN";
        endcase
        $write("%0d TILE0 L1.5 th%d: Sent CPX %0s", $time, `L15_PIPE0.l15_cpxencoder_threadid, cpx);
        $display("   l2miss %d, nc %d, atomic %d, threadid %d, pf %d, f4b %d, iia %d, dia %d, dinval %d, iinval %d, invalway %d, blkinit %d",
                    `L15_PIPE0.l15_cpxencoder_l2miss, `L15_PIPE0.l15_cpxencoder_noncacheable, `L15_PIPE0.l15_cpxencoder_atomic,
                    `L15_PIPE0.l15_cpxencoder_threadid, `L15_PIPE0.l15_cpxencoder_prefetch,
                    `L15_PIPE0.l15_cpxencoder_f4b, `L15_PIPE0.l15_cpxencoder_inval_icache_all_way,
                    `L15_PIPE0.l15_cpxencoder_inval_dcache_all_way, `L15_PIPE0.l15_cpxencoder_inval_dcache_inval,
                    `L15_PIPE0.l15_cpxencoder_inval_icache_inval, `L15_PIPE0.l15_cpxencoder_inval_way,
                    `L15_PIPE0.l15_cpxencoder_blockinitstore);
        $display("   Data0: 0x%x", `L15_PIPE0.l15_cpxencoder_data_0);
        $display("   Data1: 0x%x", `L15_PIPE0.l15_cpxencoder_data_1);
        $display("   Data2: 0x%x", `L15_PIPE0.l15_cpxencoder_data_2);
        $display("   Data3: 0x%x", `L15_PIPE0.l15_cpxencoder_data_3);
    end

    if (`L15_TOP0.noc1encoder.noc1encoder_noc1out_val && `L15_TOP0.noc1encoder.noc1encoder_noc1buffer_req_ack)
    begin
        noc1 = 0;
        case(`L15_TOP0.noc1encoder.req_type)
        `L15_NOC1_REQTYPE_WRITEBACK_GUARD:
            noc1 = "L15_NOC1_REQTYPE_WRITEBACK_GUARD";
        `L15_NOC1_REQTYPE_LD_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_LD_REQUEST";
        `L15_NOC1_REQTYPE_IFILL_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_IFILL_REQUEST";
        `L15_NOC1_REQTYPE_WRITETHROUGH_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_WRITETHROUGH_REQUEST";
        `L15_NOC1_REQTYPE_ST_UPGRADE_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_ST_UPGRADE_REQUEST";
        `L15_NOC1_REQTYPE_ST_FILL_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_ST_FILL_REQUEST";
        `L15_NOC1_REQTYPE_CAS_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_CAS_REQUEST";
        `L15_NOC1_REQTYPE_SWAP_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_SWAP_REQUEST";
        `L15_NOC1_REQTYPE_INTERRUPT_FWD:
            noc1 = "L15_NOC1_REQTYPE_INTERRUPT_FWD";
        `L15_NOC1_REQTYPE_AMO_ADD_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_ADD_REQUEST";
        `L15_NOC1_REQTYPE_AMO_AND_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_AND_REQUEST";
        `L15_NOC1_REQTYPE_AMO_OR_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_OR_REQUEST";
        `L15_NOC1_REQTYPE_AMO_XOR_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_XOR_REQUEST";
        `L15_NOC1_REQTYPE_AMO_MAX_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_MAX_REQUEST";
        `L15_NOC1_REQTYPE_AMO_MAXU_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_MAXU_REQUEST";
        `L15_NOC1_REQTYPE_AMO_MIN_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_MIN_REQUEST";
        `L15_NOC1_REQTYPE_AMO_MINU_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_MINU_REQUEST";
        default:
            noc1 = "ERROR noc1";
        endcase

        $write("%0d TILE0 L1.5: Sending NOC1 %s", $time, noc1);
        $display("   mshrid %d, nc %d, size %d, pf %d, address %0x",
                    `L15_TOP0.noc1encoder.noc1buffer_noc1encoder_req_mshrid, `L15_TOP0.noc1encoder.noc1buffer_noc1encoder_req_non_cacheable,
                    `L15_TOP0.noc1encoder.noc1buffer_noc1encoder_req_size, `L15_TOP0.noc1encoder.noc1buffer_noc1encoder_req_prefetch, `L15_TOP0.noc1encoder.noc1buffer_noc1encoder_req_address);
        $display("   Data0: 0x%x", `L15_TOP0.noc1encoder.noc1buffer_noc1encoder_req_data_0);
        $display("   Data1: 0x%x", `L15_TOP0.noc1encoder.noc1buffer_noc1encoder_req_data_1);
        $display("   Destination X: %d Y: %d", `L15_TOP0.noc1encoder.msg_dest_l2_xpos, `L15_TOP0.noc1encoder.msg_dest_l2_ypos);
    end

    if (`L15_TOP0.noc3encoder.noc3encoder_noc3out_val && `L15_TOP0.noc3encoder.noc3encoder_l15_req_ack)
    begin
        noc3 = 0;
        case(`L15_TOP0.noc3encoder.l15_noc3encoder_req_type)
        `L15_NOC3_REQTYPE_WRITEBACK:
            noc3 = "L15_NOC3_REQTYPE_WRITEBACK";
        `L15_NOC3_REQTYPE_INVAL_ACK:
            noc3 = "L15_NOC3_REQTYPE_INVAL_ACK";
        `L15_NOC3_REQTYPE_DOWNGRADE_ACK:
            noc3 = "L15_NOC3_REQTYPE_DOWNGRADE_ACK";
        `L15_NOC3_REQTYPE_ICACHE_INVAL_ACK:
            noc3 = "L15_NOC3_REQTYPE_ICACHE_INVAL_ACK";
        default:
            noc3 = "ERROR NOC3";
        endcase

        // quick check for an error case
        if (`L15_TOP0.noc3encoder.msg_type == `MSG_TYPE_INV_FWDACK
            && `L15_TOP0.noc3encoder.l15_noc3encoder_req_with_data)
        begin
            $display("L1.5 MON: sending back invalid ack with data");
            $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: sending back invalid ack with data");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("L1.5 MON: sending back invalid ack with data");
        end


        $write("%0d TILE0 L1.5: Sent NOC3 %s", $time, noc3);
        $display("   mshrid %d, seqid %d, address %0x",
                    `L15_TOP0.noc3encoder.l15_noc3encoder_req_mshrid, `L15_TOP0.noc3encoder.l15_noc3encoder_req_sequenceid, `L15_TOP0.noc3encoder.l15_noc3encoder_req_address);
        $display("   srcX: %d, srcY: %d", `L15_TOP0.noc3encoder.src_l2_xpos, `L15_TOP0.noc3encoder.src_l2_ypos);
        $display("   destX: %d, destY: %d", `L15_TOP0.noc3encoder.dest_l2_xpos, `L15_TOP0.noc3encoder.dest_l2_ypos);
        $display("   Data0: 0x%x", `L15_TOP0.noc3encoder.l15_noc3encoder_req_data_0);
        $display("   Data1: 0x%x", `L15_TOP0.noc3encoder.l15_noc3encoder_req_data_1);
    end

    do_print_stage_TILE0 = ((`L15_PIPE0.val_s1 && !`L15_PIPE0.stall_s1) || (`L15_PIPE0.val_s2 && !`L15_PIPE0.stall_s2) || (`L15_PIPE0.val_s3 && !`L15_PIPE0.stall_s3));
    if (do_print_stage_TILE0)
    begin
        // $display("");
        $display("");
        $display($time, " L15 TILE0:");
        $display("NoC1 credit: %d", `L15_PIPE0.creditman_noc1_avail);
        $display("NoC1 reserved credit: %d", `L15_PIPE0.creditman_noc1_reserve);
        // $display("NoC1 r down: %d", `L15_PIPE0.creditman_noc1_reserve_minus1);
        // $display("NoC1 r up: %d", `L15_PIPE0.creditman_noc1_reserve_add1);

        // monitor the MSHRID allocation
        // $display("MSHRID allocation info:");
        // for (i_TILE0 = 0; i_TILE0 < `L15_MSHR_COUNT; i_TILE0 = i_TILE0 + 1)
        //     $write("%d:%d", i_TILE0, `L15_PIPE0.mshr_val_array[i_TILE0]);
            // $write("%d %d", i_TILE0, i_TILE0);
        // $display("");

`ifdef RTL_SPARC0
        $display("Core STB info:");
        $display("  STB0: %d", `SPARC_CORE0.sparc0.ifu.lsu_ifu_stbcnt0);
        $display("  STB1: %d", `SPARC_CORE0.sparc0.ifu.lsu_ifu_stbcnt1);
            // $write("%d %d", i_TILE0, i_TILE0);
`endif

        $write("TILE0 Pipeline:");
        if (`L15_PIPE0.val_s1 && !`L15_PIPE0.stall_s1)
            $write(" * ");
        else if (`L15_PIPE0.val_s1 && `L15_PIPE0.stall_s1)
            $write(" = ");
        else
            $write(" X ");

        if (`L15_PIPE0.val_s2 && !`L15_PIPE0.stall_s2)
            $write(" * ");
        else if (`L15_PIPE0.val_s2 && `L15_PIPE0.stall_s2)
            $write(" = ");
        else
            $write(" X ");

        if (`L15_PIPE0.val_s3 && !`L15_PIPE0.stall_s3)
            $write(" * ");
        else if (`L15_PIPE0.val_s3 && `L15_PIPE0.stall_s3)
            $write(" = ");
        else
            $write(" X ");
        $display("");

        // $write("PCX pipe info: "); decode_pcx_op(`L15_PIPE0.pcxdecoder_l15_rqtype, L15_PIPE0.pcxdecoder_l15_amo_op);
        // if (`L15_PIPE0.noc1_req_val_s3 && `L15_PIPE0.noc1encoder_req_staled_s3)
        //     $display(" (staled)");
        // else if (!`L15_PIPE0.noc1_req_val_s3)
        //     $display(" (invalid)");
        // else if (`L15_PIPE0.noc1_req_val_s3 && !`L15_PIPE0.noc1encoder_req_staled_s3)
        // begin
        //     $display(" (fresh)");
        // end

        // $write("NoC1 pipe info: ");
        // if (`L15_PIPE0.noc1_req_val_s3 && `L15_PIPE0.noc1encoder_req_staled_s3)
        //     $display("staled");
        // else if (!`L15_PIPE0.noc1_req_val_s3)
        //     $display("invalid");
        // else if (`L15_PIPE0.noc1_req_val_s3 && !`L15_PIPE0.noc1encoder_req_staled_s3)
        // begin
        //     $display("fresh");
        // end

        // $write("NoC3 pipe info: ");
        // if (`L15_PIPE0.noc3_req_val_s3 && `L15_PIPE0.noc3encoder_req_staled_s3)
        //     $display("staled");
        // else if (!`L15_PIPE0.noc3_req_val_s3)
        //     $display("invalid");
        // else if (`L15_PIPE0.noc3_req_val_s3 && !`L15_PIPE0.noc3encoder_req_staled_s3)
        // begin
        //     $display("fresh");
        // end

        // $write("CPX pipe info: ");
        // if (`L15_PIPE0.cpx_req_val_s3 && `L15_PIPE0.cpxencoder_req_staled_s3)
        //     $display("staled");
        // else if (!`L15_PIPE0.cpx_req_val_s3)
        //     $display("invalid");
        // else if (`L15_PIPE0.cpx_req_val_s3 && !`L15_PIPE0.cpxencoder_req_staled_s3)
        // begin
        //     $display("fresh");
        // end

            // Stage 1 debug information
        if (`L15_PIPE0.stall_s1 === 1'bx)
            $display("S1 stall is XXXXXXX");
        if (`L15_PIPE0.val_s1 && !`L15_PIPE0.stall_s1)
        begin
            $write("Stage 1 status: ");
            $write("   Operation: "); decode_predecode_reqtype(`L15_PIPE0.predecode_reqtype_s1);
            $display("   TILE0 S1 Address: 0x%x", `L15_PIPE0.predecode_address_s1);
            // if (`L15_PIPE0.decoder_dtag_operation_s1 == `L15_DTAG_OP_READ)
            // begin
            //     $display("   DTAG OP: L15_DTAG_OP_READ");
            //     $display("      Index: 0x%x", `L15_PIPE0.dtag_index);
            // end
            // if (`L15_PIPE0.l15_dtag_rw_s1 == `L15_DTAG_RW_WRITE)
            // begin
            //     $display("   DTAG OP: L15_DTAG_OP_WRITE");
            //     $display("      Data:  0x%x", `L15_PIPE0.dtag_write_tag_s1);
            //     $display("      Way:  0x%x", `L15_PIPE0.dtag_write_way_s1);
            //     // $display("      Mask: 0x%x", `L15_PIPE0.dtag_write_mask);
            // end
            // if (`L15_PIPE0.s1_mshr_write_val_s1)
            // begin
            //     $display("   DTAG OP: ");
            //     if (`L15_PIPE0.s1_mshr_write_type_s1 == `L15_MSHR_WRITE_TYPE_ALLOCATION)
            //     begin
            //         $write ("L15_MSHR_WRITE_TYPE_ALLOCATION");
            //         $display ("      MSRID: %d", `L15_PIPE0.s1_mshr_write_mshrid_s1);
            //     end
            //     else if (`L15_PIPE0.s1_mshr_write_type_s1 == `L15_S1_MSHR_OP_UPDATE_WRITECACHE)
            //     begin
            //         $write ("L15_S1_MSHR_OP_UPDATE_WRITECACHE");
            //         $display ("      MSRID:     %d", `L15_PIPE0.s1_mshr_write_mshrid_s1);
            //         $display ("      DATA:      0x%x", `L15_PIPE0.s1_mshr_write_data);
            //         $display ("      DATAMASK:  0x%x", `L15_PIPE0.s1_mshr_write_byte_mask);
            //     end
            // end
        end
        // Stage 2 debug information
        if (`L15_PIPE0.stall_s2 === 1'bx)
            $display("S2 stall is XXXXXXX");
        if (`L15_PIPE0.val_s2 && !`L15_PIPE0.stall_s2)
        begin
        $write("Stage 2 status: ");
            $write("   Operation: "); decode_predecode_reqtype(`L15_PIPE0.predecode_reqtype_s2);
            $display("   TILE0 S2 Address: 0x%x", `L15_PIPE0.address_s2);
            $display("   TILE0 S2 Cache index: %d", `L15_PIPE0.cache_index_s2);

            if (`L15_PIPE0.csm_req_val_s2)
            begin
                $display("   CSM op: %d", `L15_PIPE0.csm_op_s2);
                if (`L15_PIPE0.l15_csm_req_type_s2 == 1'b0)
                    $display("      CSM read ticket: 0x%x", `L15_PIPE0.l15_csm_req_ticket_s2);
                else
                begin
                    $display("      CSM write ticket: 0x%x", `L15_PIPE0.l15_csm_req_ticket_s2);
                    $display("      CSM write data: 0x%x", `L15_PIPE0.l15_csm_req_data_s2);
                end
            end

            // $display("   Source chipid: %d", `L15_PIPE0.noc2_src_homeid_s2[`PACKET_HOME_ID_CHIP_MASK]);
            // $display("   Source X: %d", `L15_PIPE0.noc2_src_homeid_s2[`PACKET_HOME_ID_X_MASK]);
            // $display("   Source Y: %d", `L15_PIPE0.noc2_src_homeid_s2[`PACKET_HOME_ID_Y_MASK]);
            // `ifdef L15_EXTRA_DEBUG
            // $display("   LRU state: %d", `L15_PIPE0.lru_state_s2);
            // $display("   LRU way: %d", `L15_PIPE0.lru_way_s2);
            // $display("   Tagcheck state: %d", `L15_PIPE0.tagcheck_state_s2);
            // $display("   Tagcheck way: %d", `L15_PIPE0.tagcheck_way_s2);

            if (`L15_PIPE0.decoder_dtag_operation_s2 == `L15_DTAG_OP_READ)
            begin
                $display("   DTAG way0 state: 0x%x", `L15_PIPE0.mesi_state_way0_s2);
                $display("   DTAG way0 data: 0x%x", dtag_tag_way0_s2_TILE0);
                $display("   DTAG way1 state: 0x%x", `L15_PIPE0.mesi_state_way1_s2);
                $display("   DTAG way1 data: 0x%x", dtag_tag_way1_s2_TILE0);
                $display("   DTAG way2 state: 0x%x", `L15_PIPE0.mesi_state_way2_s2);
                $display("   DTAG way2 data: 0x%x", dtag_tag_way2_s2_TILE0);
                $display("   DTAG way3 state: 0x%x", `L15_PIPE0.mesi_state_way3_s2);
                $display("   DTAG way3 data: 0x%x", dtag_tag_way3_s2_TILE0);
            end

            if (`L15_PIPE0.l15_mesi_write_val_s2)
            begin
                $display("   MESI write way: 0x%x", `L15_PIPE0.mesi_write_way_s2);
                $display("   MESI write data: 0x%x", `L15_PIPE0.mesi_write_state_s2);
            end

            // if (`L15_PIPE0.lruarray_write_op_s2 == `L15_LRU_EVICTION)
            // begin
            //     $display("   LRU EVICTION INDEX: %d, WAY: %d", `L15_PIPE0.cache_index_s2,
            //         `L15_PIPE0.lru_way_s2[1:0]);
            // end
            // `endif

            // if (`L15_PIPE0.s2_mesi_operation_s2 == `L15_S2_MESI_READ)
            // begin
            //     $display("   MESI OP: L15_S2_MESI_READ");
            //     $display ("      Index:     %d", `L15_PIPE0.s2_mesi_index_s2);
            // end
            // if (`L15_PIPE0.s2_mshr_val_s2)
            // begin
            //     $display("   MSHR OP: L15_S2_MSHR_OP_READ_WRITE_CACHE");
            //     $display ("      MSHR: %d", `L15_PIPE0.s2_mshr_read_mshrid);
            // end
            if (`L15_PIPE0.dcache_val_s2)
            begin
                // $write("   DCACHE OP: "); decode_dcache_op(`L15_PIPE0.dcache_operation_s2);
                // $display ("      RW:     %d", `L15_PIPE0.dcache_rw);
                // $display ("      Index:      0x%x", `L15_PIPE0.dcache_index);
                // $display ("      Data:  0x%x", `L15_PIPE0.dcache_write_data);
                // $display ("      Data mask:  0x%x", `L15_PIPE0.dcache_write_mask);
                if (`L15_PIPE0.l15_dcache_rw_s2 == 1'b0)
                begin
                    `ifndef NO_RTL_CSM
                    $display("HMT writing: %0b", `L15_PIPE0.l15_hmt_write_data_s2);
                    `endif
                    // TODO
                    // $display("HMT chip: %0b", `L15_PIPE0.wmt_fill_homeid_s2[`PACKET_HOME_ID_CHIP_MASK]);
                    // $display("HMT X: %0b", `L15_PIPE0.wmt_fill_homeid_s2[`PACKET_HOME_ID_X_MASK]);
                    // $display("HMT Y: %0b", `L15_PIPE0.wmt_fill_homeid_s2[`PACKET_HOME_ID_Y_MASK]);
                end
            end
        end

        // Stage 3 debug information
        if (`L15_PIPE0.stall_s3 === 1'bx)
            $display("S3 stall is XXXXXXX");
        if (`L15_PIPE0.val_s3 && !`L15_PIPE0.stall_s3)
        begin
            $write("Stage 3 status: ");
            $write("   Operation: "); decode_predecode_reqtype(`L15_PIPE0.predecode_reqtype_s3);
            $display("   TILE0 S3 Address: 0x%x", `L15_PIPE0.address_s3);
            `ifndef NO_RTL_CSM
            if ((`L15_PIPE0.noc1_homeid_source_s3 == `L15_HOMEID_SRC_HMT && `L15_PIPE0.noc1_req_val_s3)
                || (`L15_PIPE0.noc3_homeid_source_s3 == `L15_HOMEID_SRC_HMT && `L15_PIPE0.noc3_req_val_s3))
            begin
                `ifndef NO_RTL_CSM
                $display("   HMT chipid: %d", `L15_PIPE0.hmt_l15_dout_s3[`L15_CSM_GHID_CHIP_MASK]);
                $display("   HMT X: %d", `L15_PIPE0.hmt_l15_dout_s3[`L15_CSM_GHID_XPOS_MASK]);
                $display("   HMT Y: %d", `L15_PIPE0.hmt_l15_dout_s3[`L15_CSM_GHID_YPOS_MASK]);
                $display("   HMT reading: %0b", `L15_PIPE0.hmt_l15_dout_s3);
                `endif
            end
            `endif
            if (`L15_PIPE0.noc3_homeid_source_s3 == `L15_HOMEID_SRC_NOC2_SOURCE && `L15_PIPE0.noc3_req_val_s3)
            begin
                $display("   Source chipid: %d", `L15_PIPE0.noc2_src_homeid_s3[`PACKET_HOME_ID_CHIP_MASK]);
                $display("   Source X: %d", `L15_PIPE0.noc2_src_homeid_s3[`PACKET_HOME_ID_X_MASK]);
                $display("   Source Y: %d", `L15_PIPE0.noc2_src_homeid_s3[`PACKET_HOME_ID_Y_MASK]);
            end

            if (`L15_PIPE0.cpx_data_source_s3 == `L15_CPX_SOURCE_CSM)
                $display("      CSM read data: 0x%x", `L15_PIPE0.csm_l15_res_data_s3);
            // `ifdef L15_EXTRA_DEBUG
            // $display("   LRU state: %d", `L15_PIPE0.lru_state_s3);
            // $display("   LRU way: %d", `L15_PIPE0.lru_way_s3);
            // $display("   Tagcheck state: %d", `L15_PIPE0.tagcheck_state_s3);
            // $display("   Tagcheck way: %d", `L15_PIPE0.tagcheck_way_s3);
            // `endif

            // if (`L15_PIPE0.s3_mesi_val_s3)
            // begin
            //     $write("   MESI OP: "); decode_s3mesi_op(`L15_PIPE0.s3_mesi_operation_s3);
            //     $display ("      Index:      0x%x", `L15_PIPE0.mesi_write_index);
            //     $display ("      Data:  0x%x", `L15_PIPE0.mesi_write_data);
            //     $display ("      Data mask:  0x%x", `L15_PIPE0.mesi_write_mask);
            // end
            // if (`L15_PIPE0.wmc_val_s3)
            // begin
            //     $write("   WMC OP: "); decode_wmc_op(`L15_PIPE0.wmc_operation_s3);
            //     if (`L15_PIPE0.wmc_rw_s3 == `L15_WMC_OP_READ)
            //     begin
            //         $display ("      wmc_index_s3:      0x%x", `L15_PIPE0.wmc_index_s3);
            //         $display ("      wmc_invalidate_val_s3:      0x%x", `L15_PIPE0.wmc_invalidate_val_s3);
            //         $display ("      wmc_invalidate_way_s3:      0x%x", `L15_PIPE0.wmc_invalidate_way_s3);
            //     end
            //     else if (`L15_PIPE0.wmc_rw_s3 == `L15_WMC_OP_WRITE)
            //     begin
            //         $display ("      wmc_index_s3:      0x%x", `L15_PIPE0.wmc_index_s3);
            //         $display ("      wmc_update_way_s3:      0x%x", `L15_PIPE0.wmc_update_way_s3);
            //         $display ("      wmc_update_data_s3:      0x%x", `L15_PIPE0.wmc_update_data_s3);
            //         $display ("      wmc_invalidate_val_s3:      0x%x", `L15_PIPE0.wmc_invalidate_val_s3);
            //         $display ("      wmc_invalidate_way_s3:      0x%x", `L15_PIPE0.wmc_invalidate_way_s3);
            //     end
            //     $display ("      cpx_inval_way_s3:      0x%x", `L15_PIPE0.cpx_inval_way_s3);
            //     $display ("      wmc_read_way0_data_s3:      0x%x", `L15_PIPE0.wmc_read_way0_data_s3);
            //     $display ("      wmc_read_way1_data_s3:      0x%x", `L15_PIPE0.wmc_read_way1_data_s3);
            //     $display ("      wmc_read_way2_data_s3:      0x%x", `L15_PIPE0.wmc_read_way2_data_s3);
            //     $display ("      wmc_read_way3_data_s3:      0x%x", `L15_PIPE0.wmc_read_way3_data_s3);
            // end
            // if (`L15_PIPE0.s3_mshr_val_s3)
            // begin
            //     $write("   MSHR OP: "); decode_s3mshr_op(`L15_PIPE0.s3_mshr_operation_s3);
            //     $display ("      MSHR:      %d", `L15_PIPE0.s3_mshr_write_mshrid);
            //     $display ("      U.State:      0x%x", `L15_PIPE0.s3_mshr_write_update_state);
            //     $display ("      U.Way:  0x%x", `L15_PIPE0.s3_mshr_write_update_way);
            //     $display ("      St.mshr rand hit:   %d", `L15_PIPE0.LRU_st1_mshr_s3 || `L15_PIPE0.LRU_st2_mshr_s3);
            //     $display ("      St.mshr tag hit:   %d", `L15_PIPE0.tagcheck_st1_mshr_s3 || `L15_PIPE0.tagcheck_st2_mshr_s3);
            // end
            if (wmt_read_val_s3_TILE0)
            begin
                $display("   TILE0 WMT read index: %x", `L15_PIPE0.cache_index_l1d_s3[`L1D_SET_IDX_MASK]);
                // $display("   WMT way0: %x 0x%x", `L15_PIPE0.wmt_data_s3[0][`L15_WMT_VALID_MASK], `L15_PIPE0.wmt_data_s3[0][`L15_WMT_DATA_MASK]);
                // $display("   WMT way1: %x 0x%x", `L15_PIPE0.wmt_data_s3[1][`L15_WMT_VALID_MASK], `L15_PIPE0.wmt_data_s3[1][`L15_WMT_DATA_MASK]);
                // $display("   WMT way2: %x 0x%x", `L15_PIPE0.wmt_data_s3[2][`L15_WMT_VALID_MASK], `L15_PIPE0.wmt_data_s3[2][`L15_WMT_DATA_MASK]);
                // $display("   WMT way3: %x 0x%x", `L15_PIPE0.wmt_data_s3[3][`L15_WMT_VALID_MASK], `L15_PIPE0.wmt_data_s3[3][`L15_WMT_DATA_MASK]);
                for (i = 0; i < `L1D_WAY_COUNT; i = i + 1)
                begin
                    $display("   WMT way%d: %x 0x%x", i, `L15_PIPE0.wmt_data_s3[i][`L15_WMT_VALID_MASK], `L15_PIPE0.wmt_data_s3[i][`L15_WMT_DATA_MASK]);
                end
            end
            if (`L15_PIPE0.l15_wmt_write_val_s3)
            begin
                $display("   TILE0 WMT write index: %x", `L15_PIPE0.cache_index_l1d_s3[`L1D_SET_IDX_MASK]);
                // $display("   WMT write mask: %x", `L15_PIPE0.l15_wmt_write_mask_s3);
                // $display("   WMT write data: %x", `L15_PIPE0.l15_wmt_write_data_s3);
                // $display("   WMT way0 m%x d0x%x", `L15_PIPE0.l15_wmt_write_mask_s3[`L15_WMT_ENTRY_0_MASK], `L15_PIPE0.wmt_write_data_s3[`L15_WMT_ENTRY_0_MASK]);
                // $display("   WMT way1 m%x d0x%x", `L15_PIPE0.l15_wmt_write_mask_s3[`L15_WMT_ENTRY_1_MASK], `L15_PIPE0.wmt_write_data_s3[`L15_WMT_ENTRY_1_MASK]);
                // $display("   WMT way2 m%x d0x%x", `L15_PIPE0.l15_wmt_write_mask_s3[`L15_WMT_ENTRY_2_MASK], `L15_PIPE0.wmt_write_data_s3[`L15_WMT_ENTRY_2_MASK]);
                // $display("   WMT way3 m%x d0x%x", `L15_PIPE0.l15_wmt_write_mask_s3[`L15_WMT_ENTRY_3_MASK], `L15_PIPE0.wmt_write_data_s3[`L15_WMT_ENTRY_3_MASK]);
            end
        end
        $display ("L15_MON_END");
        $display ("");
    end

//CSM monitor
    if(`L15_TOP0.l15_csm.l15_csm_req_val_s2)
    begin
        $display($time, ": TILE0 L15_CSM REQ MON:");
        $display("L15 CSM req addr: 0x%x", `L15_TOP0.l15_csm.l15_csm_req_address_s2);
        $display("L15 CSM req ticket: %d", `L15_TOP0.l15_csm.l15_csm_req_ticket_s2);
        $display("L15 CSM req type: %d", `L15_TOP0.l15_csm.l15_csm_req_type_s2);
        $display("L15 CSM req data: 0x%x", `L15_TOP0.l15_csm.l15_csm_req_data_s2);
        $display("L15 CSM req pcx data: 0x%x", `L15_TOP0.l15_csm.l15_csm_req_pcx_data_s2);
    end
    if(`L15_TOP0.l15_csm.csm_l15_res_val_s3)
    begin
        $display($time, ": TILE0 L15_CSM RES MON:");
        $display("L15 CSM res data: 0x%x", `L15_TOP0.l15_csm.csm_l15_res_data_s3);
    end
    if(`L15_TOP0.l15_csm.csm_l15_read_res_val)
    begin
        $display($time, ": TILE0 L15_CSM READ TICKET MON:");
        $display("L15 CSM read ticket: %d", `L15_TOP0.l15_csm.l15_csm_read_ticket);
        $display("L15 CSM read data: 0x%x", `L15_TOP0.l15_csm.csm_l15_read_res_data);
    end
    if(`L15_TOP0.l15_csm.csm_noc1encoder_req_val)
    begin
        $display($time, ": TILE0 L15_CSM NOC1 REQ MON:");
        $display("L15 CSM noc1 req addr: 0x%x", `L15_TOP0.l15_csm.csm_noc1encoder_req_address);
        $display("L15 CSM noc1 req type: %d", `L15_TOP0.l15_csm.csm_noc1encoder_req_type);
        $display("L15 CSM noc1 req mshrid: %d", `L15_TOP0.l15_csm.csm_noc1encoder_req_mshrid);
    end
    if(`L15_TOP0.l15_csm.noc1encoder_csm_req_ack)
    begin
        $display($time, ": TILE0 L15_CSM NOC1 REQ ACK MON:");
        $display("L15 CSM noc1 req ack: %b", `L15_TOP0.l15_csm.noc1encoder_csm_req_ack);
    end

    if(`L15_TOP0.l15_csm.write_val_s2 && (~`L15_TOP0.l15_csm.ghid_val_s2))
    begin
        $display("L1.5 MON: HMC refills invalid data");
        $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: HMC refills invalid data");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("L1.5 MON: HMC refills invalid data");
    end

// valid mshrid monitor
    // check for incoming messages
    if (`L15_PIPE0.noc2decoder_l15_val && `L15_PIPE0.val_s1 && !`L15_PIPE0.stall_s1)
    begin
        is_csm_mshrid_TILE0 = `L15_PIPE0.noc2decoder_l15_hmc_fill;
        if ((`L15_PIPE0.noc2decoder_l15_reqtype == `MSG_TYPE_NODATA_ACK ||
            `L15_PIPE0.noc2decoder_l15_reqtype == `MSG_TYPE_DATA_ACK)
            && !is_csm_mshrid_TILE0)
        begin
            // first check if mshrid is in range
            if (`L15_PIPE0.noc2decoder_l15_mshrid > 9)
            begin
                $display("L1.5 MON: Received NoC2 message with MSHRID greater than 9 (%d)", `L15_PIPE0.noc2decoder_l15_mshrid);
                $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: Received NoC2 message with MSHRID greater than 9");
                `ifndef VERILATOR
                repeat(5)@(posedge clk)
                `endif
                    `MONITOR_PATH.fail("L1.5 MON: Received NoC2 message with MSHRID greater than 9");
            end

            // now check if it's valid
            // TODO
            // if (`L15_TOP0.mshr.val_array[`L15_PIPE0.noc2decoder_l15_mshrid] != 1'b1)
            // begin
            //     $display("L1.5 MON: Received NoC2 message with invalid MSHRID (%d)", `L15_PIPE0.noc2decoder_l15_mshrid);
            //     $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: Received NoC2 message with invalid MSHRID");
            //     `ifndef VERILATOR
            //     repeat(5)@(posedge clk)
            //     `endif
                //     `MONITOR_PATH.fail("L1.5 MON: Received NoC2 message with invalid MSHRID");
            // end
        end
    end
    // if (`L15_PIPE0.l15_noc1buffer_req_val && !`L15_PIPE0.stall_s3)
    // begin
    //     if (`L15_PIPE0.l15_noc1buffer_req_type != `L15_NOC1_REQTYPE_WRITEBACK_GUARD
    //         && `L15_PIPE0.l15_noc1buffer_req_type != `L15_NOC1_REQTYPE_INTERRUPT_FWD)
    //     begin
    //         if (`L15_TOP0.mshr.val_array[`L15_PIPE0.l15_noc1buffer_req_mshrid] != 1'b1
    //             || `L15_PIPE0.l15_noc1buffer_req_mshrid > 9)
    //         begin
    //             $display("L1.5 MON: Sending NoC1 message with invalid MSHRID (%d)", `L15_PIPE0.l15_noc1buffer_req_mshrid);
    //             $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: Sending NoC1 message with invalid MSHRID");
    //             `ifndef VERILATOR
    //             repeat(5)@(posedge clk)
    //             `endif
        //             `MONITOR_PATH.fail("L1.5 MON: Sending NoC1 message with invalid MSHRID");
    //         end
    //     end
    // end

// monitor PCX buffer full compare to t1 internal buffer mon
`ifdef RTL_SPARC0
`ifndef RTL_SPU
    if ((`CCX_TRANSDUCER0.pcx_buffer.is_req_squashed == 1'b1) && (`SPARC_CORE0.sparc0.lsu.lsu.qctl1.pcx_req_squash == 1'b0))
`else
    if ((`CCX_TRANSDUCER0.pcx_buffer.is_req_squashed == 1'b1) && (`SPARC_CORE0.sparc0.lsu.qctl1.pcx_req_squash == 1'b0))
`endif
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "PCXTILE0 req was valid but squashed in L1.5");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("PCXTILE0 req was valid but squashed in L1.5");
    end
`ifndef RTL_SPU
    if ((`CCX_TRANSDUCER0.pcx_buffer.is_req_squashed == 1'b0) && (`SPARC_CORE0.sparc0.lsu.lsu.qctl1.pcx_req_squash == 1'b1))
`else
    if ((`CCX_TRANSDUCER0.pcx_buffer.is_req_squashed == 1'b0) && (`SPARC_CORE0.sparc0.lsu.qctl1.pcx_req_squash == 1'b1))
`endif
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "PCXTILE0 req was squashed but valid at L1.5");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("PCXTILE0 req was squashed but valid at L1.5");
    end

    // check for squashed atomic
    if ((`CCX_TRANSDUCER0.pcx_buffer.is_req_squashed == 1'b1) && (`CCX_TRANSDUCER0.pcx_buffer.spc_uncore_atomic_req == 1'b1))
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "PCXTILE0 atomic req squashed");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("PCXTILE0 atomic req squashed");
    end
`endif

// monitor FP transactions because it is not supported yet
//     if (`L15_PIPE0.pcxdecoder_l15_val && !`L15_PIPE0.pcx_message_staled_s1 && `L15_PIPE0.val_s1 && !`L15_PIPE0.stall_s1 && !`L15_PIPE0.noc2decoder_l15_val)
//     begin
//         if (`L15_PIPE0.pcxdecoder_l15_rqtype == `PCX_REQTYPE_FP1)
//         begin
//             $display("%d : Simulation -> FAIL(%0s)", $time, "FP requests received but not implemented");
//             `ifndef VERILATOR
//             repeat(5)@(posedge clk)
//             `endif
    //             `MONITOR_PATH.fail("FP requests received but not implemented");
//         end
//     end

// monitor INT_VEC_DIS requests
    if (`L15_PIPE0.pcxdecoder_l15_val && `L15_PIPE0.val_s1 && !`L15_PIPE0.stall_s1 && !`L15_PIPE0.noc2decoder_l15_val)
    begin
        if (`L15_PIPE0.pcxdecoder_l15_rqtype == `PCX_REQTYPE_STORE
            && `L15_PIPE0.pcxdecoder_l15_address == 40'h9800000800)
        begin
            $display("%d : PCX write to INT_VEC_DIS", $time);
            // $display("%d : Simulation -> FAIL(%0s)", $time, "Write to INT_VEC_DIS");
            // `ifndef VERILATOR
            // repeat(5)@(posedge clk)
            // `endif
                // `MONITOR_PATH.fail("Write to INT_VEC_DIS");
        end
    end

// monitor noc1 buffer credit for underflow
    if (`L15_PIPE0.creditman_noc1_avail == 4'd15)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE0 NOC1 credit underflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE0 NOC1 credit underflow");
    end
    if (`L15_PIPE0.creditman_noc1_avail > `NOC1_BUFFER_NUM_SLOTS)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE0 NOC1 credit overflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE0 NOC1 credit overflow");
    end
    if (`L15_PIPE0.creditman_noc1_data_avail == 4'd15)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE0 NOC1 data credit underflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE0 NOC1 data credit underflow");
    end
    if (`L15_PIPE0.creditman_noc1_data_avail > `NOC1_BUFFER_NUM_DATA_SLOTS)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE0 NOC1 data credit overflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE0 NOC1 data credit overflow");
    end

    // check noc1 reserve credit
    if (`L15_PIPE0.creditman_noc1_reserve == 4'd15)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE0 NOC1 reserve credit underflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE0 NOC1 reserve credit underflow");
    end
    if (`L15_PIPE0.creditman_noc1_reserve > `NOC1_BUFFER_NUM_SLOTS)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE0 NOC1 reserve credit overflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE0 NOC1 reserve credit overflow");
    end
    // check reserve logics
    // if (`L15_PIPE0.creditman_noc1_reserve_s3)
    // begin
    //     $display("%d : Simulation -> FAIL(%0s)", $time, "TILE0 NOC1 reserve credit underflow");
    //     `ifndef VERILATOR
    //     repeat(5)@(posedge clk)
    //     `endif
        //     `MONITOR_PATH.fail("TILE0 NOC1 reserve credit underflow");
    // end

// Monitor for "RESERVED" messages
    if (`L15_PIPE0.noc2decoder_l15_val && `L15_PIPE0.val_s1 && !`L15_PIPE0.stall_s1)
    begin
        if (`L15_PIPE0.noc2decoder_l15_reqtype == `MSG_TYPE_RESERVED)
        begin
            $display("%d : Simulation -> FAIL(%0s)", $time, "TILE0 L15 received MSG_TYPE_RESERVED");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("TILE0 L15 received MSG_TYPE_RESERVED");
        end
    end

// Monitor WMT duplicate error
    if (`L15_PIPE0.val_s3)
    begin
        {wmt_read_data_TILE0[3], wmt_read_data_TILE0[2], wmt_read_data_TILE0[1], wmt_read_data_TILE0[0]} = `L15_PIPE0.wmt_l15_data_s3;
        for (i_TILE0 = 0; i_TILE0 < 4; i_TILE0 = i_TILE0+1)
        begin
            for (j_TILE0 = 0; j_TILE0 < i_TILE0; j_TILE0 = j_TILE0 + 1)
            begin
                if ((wmt_read_data_TILE0[i_TILE0][`L15_WMT_VALID_MASK] && wmt_read_data_TILE0[j_TILE0][`L15_WMT_VALID_MASK]) && (wmt_read_data_TILE0[i_TILE0] == wmt_read_data_TILE0[j_TILE0]))
                begin
                    $display("%d : Simulation -> FAIL(%0s)", $time, "TILE0 L15 has error with WMT");
                    `ifndef VERILATOR
                    repeat(5)@(posedge clk)
                    `endif
                        `MONITOR_PATH.fail("TILE0 L15 has error with WMT");
                end
            end
        end
    end

// Monitor tags duplication error (bug #86)
    if (`L15_PIPE0.val_s2 && `L15_PIPE0.decoder_dtag_operation_s2 == `L15_DTAG_OP_READ)
    begin
        tag_data_TILE0[0] = `L15_PIPE0.dtag_tag_way0_s2[`L15_CACHE_TAG_WIDTH-1:0];
        tag_data_TILE0[1] = `L15_PIPE0.dtag_tag_way1_s2[`L15_CACHE_TAG_WIDTH-1:0];
        tag_data_TILE0[2] = `L15_PIPE0.dtag_tag_way2_s2[`L15_CACHE_TAG_WIDTH-1:0];
        tag_data_TILE0[3] = `L15_PIPE0.dtag_tag_way3_s2[`L15_CACHE_TAG_WIDTH-1:0];
        tag_val_TILE0[0] = `L15_PIPE0.mesi_state_way0_s2 != `L15_MESI_STATE_I;
        tag_val_TILE0[1] = `L15_PIPE0.mesi_state_way1_s2 != `L15_MESI_STATE_I;
        tag_val_TILE0[2] = `L15_PIPE0.mesi_state_way2_s2 != `L15_MESI_STATE_I;
        tag_val_TILE0[3] = `L15_PIPE0.mesi_state_way3_s2 != `L15_MESI_STATE_I;
        for (i_TILE0 = 0; i_TILE0 < 4; i_TILE0 = i_TILE0+1)
        begin
            for (j_TILE0 = 0; j_TILE0 < i_TILE0; j_TILE0 = j_TILE0 + 1)
            begin
                if ((tag_val_TILE0[i_TILE0] && tag_val_TILE0[j_TILE0]) && (tag_data_TILE0[i_TILE0] == tag_data_TILE0[j_TILE0]))
                begin
                    $display("%d : Simulation -> FAIL(%0s)", $time, "TILE0 L15 has duplicated tag entry");
                    `ifndef VERILATOR
                    repeat(5)@(posedge clk)
                    `endif
                        `MONITOR_PATH.fail("TILE0 L15 has duplicated tag entry");
                end
            end
        end
    end

// // monitor FP transactions because it is not supported yet
//     if (`L15_TOP0.noc1encoder.sending)
//     begin
//         $display("noc1 flit raw: 0x%x", `L15_TOP0.noc1encoder.flit);
//     end
//     if (`L15_PIPE0.pcxdecoder_l15_val && !`L15_PIPE0.pcx_message_staled_s1 && `L15_PIPE0.val_s1 && !`L15_PIPE0.stall_s1 && !`L15_PIPE0.noc2decoder_l15_val)
//     begin
//         $display("%d : Simulation -> FAIL(%0s)", $time, "FP requests received but not implemented");
//         `ifndef VERILATOR
//         repeat(5)@(posedge clk)
//         `endif
    //         `MONITOR_PATH.fail("FP requests received but not implemented");
//     end


// Monitor FP transactions
//    if (`TILE0.fpu_arb_wrap.pcx_fpio_data_px2[123]
//            && `TILE0.fpu_arb_wrap.pcx_fpio_data_px2[122:119] == 4'b0101)
//    begin
//        $display("TILE0 FPU th%d: Received FP%d",
//                    `TILE0.fpu_arb_wrap.pcx_fpio_data_px2[113:112],
//                    `TILE0.fpu_arb_wrap.pcx_fpio_data_px2[118]);
//    end
//    if (`TILE0.fpu_arb_wrap.fpu_arb_data_rdy
//            && !`TILE0.fpu_arb_wrap.l15_fp_rdy)
//        $display("TILE0 FPU th%d: Sent FP data",
//                    `TILE0.fpu_arb_wrap.fpu_arb_data[135:134]);

// monitor L1.5 way replacement error
    if (`L15_PIPE0.l15_dcache_val_s2
        && `L15_PIPE0.dcache_operation_s2 == `L15_DCACHE_READ_LRU_WAY_IF_M)
    begin
        if (`L15_PIPE0.lruarray_l15_dout_s2[`L15_PIPE0.lru_way_s2] == 1'b1)
        begin
            // replacing a valid line
            if (&`L15_PIPE0.lru_used_bits_s2[3:0] == 1'b0)
            begin
                // and an another entry is 0, then is an error
                $display("%d : Simulation -> FAIL(%0s)", $time, "TILE0 L15 picked the wrong LRU entry");
                `ifndef VERILATOR
                repeat(5)@(posedge clk)
                `endif
                    `MONITOR_PATH.fail("TILE0 L15 picked the wrong LRU entry");
            end
        end
    end

// monitor X's in stall signals
    if (`L15_PIPE0.val_s1 && (`L15_PIPE0.stall_s1 === 1'bx) ||
        `L15_PIPE0.val_s2 && (`L15_PIPE0.stall_s2 === 1'bx) ||
        `L15_PIPE0.val_s3 && (`L15_PIPE0.stall_s3 === 1'bx))
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "L15 has X's in the stall_s1 signal");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("L15 has X's in the stall_s1 signal");
    end

`ifdef RTL_SPARC0
// some checks for l15cpxencoder
    if (`L15_TOP0.l15_transducer_val)
    begin
        if (`L15_TOP0.l15_transducer_inval_icache_inval)
        begin
            $display("%d : Simulation -> FAIL(%0s)", $time, "l15 icache inval is not used");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("l15 icache inval is not used");
        end
        if (`L15_TOP0.l15_transducer_returntype == `CPX_RESTYPE_ATOMIC_RES
            && `L15_TOP0.l15_transducer_inval_dcache_inval)
        begin
            $display("%d : Simulation -> FAIL(%0s)", $time, "l15 CAS inval is not used");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("l15 CAS inval is not used");
        end
    end
`endif

// some checks for l15 noc1 encoder
    if (`L15_TOP0.noc1encoder.sending && `L15_TOP0.noc1encoder.req_type == 0)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "l15 noc1 message is null");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("l15 noc1 message is null");
    end

    end // disable_l15_mon
end

//CORE0 END


// CORE1

reg do_print_stage_TILE1;
integer i_TILE1;
wire [63:0] dtag_tag_way0_s2_TILE1;
wire [63:0] dtag_tag_way1_s2_TILE1;
wire [63:0] dtag_tag_way2_s2_TILE1;
wire [63:0] dtag_tag_way3_s2_TILE1;

assign dtag_tag_way0_s2_TILE1 = (`L15_PIPE1.dtag_tag_way0_s2 << 11);
assign dtag_tag_way1_s2_TILE1 = (`L15_PIPE1.dtag_tag_way1_s2 << 11);
assign dtag_tag_way2_s2_TILE1 = (`L15_PIPE1.dtag_tag_way2_s2 << 11);
assign dtag_tag_way3_s2_TILE1 = (`L15_PIPE1.dtag_tag_way3_s2 << 11);
reg [`L15_CACHE_TAG_WIDTH-1:0] tag_data_TILE1 [0:3];
reg [3:0] tag_val_TILE1;
reg [`L15_WMT_ENTRY_MASK] wmt_read_data_TILE1 [0:3];
integer j_TILE1;
reg is_csm_mshrid_TILE1;

reg wmt_read_val_s3_TILE1;
always @ (posedge clk)
    wmt_read_val_s3_TILE1 <= `L15_PIPE1.l15_wmt_read_val_s2;

always @ (negedge clk)
begin
    if(!$test$plusargs("disable_l15_mon"))
    begin

    // monitoring outgoing noc1/noc3 messages
    if (`L15_TOP1.noc1encoder.sending)
    begin
        $display($time);
        $display("TILE1 noc1 flit raw: 0x%x", `L15_TOP1.noc1encoder.flit);
        $display("   srcX: %d, srcY: %d", `L15_TOP1.noc1encoder.msg_src_xpos, `L15_TOP1.noc1encoder.msg_src_ypos);
        $display("   destX: %d, destY: %d", `L15_TOP1.noc1encoder.msg_dest_l2_xpos, `L15_TOP1.noc1encoder.msg_dest_l2_ypos);
        if ( ^`L15_TOP1.noc1encoder.flit === 1'bx)
        begin
            $display("%d : Simulation -> FAIL(TILE1 noc1 sends X data 0x%x)", $time, `L15_TOP1.noc1encoder.flit);
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("l15_mon: TILE1 noc1 sends X data");
        end

    end




    if (`L15_PIPE1.pcxdecoder_l15_val && `L15_PIPE1.val_s1 && !`L15_PIPE1.stall_s1 && !`L15_PIPE1.noc2decoder_l15_val
        && `L15_PIPE1.fetch_state_s1 == `L15_FETCH_STATE_NORMAL)
    begin
        $write("%0d TILE1 L1.5 th%d: Received PCX ", $time, `L15_PIPE1.pcxdecoder_l15_threadid); decode_pcx_op(`L15_PIPE1.pcxdecoder_l15_rqtype, `L15_PIPE1.pcxdecoder_l15_amo_op);
        $display("   Addr 0x%x, nc %d, size %d, invalall %d, pf %d, bs %d, bsi %d, l1way %d",
                                `L15_PIPE1.pcxdecoder_l15_address, `L15_PIPE1.pcxdecoder_l15_nc, `L15_PIPE1.pcxdecoder_l15_size, `L15_PIPE1.pcxdecoder_l15_invalidate_cacheline,
                                `L15_PIPE1.pcxdecoder_l15_prefetch, `L15_PIPE1.pcxdecoder_l15_blockstore, `L15_PIPE1.pcxdecoder_l15_blockinitstore, `L15_PIPE1.pcxdecoder_l15_l1rplway);
        $display("   Data: 0x%x", `L15_PIPE1.pcxdecoder_l15_data);
        if (`L15_PIPE1.pcxdecoder_l15_csm_data[`TLB_CSM_STATE] == `TLB_CSM_STATE_LOCAL)
        begin
            $display("   CSM HDID: %d, HD_SIZE: %d, SDID: %d, LSID: %d", `L15_PIPE1.pcxdecoder_l15_csm_data[`TLB_CSM_HDID], `L15_PIPE1.pcxdecoder_l15_csm_data[`TLB_CSM_HD_SIZE],
            `L15_PIPE1.pcxdecoder_l15_csm_data[`TLB_CSM_SDID], `L15_PIPE1.pcxdecoder_l15_csm_data[`TLB_CSM_LSID]);
        end
        else if (`L15_PIPE1.pcxdecoder_l15_csm_data[`TLB_CSM_STATE] == `TLB_CSM_STATE_GLOBAL)
        begin
            $display("   CSM CHIPID: %d, X: %d, Y: %d", `L15_PIPE1.pcxdecoder_l15_csm_data[`TLB_CSM_CHIPID], `L15_PIPE1.pcxdecoder_l15_csm_data[`TLB_CSM_X],`L15_PIPE1.pcxdecoder_l15_csm_data[`TLB_CSM_Y]);
        end
        $display("   CSM Data: 0x%x", `L15_PIPE1.pcxdecoder_l15_csm_data);
        /*
        if (noc2decoder_l15_reqtype == `PCX_REQTYPE_STORE)
        if (noc2decoder_l15_reqtype == `PCX_REQTYPE_CAS1)
        begin
        $display("   Cmp.data: 0x%x", `L15_PIPE1.pcxdecoder_l15_data);
        $display("   Swp.data: 0x%x", `L15_PIPE1.pcxdecoder_l15_data_next_entry);
        end
        if (noc2decoder_l15_reqtype == `PCX_REQTYPE_SWP_LOADSTUB)
        begin
        $display("   Swp.data: 0x%x", `L15_PIPE1.pcxdecoder_l15_data);
        end
        */
        if (`L15_PIPE1.pcxdecoder_l15_rqtype == `PCX_REQTYPE_INTERRUPT && `L15_PIPE1.pcxdecoder_l15_data[63] == 1'b0)
        begin
            pcx_interrupt_type = `L15_PIPE1.pcxdecoder_l15_data[17:16];
            pcx_interrupt_dst_chipid = `L15_PIPE1.pcxdecoder_l15_data[31:18];
            pcx_interrupt_dst_y = `L15_PIPE1.pcxdecoder_l15_data[14:12];
            pcx_interrupt_dst_x = `L15_PIPE1.pcxdecoder_l15_data[11:9];
            pcx_interrupt_threadid = `L15_PIPE1.pcxdecoder_l15_data[8];
            pcx_interrupt_vector = `L15_PIPE1.pcxdecoder_l15_data[5:0];
            $display("Interrupt info:");
            $write("    Type: ");
            case(pcx_interrupt_type)
                2'b00:
                    $display("hw int");
                2'b01:
                    $display("reset");
                2'b10:
                    $display("idle");
                2'b11:
                    $display("resume");
            endcase

            $display("    Dst CHIP ID: %d", pcx_interrupt_dst_chipid);
            $display("    Dst X: %d", pcx_interrupt_dst_x);
            $display("    Dst Y: %d", pcx_interrupt_dst_y);
            $display("    Thread ID: %d", pcx_interrupt_threadid);
            $display("    Vector: %d", pcx_interrupt_vector);
        end
    end

    if (`L15_PIPE1.noc2decoder_l15_val && `L15_PIPE1.val_s1 && !`L15_PIPE1.stall_s1)
    begin
        noc2 = 0;
        case(`L15_PIPE1.noc2decoder_l15_reqtype)
        `MSG_TYPE_RESERVED:
            noc2 = "MSG_TYPE_RESERVED";
        `MSG_TYPE_LOAD_FWD:
            noc2 = "MSG_TYPE_LOAD_FWD";
        `MSG_TYPE_STORE_FWD:
            noc2 = "MSG_TYPE_STORE_FWD";
        `MSG_TYPE_INV_FWD:
            noc2 = "MSG_TYPE_INV_FWD";
        `MSG_TYPE_NODATA_ACK:
            noc2 = "MSG_TYPE_NODATA_ACK";
        `MSG_TYPE_DATA_ACK:
            noc2 = "MSG_TYPE_DATA_ACK";
        `MSG_TYPE_NC_LOAD_MEM_ACK:
            noc2 = "MSG_TYPE_NC_LOAD_MEM_ACK";
        `MSG_TYPE_NC_STORE_MEM_ACK:
            noc2 = "MSG_TYPE_NC_STORE_MEM_ACK";
        `MSG_TYPE_INTERRUPT:
            noc2 = "MSG_TYPE_L2_INTERRUPT";
        default:
        begin
            noc2 = "MSG_TYPE_UNKNOWN_ERROR";
            $display("%d : Simulation -> FAIL(%0s)", $time, "L15 mon: error message type from L2");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("L15 mon: error message type from L2");
        end
        endcase

        $write("%0d TILE1 L1.5: Received NOC2 %s", $time, noc2);
        $display("   mshrid %d, l2miss %d, f4b %d, ackstate %d, address 0x%x",
                    `L15_PIPE1.noc2decoder_l15_mshrid, `L15_PIPE1.noc2decoder_l15_l2miss, `L15_PIPE1.noc2decoder_l15_f4b,
                    `L15_PIPE1.noc2decoder_l15_ack_state, `L15_PIPE1.noc2decoder_l15_address);
        $display("   Data1: 0x%x", `L15_PIPE1.noc2decoder_l15_data_0);
        $display("   Data2: 0x%x", `L15_PIPE1.noc2decoder_l15_data_1);
        $display("   Data3: 0x%x", `L15_PIPE1.noc2decoder_l15_data_2);
        $display("   Data4: 0x%x", `L15_PIPE1.noc2decoder_l15_data_3);
    end

    if (`L15_PIPE1.l15_cpxencoder_val && !`L15_PIPE1.stall_s3)
    begin
        cpx = 0;
        case(`L15_PIPE1.l15_cpxencoder_returntype)
            `LOAD_RET:
                cpx = "LOAD_RET";
            `INV_RET:
                cpx = "INV_RET";
            `ST_ACK:
                cpx = "ST_ACK";
            `AT_ACK:
                cpx = "AT_ACK";
            `INT_RET:
                cpx = "INT_RET";
            `TEST_RET:
                cpx = "TEST_RET";
            `FP_RET:
                cpx = "FP_RET";
            `IFILL_RET:
                cpx = "IFILL_RET";
            `EVICT_REQ:
                cpx = "EVICT_REQ";
            `ERR_RET:
                cpx = "ERR_RET";
            `STRLOAD_RET:
                cpx = "STRLOAD_RET";
            `STRST_ACK:
                cpx = "STRST_ACK";
            `FWD_RQ_RET:
                cpx = "FWD_RQ_RET";
            `FWD_RPY_RET:
                cpx = "FWD_RPY_RET";
            `RSVD_RET:
                cpx = "RSVD_RET";
            4'b1110:
                cpx = "ATOMIC_ACK";
            default:
                cpx = "CPX_UNKNOWN";
        endcase
        $write("%0d TILE1 L1.5 th%d: Sent CPX %0s", $time, `L15_PIPE1.l15_cpxencoder_threadid, cpx);
        $display("   l2miss %d, nc %d, atomic %d, threadid %d, pf %d, f4b %d, iia %d, dia %d, dinval %d, iinval %d, invalway %d, blkinit %d",
                    `L15_PIPE1.l15_cpxencoder_l2miss, `L15_PIPE1.l15_cpxencoder_noncacheable, `L15_PIPE1.l15_cpxencoder_atomic,
                    `L15_PIPE1.l15_cpxencoder_threadid, `L15_PIPE1.l15_cpxencoder_prefetch,
                    `L15_PIPE1.l15_cpxencoder_f4b, `L15_PIPE1.l15_cpxencoder_inval_icache_all_way,
                    `L15_PIPE1.l15_cpxencoder_inval_dcache_all_way, `L15_PIPE1.l15_cpxencoder_inval_dcache_inval,
                    `L15_PIPE1.l15_cpxencoder_inval_icache_inval, `L15_PIPE1.l15_cpxencoder_inval_way,
                    `L15_PIPE1.l15_cpxencoder_blockinitstore);
        $display("   Data0: 0x%x", `L15_PIPE1.l15_cpxencoder_data_0);
        $display("   Data1: 0x%x", `L15_PIPE1.l15_cpxencoder_data_1);
        $display("   Data2: 0x%x", `L15_PIPE1.l15_cpxencoder_data_2);
        $display("   Data3: 0x%x", `L15_PIPE1.l15_cpxencoder_data_3);
    end

    if (`L15_TOP1.noc1encoder.noc1encoder_noc1out_val && `L15_TOP1.noc1encoder.noc1encoder_noc1buffer_req_ack)
    begin
        noc1 = 0;
        case(`L15_TOP1.noc1encoder.req_type)
        `L15_NOC1_REQTYPE_WRITEBACK_GUARD:
            noc1 = "L15_NOC1_REQTYPE_WRITEBACK_GUARD";
        `L15_NOC1_REQTYPE_LD_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_LD_REQUEST";
        `L15_NOC1_REQTYPE_IFILL_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_IFILL_REQUEST";
        `L15_NOC1_REQTYPE_WRITETHROUGH_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_WRITETHROUGH_REQUEST";
        `L15_NOC1_REQTYPE_ST_UPGRADE_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_ST_UPGRADE_REQUEST";
        `L15_NOC1_REQTYPE_ST_FILL_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_ST_FILL_REQUEST";
        `L15_NOC1_REQTYPE_CAS_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_CAS_REQUEST";
        `L15_NOC1_REQTYPE_SWAP_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_SWAP_REQUEST";
        `L15_NOC1_REQTYPE_INTERRUPT_FWD:
            noc1 = "L15_NOC1_REQTYPE_INTERRUPT_FWD";
        `L15_NOC1_REQTYPE_AMO_ADD_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_ADD_REQUEST";
        `L15_NOC1_REQTYPE_AMO_AND_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_AND_REQUEST";
        `L15_NOC1_REQTYPE_AMO_OR_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_OR_REQUEST";
        `L15_NOC1_REQTYPE_AMO_XOR_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_XOR_REQUEST";
        `L15_NOC1_REQTYPE_AMO_MAX_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_MAX_REQUEST";
        `L15_NOC1_REQTYPE_AMO_MAXU_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_MAXU_REQUEST";
        `L15_NOC1_REQTYPE_AMO_MIN_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_MIN_REQUEST";
        `L15_NOC1_REQTYPE_AMO_MINU_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_MINU_REQUEST";
        default:
            noc1 = "ERROR noc1";
        endcase

        $write("%0d TILE1 L1.5: Sending NOC1 %s", $time, noc1);
        $display("   mshrid %d, nc %d, size %d, pf %d, address %0x",
                    `L15_TOP1.noc1encoder.noc1buffer_noc1encoder_req_mshrid, `L15_TOP1.noc1encoder.noc1buffer_noc1encoder_req_non_cacheable,
                    `L15_TOP1.noc1encoder.noc1buffer_noc1encoder_req_size, `L15_TOP1.noc1encoder.noc1buffer_noc1encoder_req_prefetch, `L15_TOP1.noc1encoder.noc1buffer_noc1encoder_req_address);
        $display("   Data0: 0x%x", `L15_TOP1.noc1encoder.noc1buffer_noc1encoder_req_data_0);
        $display("   Data1: 0x%x", `L15_TOP1.noc1encoder.noc1buffer_noc1encoder_req_data_1);
        $display("   Destination X: %d Y: %d", `L15_TOP1.noc1encoder.msg_dest_l2_xpos, `L15_TOP1.noc1encoder.msg_dest_l2_ypos);
    end

    if (`L15_TOP1.noc3encoder.noc3encoder_noc3out_val && `L15_TOP1.noc3encoder.noc3encoder_l15_req_ack)
    begin
        noc3 = 0;
        case(`L15_TOP1.noc3encoder.l15_noc3encoder_req_type)
        `L15_NOC3_REQTYPE_WRITEBACK:
            noc3 = "L15_NOC3_REQTYPE_WRITEBACK";
        `L15_NOC3_REQTYPE_INVAL_ACK:
            noc3 = "L15_NOC3_REQTYPE_INVAL_ACK";
        `L15_NOC3_REQTYPE_DOWNGRADE_ACK:
            noc3 = "L15_NOC3_REQTYPE_DOWNGRADE_ACK";
        `L15_NOC3_REQTYPE_ICACHE_INVAL_ACK:
            noc3 = "L15_NOC3_REQTYPE_ICACHE_INVAL_ACK";
        default:
            noc3 = "ERROR NOC3";
        endcase

        // quick check for an error case
        if (`L15_TOP1.noc3encoder.msg_type == `MSG_TYPE_INV_FWDACK
            && `L15_TOP1.noc3encoder.l15_noc3encoder_req_with_data)
        begin
            $display("L1.5 MON: sending back invalid ack with data");
            $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: sending back invalid ack with data");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("L1.5 MON: sending back invalid ack with data");
        end


        $write("%0d TILE1 L1.5: Sent NOC3 %s", $time, noc3);
        $display("   mshrid %d, seqid %d, address %0x",
                    `L15_TOP1.noc3encoder.l15_noc3encoder_req_mshrid, `L15_TOP1.noc3encoder.l15_noc3encoder_req_sequenceid, `L15_TOP1.noc3encoder.l15_noc3encoder_req_address);
        $display("   srcX: %d, srcY: %d", `L15_TOP1.noc3encoder.src_l2_xpos, `L15_TOP1.noc3encoder.src_l2_ypos);
        $display("   destX: %d, destY: %d", `L15_TOP1.noc3encoder.dest_l2_xpos, `L15_TOP1.noc3encoder.dest_l2_ypos);
        $display("   Data0: 0x%x", `L15_TOP1.noc3encoder.l15_noc3encoder_req_data_0);
        $display("   Data1: 0x%x", `L15_TOP1.noc3encoder.l15_noc3encoder_req_data_1);
    end

    do_print_stage_TILE1 = ((`L15_PIPE1.val_s1 && !`L15_PIPE1.stall_s1) || (`L15_PIPE1.val_s2 && !`L15_PIPE1.stall_s2) || (`L15_PIPE1.val_s3 && !`L15_PIPE1.stall_s3));
    if (do_print_stage_TILE1)
    begin
        // $display("");
        $display("");
        $display($time, " L15 TILE1:");
        $display("NoC1 credit: %d", `L15_PIPE1.creditman_noc1_avail);
        $display("NoC1 reserved credit: %d", `L15_PIPE1.creditman_noc1_reserve);
        // $display("NoC1 r down: %d", `L15_PIPE1.creditman_noc1_reserve_minus1);
        // $display("NoC1 r up: %d", `L15_PIPE1.creditman_noc1_reserve_add1);

        // monitor the MSHRID allocation
        // $display("MSHRID allocation info:");
        // for (i_TILE1 = 0; i_TILE1 < `L15_MSHR_COUNT; i_TILE1 = i_TILE1 + 1)
        //     $write("%d:%d", i_TILE1, `L15_PIPE1.mshr_val_array[i_TILE1]);
            // $write("%d %d", i_TILE1, i_TILE1);
        // $display("");

`ifdef RTL_SPARC1
        $display("Core STB info:");
        $display("  STB0: %d", `SPARC_CORE1.sparc0.ifu.lsu_ifu_stbcnt0);
        $display("  STB1: %d", `SPARC_CORE1.sparc0.ifu.lsu_ifu_stbcnt1);
            // $write("%d %d", i_TILE1, i_TILE1);
`endif

        $write("TILE1 Pipeline:");
        if (`L15_PIPE1.val_s1 && !`L15_PIPE1.stall_s1)
            $write(" * ");
        else if (`L15_PIPE1.val_s1 && `L15_PIPE1.stall_s1)
            $write(" = ");
        else
            $write(" X ");

        if (`L15_PIPE1.val_s2 && !`L15_PIPE1.stall_s2)
            $write(" * ");
        else if (`L15_PIPE1.val_s2 && `L15_PIPE1.stall_s2)
            $write(" = ");
        else
            $write(" X ");

        if (`L15_PIPE1.val_s3 && !`L15_PIPE1.stall_s3)
            $write(" * ");
        else if (`L15_PIPE1.val_s3 && `L15_PIPE1.stall_s3)
            $write(" = ");
        else
            $write(" X ");
        $display("");

        // $write("PCX pipe info: "); decode_pcx_op(`L15_PIPE1.pcxdecoder_l15_rqtype, L15_PIPE1.pcxdecoder_l15_amo_op);
        // if (`L15_PIPE1.noc1_req_val_s3 && `L15_PIPE1.noc1encoder_req_staled_s3)
        //     $display(" (staled)");
        // else if (!`L15_PIPE1.noc1_req_val_s3)
        //     $display(" (invalid)");
        // else if (`L15_PIPE1.noc1_req_val_s3 && !`L15_PIPE1.noc1encoder_req_staled_s3)
        // begin
        //     $display(" (fresh)");
        // end

        // $write("NoC1 pipe info: ");
        // if (`L15_PIPE1.noc1_req_val_s3 && `L15_PIPE1.noc1encoder_req_staled_s3)
        //     $display("staled");
        // else if (!`L15_PIPE1.noc1_req_val_s3)
        //     $display("invalid");
        // else if (`L15_PIPE1.noc1_req_val_s3 && !`L15_PIPE1.noc1encoder_req_staled_s3)
        // begin
        //     $display("fresh");
        // end

        // $write("NoC3 pipe info: ");
        // if (`L15_PIPE1.noc3_req_val_s3 && `L15_PIPE1.noc3encoder_req_staled_s3)
        //     $display("staled");
        // else if (!`L15_PIPE1.noc3_req_val_s3)
        //     $display("invalid");
        // else if (`L15_PIPE1.noc3_req_val_s3 && !`L15_PIPE1.noc3encoder_req_staled_s3)
        // begin
        //     $display("fresh");
        // end

        // $write("CPX pipe info: ");
        // if (`L15_PIPE1.cpx_req_val_s3 && `L15_PIPE1.cpxencoder_req_staled_s3)
        //     $display("staled");
        // else if (!`L15_PIPE1.cpx_req_val_s3)
        //     $display("invalid");
        // else if (`L15_PIPE1.cpx_req_val_s3 && !`L15_PIPE1.cpxencoder_req_staled_s3)
        // begin
        //     $display("fresh");
        // end

            // Stage 1 debug information
        if (`L15_PIPE1.stall_s1 === 1'bx)
            $display("S1 stall is XXXXXXX");
        if (`L15_PIPE1.val_s1 && !`L15_PIPE1.stall_s1)
        begin
            $write("Stage 1 status: ");
            $write("   Operation: "); decode_predecode_reqtype(`L15_PIPE1.predecode_reqtype_s1);
            $display("   TILE1 S1 Address: 0x%x", `L15_PIPE1.predecode_address_s1);
            // if (`L15_PIPE1.decoder_dtag_operation_s1 == `L15_DTAG_OP_READ)
            // begin
            //     $display("   DTAG OP: L15_DTAG_OP_READ");
            //     $display("      Index: 0x%x", `L15_PIPE1.dtag_index);
            // end
            // if (`L15_PIPE1.l15_dtag_rw_s1 == `L15_DTAG_RW_WRITE)
            // begin
            //     $display("   DTAG OP: L15_DTAG_OP_WRITE");
            //     $display("      Data:  0x%x", `L15_PIPE1.dtag_write_tag_s1);
            //     $display("      Way:  0x%x", `L15_PIPE1.dtag_write_way_s1);
            //     // $display("      Mask: 0x%x", `L15_PIPE1.dtag_write_mask);
            // end
            // if (`L15_PIPE1.s1_mshr_write_val_s1)
            // begin
            //     $display("   DTAG OP: ");
            //     if (`L15_PIPE1.s1_mshr_write_type_s1 == `L15_MSHR_WRITE_TYPE_ALLOCATION)
            //     begin
            //         $write ("L15_MSHR_WRITE_TYPE_ALLOCATION");
            //         $display ("      MSRID: %d", `L15_PIPE1.s1_mshr_write_mshrid_s1);
            //     end
            //     else if (`L15_PIPE1.s1_mshr_write_type_s1 == `L15_S1_MSHR_OP_UPDATE_WRITECACHE)
            //     begin
            //         $write ("L15_S1_MSHR_OP_UPDATE_WRITECACHE");
            //         $display ("      MSRID:     %d", `L15_PIPE1.s1_mshr_write_mshrid_s1);
            //         $display ("      DATA:      0x%x", `L15_PIPE1.s1_mshr_write_data);
            //         $display ("      DATAMASK:  0x%x", `L15_PIPE1.s1_mshr_write_byte_mask);
            //     end
            // end
        end
        // Stage 2 debug information
        if (`L15_PIPE1.stall_s2 === 1'bx)
            $display("S2 stall is XXXXXXX");
        if (`L15_PIPE1.val_s2 && !`L15_PIPE1.stall_s2)
        begin
        $write("Stage 2 status: ");
            $write("   Operation: "); decode_predecode_reqtype(`L15_PIPE1.predecode_reqtype_s2);
            $display("   TILE1 S2 Address: 0x%x", `L15_PIPE1.address_s2);
            $display("   TILE1 S2 Cache index: %d", `L15_PIPE1.cache_index_s2);

            if (`L15_PIPE1.csm_req_val_s2)
            begin
                $display("   CSM op: %d", `L15_PIPE1.csm_op_s2);
                if (`L15_PIPE1.l15_csm_req_type_s2 == 1'b0)
                    $display("      CSM read ticket: 0x%x", `L15_PIPE1.l15_csm_req_ticket_s2);
                else
                begin
                    $display("      CSM write ticket: 0x%x", `L15_PIPE1.l15_csm_req_ticket_s2);
                    $display("      CSM write data: 0x%x", `L15_PIPE1.l15_csm_req_data_s2);
                end
            end

            // $display("   Source chipid: %d", `L15_PIPE1.noc2_src_homeid_s2[`PACKET_HOME_ID_CHIP_MASK]);
            // $display("   Source X: %d", `L15_PIPE1.noc2_src_homeid_s2[`PACKET_HOME_ID_X_MASK]);
            // $display("   Source Y: %d", `L15_PIPE1.noc2_src_homeid_s2[`PACKET_HOME_ID_Y_MASK]);
            // `ifdef L15_EXTRA_DEBUG
            // $display("   LRU state: %d", `L15_PIPE1.lru_state_s2);
            // $display("   LRU way: %d", `L15_PIPE1.lru_way_s2);
            // $display("   Tagcheck state: %d", `L15_PIPE1.tagcheck_state_s2);
            // $display("   Tagcheck way: %d", `L15_PIPE1.tagcheck_way_s2);

            if (`L15_PIPE1.decoder_dtag_operation_s2 == `L15_DTAG_OP_READ)
            begin
                $display("   DTAG way0 state: 0x%x", `L15_PIPE1.mesi_state_way0_s2);
                $display("   DTAG way0 data: 0x%x", dtag_tag_way0_s2_TILE1);
                $display("   DTAG way1 state: 0x%x", `L15_PIPE1.mesi_state_way1_s2);
                $display("   DTAG way1 data: 0x%x", dtag_tag_way1_s2_TILE1);
                $display("   DTAG way2 state: 0x%x", `L15_PIPE1.mesi_state_way2_s2);
                $display("   DTAG way2 data: 0x%x", dtag_tag_way2_s2_TILE1);
                $display("   DTAG way3 state: 0x%x", `L15_PIPE1.mesi_state_way3_s2);
                $display("   DTAG way3 data: 0x%x", dtag_tag_way3_s2_TILE1);
            end

            if (`L15_PIPE1.l15_mesi_write_val_s2)
            begin
                $display("   MESI write way: 0x%x", `L15_PIPE1.mesi_write_way_s2);
                $display("   MESI write data: 0x%x", `L15_PIPE1.mesi_write_state_s2);
            end

            // if (`L15_PIPE1.lruarray_write_op_s2 == `L15_LRU_EVICTION)
            // begin
            //     $display("   LRU EVICTION INDEX: %d, WAY: %d", `L15_PIPE1.cache_index_s2,
            //         `L15_PIPE1.lru_way_s2[1:0]);
            // end
            // `endif

            // if (`L15_PIPE1.s2_mesi_operation_s2 == `L15_S2_MESI_READ)
            // begin
            //     $display("   MESI OP: L15_S2_MESI_READ");
            //     $display ("      Index:     %d", `L15_PIPE1.s2_mesi_index_s2);
            // end
            // if (`L15_PIPE1.s2_mshr_val_s2)
            // begin
            //     $display("   MSHR OP: L15_S2_MSHR_OP_READ_WRITE_CACHE");
            //     $display ("      MSHR: %d", `L15_PIPE1.s2_mshr_read_mshrid);
            // end
            if (`L15_PIPE1.dcache_val_s2)
            begin
                // $write("   DCACHE OP: "); decode_dcache_op(`L15_PIPE1.dcache_operation_s2);
                // $display ("      RW:     %d", `L15_PIPE1.dcache_rw);
                // $display ("      Index:      0x%x", `L15_PIPE1.dcache_index);
                // $display ("      Data:  0x%x", `L15_PIPE1.dcache_write_data);
                // $display ("      Data mask:  0x%x", `L15_PIPE1.dcache_write_mask);
                if (`L15_PIPE1.l15_dcache_rw_s2 == 1'b0)
                begin
                    `ifndef NO_RTL_CSM
                    $display("HMT writing: %0b", `L15_PIPE1.l15_hmt_write_data_s2);
                    `endif
                    // TODO
                    // $display("HMT chip: %0b", `L15_PIPE1.wmt_fill_homeid_s2[`PACKET_HOME_ID_CHIP_MASK]);
                    // $display("HMT X: %0b", `L15_PIPE1.wmt_fill_homeid_s2[`PACKET_HOME_ID_X_MASK]);
                    // $display("HMT Y: %0b", `L15_PIPE1.wmt_fill_homeid_s2[`PACKET_HOME_ID_Y_MASK]);
                end
            end
        end

        // Stage 3 debug information
        if (`L15_PIPE1.stall_s3 === 1'bx)
            $display("S3 stall is XXXXXXX");
        if (`L15_PIPE1.val_s3 && !`L15_PIPE1.stall_s3)
        begin
            $write("Stage 3 status: ");
            $write("   Operation: "); decode_predecode_reqtype(`L15_PIPE1.predecode_reqtype_s3);
            $display("   TILE1 S3 Address: 0x%x", `L15_PIPE1.address_s3);
            `ifndef NO_RTL_CSM
            if ((`L15_PIPE1.noc1_homeid_source_s3 == `L15_HOMEID_SRC_HMT && `L15_PIPE1.noc1_req_val_s3)
                || (`L15_PIPE1.noc3_homeid_source_s3 == `L15_HOMEID_SRC_HMT && `L15_PIPE1.noc3_req_val_s3))
            begin
                `ifndef NO_RTL_CSM
                $display("   HMT chipid: %d", `L15_PIPE1.hmt_l15_dout_s3[`L15_CSM_GHID_CHIP_MASK]);
                $display("   HMT X: %d", `L15_PIPE1.hmt_l15_dout_s3[`L15_CSM_GHID_XPOS_MASK]);
                $display("   HMT Y: %d", `L15_PIPE1.hmt_l15_dout_s3[`L15_CSM_GHID_YPOS_MASK]);
                $display("   HMT reading: %0b", `L15_PIPE1.hmt_l15_dout_s3);
                `endif
            end
            `endif
            if (`L15_PIPE1.noc3_homeid_source_s3 == `L15_HOMEID_SRC_NOC2_SOURCE && `L15_PIPE1.noc3_req_val_s3)
            begin
                $display("   Source chipid: %d", `L15_PIPE1.noc2_src_homeid_s3[`PACKET_HOME_ID_CHIP_MASK]);
                $display("   Source X: %d", `L15_PIPE1.noc2_src_homeid_s3[`PACKET_HOME_ID_X_MASK]);
                $display("   Source Y: %d", `L15_PIPE1.noc2_src_homeid_s3[`PACKET_HOME_ID_Y_MASK]);
            end

            if (`L15_PIPE1.cpx_data_source_s3 == `L15_CPX_SOURCE_CSM)
                $display("      CSM read data: 0x%x", `L15_PIPE1.csm_l15_res_data_s3);
            // `ifdef L15_EXTRA_DEBUG
            // $display("   LRU state: %d", `L15_PIPE1.lru_state_s3);
            // $display("   LRU way: %d", `L15_PIPE1.lru_way_s3);
            // $display("   Tagcheck state: %d", `L15_PIPE1.tagcheck_state_s3);
            // $display("   Tagcheck way: %d", `L15_PIPE1.tagcheck_way_s3);
            // `endif

            // if (`L15_PIPE1.s3_mesi_val_s3)
            // begin
            //     $write("   MESI OP: "); decode_s3mesi_op(`L15_PIPE1.s3_mesi_operation_s3);
            //     $display ("      Index:      0x%x", `L15_PIPE1.mesi_write_index);
            //     $display ("      Data:  0x%x", `L15_PIPE1.mesi_write_data);
            //     $display ("      Data mask:  0x%x", `L15_PIPE1.mesi_write_mask);
            // end
            // if (`L15_PIPE1.wmc_val_s3)
            // begin
            //     $write("   WMC OP: "); decode_wmc_op(`L15_PIPE1.wmc_operation_s3);
            //     if (`L15_PIPE1.wmc_rw_s3 == `L15_WMC_OP_READ)
            //     begin
            //         $display ("      wmc_index_s3:      0x%x", `L15_PIPE1.wmc_index_s3);
            //         $display ("      wmc_invalidate_val_s3:      0x%x", `L15_PIPE1.wmc_invalidate_val_s3);
            //         $display ("      wmc_invalidate_way_s3:      0x%x", `L15_PIPE1.wmc_invalidate_way_s3);
            //     end
            //     else if (`L15_PIPE1.wmc_rw_s3 == `L15_WMC_OP_WRITE)
            //     begin
            //         $display ("      wmc_index_s3:      0x%x", `L15_PIPE1.wmc_index_s3);
            //         $display ("      wmc_update_way_s3:      0x%x", `L15_PIPE1.wmc_update_way_s3);
            //         $display ("      wmc_update_data_s3:      0x%x", `L15_PIPE1.wmc_update_data_s3);
            //         $display ("      wmc_invalidate_val_s3:      0x%x", `L15_PIPE1.wmc_invalidate_val_s3);
            //         $display ("      wmc_invalidate_way_s3:      0x%x", `L15_PIPE1.wmc_invalidate_way_s3);
            //     end
            //     $display ("      cpx_inval_way_s3:      0x%x", `L15_PIPE1.cpx_inval_way_s3);
            //     $display ("      wmc_read_way0_data_s3:      0x%x", `L15_PIPE1.wmc_read_way0_data_s3);
            //     $display ("      wmc_read_way1_data_s3:      0x%x", `L15_PIPE1.wmc_read_way1_data_s3);
            //     $display ("      wmc_read_way2_data_s3:      0x%x", `L15_PIPE1.wmc_read_way2_data_s3);
            //     $display ("      wmc_read_way3_data_s3:      0x%x", `L15_PIPE1.wmc_read_way3_data_s3);
            // end
            // if (`L15_PIPE1.s3_mshr_val_s3)
            // begin
            //     $write("   MSHR OP: "); decode_s3mshr_op(`L15_PIPE1.s3_mshr_operation_s3);
            //     $display ("      MSHR:      %d", `L15_PIPE1.s3_mshr_write_mshrid);
            //     $display ("      U.State:      0x%x", `L15_PIPE1.s3_mshr_write_update_state);
            //     $display ("      U.Way:  0x%x", `L15_PIPE1.s3_mshr_write_update_way);
            //     $display ("      St.mshr rand hit:   %d", `L15_PIPE1.LRU_st1_mshr_s3 || `L15_PIPE1.LRU_st2_mshr_s3);
            //     $display ("      St.mshr tag hit:   %d", `L15_PIPE1.tagcheck_st1_mshr_s3 || `L15_PIPE1.tagcheck_st2_mshr_s3);
            // end
            if (wmt_read_val_s3_TILE1)
            begin
                $display("   TILE1 WMT read index: %x", `L15_PIPE1.cache_index_l1d_s3[`L1D_SET_IDX_MASK]);
                // $display("   WMT way0: %x 0x%x", `L15_PIPE1.wmt_data_s3[0][`L15_WMT_VALID_MASK], `L15_PIPE1.wmt_data_s3[0][`L15_WMT_DATA_MASK]);
                // $display("   WMT way1: %x 0x%x", `L15_PIPE1.wmt_data_s3[1][`L15_WMT_VALID_MASK], `L15_PIPE1.wmt_data_s3[1][`L15_WMT_DATA_MASK]);
                // $display("   WMT way2: %x 0x%x", `L15_PIPE1.wmt_data_s3[2][`L15_WMT_VALID_MASK], `L15_PIPE1.wmt_data_s3[2][`L15_WMT_DATA_MASK]);
                // $display("   WMT way3: %x 0x%x", `L15_PIPE1.wmt_data_s3[3][`L15_WMT_VALID_MASK], `L15_PIPE1.wmt_data_s3[3][`L15_WMT_DATA_MASK]);
                for (i = 0; i < `L1D_WAY_COUNT; i = i + 1)
                begin
                    $display("   WMT way%d: %x 0x%x", i, `L15_PIPE1.wmt_data_s3[i][`L15_WMT_VALID_MASK], `L15_PIPE1.wmt_data_s3[i][`L15_WMT_DATA_MASK]);
                end
            end
            if (`L15_PIPE1.l15_wmt_write_val_s3)
            begin
                $display("   TILE1 WMT write index: %x", `L15_PIPE1.cache_index_l1d_s3[`L1D_SET_IDX_MASK]);
                // $display("   WMT write mask: %x", `L15_PIPE1.l15_wmt_write_mask_s3);
                // $display("   WMT write data: %x", `L15_PIPE1.l15_wmt_write_data_s3);
                // $display("   WMT way0 m%x d0x%x", `L15_PIPE1.l15_wmt_write_mask_s3[`L15_WMT_ENTRY_0_MASK], `L15_PIPE1.wmt_write_data_s3[`L15_WMT_ENTRY_0_MASK]);
                // $display("   WMT way1 m%x d0x%x", `L15_PIPE1.l15_wmt_write_mask_s3[`L15_WMT_ENTRY_1_MASK], `L15_PIPE1.wmt_write_data_s3[`L15_WMT_ENTRY_1_MASK]);
                // $display("   WMT way2 m%x d0x%x", `L15_PIPE1.l15_wmt_write_mask_s3[`L15_WMT_ENTRY_2_MASK], `L15_PIPE1.wmt_write_data_s3[`L15_WMT_ENTRY_2_MASK]);
                // $display("   WMT way3 m%x d0x%x", `L15_PIPE1.l15_wmt_write_mask_s3[`L15_WMT_ENTRY_3_MASK], `L15_PIPE1.wmt_write_data_s3[`L15_WMT_ENTRY_3_MASK]);
            end
        end
        $display ("L15_MON_END");
        $display ("");
    end

//CSM monitor
    if(`L15_TOP1.l15_csm.l15_csm_req_val_s2)
    begin
        $display($time, ": TILE1 L15_CSM REQ MON:");
        $display("L15 CSM req addr: 0x%x", `L15_TOP1.l15_csm.l15_csm_req_address_s2);
        $display("L15 CSM req ticket: %d", `L15_TOP1.l15_csm.l15_csm_req_ticket_s2);
        $display("L15 CSM req type: %d", `L15_TOP1.l15_csm.l15_csm_req_type_s2);
        $display("L15 CSM req data: 0x%x", `L15_TOP1.l15_csm.l15_csm_req_data_s2);
        $display("L15 CSM req pcx data: 0x%x", `L15_TOP1.l15_csm.l15_csm_req_pcx_data_s2);
    end
    if(`L15_TOP1.l15_csm.csm_l15_res_val_s3)
    begin
        $display($time, ": TILE1 L15_CSM RES MON:");
        $display("L15 CSM res data: 0x%x", `L15_TOP1.l15_csm.csm_l15_res_data_s3);
    end
    if(`L15_TOP1.l15_csm.csm_l15_read_res_val)
    begin
        $display($time, ": TILE1 L15_CSM READ TICKET MON:");
        $display("L15 CSM read ticket: %d", `L15_TOP1.l15_csm.l15_csm_read_ticket);
        $display("L15 CSM read data: 0x%x", `L15_TOP1.l15_csm.csm_l15_read_res_data);
    end
    if(`L15_TOP1.l15_csm.csm_noc1encoder_req_val)
    begin
        $display($time, ": TILE1 L15_CSM NOC1 REQ MON:");
        $display("L15 CSM noc1 req addr: 0x%x", `L15_TOP1.l15_csm.csm_noc1encoder_req_address);
        $display("L15 CSM noc1 req type: %d", `L15_TOP1.l15_csm.csm_noc1encoder_req_type);
        $display("L15 CSM noc1 req mshrid: %d", `L15_TOP1.l15_csm.csm_noc1encoder_req_mshrid);
    end
    if(`L15_TOP1.l15_csm.noc1encoder_csm_req_ack)
    begin
        $display($time, ": TILE1 L15_CSM NOC1 REQ ACK MON:");
        $display("L15 CSM noc1 req ack: %b", `L15_TOP1.l15_csm.noc1encoder_csm_req_ack);
    end

    if(`L15_TOP1.l15_csm.write_val_s2 && (~`L15_TOP1.l15_csm.ghid_val_s2))
    begin
        $display("L1.5 MON: HMC refills invalid data");
        $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: HMC refills invalid data");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("L1.5 MON: HMC refills invalid data");
    end

// valid mshrid monitor
    // check for incoming messages
    if (`L15_PIPE1.noc2decoder_l15_val && `L15_PIPE1.val_s1 && !`L15_PIPE1.stall_s1)
    begin
        is_csm_mshrid_TILE1 = `L15_PIPE1.noc2decoder_l15_hmc_fill;
        if ((`L15_PIPE1.noc2decoder_l15_reqtype == `MSG_TYPE_NODATA_ACK ||
            `L15_PIPE1.noc2decoder_l15_reqtype == `MSG_TYPE_DATA_ACK)
            && !is_csm_mshrid_TILE1)
        begin
            // first check if mshrid is in range
            if (`L15_PIPE1.noc2decoder_l15_mshrid > 9)
            begin
                $display("L1.5 MON: Received NoC2 message with MSHRID greater than 9 (%d)", `L15_PIPE1.noc2decoder_l15_mshrid);
                $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: Received NoC2 message with MSHRID greater than 9");
                `ifndef VERILATOR
                repeat(5)@(posedge clk)
                `endif
                    `MONITOR_PATH.fail("L1.5 MON: Received NoC2 message with MSHRID greater than 9");
            end

            // now check if it's valid
            // TODO
            // if (`L15_TOP1.mshr.val_array[`L15_PIPE1.noc2decoder_l15_mshrid] != 1'b1)
            // begin
            //     $display("L1.5 MON: Received NoC2 message with invalid MSHRID (%d)", `L15_PIPE1.noc2decoder_l15_mshrid);
            //     $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: Received NoC2 message with invalid MSHRID");
            //     `ifndef VERILATOR
            //     repeat(5)@(posedge clk)
            //     `endif
                //     `MONITOR_PATH.fail("L1.5 MON: Received NoC2 message with invalid MSHRID");
            // end
        end
    end
    // if (`L15_PIPE1.l15_noc1buffer_req_val && !`L15_PIPE1.stall_s3)
    // begin
    //     if (`L15_PIPE1.l15_noc1buffer_req_type != `L15_NOC1_REQTYPE_WRITEBACK_GUARD
    //         && `L15_PIPE1.l15_noc1buffer_req_type != `L15_NOC1_REQTYPE_INTERRUPT_FWD)
    //     begin
    //         if (`L15_TOP1.mshr.val_array[`L15_PIPE1.l15_noc1buffer_req_mshrid] != 1'b1
    //             || `L15_PIPE1.l15_noc1buffer_req_mshrid > 9)
    //         begin
    //             $display("L1.5 MON: Sending NoC1 message with invalid MSHRID (%d)", `L15_PIPE1.l15_noc1buffer_req_mshrid);
    //             $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: Sending NoC1 message with invalid MSHRID");
    //             `ifndef VERILATOR
    //             repeat(5)@(posedge clk)
    //             `endif
        //             `MONITOR_PATH.fail("L1.5 MON: Sending NoC1 message with invalid MSHRID");
    //         end
    //     end
    // end

// monitor PCX buffer full compare to t1 internal buffer mon
`ifdef RTL_SPARC1
`ifndef RTL_SPU
    if ((`CCX_TRANSDUCER1.pcx_buffer.is_req_squashed == 1'b1) && (`SPARC_CORE1.sparc0.lsu.lsu.qctl1.pcx_req_squash == 1'b0))
`else
    if ((`CCX_TRANSDUCER1.pcx_buffer.is_req_squashed == 1'b1) && (`SPARC_CORE1.sparc0.lsu.qctl1.pcx_req_squash == 1'b0))
`endif
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "PCXTILE1 req was valid but squashed in L1.5");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("PCXTILE1 req was valid but squashed in L1.5");
    end
`ifndef RTL_SPU
    if ((`CCX_TRANSDUCER1.pcx_buffer.is_req_squashed == 1'b0) && (`SPARC_CORE1.sparc0.lsu.lsu.qctl1.pcx_req_squash == 1'b1))
`else
    if ((`CCX_TRANSDUCER1.pcx_buffer.is_req_squashed == 1'b0) && (`SPARC_CORE1.sparc0.lsu.qctl1.pcx_req_squash == 1'b1))
`endif
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "PCXTILE1 req was squashed but valid at L1.5");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("PCXTILE1 req was squashed but valid at L1.5");
    end

    // check for squashed atomic
    if ((`CCX_TRANSDUCER1.pcx_buffer.is_req_squashed == 1'b1) && (`CCX_TRANSDUCER1.pcx_buffer.spc_uncore_atomic_req == 1'b1))
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "PCXTILE1 atomic req squashed");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("PCXTILE1 atomic req squashed");
    end
`endif

// monitor FP transactions because it is not supported yet
//     if (`L15_PIPE1.pcxdecoder_l15_val && !`L15_PIPE1.pcx_message_staled_s1 && `L15_PIPE1.val_s1 && !`L15_PIPE1.stall_s1 && !`L15_PIPE1.noc2decoder_l15_val)
//     begin
//         if (`L15_PIPE1.pcxdecoder_l15_rqtype == `PCX_REQTYPE_FP1)
//         begin
//             $display("%d : Simulation -> FAIL(%0s)", $time, "FP requests received but not implemented");
//             `ifndef VERILATOR
//             repeat(5)@(posedge clk)
//             `endif
    //             `MONITOR_PATH.fail("FP requests received but not implemented");
//         end
//     end

// monitor INT_VEC_DIS requests
    if (`L15_PIPE1.pcxdecoder_l15_val && `L15_PIPE1.val_s1 && !`L15_PIPE1.stall_s1 && !`L15_PIPE1.noc2decoder_l15_val)
    begin
        if (`L15_PIPE1.pcxdecoder_l15_rqtype == `PCX_REQTYPE_STORE
            && `L15_PIPE1.pcxdecoder_l15_address == 40'h9800000800)
        begin
            $display("%d : PCX write to INT_VEC_DIS", $time);
            // $display("%d : Simulation -> FAIL(%0s)", $time, "Write to INT_VEC_DIS");
            // `ifndef VERILATOR
            // repeat(5)@(posedge clk)
            // `endif
                // `MONITOR_PATH.fail("Write to INT_VEC_DIS");
        end
    end

// monitor noc1 buffer credit for underflow
    if (`L15_PIPE1.creditman_noc1_avail == 4'd15)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE1 NOC1 credit underflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE1 NOC1 credit underflow");
    end
    if (`L15_PIPE1.creditman_noc1_avail > `NOC1_BUFFER_NUM_SLOTS)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE1 NOC1 credit overflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE1 NOC1 credit overflow");
    end
    if (`L15_PIPE1.creditman_noc1_data_avail == 4'd15)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE1 NOC1 data credit underflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE1 NOC1 data credit underflow");
    end
    if (`L15_PIPE1.creditman_noc1_data_avail > `NOC1_BUFFER_NUM_DATA_SLOTS)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE1 NOC1 data credit overflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE1 NOC1 data credit overflow");
    end

    // check noc1 reserve credit
    if (`L15_PIPE1.creditman_noc1_reserve == 4'd15)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE1 NOC1 reserve credit underflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE1 NOC1 reserve credit underflow");
    end
    if (`L15_PIPE1.creditman_noc1_reserve > `NOC1_BUFFER_NUM_SLOTS)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE1 NOC1 reserve credit overflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE1 NOC1 reserve credit overflow");
    end
    // check reserve logics
    // if (`L15_PIPE1.creditman_noc1_reserve_s3)
    // begin
    //     $display("%d : Simulation -> FAIL(%0s)", $time, "TILE1 NOC1 reserve credit underflow");
    //     `ifndef VERILATOR
    //     repeat(5)@(posedge clk)
    //     `endif
        //     `MONITOR_PATH.fail("TILE1 NOC1 reserve credit underflow");
    // end

// Monitor for "RESERVED" messages
    if (`L15_PIPE1.noc2decoder_l15_val && `L15_PIPE1.val_s1 && !`L15_PIPE1.stall_s1)
    begin
        if (`L15_PIPE1.noc2decoder_l15_reqtype == `MSG_TYPE_RESERVED)
        begin
            $display("%d : Simulation -> FAIL(%0s)", $time, "TILE1 L15 received MSG_TYPE_RESERVED");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("TILE1 L15 received MSG_TYPE_RESERVED");
        end
    end

// Monitor WMT duplicate error
    if (`L15_PIPE1.val_s3)
    begin
        {wmt_read_data_TILE1[3], wmt_read_data_TILE1[2], wmt_read_data_TILE1[1], wmt_read_data_TILE1[0]} = `L15_PIPE1.wmt_l15_data_s3;
        for (i_TILE1 = 0; i_TILE1 < 4; i_TILE1 = i_TILE1+1)
        begin
            for (j_TILE1 = 0; j_TILE1 < i_TILE1; j_TILE1 = j_TILE1 + 1)
            begin
                if ((wmt_read_data_TILE1[i_TILE1][`L15_WMT_VALID_MASK] && wmt_read_data_TILE1[j_TILE1][`L15_WMT_VALID_MASK]) && (wmt_read_data_TILE1[i_TILE1] == wmt_read_data_TILE1[j_TILE1]))
                begin
                    $display("%d : Simulation -> FAIL(%0s)", $time, "TILE1 L15 has error with WMT");
                    `ifndef VERILATOR
                    repeat(5)@(posedge clk)
                    `endif
                        `MONITOR_PATH.fail("TILE1 L15 has error with WMT");
                end
            end
        end
    end

// Monitor tags duplication error (bug #86)
    if (`L15_PIPE1.val_s2 && `L15_PIPE1.decoder_dtag_operation_s2 == `L15_DTAG_OP_READ)
    begin
        tag_data_TILE1[0] = `L15_PIPE1.dtag_tag_way0_s2[`L15_CACHE_TAG_WIDTH-1:0];
        tag_data_TILE1[1] = `L15_PIPE1.dtag_tag_way1_s2[`L15_CACHE_TAG_WIDTH-1:0];
        tag_data_TILE1[2] = `L15_PIPE1.dtag_tag_way2_s2[`L15_CACHE_TAG_WIDTH-1:0];
        tag_data_TILE1[3] = `L15_PIPE1.dtag_tag_way3_s2[`L15_CACHE_TAG_WIDTH-1:0];
        tag_val_TILE1[0] = `L15_PIPE1.mesi_state_way0_s2 != `L15_MESI_STATE_I;
        tag_val_TILE1[1] = `L15_PIPE1.mesi_state_way1_s2 != `L15_MESI_STATE_I;
        tag_val_TILE1[2] = `L15_PIPE1.mesi_state_way2_s2 != `L15_MESI_STATE_I;
        tag_val_TILE1[3] = `L15_PIPE1.mesi_state_way3_s2 != `L15_MESI_STATE_I;
        for (i_TILE1 = 0; i_TILE1 < 4; i_TILE1 = i_TILE1+1)
        begin
            for (j_TILE1 = 0; j_TILE1 < i_TILE1; j_TILE1 = j_TILE1 + 1)
            begin
                if ((tag_val_TILE1[i_TILE1] && tag_val_TILE1[j_TILE1]) && (tag_data_TILE1[i_TILE1] == tag_data_TILE1[j_TILE1]))
                begin
                    $display("%d : Simulation -> FAIL(%0s)", $time, "TILE1 L15 has duplicated tag entry");
                    `ifndef VERILATOR
                    repeat(5)@(posedge clk)
                    `endif
                        `MONITOR_PATH.fail("TILE1 L15 has duplicated tag entry");
                end
            end
        end
    end

// // monitor FP transactions because it is not supported yet
//     if (`L15_TOP1.noc1encoder.sending)
//     begin
//         $display("noc1 flit raw: 0x%x", `L15_TOP1.noc1encoder.flit);
//     end
//     if (`L15_PIPE1.pcxdecoder_l15_val && !`L15_PIPE1.pcx_message_staled_s1 && `L15_PIPE1.val_s1 && !`L15_PIPE1.stall_s1 && !`L15_PIPE1.noc2decoder_l15_val)
//     begin
//         $display("%d : Simulation -> FAIL(%0s)", $time, "FP requests received but not implemented");
//         `ifndef VERILATOR
//         repeat(5)@(posedge clk)
//         `endif
    //         `MONITOR_PATH.fail("FP requests received but not implemented");
//     end


// Monitor FP transactions
//    if (`TILE1.fpu_arb_wrap.pcx_fpio_data_px2[123]
//            && `TILE1.fpu_arb_wrap.pcx_fpio_data_px2[122:119] == 4'b0101)
//    begin
//        $display("TILE1 FPU th%d: Received FP%d",
//                    `TILE1.fpu_arb_wrap.pcx_fpio_data_px2[113:112],
//                    `TILE1.fpu_arb_wrap.pcx_fpio_data_px2[118]);
//    end
//    if (`TILE1.fpu_arb_wrap.fpu_arb_data_rdy
//            && !`TILE1.fpu_arb_wrap.l15_fp_rdy)
//        $display("TILE1 FPU th%d: Sent FP data",
//                    `TILE1.fpu_arb_wrap.fpu_arb_data[135:134]);

// monitor L1.5 way replacement error
    if (`L15_PIPE1.l15_dcache_val_s2
        && `L15_PIPE1.dcache_operation_s2 == `L15_DCACHE_READ_LRU_WAY_IF_M)
    begin
        if (`L15_PIPE1.lruarray_l15_dout_s2[`L15_PIPE1.lru_way_s2] == 1'b1)
        begin
            // replacing a valid line
            if (&`L15_PIPE1.lru_used_bits_s2[3:0] == 1'b0)
            begin
                // and an another entry is 0, then is an error
                $display("%d : Simulation -> FAIL(%0s)", $time, "TILE1 L15 picked the wrong LRU entry");
                `ifndef VERILATOR
                repeat(5)@(posedge clk)
                `endif
                    `MONITOR_PATH.fail("TILE1 L15 picked the wrong LRU entry");
            end
        end
    end

// monitor X's in stall signals
    if (`L15_PIPE1.val_s1 && (`L15_PIPE1.stall_s1 === 1'bx) ||
        `L15_PIPE1.val_s2 && (`L15_PIPE1.stall_s2 === 1'bx) ||
        `L15_PIPE1.val_s3 && (`L15_PIPE1.stall_s3 === 1'bx))
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "L15 has X's in the stall_s1 signal");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("L15 has X's in the stall_s1 signal");
    end

`ifdef RTL_SPARC1
// some checks for l15cpxencoder
    if (`L15_TOP1.l15_transducer_val)
    begin
        if (`L15_TOP1.l15_transducer_inval_icache_inval)
        begin
            $display("%d : Simulation -> FAIL(%0s)", $time, "l15 icache inval is not used");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("l15 icache inval is not used");
        end
        if (`L15_TOP1.l15_transducer_returntype == `CPX_RESTYPE_ATOMIC_RES
            && `L15_TOP1.l15_transducer_inval_dcache_inval)
        begin
            $display("%d : Simulation -> FAIL(%0s)", $time, "l15 CAS inval is not used");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("l15 CAS inval is not used");
        end
    end
`endif

// some checks for l15 noc1 encoder
    if (`L15_TOP1.noc1encoder.sending && `L15_TOP1.noc1encoder.req_type == 0)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "l15 noc1 message is null");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("l15 noc1 message is null");
    end

    end // disable_l15_mon
end

//CORE1 END


// CORE2

reg do_print_stage_TILE2;
integer i_TILE2;
wire [63:0] dtag_tag_way0_s2_TILE2;
wire [63:0] dtag_tag_way1_s2_TILE2;
wire [63:0] dtag_tag_way2_s2_TILE2;
wire [63:0] dtag_tag_way3_s2_TILE2;

assign dtag_tag_way0_s2_TILE2 = (`L15_PIPE2.dtag_tag_way0_s2 << 11);
assign dtag_tag_way1_s2_TILE2 = (`L15_PIPE2.dtag_tag_way1_s2 << 11);
assign dtag_tag_way2_s2_TILE2 = (`L15_PIPE2.dtag_tag_way2_s2 << 11);
assign dtag_tag_way3_s2_TILE2 = (`L15_PIPE2.dtag_tag_way3_s2 << 11);
reg [`L15_CACHE_TAG_WIDTH-1:0] tag_data_TILE2 [0:3];
reg [3:0] tag_val_TILE2;
reg [`L15_WMT_ENTRY_MASK] wmt_read_data_TILE2 [0:3];
integer j_TILE2;
reg is_csm_mshrid_TILE2;

reg wmt_read_val_s3_TILE2;
always @ (posedge clk)
    wmt_read_val_s3_TILE2 <= `L15_PIPE2.l15_wmt_read_val_s2;

always @ (negedge clk)
begin
    if(!$test$plusargs("disable_l15_mon"))
    begin

    // monitoring outgoing noc1/noc3 messages
    if (`L15_TOP2.noc1encoder.sending)
    begin
        $display($time);
        $display("TILE2 noc1 flit raw: 0x%x", `L15_TOP2.noc1encoder.flit);
        $display("   srcX: %d, srcY: %d", `L15_TOP2.noc1encoder.msg_src_xpos, `L15_TOP2.noc1encoder.msg_src_ypos);
        $display("   destX: %d, destY: %d", `L15_TOP2.noc1encoder.msg_dest_l2_xpos, `L15_TOP2.noc1encoder.msg_dest_l2_ypos);
        if ( ^`L15_TOP2.noc1encoder.flit === 1'bx)
        begin
            $display("%d : Simulation -> FAIL(TILE2 noc1 sends X data 0x%x)", $time, `L15_TOP2.noc1encoder.flit);
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("l15_mon: TILE2 noc1 sends X data");
        end

    end




    if (`L15_PIPE2.pcxdecoder_l15_val && `L15_PIPE2.val_s1 && !`L15_PIPE2.stall_s1 && !`L15_PIPE2.noc2decoder_l15_val
        && `L15_PIPE2.fetch_state_s1 == `L15_FETCH_STATE_NORMAL)
    begin
        $write("%0d TILE2 L1.5 th%d: Received PCX ", $time, `L15_PIPE2.pcxdecoder_l15_threadid); decode_pcx_op(`L15_PIPE2.pcxdecoder_l15_rqtype, `L15_PIPE2.pcxdecoder_l15_amo_op);
        $display("   Addr 0x%x, nc %d, size %d, invalall %d, pf %d, bs %d, bsi %d, l1way %d",
                                `L15_PIPE2.pcxdecoder_l15_address, `L15_PIPE2.pcxdecoder_l15_nc, `L15_PIPE2.pcxdecoder_l15_size, `L15_PIPE2.pcxdecoder_l15_invalidate_cacheline,
                                `L15_PIPE2.pcxdecoder_l15_prefetch, `L15_PIPE2.pcxdecoder_l15_blockstore, `L15_PIPE2.pcxdecoder_l15_blockinitstore, `L15_PIPE2.pcxdecoder_l15_l1rplway);
        $display("   Data: 0x%x", `L15_PIPE2.pcxdecoder_l15_data);
        if (`L15_PIPE2.pcxdecoder_l15_csm_data[`TLB_CSM_STATE] == `TLB_CSM_STATE_LOCAL)
        begin
            $display("   CSM HDID: %d, HD_SIZE: %d, SDID: %d, LSID: %d", `L15_PIPE2.pcxdecoder_l15_csm_data[`TLB_CSM_HDID], `L15_PIPE2.pcxdecoder_l15_csm_data[`TLB_CSM_HD_SIZE],
            `L15_PIPE2.pcxdecoder_l15_csm_data[`TLB_CSM_SDID], `L15_PIPE2.pcxdecoder_l15_csm_data[`TLB_CSM_LSID]);
        end
        else if (`L15_PIPE2.pcxdecoder_l15_csm_data[`TLB_CSM_STATE] == `TLB_CSM_STATE_GLOBAL)
        begin
            $display("   CSM CHIPID: %d, X: %d, Y: %d", `L15_PIPE2.pcxdecoder_l15_csm_data[`TLB_CSM_CHIPID], `L15_PIPE2.pcxdecoder_l15_csm_data[`TLB_CSM_X],`L15_PIPE2.pcxdecoder_l15_csm_data[`TLB_CSM_Y]);
        end
        $display("   CSM Data: 0x%x", `L15_PIPE2.pcxdecoder_l15_csm_data);
        /*
        if (noc2decoder_l15_reqtype == `PCX_REQTYPE_STORE)
        if (noc2decoder_l15_reqtype == `PCX_REQTYPE_CAS1)
        begin
        $display("   Cmp.data: 0x%x", `L15_PIPE2.pcxdecoder_l15_data);
        $display("   Swp.data: 0x%x", `L15_PIPE2.pcxdecoder_l15_data_next_entry);
        end
        if (noc2decoder_l15_reqtype == `PCX_REQTYPE_SWP_LOADSTUB)
        begin
        $display("   Swp.data: 0x%x", `L15_PIPE2.pcxdecoder_l15_data);
        end
        */
        if (`L15_PIPE2.pcxdecoder_l15_rqtype == `PCX_REQTYPE_INTERRUPT && `L15_PIPE2.pcxdecoder_l15_data[63] == 1'b0)
        begin
            pcx_interrupt_type = `L15_PIPE2.pcxdecoder_l15_data[17:16];
            pcx_interrupt_dst_chipid = `L15_PIPE2.pcxdecoder_l15_data[31:18];
            pcx_interrupt_dst_y = `L15_PIPE2.pcxdecoder_l15_data[14:12];
            pcx_interrupt_dst_x = `L15_PIPE2.pcxdecoder_l15_data[11:9];
            pcx_interrupt_threadid = `L15_PIPE2.pcxdecoder_l15_data[8];
            pcx_interrupt_vector = `L15_PIPE2.pcxdecoder_l15_data[5:0];
            $display("Interrupt info:");
            $write("    Type: ");
            case(pcx_interrupt_type)
                2'b00:
                    $display("hw int");
                2'b01:
                    $display("reset");
                2'b10:
                    $display("idle");
                2'b11:
                    $display("resume");
            endcase

            $display("    Dst CHIP ID: %d", pcx_interrupt_dst_chipid);
            $display("    Dst X: %d", pcx_interrupt_dst_x);
            $display("    Dst Y: %d", pcx_interrupt_dst_y);
            $display("    Thread ID: %d", pcx_interrupt_threadid);
            $display("    Vector: %d", pcx_interrupt_vector);
        end
    end

    if (`L15_PIPE2.noc2decoder_l15_val && `L15_PIPE2.val_s1 && !`L15_PIPE2.stall_s1)
    begin
        noc2 = 0;
        case(`L15_PIPE2.noc2decoder_l15_reqtype)
        `MSG_TYPE_RESERVED:
            noc2 = "MSG_TYPE_RESERVED";
        `MSG_TYPE_LOAD_FWD:
            noc2 = "MSG_TYPE_LOAD_FWD";
        `MSG_TYPE_STORE_FWD:
            noc2 = "MSG_TYPE_STORE_FWD";
        `MSG_TYPE_INV_FWD:
            noc2 = "MSG_TYPE_INV_FWD";
        `MSG_TYPE_NODATA_ACK:
            noc2 = "MSG_TYPE_NODATA_ACK";
        `MSG_TYPE_DATA_ACK:
            noc2 = "MSG_TYPE_DATA_ACK";
        `MSG_TYPE_NC_LOAD_MEM_ACK:
            noc2 = "MSG_TYPE_NC_LOAD_MEM_ACK";
        `MSG_TYPE_NC_STORE_MEM_ACK:
            noc2 = "MSG_TYPE_NC_STORE_MEM_ACK";
        `MSG_TYPE_INTERRUPT:
            noc2 = "MSG_TYPE_L2_INTERRUPT";
        default:
        begin
            noc2 = "MSG_TYPE_UNKNOWN_ERROR";
            $display("%d : Simulation -> FAIL(%0s)", $time, "L15 mon: error message type from L2");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("L15 mon: error message type from L2");
        end
        endcase

        $write("%0d TILE2 L1.5: Received NOC2 %s", $time, noc2);
        $display("   mshrid %d, l2miss %d, f4b %d, ackstate %d, address 0x%x",
                    `L15_PIPE2.noc2decoder_l15_mshrid, `L15_PIPE2.noc2decoder_l15_l2miss, `L15_PIPE2.noc2decoder_l15_f4b,
                    `L15_PIPE2.noc2decoder_l15_ack_state, `L15_PIPE2.noc2decoder_l15_address);
        $display("   Data1: 0x%x", `L15_PIPE2.noc2decoder_l15_data_0);
        $display("   Data2: 0x%x", `L15_PIPE2.noc2decoder_l15_data_1);
        $display("   Data3: 0x%x", `L15_PIPE2.noc2decoder_l15_data_2);
        $display("   Data4: 0x%x", `L15_PIPE2.noc2decoder_l15_data_3);
    end

    if (`L15_PIPE2.l15_cpxencoder_val && !`L15_PIPE2.stall_s3)
    begin
        cpx = 0;
        case(`L15_PIPE2.l15_cpxencoder_returntype)
            `LOAD_RET:
                cpx = "LOAD_RET";
            `INV_RET:
                cpx = "INV_RET";
            `ST_ACK:
                cpx = "ST_ACK";
            `AT_ACK:
                cpx = "AT_ACK";
            `INT_RET:
                cpx = "INT_RET";
            `TEST_RET:
                cpx = "TEST_RET";
            `FP_RET:
                cpx = "FP_RET";
            `IFILL_RET:
                cpx = "IFILL_RET";
            `EVICT_REQ:
                cpx = "EVICT_REQ";
            `ERR_RET:
                cpx = "ERR_RET";
            `STRLOAD_RET:
                cpx = "STRLOAD_RET";
            `STRST_ACK:
                cpx = "STRST_ACK";
            `FWD_RQ_RET:
                cpx = "FWD_RQ_RET";
            `FWD_RPY_RET:
                cpx = "FWD_RPY_RET";
            `RSVD_RET:
                cpx = "RSVD_RET";
            4'b1110:
                cpx = "ATOMIC_ACK";
            default:
                cpx = "CPX_UNKNOWN";
        endcase
        $write("%0d TILE2 L1.5 th%d: Sent CPX %0s", $time, `L15_PIPE2.l15_cpxencoder_threadid, cpx);
        $display("   l2miss %d, nc %d, atomic %d, threadid %d, pf %d, f4b %d, iia %d, dia %d, dinval %d, iinval %d, invalway %d, blkinit %d",
                    `L15_PIPE2.l15_cpxencoder_l2miss, `L15_PIPE2.l15_cpxencoder_noncacheable, `L15_PIPE2.l15_cpxencoder_atomic,
                    `L15_PIPE2.l15_cpxencoder_threadid, `L15_PIPE2.l15_cpxencoder_prefetch,
                    `L15_PIPE2.l15_cpxencoder_f4b, `L15_PIPE2.l15_cpxencoder_inval_icache_all_way,
                    `L15_PIPE2.l15_cpxencoder_inval_dcache_all_way, `L15_PIPE2.l15_cpxencoder_inval_dcache_inval,
                    `L15_PIPE2.l15_cpxencoder_inval_icache_inval, `L15_PIPE2.l15_cpxencoder_inval_way,
                    `L15_PIPE2.l15_cpxencoder_blockinitstore);
        $display("   Data0: 0x%x", `L15_PIPE2.l15_cpxencoder_data_0);
        $display("   Data1: 0x%x", `L15_PIPE2.l15_cpxencoder_data_1);
        $display("   Data2: 0x%x", `L15_PIPE2.l15_cpxencoder_data_2);
        $display("   Data3: 0x%x", `L15_PIPE2.l15_cpxencoder_data_3);
    end

    if (`L15_TOP2.noc1encoder.noc1encoder_noc1out_val && `L15_TOP2.noc1encoder.noc1encoder_noc1buffer_req_ack)
    begin
        noc1 = 0;
        case(`L15_TOP2.noc1encoder.req_type)
        `L15_NOC1_REQTYPE_WRITEBACK_GUARD:
            noc1 = "L15_NOC1_REQTYPE_WRITEBACK_GUARD";
        `L15_NOC1_REQTYPE_LD_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_LD_REQUEST";
        `L15_NOC1_REQTYPE_IFILL_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_IFILL_REQUEST";
        `L15_NOC1_REQTYPE_WRITETHROUGH_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_WRITETHROUGH_REQUEST";
        `L15_NOC1_REQTYPE_ST_UPGRADE_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_ST_UPGRADE_REQUEST";
        `L15_NOC1_REQTYPE_ST_FILL_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_ST_FILL_REQUEST";
        `L15_NOC1_REQTYPE_CAS_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_CAS_REQUEST";
        `L15_NOC1_REQTYPE_SWAP_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_SWAP_REQUEST";
        `L15_NOC1_REQTYPE_INTERRUPT_FWD:
            noc1 = "L15_NOC1_REQTYPE_INTERRUPT_FWD";
        `L15_NOC1_REQTYPE_AMO_ADD_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_ADD_REQUEST";
        `L15_NOC1_REQTYPE_AMO_AND_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_AND_REQUEST";
        `L15_NOC1_REQTYPE_AMO_OR_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_OR_REQUEST";
        `L15_NOC1_REQTYPE_AMO_XOR_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_XOR_REQUEST";
        `L15_NOC1_REQTYPE_AMO_MAX_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_MAX_REQUEST";
        `L15_NOC1_REQTYPE_AMO_MAXU_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_MAXU_REQUEST";
        `L15_NOC1_REQTYPE_AMO_MIN_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_MIN_REQUEST";
        `L15_NOC1_REQTYPE_AMO_MINU_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_MINU_REQUEST";
        default:
            noc1 = "ERROR noc1";
        endcase

        $write("%0d TILE2 L1.5: Sending NOC1 %s", $time, noc1);
        $display("   mshrid %d, nc %d, size %d, pf %d, address %0x",
                    `L15_TOP2.noc1encoder.noc1buffer_noc1encoder_req_mshrid, `L15_TOP2.noc1encoder.noc1buffer_noc1encoder_req_non_cacheable,
                    `L15_TOP2.noc1encoder.noc1buffer_noc1encoder_req_size, `L15_TOP2.noc1encoder.noc1buffer_noc1encoder_req_prefetch, `L15_TOP2.noc1encoder.noc1buffer_noc1encoder_req_address);
        $display("   Data0: 0x%x", `L15_TOP2.noc1encoder.noc1buffer_noc1encoder_req_data_0);
        $display("   Data1: 0x%x", `L15_TOP2.noc1encoder.noc1buffer_noc1encoder_req_data_1);
        $display("   Destination X: %d Y: %d", `L15_TOP2.noc1encoder.msg_dest_l2_xpos, `L15_TOP2.noc1encoder.msg_dest_l2_ypos);
    end

    if (`L15_TOP2.noc3encoder.noc3encoder_noc3out_val && `L15_TOP2.noc3encoder.noc3encoder_l15_req_ack)
    begin
        noc3 = 0;
        case(`L15_TOP2.noc3encoder.l15_noc3encoder_req_type)
        `L15_NOC3_REQTYPE_WRITEBACK:
            noc3 = "L15_NOC3_REQTYPE_WRITEBACK";
        `L15_NOC3_REQTYPE_INVAL_ACK:
            noc3 = "L15_NOC3_REQTYPE_INVAL_ACK";
        `L15_NOC3_REQTYPE_DOWNGRADE_ACK:
            noc3 = "L15_NOC3_REQTYPE_DOWNGRADE_ACK";
        `L15_NOC3_REQTYPE_ICACHE_INVAL_ACK:
            noc3 = "L15_NOC3_REQTYPE_ICACHE_INVAL_ACK";
        default:
            noc3 = "ERROR NOC3";
        endcase

        // quick check for an error case
        if (`L15_TOP2.noc3encoder.msg_type == `MSG_TYPE_INV_FWDACK
            && `L15_TOP2.noc3encoder.l15_noc3encoder_req_with_data)
        begin
            $display("L1.5 MON: sending back invalid ack with data");
            $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: sending back invalid ack with data");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("L1.5 MON: sending back invalid ack with data");
        end


        $write("%0d TILE2 L1.5: Sent NOC3 %s", $time, noc3);
        $display("   mshrid %d, seqid %d, address %0x",
                    `L15_TOP2.noc3encoder.l15_noc3encoder_req_mshrid, `L15_TOP2.noc3encoder.l15_noc3encoder_req_sequenceid, `L15_TOP2.noc3encoder.l15_noc3encoder_req_address);
        $display("   srcX: %d, srcY: %d", `L15_TOP2.noc3encoder.src_l2_xpos, `L15_TOP2.noc3encoder.src_l2_ypos);
        $display("   destX: %d, destY: %d", `L15_TOP2.noc3encoder.dest_l2_xpos, `L15_TOP2.noc3encoder.dest_l2_ypos);
        $display("   Data0: 0x%x", `L15_TOP2.noc3encoder.l15_noc3encoder_req_data_0);
        $display("   Data1: 0x%x", `L15_TOP2.noc3encoder.l15_noc3encoder_req_data_1);
    end

    do_print_stage_TILE2 = ((`L15_PIPE2.val_s1 && !`L15_PIPE2.stall_s1) || (`L15_PIPE2.val_s2 && !`L15_PIPE2.stall_s2) || (`L15_PIPE2.val_s3 && !`L15_PIPE2.stall_s3));
    if (do_print_stage_TILE2)
    begin
        // $display("");
        $display("");
        $display($time, " L15 TILE2:");
        $display("NoC1 credit: %d", `L15_PIPE2.creditman_noc1_avail);
        $display("NoC1 reserved credit: %d", `L15_PIPE2.creditman_noc1_reserve);
        // $display("NoC1 r down: %d", `L15_PIPE2.creditman_noc1_reserve_minus1);
        // $display("NoC1 r up: %d", `L15_PIPE2.creditman_noc1_reserve_add1);

        // monitor the MSHRID allocation
        // $display("MSHRID allocation info:");
        // for (i_TILE2 = 0; i_TILE2 < `L15_MSHR_COUNT; i_TILE2 = i_TILE2 + 1)
        //     $write("%d:%d", i_TILE2, `L15_PIPE2.mshr_val_array[i_TILE2]);
            // $write("%d %d", i_TILE2, i_TILE2);
        // $display("");

`ifdef RTL_SPARC2
        $display("Core STB info:");
        $display("  STB0: %d", `SPARC_CORE2.sparc0.ifu.lsu_ifu_stbcnt0);
        $display("  STB1: %d", `SPARC_CORE2.sparc0.ifu.lsu_ifu_stbcnt1);
            // $write("%d %d", i_TILE2, i_TILE2);
`endif

        $write("TILE2 Pipeline:");
        if (`L15_PIPE2.val_s1 && !`L15_PIPE2.stall_s1)
            $write(" * ");
        else if (`L15_PIPE2.val_s1 && `L15_PIPE2.stall_s1)
            $write(" = ");
        else
            $write(" X ");

        if (`L15_PIPE2.val_s2 && !`L15_PIPE2.stall_s2)
            $write(" * ");
        else if (`L15_PIPE2.val_s2 && `L15_PIPE2.stall_s2)
            $write(" = ");
        else
            $write(" X ");

        if (`L15_PIPE2.val_s3 && !`L15_PIPE2.stall_s3)
            $write(" * ");
        else if (`L15_PIPE2.val_s3 && `L15_PIPE2.stall_s3)
            $write(" = ");
        else
            $write(" X ");
        $display("");

        // $write("PCX pipe info: "); decode_pcx_op(`L15_PIPE2.pcxdecoder_l15_rqtype, L15_PIPE2.pcxdecoder_l15_amo_op);
        // if (`L15_PIPE2.noc1_req_val_s3 && `L15_PIPE2.noc1encoder_req_staled_s3)
        //     $display(" (staled)");
        // else if (!`L15_PIPE2.noc1_req_val_s3)
        //     $display(" (invalid)");
        // else if (`L15_PIPE2.noc1_req_val_s3 && !`L15_PIPE2.noc1encoder_req_staled_s3)
        // begin
        //     $display(" (fresh)");
        // end

        // $write("NoC1 pipe info: ");
        // if (`L15_PIPE2.noc1_req_val_s3 && `L15_PIPE2.noc1encoder_req_staled_s3)
        //     $display("staled");
        // else if (!`L15_PIPE2.noc1_req_val_s3)
        //     $display("invalid");
        // else if (`L15_PIPE2.noc1_req_val_s3 && !`L15_PIPE2.noc1encoder_req_staled_s3)
        // begin
        //     $display("fresh");
        // end

        // $write("NoC3 pipe info: ");
        // if (`L15_PIPE2.noc3_req_val_s3 && `L15_PIPE2.noc3encoder_req_staled_s3)
        //     $display("staled");
        // else if (!`L15_PIPE2.noc3_req_val_s3)
        //     $display("invalid");
        // else if (`L15_PIPE2.noc3_req_val_s3 && !`L15_PIPE2.noc3encoder_req_staled_s3)
        // begin
        //     $display("fresh");
        // end

        // $write("CPX pipe info: ");
        // if (`L15_PIPE2.cpx_req_val_s3 && `L15_PIPE2.cpxencoder_req_staled_s3)
        //     $display("staled");
        // else if (!`L15_PIPE2.cpx_req_val_s3)
        //     $display("invalid");
        // else if (`L15_PIPE2.cpx_req_val_s3 && !`L15_PIPE2.cpxencoder_req_staled_s3)
        // begin
        //     $display("fresh");
        // end

            // Stage 1 debug information
        if (`L15_PIPE2.stall_s1 === 1'bx)
            $display("S1 stall is XXXXXXX");
        if (`L15_PIPE2.val_s1 && !`L15_PIPE2.stall_s1)
        begin
            $write("Stage 1 status: ");
            $write("   Operation: "); decode_predecode_reqtype(`L15_PIPE2.predecode_reqtype_s1);
            $display("   TILE2 S1 Address: 0x%x", `L15_PIPE2.predecode_address_s1);
            // if (`L15_PIPE2.decoder_dtag_operation_s1 == `L15_DTAG_OP_READ)
            // begin
            //     $display("   DTAG OP: L15_DTAG_OP_READ");
            //     $display("      Index: 0x%x", `L15_PIPE2.dtag_index);
            // end
            // if (`L15_PIPE2.l15_dtag_rw_s1 == `L15_DTAG_RW_WRITE)
            // begin
            //     $display("   DTAG OP: L15_DTAG_OP_WRITE");
            //     $display("      Data:  0x%x", `L15_PIPE2.dtag_write_tag_s1);
            //     $display("      Way:  0x%x", `L15_PIPE2.dtag_write_way_s1);
            //     // $display("      Mask: 0x%x", `L15_PIPE2.dtag_write_mask);
            // end
            // if (`L15_PIPE2.s1_mshr_write_val_s1)
            // begin
            //     $display("   DTAG OP: ");
            //     if (`L15_PIPE2.s1_mshr_write_type_s1 == `L15_MSHR_WRITE_TYPE_ALLOCATION)
            //     begin
            //         $write ("L15_MSHR_WRITE_TYPE_ALLOCATION");
            //         $display ("      MSRID: %d", `L15_PIPE2.s1_mshr_write_mshrid_s1);
            //     end
            //     else if (`L15_PIPE2.s1_mshr_write_type_s1 == `L15_S1_MSHR_OP_UPDATE_WRITECACHE)
            //     begin
            //         $write ("L15_S1_MSHR_OP_UPDATE_WRITECACHE");
            //         $display ("      MSRID:     %d", `L15_PIPE2.s1_mshr_write_mshrid_s1);
            //         $display ("      DATA:      0x%x", `L15_PIPE2.s1_mshr_write_data);
            //         $display ("      DATAMASK:  0x%x", `L15_PIPE2.s1_mshr_write_byte_mask);
            //     end
            // end
        end
        // Stage 2 debug information
        if (`L15_PIPE2.stall_s2 === 1'bx)
            $display("S2 stall is XXXXXXX");
        if (`L15_PIPE2.val_s2 && !`L15_PIPE2.stall_s2)
        begin
        $write("Stage 2 status: ");
            $write("   Operation: "); decode_predecode_reqtype(`L15_PIPE2.predecode_reqtype_s2);
            $display("   TILE2 S2 Address: 0x%x", `L15_PIPE2.address_s2);
            $display("   TILE2 S2 Cache index: %d", `L15_PIPE2.cache_index_s2);

            if (`L15_PIPE2.csm_req_val_s2)
            begin
                $display("   CSM op: %d", `L15_PIPE2.csm_op_s2);
                if (`L15_PIPE2.l15_csm_req_type_s2 == 1'b0)
                    $display("      CSM read ticket: 0x%x", `L15_PIPE2.l15_csm_req_ticket_s2);
                else
                begin
                    $display("      CSM write ticket: 0x%x", `L15_PIPE2.l15_csm_req_ticket_s2);
                    $display("      CSM write data: 0x%x", `L15_PIPE2.l15_csm_req_data_s2);
                end
            end

            // $display("   Source chipid: %d", `L15_PIPE2.noc2_src_homeid_s2[`PACKET_HOME_ID_CHIP_MASK]);
            // $display("   Source X: %d", `L15_PIPE2.noc2_src_homeid_s2[`PACKET_HOME_ID_X_MASK]);
            // $display("   Source Y: %d", `L15_PIPE2.noc2_src_homeid_s2[`PACKET_HOME_ID_Y_MASK]);
            // `ifdef L15_EXTRA_DEBUG
            // $display("   LRU state: %d", `L15_PIPE2.lru_state_s2);
            // $display("   LRU way: %d", `L15_PIPE2.lru_way_s2);
            // $display("   Tagcheck state: %d", `L15_PIPE2.tagcheck_state_s2);
            // $display("   Tagcheck way: %d", `L15_PIPE2.tagcheck_way_s2);

            if (`L15_PIPE2.decoder_dtag_operation_s2 == `L15_DTAG_OP_READ)
            begin
                $display("   DTAG way0 state: 0x%x", `L15_PIPE2.mesi_state_way0_s2);
                $display("   DTAG way0 data: 0x%x", dtag_tag_way0_s2_TILE2);
                $display("   DTAG way1 state: 0x%x", `L15_PIPE2.mesi_state_way1_s2);
                $display("   DTAG way1 data: 0x%x", dtag_tag_way1_s2_TILE2);
                $display("   DTAG way2 state: 0x%x", `L15_PIPE2.mesi_state_way2_s2);
                $display("   DTAG way2 data: 0x%x", dtag_tag_way2_s2_TILE2);
                $display("   DTAG way3 state: 0x%x", `L15_PIPE2.mesi_state_way3_s2);
                $display("   DTAG way3 data: 0x%x", dtag_tag_way3_s2_TILE2);
            end

            if (`L15_PIPE2.l15_mesi_write_val_s2)
            begin
                $display("   MESI write way: 0x%x", `L15_PIPE2.mesi_write_way_s2);
                $display("   MESI write data: 0x%x", `L15_PIPE2.mesi_write_state_s2);
            end

            // if (`L15_PIPE2.lruarray_write_op_s2 == `L15_LRU_EVICTION)
            // begin
            //     $display("   LRU EVICTION INDEX: %d, WAY: %d", `L15_PIPE2.cache_index_s2,
            //         `L15_PIPE2.lru_way_s2[1:0]);
            // end
            // `endif

            // if (`L15_PIPE2.s2_mesi_operation_s2 == `L15_S2_MESI_READ)
            // begin
            //     $display("   MESI OP: L15_S2_MESI_READ");
            //     $display ("      Index:     %d", `L15_PIPE2.s2_mesi_index_s2);
            // end
            // if (`L15_PIPE2.s2_mshr_val_s2)
            // begin
            //     $display("   MSHR OP: L15_S2_MSHR_OP_READ_WRITE_CACHE");
            //     $display ("      MSHR: %d", `L15_PIPE2.s2_mshr_read_mshrid);
            // end
            if (`L15_PIPE2.dcache_val_s2)
            begin
                // $write("   DCACHE OP: "); decode_dcache_op(`L15_PIPE2.dcache_operation_s2);
                // $display ("      RW:     %d", `L15_PIPE2.dcache_rw);
                // $display ("      Index:      0x%x", `L15_PIPE2.dcache_index);
                // $display ("      Data:  0x%x", `L15_PIPE2.dcache_write_data);
                // $display ("      Data mask:  0x%x", `L15_PIPE2.dcache_write_mask);
                if (`L15_PIPE2.l15_dcache_rw_s2 == 1'b0)
                begin
                    `ifndef NO_RTL_CSM
                    $display("HMT writing: %0b", `L15_PIPE2.l15_hmt_write_data_s2);
                    `endif
                    // TODO
                    // $display("HMT chip: %0b", `L15_PIPE2.wmt_fill_homeid_s2[`PACKET_HOME_ID_CHIP_MASK]);
                    // $display("HMT X: %0b", `L15_PIPE2.wmt_fill_homeid_s2[`PACKET_HOME_ID_X_MASK]);
                    // $display("HMT Y: %0b", `L15_PIPE2.wmt_fill_homeid_s2[`PACKET_HOME_ID_Y_MASK]);
                end
            end
        end

        // Stage 3 debug information
        if (`L15_PIPE2.stall_s3 === 1'bx)
            $display("S3 stall is XXXXXXX");
        if (`L15_PIPE2.val_s3 && !`L15_PIPE2.stall_s3)
        begin
            $write("Stage 3 status: ");
            $write("   Operation: "); decode_predecode_reqtype(`L15_PIPE2.predecode_reqtype_s3);
            $display("   TILE2 S3 Address: 0x%x", `L15_PIPE2.address_s3);
            `ifndef NO_RTL_CSM
            if ((`L15_PIPE2.noc1_homeid_source_s3 == `L15_HOMEID_SRC_HMT && `L15_PIPE2.noc1_req_val_s3)
                || (`L15_PIPE2.noc3_homeid_source_s3 == `L15_HOMEID_SRC_HMT && `L15_PIPE2.noc3_req_val_s3))
            begin
                `ifndef NO_RTL_CSM
                $display("   HMT chipid: %d", `L15_PIPE2.hmt_l15_dout_s3[`L15_CSM_GHID_CHIP_MASK]);
                $display("   HMT X: %d", `L15_PIPE2.hmt_l15_dout_s3[`L15_CSM_GHID_XPOS_MASK]);
                $display("   HMT Y: %d", `L15_PIPE2.hmt_l15_dout_s3[`L15_CSM_GHID_YPOS_MASK]);
                $display("   HMT reading: %0b", `L15_PIPE2.hmt_l15_dout_s3);
                `endif
            end
            `endif
            if (`L15_PIPE2.noc3_homeid_source_s3 == `L15_HOMEID_SRC_NOC2_SOURCE && `L15_PIPE2.noc3_req_val_s3)
            begin
                $display("   Source chipid: %d", `L15_PIPE2.noc2_src_homeid_s3[`PACKET_HOME_ID_CHIP_MASK]);
                $display("   Source X: %d", `L15_PIPE2.noc2_src_homeid_s3[`PACKET_HOME_ID_X_MASK]);
                $display("   Source Y: %d", `L15_PIPE2.noc2_src_homeid_s3[`PACKET_HOME_ID_Y_MASK]);
            end

            if (`L15_PIPE2.cpx_data_source_s3 == `L15_CPX_SOURCE_CSM)
                $display("      CSM read data: 0x%x", `L15_PIPE2.csm_l15_res_data_s3);
            // `ifdef L15_EXTRA_DEBUG
            // $display("   LRU state: %d", `L15_PIPE2.lru_state_s3);
            // $display("   LRU way: %d", `L15_PIPE2.lru_way_s3);
            // $display("   Tagcheck state: %d", `L15_PIPE2.tagcheck_state_s3);
            // $display("   Tagcheck way: %d", `L15_PIPE2.tagcheck_way_s3);
            // `endif

            // if (`L15_PIPE2.s3_mesi_val_s3)
            // begin
            //     $write("   MESI OP: "); decode_s3mesi_op(`L15_PIPE2.s3_mesi_operation_s3);
            //     $display ("      Index:      0x%x", `L15_PIPE2.mesi_write_index);
            //     $display ("      Data:  0x%x", `L15_PIPE2.mesi_write_data);
            //     $display ("      Data mask:  0x%x", `L15_PIPE2.mesi_write_mask);
            // end
            // if (`L15_PIPE2.wmc_val_s3)
            // begin
            //     $write("   WMC OP: "); decode_wmc_op(`L15_PIPE2.wmc_operation_s3);
            //     if (`L15_PIPE2.wmc_rw_s3 == `L15_WMC_OP_READ)
            //     begin
            //         $display ("      wmc_index_s3:      0x%x", `L15_PIPE2.wmc_index_s3);
            //         $display ("      wmc_invalidate_val_s3:      0x%x", `L15_PIPE2.wmc_invalidate_val_s3);
            //         $display ("      wmc_invalidate_way_s3:      0x%x", `L15_PIPE2.wmc_invalidate_way_s3);
            //     end
            //     else if (`L15_PIPE2.wmc_rw_s3 == `L15_WMC_OP_WRITE)
            //     begin
            //         $display ("      wmc_index_s3:      0x%x", `L15_PIPE2.wmc_index_s3);
            //         $display ("      wmc_update_way_s3:      0x%x", `L15_PIPE2.wmc_update_way_s3);
            //         $display ("      wmc_update_data_s3:      0x%x", `L15_PIPE2.wmc_update_data_s3);
            //         $display ("      wmc_invalidate_val_s3:      0x%x", `L15_PIPE2.wmc_invalidate_val_s3);
            //         $display ("      wmc_invalidate_way_s3:      0x%x", `L15_PIPE2.wmc_invalidate_way_s3);
            //     end
            //     $display ("      cpx_inval_way_s3:      0x%x", `L15_PIPE2.cpx_inval_way_s3);
            //     $display ("      wmc_read_way0_data_s3:      0x%x", `L15_PIPE2.wmc_read_way0_data_s3);
            //     $display ("      wmc_read_way1_data_s3:      0x%x", `L15_PIPE2.wmc_read_way1_data_s3);
            //     $display ("      wmc_read_way2_data_s3:      0x%x", `L15_PIPE2.wmc_read_way2_data_s3);
            //     $display ("      wmc_read_way3_data_s3:      0x%x", `L15_PIPE2.wmc_read_way3_data_s3);
            // end
            // if (`L15_PIPE2.s3_mshr_val_s3)
            // begin
            //     $write("   MSHR OP: "); decode_s3mshr_op(`L15_PIPE2.s3_mshr_operation_s3);
            //     $display ("      MSHR:      %d", `L15_PIPE2.s3_mshr_write_mshrid);
            //     $display ("      U.State:      0x%x", `L15_PIPE2.s3_mshr_write_update_state);
            //     $display ("      U.Way:  0x%x", `L15_PIPE2.s3_mshr_write_update_way);
            //     $display ("      St.mshr rand hit:   %d", `L15_PIPE2.LRU_st1_mshr_s3 || `L15_PIPE2.LRU_st2_mshr_s3);
            //     $display ("      St.mshr tag hit:   %d", `L15_PIPE2.tagcheck_st1_mshr_s3 || `L15_PIPE2.tagcheck_st2_mshr_s3);
            // end
            if (wmt_read_val_s3_TILE2)
            begin
                $display("   TILE2 WMT read index: %x", `L15_PIPE2.cache_index_l1d_s3[`L1D_SET_IDX_MASK]);
                // $display("   WMT way0: %x 0x%x", `L15_PIPE2.wmt_data_s3[0][`L15_WMT_VALID_MASK], `L15_PIPE2.wmt_data_s3[0][`L15_WMT_DATA_MASK]);
                // $display("   WMT way1: %x 0x%x", `L15_PIPE2.wmt_data_s3[1][`L15_WMT_VALID_MASK], `L15_PIPE2.wmt_data_s3[1][`L15_WMT_DATA_MASK]);
                // $display("   WMT way2: %x 0x%x", `L15_PIPE2.wmt_data_s3[2][`L15_WMT_VALID_MASK], `L15_PIPE2.wmt_data_s3[2][`L15_WMT_DATA_MASK]);
                // $display("   WMT way3: %x 0x%x", `L15_PIPE2.wmt_data_s3[3][`L15_WMT_VALID_MASK], `L15_PIPE2.wmt_data_s3[3][`L15_WMT_DATA_MASK]);
                for (i = 0; i < `L1D_WAY_COUNT; i = i + 1)
                begin
                    $display("   WMT way%d: %x 0x%x", i, `L15_PIPE2.wmt_data_s3[i][`L15_WMT_VALID_MASK], `L15_PIPE2.wmt_data_s3[i][`L15_WMT_DATA_MASK]);
                end
            end
            if (`L15_PIPE2.l15_wmt_write_val_s3)
            begin
                $display("   TILE2 WMT write index: %x", `L15_PIPE2.cache_index_l1d_s3[`L1D_SET_IDX_MASK]);
                // $display("   WMT write mask: %x", `L15_PIPE2.l15_wmt_write_mask_s3);
                // $display("   WMT write data: %x", `L15_PIPE2.l15_wmt_write_data_s3);
                // $display("   WMT way0 m%x d0x%x", `L15_PIPE2.l15_wmt_write_mask_s3[`L15_WMT_ENTRY_0_MASK], `L15_PIPE2.wmt_write_data_s3[`L15_WMT_ENTRY_0_MASK]);
                // $display("   WMT way1 m%x d0x%x", `L15_PIPE2.l15_wmt_write_mask_s3[`L15_WMT_ENTRY_1_MASK], `L15_PIPE2.wmt_write_data_s3[`L15_WMT_ENTRY_1_MASK]);
                // $display("   WMT way2 m%x d0x%x", `L15_PIPE2.l15_wmt_write_mask_s3[`L15_WMT_ENTRY_2_MASK], `L15_PIPE2.wmt_write_data_s3[`L15_WMT_ENTRY_2_MASK]);
                // $display("   WMT way3 m%x d0x%x", `L15_PIPE2.l15_wmt_write_mask_s3[`L15_WMT_ENTRY_3_MASK], `L15_PIPE2.wmt_write_data_s3[`L15_WMT_ENTRY_3_MASK]);
            end
        end
        $display ("L15_MON_END");
        $display ("");
    end

//CSM monitor
    if(`L15_TOP2.l15_csm.l15_csm_req_val_s2)
    begin
        $display($time, ": TILE2 L15_CSM REQ MON:");
        $display("L15 CSM req addr: 0x%x", `L15_TOP2.l15_csm.l15_csm_req_address_s2);
        $display("L15 CSM req ticket: %d", `L15_TOP2.l15_csm.l15_csm_req_ticket_s2);
        $display("L15 CSM req type: %d", `L15_TOP2.l15_csm.l15_csm_req_type_s2);
        $display("L15 CSM req data: 0x%x", `L15_TOP2.l15_csm.l15_csm_req_data_s2);
        $display("L15 CSM req pcx data: 0x%x", `L15_TOP2.l15_csm.l15_csm_req_pcx_data_s2);
    end
    if(`L15_TOP2.l15_csm.csm_l15_res_val_s3)
    begin
        $display($time, ": TILE2 L15_CSM RES MON:");
        $display("L15 CSM res data: 0x%x", `L15_TOP2.l15_csm.csm_l15_res_data_s3);
    end
    if(`L15_TOP2.l15_csm.csm_l15_read_res_val)
    begin
        $display($time, ": TILE2 L15_CSM READ TICKET MON:");
        $display("L15 CSM read ticket: %d", `L15_TOP2.l15_csm.l15_csm_read_ticket);
        $display("L15 CSM read data: 0x%x", `L15_TOP2.l15_csm.csm_l15_read_res_data);
    end
    if(`L15_TOP2.l15_csm.csm_noc1encoder_req_val)
    begin
        $display($time, ": TILE2 L15_CSM NOC1 REQ MON:");
        $display("L15 CSM noc1 req addr: 0x%x", `L15_TOP2.l15_csm.csm_noc1encoder_req_address);
        $display("L15 CSM noc1 req type: %d", `L15_TOP2.l15_csm.csm_noc1encoder_req_type);
        $display("L15 CSM noc1 req mshrid: %d", `L15_TOP2.l15_csm.csm_noc1encoder_req_mshrid);
    end
    if(`L15_TOP2.l15_csm.noc1encoder_csm_req_ack)
    begin
        $display($time, ": TILE2 L15_CSM NOC1 REQ ACK MON:");
        $display("L15 CSM noc1 req ack: %b", `L15_TOP2.l15_csm.noc1encoder_csm_req_ack);
    end

    if(`L15_TOP2.l15_csm.write_val_s2 && (~`L15_TOP2.l15_csm.ghid_val_s2))
    begin
        $display("L1.5 MON: HMC refills invalid data");
        $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: HMC refills invalid data");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("L1.5 MON: HMC refills invalid data");
    end

// valid mshrid monitor
    // check for incoming messages
    if (`L15_PIPE2.noc2decoder_l15_val && `L15_PIPE2.val_s1 && !`L15_PIPE2.stall_s1)
    begin
        is_csm_mshrid_TILE2 = `L15_PIPE2.noc2decoder_l15_hmc_fill;
        if ((`L15_PIPE2.noc2decoder_l15_reqtype == `MSG_TYPE_NODATA_ACK ||
            `L15_PIPE2.noc2decoder_l15_reqtype == `MSG_TYPE_DATA_ACK)
            && !is_csm_mshrid_TILE2)
        begin
            // first check if mshrid is in range
            if (`L15_PIPE2.noc2decoder_l15_mshrid > 9)
            begin
                $display("L1.5 MON: Received NoC2 message with MSHRID greater than 9 (%d)", `L15_PIPE2.noc2decoder_l15_mshrid);
                $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: Received NoC2 message with MSHRID greater than 9");
                `ifndef VERILATOR
                repeat(5)@(posedge clk)
                `endif
                    `MONITOR_PATH.fail("L1.5 MON: Received NoC2 message with MSHRID greater than 9");
            end

            // now check if it's valid
            // TODO
            // if (`L15_TOP2.mshr.val_array[`L15_PIPE2.noc2decoder_l15_mshrid] != 1'b1)
            // begin
            //     $display("L1.5 MON: Received NoC2 message with invalid MSHRID (%d)", `L15_PIPE2.noc2decoder_l15_mshrid);
            //     $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: Received NoC2 message with invalid MSHRID");
            //     `ifndef VERILATOR
            //     repeat(5)@(posedge clk)
            //     `endif
                //     `MONITOR_PATH.fail("L1.5 MON: Received NoC2 message with invalid MSHRID");
            // end
        end
    end
    // if (`L15_PIPE2.l15_noc1buffer_req_val && !`L15_PIPE2.stall_s3)
    // begin
    //     if (`L15_PIPE2.l15_noc1buffer_req_type != `L15_NOC1_REQTYPE_WRITEBACK_GUARD
    //         && `L15_PIPE2.l15_noc1buffer_req_type != `L15_NOC1_REQTYPE_INTERRUPT_FWD)
    //     begin
    //         if (`L15_TOP2.mshr.val_array[`L15_PIPE2.l15_noc1buffer_req_mshrid] != 1'b1
    //             || `L15_PIPE2.l15_noc1buffer_req_mshrid > 9)
    //         begin
    //             $display("L1.5 MON: Sending NoC1 message with invalid MSHRID (%d)", `L15_PIPE2.l15_noc1buffer_req_mshrid);
    //             $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: Sending NoC1 message with invalid MSHRID");
    //             `ifndef VERILATOR
    //             repeat(5)@(posedge clk)
    //             `endif
        //             `MONITOR_PATH.fail("L1.5 MON: Sending NoC1 message with invalid MSHRID");
    //         end
    //     end
    // end

// monitor PCX buffer full compare to t1 internal buffer mon
`ifdef RTL_SPARC2
`ifndef RTL_SPU
    if ((`CCX_TRANSDUCER2.pcx_buffer.is_req_squashed == 1'b1) && (`SPARC_CORE2.sparc0.lsu.lsu.qctl1.pcx_req_squash == 1'b0))
`else
    if ((`CCX_TRANSDUCER2.pcx_buffer.is_req_squashed == 1'b1) && (`SPARC_CORE2.sparc0.lsu.qctl1.pcx_req_squash == 1'b0))
`endif
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "PCXTILE2 req was valid but squashed in L1.5");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("PCXTILE2 req was valid but squashed in L1.5");
    end
`ifndef RTL_SPU
    if ((`CCX_TRANSDUCER2.pcx_buffer.is_req_squashed == 1'b0) && (`SPARC_CORE2.sparc0.lsu.lsu.qctl1.pcx_req_squash == 1'b1))
`else
    if ((`CCX_TRANSDUCER2.pcx_buffer.is_req_squashed == 1'b0) && (`SPARC_CORE2.sparc0.lsu.qctl1.pcx_req_squash == 1'b1))
`endif
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "PCXTILE2 req was squashed but valid at L1.5");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("PCXTILE2 req was squashed but valid at L1.5");
    end

    // check for squashed atomic
    if ((`CCX_TRANSDUCER2.pcx_buffer.is_req_squashed == 1'b1) && (`CCX_TRANSDUCER2.pcx_buffer.spc_uncore_atomic_req == 1'b1))
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "PCXTILE2 atomic req squashed");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("PCXTILE2 atomic req squashed");
    end
`endif

// monitor FP transactions because it is not supported yet
//     if (`L15_PIPE2.pcxdecoder_l15_val && !`L15_PIPE2.pcx_message_staled_s1 && `L15_PIPE2.val_s1 && !`L15_PIPE2.stall_s1 && !`L15_PIPE2.noc2decoder_l15_val)
//     begin
//         if (`L15_PIPE2.pcxdecoder_l15_rqtype == `PCX_REQTYPE_FP1)
//         begin
//             $display("%d : Simulation -> FAIL(%0s)", $time, "FP requests received but not implemented");
//             `ifndef VERILATOR
//             repeat(5)@(posedge clk)
//             `endif
    //             `MONITOR_PATH.fail("FP requests received but not implemented");
//         end
//     end

// monitor INT_VEC_DIS requests
    if (`L15_PIPE2.pcxdecoder_l15_val && `L15_PIPE2.val_s1 && !`L15_PIPE2.stall_s1 && !`L15_PIPE2.noc2decoder_l15_val)
    begin
        if (`L15_PIPE2.pcxdecoder_l15_rqtype == `PCX_REQTYPE_STORE
            && `L15_PIPE2.pcxdecoder_l15_address == 40'h9800000800)
        begin
            $display("%d : PCX write to INT_VEC_DIS", $time);
            // $display("%d : Simulation -> FAIL(%0s)", $time, "Write to INT_VEC_DIS");
            // `ifndef VERILATOR
            // repeat(5)@(posedge clk)
            // `endif
                // `MONITOR_PATH.fail("Write to INT_VEC_DIS");
        end
    end

// monitor noc1 buffer credit for underflow
    if (`L15_PIPE2.creditman_noc1_avail == 4'd15)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE2 NOC1 credit underflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE2 NOC1 credit underflow");
    end
    if (`L15_PIPE2.creditman_noc1_avail > `NOC1_BUFFER_NUM_SLOTS)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE2 NOC1 credit overflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE2 NOC1 credit overflow");
    end
    if (`L15_PIPE2.creditman_noc1_data_avail == 4'd15)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE2 NOC1 data credit underflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE2 NOC1 data credit underflow");
    end
    if (`L15_PIPE2.creditman_noc1_data_avail > `NOC1_BUFFER_NUM_DATA_SLOTS)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE2 NOC1 data credit overflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE2 NOC1 data credit overflow");
    end

    // check noc1 reserve credit
    if (`L15_PIPE2.creditman_noc1_reserve == 4'd15)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE2 NOC1 reserve credit underflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE2 NOC1 reserve credit underflow");
    end
    if (`L15_PIPE2.creditman_noc1_reserve > `NOC1_BUFFER_NUM_SLOTS)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE2 NOC1 reserve credit overflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE2 NOC1 reserve credit overflow");
    end
    // check reserve logics
    // if (`L15_PIPE2.creditman_noc1_reserve_s3)
    // begin
    //     $display("%d : Simulation -> FAIL(%0s)", $time, "TILE2 NOC1 reserve credit underflow");
    //     `ifndef VERILATOR
    //     repeat(5)@(posedge clk)
    //     `endif
        //     `MONITOR_PATH.fail("TILE2 NOC1 reserve credit underflow");
    // end

// Monitor for "RESERVED" messages
    if (`L15_PIPE2.noc2decoder_l15_val && `L15_PIPE2.val_s1 && !`L15_PIPE2.stall_s1)
    begin
        if (`L15_PIPE2.noc2decoder_l15_reqtype == `MSG_TYPE_RESERVED)
        begin
            $display("%d : Simulation -> FAIL(%0s)", $time, "TILE2 L15 received MSG_TYPE_RESERVED");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("TILE2 L15 received MSG_TYPE_RESERVED");
        end
    end

// Monitor WMT duplicate error
    if (`L15_PIPE2.val_s3)
    begin
        {wmt_read_data_TILE2[3], wmt_read_data_TILE2[2], wmt_read_data_TILE2[1], wmt_read_data_TILE2[0]} = `L15_PIPE2.wmt_l15_data_s3;
        for (i_TILE2 = 0; i_TILE2 < 4; i_TILE2 = i_TILE2+1)
        begin
            for (j_TILE2 = 0; j_TILE2 < i_TILE2; j_TILE2 = j_TILE2 + 1)
            begin
                if ((wmt_read_data_TILE2[i_TILE2][`L15_WMT_VALID_MASK] && wmt_read_data_TILE2[j_TILE2][`L15_WMT_VALID_MASK]) && (wmt_read_data_TILE2[i_TILE2] == wmt_read_data_TILE2[j_TILE2]))
                begin
                    $display("%d : Simulation -> FAIL(%0s)", $time, "TILE2 L15 has error with WMT");
                    `ifndef VERILATOR
                    repeat(5)@(posedge clk)
                    `endif
                        `MONITOR_PATH.fail("TILE2 L15 has error with WMT");
                end
            end
        end
    end

// Monitor tags duplication error (bug #86)
    if (`L15_PIPE2.val_s2 && `L15_PIPE2.decoder_dtag_operation_s2 == `L15_DTAG_OP_READ)
    begin
        tag_data_TILE2[0] = `L15_PIPE2.dtag_tag_way0_s2[`L15_CACHE_TAG_WIDTH-1:0];
        tag_data_TILE2[1] = `L15_PIPE2.dtag_tag_way1_s2[`L15_CACHE_TAG_WIDTH-1:0];
        tag_data_TILE2[2] = `L15_PIPE2.dtag_tag_way2_s2[`L15_CACHE_TAG_WIDTH-1:0];
        tag_data_TILE2[3] = `L15_PIPE2.dtag_tag_way3_s2[`L15_CACHE_TAG_WIDTH-1:0];
        tag_val_TILE2[0] = `L15_PIPE2.mesi_state_way0_s2 != `L15_MESI_STATE_I;
        tag_val_TILE2[1] = `L15_PIPE2.mesi_state_way1_s2 != `L15_MESI_STATE_I;
        tag_val_TILE2[2] = `L15_PIPE2.mesi_state_way2_s2 != `L15_MESI_STATE_I;
        tag_val_TILE2[3] = `L15_PIPE2.mesi_state_way3_s2 != `L15_MESI_STATE_I;
        for (i_TILE2 = 0; i_TILE2 < 4; i_TILE2 = i_TILE2+1)
        begin
            for (j_TILE2 = 0; j_TILE2 < i_TILE2; j_TILE2 = j_TILE2 + 1)
            begin
                if ((tag_val_TILE2[i_TILE2] && tag_val_TILE2[j_TILE2]) && (tag_data_TILE2[i_TILE2] == tag_data_TILE2[j_TILE2]))
                begin
                    $display("%d : Simulation -> FAIL(%0s)", $time, "TILE2 L15 has duplicated tag entry");
                    `ifndef VERILATOR
                    repeat(5)@(posedge clk)
                    `endif
                        `MONITOR_PATH.fail("TILE2 L15 has duplicated tag entry");
                end
            end
        end
    end

// // monitor FP transactions because it is not supported yet
//     if (`L15_TOP2.noc1encoder.sending)
//     begin
//         $display("noc1 flit raw: 0x%x", `L15_TOP2.noc1encoder.flit);
//     end
//     if (`L15_PIPE2.pcxdecoder_l15_val && !`L15_PIPE2.pcx_message_staled_s1 && `L15_PIPE2.val_s1 && !`L15_PIPE2.stall_s1 && !`L15_PIPE2.noc2decoder_l15_val)
//     begin
//         $display("%d : Simulation -> FAIL(%0s)", $time, "FP requests received but not implemented");
//         `ifndef VERILATOR
//         repeat(5)@(posedge clk)
//         `endif
    //         `MONITOR_PATH.fail("FP requests received but not implemented");
//     end


// Monitor FP transactions
//    if (`TILE2.fpu_arb_wrap.pcx_fpio_data_px2[123]
//            && `TILE2.fpu_arb_wrap.pcx_fpio_data_px2[122:119] == 4'b0101)
//    begin
//        $display("TILE2 FPU th%d: Received FP%d",
//                    `TILE2.fpu_arb_wrap.pcx_fpio_data_px2[113:112],
//                    `TILE2.fpu_arb_wrap.pcx_fpio_data_px2[118]);
//    end
//    if (`TILE2.fpu_arb_wrap.fpu_arb_data_rdy
//            && !`TILE2.fpu_arb_wrap.l15_fp_rdy)
//        $display("TILE2 FPU th%d: Sent FP data",
//                    `TILE2.fpu_arb_wrap.fpu_arb_data[135:134]);

// monitor L1.5 way replacement error
    if (`L15_PIPE2.l15_dcache_val_s2
        && `L15_PIPE2.dcache_operation_s2 == `L15_DCACHE_READ_LRU_WAY_IF_M)
    begin
        if (`L15_PIPE2.lruarray_l15_dout_s2[`L15_PIPE2.lru_way_s2] == 1'b1)
        begin
            // replacing a valid line
            if (&`L15_PIPE2.lru_used_bits_s2[3:0] == 1'b0)
            begin
                // and an another entry is 0, then is an error
                $display("%d : Simulation -> FAIL(%0s)", $time, "TILE2 L15 picked the wrong LRU entry");
                `ifndef VERILATOR
                repeat(5)@(posedge clk)
                `endif
                    `MONITOR_PATH.fail("TILE2 L15 picked the wrong LRU entry");
            end
        end
    end

// monitor X's in stall signals
    if (`L15_PIPE2.val_s1 && (`L15_PIPE2.stall_s1 === 1'bx) ||
        `L15_PIPE2.val_s2 && (`L15_PIPE2.stall_s2 === 1'bx) ||
        `L15_PIPE2.val_s3 && (`L15_PIPE2.stall_s3 === 1'bx))
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "L15 has X's in the stall_s1 signal");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("L15 has X's in the stall_s1 signal");
    end

`ifdef RTL_SPARC2
// some checks for l15cpxencoder
    if (`L15_TOP2.l15_transducer_val)
    begin
        if (`L15_TOP2.l15_transducer_inval_icache_inval)
        begin
            $display("%d : Simulation -> FAIL(%0s)", $time, "l15 icache inval is not used");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("l15 icache inval is not used");
        end
        if (`L15_TOP2.l15_transducer_returntype == `CPX_RESTYPE_ATOMIC_RES
            && `L15_TOP2.l15_transducer_inval_dcache_inval)
        begin
            $display("%d : Simulation -> FAIL(%0s)", $time, "l15 CAS inval is not used");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("l15 CAS inval is not used");
        end
    end
`endif

// some checks for l15 noc1 encoder
    if (`L15_TOP2.noc1encoder.sending && `L15_TOP2.noc1encoder.req_type == 0)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "l15 noc1 message is null");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("l15 noc1 message is null");
    end

    end // disable_l15_mon
end

//CORE2 END


// CORE3

reg do_print_stage_TILE3;
integer i_TILE3;
wire [63:0] dtag_tag_way0_s2_TILE3;
wire [63:0] dtag_tag_way1_s2_TILE3;
wire [63:0] dtag_tag_way2_s2_TILE3;
wire [63:0] dtag_tag_way3_s2_TILE3;

assign dtag_tag_way0_s2_TILE3 = (`L15_PIPE3.dtag_tag_way0_s2 << 11);
assign dtag_tag_way1_s2_TILE3 = (`L15_PIPE3.dtag_tag_way1_s2 << 11);
assign dtag_tag_way2_s2_TILE3 = (`L15_PIPE3.dtag_tag_way2_s2 << 11);
assign dtag_tag_way3_s2_TILE3 = (`L15_PIPE3.dtag_tag_way3_s2 << 11);
reg [`L15_CACHE_TAG_WIDTH-1:0] tag_data_TILE3 [0:3];
reg [3:0] tag_val_TILE3;
reg [`L15_WMT_ENTRY_MASK] wmt_read_data_TILE3 [0:3];
integer j_TILE3;
reg is_csm_mshrid_TILE3;

reg wmt_read_val_s3_TILE3;
always @ (posedge clk)
    wmt_read_val_s3_TILE3 <= `L15_PIPE3.l15_wmt_read_val_s2;

always @ (negedge clk)
begin
    if(!$test$plusargs("disable_l15_mon"))
    begin

    // monitoring outgoing noc1/noc3 messages
    if (`L15_TOP3.noc1encoder.sending)
    begin
        $display($time);
        $display("TILE3 noc1 flit raw: 0x%x", `L15_TOP3.noc1encoder.flit);
        $display("   srcX: %d, srcY: %d", `L15_TOP3.noc1encoder.msg_src_xpos, `L15_TOP3.noc1encoder.msg_src_ypos);
        $display("   destX: %d, destY: %d", `L15_TOP3.noc1encoder.msg_dest_l2_xpos, `L15_TOP3.noc1encoder.msg_dest_l2_ypos);
        if ( ^`L15_TOP3.noc1encoder.flit === 1'bx)
        begin
            $display("%d : Simulation -> FAIL(TILE3 noc1 sends X data 0x%x)", $time, `L15_TOP3.noc1encoder.flit);
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("l15_mon: TILE3 noc1 sends X data");
        end

    end




    if (`L15_PIPE3.pcxdecoder_l15_val && `L15_PIPE3.val_s1 && !`L15_PIPE3.stall_s1 && !`L15_PIPE3.noc2decoder_l15_val
        && `L15_PIPE3.fetch_state_s1 == `L15_FETCH_STATE_NORMAL)
    begin
        $write("%0d TILE3 L1.5 th%d: Received PCX ", $time, `L15_PIPE3.pcxdecoder_l15_threadid); decode_pcx_op(`L15_PIPE3.pcxdecoder_l15_rqtype, `L15_PIPE3.pcxdecoder_l15_amo_op);
        $display("   Addr 0x%x, nc %d, size %d, invalall %d, pf %d, bs %d, bsi %d, l1way %d",
                                `L15_PIPE3.pcxdecoder_l15_address, `L15_PIPE3.pcxdecoder_l15_nc, `L15_PIPE3.pcxdecoder_l15_size, `L15_PIPE3.pcxdecoder_l15_invalidate_cacheline,
                                `L15_PIPE3.pcxdecoder_l15_prefetch, `L15_PIPE3.pcxdecoder_l15_blockstore, `L15_PIPE3.pcxdecoder_l15_blockinitstore, `L15_PIPE3.pcxdecoder_l15_l1rplway);
        $display("   Data: 0x%x", `L15_PIPE3.pcxdecoder_l15_data);
        if (`L15_PIPE3.pcxdecoder_l15_csm_data[`TLB_CSM_STATE] == `TLB_CSM_STATE_LOCAL)
        begin
            $display("   CSM HDID: %d, HD_SIZE: %d, SDID: %d, LSID: %d", `L15_PIPE3.pcxdecoder_l15_csm_data[`TLB_CSM_HDID], `L15_PIPE3.pcxdecoder_l15_csm_data[`TLB_CSM_HD_SIZE],
            `L15_PIPE3.pcxdecoder_l15_csm_data[`TLB_CSM_SDID], `L15_PIPE3.pcxdecoder_l15_csm_data[`TLB_CSM_LSID]);
        end
        else if (`L15_PIPE3.pcxdecoder_l15_csm_data[`TLB_CSM_STATE] == `TLB_CSM_STATE_GLOBAL)
        begin
            $display("   CSM CHIPID: %d, X: %d, Y: %d", `L15_PIPE3.pcxdecoder_l15_csm_data[`TLB_CSM_CHIPID], `L15_PIPE3.pcxdecoder_l15_csm_data[`TLB_CSM_X],`L15_PIPE3.pcxdecoder_l15_csm_data[`TLB_CSM_Y]);
        end
        $display("   CSM Data: 0x%x", `L15_PIPE3.pcxdecoder_l15_csm_data);
        /*
        if (noc2decoder_l15_reqtype == `PCX_REQTYPE_STORE)
        if (noc2decoder_l15_reqtype == `PCX_REQTYPE_CAS1)
        begin
        $display("   Cmp.data: 0x%x", `L15_PIPE3.pcxdecoder_l15_data);
        $display("   Swp.data: 0x%x", `L15_PIPE3.pcxdecoder_l15_data_next_entry);
        end
        if (noc2decoder_l15_reqtype == `PCX_REQTYPE_SWP_LOADSTUB)
        begin
        $display("   Swp.data: 0x%x", `L15_PIPE3.pcxdecoder_l15_data);
        end
        */
        if (`L15_PIPE3.pcxdecoder_l15_rqtype == `PCX_REQTYPE_INTERRUPT && `L15_PIPE3.pcxdecoder_l15_data[63] == 1'b0)
        begin
            pcx_interrupt_type = `L15_PIPE3.pcxdecoder_l15_data[17:16];
            pcx_interrupt_dst_chipid = `L15_PIPE3.pcxdecoder_l15_data[31:18];
            pcx_interrupt_dst_y = `L15_PIPE3.pcxdecoder_l15_data[14:12];
            pcx_interrupt_dst_x = `L15_PIPE3.pcxdecoder_l15_data[11:9];
            pcx_interrupt_threadid = `L15_PIPE3.pcxdecoder_l15_data[8];
            pcx_interrupt_vector = `L15_PIPE3.pcxdecoder_l15_data[5:0];
            $display("Interrupt info:");
            $write("    Type: ");
            case(pcx_interrupt_type)
                2'b00:
                    $display("hw int");
                2'b01:
                    $display("reset");
                2'b10:
                    $display("idle");
                2'b11:
                    $display("resume");
            endcase

            $display("    Dst CHIP ID: %d", pcx_interrupt_dst_chipid);
            $display("    Dst X: %d", pcx_interrupt_dst_x);
            $display("    Dst Y: %d", pcx_interrupt_dst_y);
            $display("    Thread ID: %d", pcx_interrupt_threadid);
            $display("    Vector: %d", pcx_interrupt_vector);
        end
    end

    if (`L15_PIPE3.noc2decoder_l15_val && `L15_PIPE3.val_s1 && !`L15_PIPE3.stall_s1)
    begin
        noc2 = 0;
        case(`L15_PIPE3.noc2decoder_l15_reqtype)
        `MSG_TYPE_RESERVED:
            noc2 = "MSG_TYPE_RESERVED";
        `MSG_TYPE_LOAD_FWD:
            noc2 = "MSG_TYPE_LOAD_FWD";
        `MSG_TYPE_STORE_FWD:
            noc2 = "MSG_TYPE_STORE_FWD";
        `MSG_TYPE_INV_FWD:
            noc2 = "MSG_TYPE_INV_FWD";
        `MSG_TYPE_NODATA_ACK:
            noc2 = "MSG_TYPE_NODATA_ACK";
        `MSG_TYPE_DATA_ACK:
            noc2 = "MSG_TYPE_DATA_ACK";
        `MSG_TYPE_NC_LOAD_MEM_ACK:
            noc2 = "MSG_TYPE_NC_LOAD_MEM_ACK";
        `MSG_TYPE_NC_STORE_MEM_ACK:
            noc2 = "MSG_TYPE_NC_STORE_MEM_ACK";
        `MSG_TYPE_INTERRUPT:
            noc2 = "MSG_TYPE_L2_INTERRUPT";
        default:
        begin
            noc2 = "MSG_TYPE_UNKNOWN_ERROR";
            $display("%d : Simulation -> FAIL(%0s)", $time, "L15 mon: error message type from L2");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("L15 mon: error message type from L2");
        end
        endcase

        $write("%0d TILE3 L1.5: Received NOC2 %s", $time, noc2);
        $display("   mshrid %d, l2miss %d, f4b %d, ackstate %d, address 0x%x",
                    `L15_PIPE3.noc2decoder_l15_mshrid, `L15_PIPE3.noc2decoder_l15_l2miss, `L15_PIPE3.noc2decoder_l15_f4b,
                    `L15_PIPE3.noc2decoder_l15_ack_state, `L15_PIPE3.noc2decoder_l15_address);
        $display("   Data1: 0x%x", `L15_PIPE3.noc2decoder_l15_data_0);
        $display("   Data2: 0x%x", `L15_PIPE3.noc2decoder_l15_data_1);
        $display("   Data3: 0x%x", `L15_PIPE3.noc2decoder_l15_data_2);
        $display("   Data4: 0x%x", `L15_PIPE3.noc2decoder_l15_data_3);
    end

    if (`L15_PIPE3.l15_cpxencoder_val && !`L15_PIPE3.stall_s3)
    begin
        cpx = 0;
        case(`L15_PIPE3.l15_cpxencoder_returntype)
            `LOAD_RET:
                cpx = "LOAD_RET";
            `INV_RET:
                cpx = "INV_RET";
            `ST_ACK:
                cpx = "ST_ACK";
            `AT_ACK:
                cpx = "AT_ACK";
            `INT_RET:
                cpx = "INT_RET";
            `TEST_RET:
                cpx = "TEST_RET";
            `FP_RET:
                cpx = "FP_RET";
            `IFILL_RET:
                cpx = "IFILL_RET";
            `EVICT_REQ:
                cpx = "EVICT_REQ";
            `ERR_RET:
                cpx = "ERR_RET";
            `STRLOAD_RET:
                cpx = "STRLOAD_RET";
            `STRST_ACK:
                cpx = "STRST_ACK";
            `FWD_RQ_RET:
                cpx = "FWD_RQ_RET";
            `FWD_RPY_RET:
                cpx = "FWD_RPY_RET";
            `RSVD_RET:
                cpx = "RSVD_RET";
            4'b1110:
                cpx = "ATOMIC_ACK";
            default:
                cpx = "CPX_UNKNOWN";
        endcase
        $write("%0d TILE3 L1.5 th%d: Sent CPX %0s", $time, `L15_PIPE3.l15_cpxencoder_threadid, cpx);
        $display("   l2miss %d, nc %d, atomic %d, threadid %d, pf %d, f4b %d, iia %d, dia %d, dinval %d, iinval %d, invalway %d, blkinit %d",
                    `L15_PIPE3.l15_cpxencoder_l2miss, `L15_PIPE3.l15_cpxencoder_noncacheable, `L15_PIPE3.l15_cpxencoder_atomic,
                    `L15_PIPE3.l15_cpxencoder_threadid, `L15_PIPE3.l15_cpxencoder_prefetch,
                    `L15_PIPE3.l15_cpxencoder_f4b, `L15_PIPE3.l15_cpxencoder_inval_icache_all_way,
                    `L15_PIPE3.l15_cpxencoder_inval_dcache_all_way, `L15_PIPE3.l15_cpxencoder_inval_dcache_inval,
                    `L15_PIPE3.l15_cpxencoder_inval_icache_inval, `L15_PIPE3.l15_cpxencoder_inval_way,
                    `L15_PIPE3.l15_cpxencoder_blockinitstore);
        $display("   Data0: 0x%x", `L15_PIPE3.l15_cpxencoder_data_0);
        $display("   Data1: 0x%x", `L15_PIPE3.l15_cpxencoder_data_1);
        $display("   Data2: 0x%x", `L15_PIPE3.l15_cpxencoder_data_2);
        $display("   Data3: 0x%x", `L15_PIPE3.l15_cpxencoder_data_3);
    end

    if (`L15_TOP3.noc1encoder.noc1encoder_noc1out_val && `L15_TOP3.noc1encoder.noc1encoder_noc1buffer_req_ack)
    begin
        noc1 = 0;
        case(`L15_TOP3.noc1encoder.req_type)
        `L15_NOC1_REQTYPE_WRITEBACK_GUARD:
            noc1 = "L15_NOC1_REQTYPE_WRITEBACK_GUARD";
        `L15_NOC1_REQTYPE_LD_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_LD_REQUEST";
        `L15_NOC1_REQTYPE_IFILL_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_IFILL_REQUEST";
        `L15_NOC1_REQTYPE_WRITETHROUGH_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_WRITETHROUGH_REQUEST";
        `L15_NOC1_REQTYPE_ST_UPGRADE_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_ST_UPGRADE_REQUEST";
        `L15_NOC1_REQTYPE_ST_FILL_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_ST_FILL_REQUEST";
        `L15_NOC1_REQTYPE_CAS_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_CAS_REQUEST";
        `L15_NOC1_REQTYPE_SWAP_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_SWAP_REQUEST";
        `L15_NOC1_REQTYPE_INTERRUPT_FWD:
            noc1 = "L15_NOC1_REQTYPE_INTERRUPT_FWD";
        `L15_NOC1_REQTYPE_AMO_ADD_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_ADD_REQUEST";
        `L15_NOC1_REQTYPE_AMO_AND_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_AND_REQUEST";
        `L15_NOC1_REQTYPE_AMO_OR_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_OR_REQUEST";
        `L15_NOC1_REQTYPE_AMO_XOR_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_XOR_REQUEST";
        `L15_NOC1_REQTYPE_AMO_MAX_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_MAX_REQUEST";
        `L15_NOC1_REQTYPE_AMO_MAXU_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_MAXU_REQUEST";
        `L15_NOC1_REQTYPE_AMO_MIN_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_MIN_REQUEST";
        `L15_NOC1_REQTYPE_AMO_MINU_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_MINU_REQUEST";
        default:
            noc1 = "ERROR noc1";
        endcase

        $write("%0d TILE3 L1.5: Sending NOC1 %s", $time, noc1);
        $display("   mshrid %d, nc %d, size %d, pf %d, address %0x",
                    `L15_TOP3.noc1encoder.noc1buffer_noc1encoder_req_mshrid, `L15_TOP3.noc1encoder.noc1buffer_noc1encoder_req_non_cacheable,
                    `L15_TOP3.noc1encoder.noc1buffer_noc1encoder_req_size, `L15_TOP3.noc1encoder.noc1buffer_noc1encoder_req_prefetch, `L15_TOP3.noc1encoder.noc1buffer_noc1encoder_req_address);
        $display("   Data0: 0x%x", `L15_TOP3.noc1encoder.noc1buffer_noc1encoder_req_data_0);
        $display("   Data1: 0x%x", `L15_TOP3.noc1encoder.noc1buffer_noc1encoder_req_data_1);
        $display("   Destination X: %d Y: %d", `L15_TOP3.noc1encoder.msg_dest_l2_xpos, `L15_TOP3.noc1encoder.msg_dest_l2_ypos);
    end

    if (`L15_TOP3.noc3encoder.noc3encoder_noc3out_val && `L15_TOP3.noc3encoder.noc3encoder_l15_req_ack)
    begin
        noc3 = 0;
        case(`L15_TOP3.noc3encoder.l15_noc3encoder_req_type)
        `L15_NOC3_REQTYPE_WRITEBACK:
            noc3 = "L15_NOC3_REQTYPE_WRITEBACK";
        `L15_NOC3_REQTYPE_INVAL_ACK:
            noc3 = "L15_NOC3_REQTYPE_INVAL_ACK";
        `L15_NOC3_REQTYPE_DOWNGRADE_ACK:
            noc3 = "L15_NOC3_REQTYPE_DOWNGRADE_ACK";
        `L15_NOC3_REQTYPE_ICACHE_INVAL_ACK:
            noc3 = "L15_NOC3_REQTYPE_ICACHE_INVAL_ACK";
        default:
            noc3 = "ERROR NOC3";
        endcase

        // quick check for an error case
        if (`L15_TOP3.noc3encoder.msg_type == `MSG_TYPE_INV_FWDACK
            && `L15_TOP3.noc3encoder.l15_noc3encoder_req_with_data)
        begin
            $display("L1.5 MON: sending back invalid ack with data");
            $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: sending back invalid ack with data");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("L1.5 MON: sending back invalid ack with data");
        end


        $write("%0d TILE3 L1.5: Sent NOC3 %s", $time, noc3);
        $display("   mshrid %d, seqid %d, address %0x",
                    `L15_TOP3.noc3encoder.l15_noc3encoder_req_mshrid, `L15_TOP3.noc3encoder.l15_noc3encoder_req_sequenceid, `L15_TOP3.noc3encoder.l15_noc3encoder_req_address);
        $display("   srcX: %d, srcY: %d", `L15_TOP3.noc3encoder.src_l2_xpos, `L15_TOP3.noc3encoder.src_l2_ypos);
        $display("   destX: %d, destY: %d", `L15_TOP3.noc3encoder.dest_l2_xpos, `L15_TOP3.noc3encoder.dest_l2_ypos);
        $display("   Data0: 0x%x", `L15_TOP3.noc3encoder.l15_noc3encoder_req_data_0);
        $display("   Data1: 0x%x", `L15_TOP3.noc3encoder.l15_noc3encoder_req_data_1);
    end

    do_print_stage_TILE3 = ((`L15_PIPE3.val_s1 && !`L15_PIPE3.stall_s1) || (`L15_PIPE3.val_s2 && !`L15_PIPE3.stall_s2) || (`L15_PIPE3.val_s3 && !`L15_PIPE3.stall_s3));
    if (do_print_stage_TILE3)
    begin
        // $display("");
        $display("");
        $display($time, " L15 TILE3:");
        $display("NoC1 credit: %d", `L15_PIPE3.creditman_noc1_avail);
        $display("NoC1 reserved credit: %d", `L15_PIPE3.creditman_noc1_reserve);
        // $display("NoC1 r down: %d", `L15_PIPE3.creditman_noc1_reserve_minus1);
        // $display("NoC1 r up: %d", `L15_PIPE3.creditman_noc1_reserve_add1);

        // monitor the MSHRID allocation
        // $display("MSHRID allocation info:");
        // for (i_TILE3 = 0; i_TILE3 < `L15_MSHR_COUNT; i_TILE3 = i_TILE3 + 1)
        //     $write("%d:%d", i_TILE3, `L15_PIPE3.mshr_val_array[i_TILE3]);
            // $write("%d %d", i_TILE3, i_TILE3);
        // $display("");

`ifdef RTL_SPARC3
        $display("Core STB info:");
        $display("  STB0: %d", `SPARC_CORE3.sparc0.ifu.lsu_ifu_stbcnt0);
        $display("  STB1: %d", `SPARC_CORE3.sparc0.ifu.lsu_ifu_stbcnt1);
            // $write("%d %d", i_TILE3, i_TILE3);
`endif

        $write("TILE3 Pipeline:");
        if (`L15_PIPE3.val_s1 && !`L15_PIPE3.stall_s1)
            $write(" * ");
        else if (`L15_PIPE3.val_s1 && `L15_PIPE3.stall_s1)
            $write(" = ");
        else
            $write(" X ");

        if (`L15_PIPE3.val_s2 && !`L15_PIPE3.stall_s2)
            $write(" * ");
        else if (`L15_PIPE3.val_s2 && `L15_PIPE3.stall_s2)
            $write(" = ");
        else
            $write(" X ");

        if (`L15_PIPE3.val_s3 && !`L15_PIPE3.stall_s3)
            $write(" * ");
        else if (`L15_PIPE3.val_s3 && `L15_PIPE3.stall_s3)
            $write(" = ");
        else
            $write(" X ");
        $display("");

        // $write("PCX pipe info: "); decode_pcx_op(`L15_PIPE3.pcxdecoder_l15_rqtype, L15_PIPE3.pcxdecoder_l15_amo_op);
        // if (`L15_PIPE3.noc1_req_val_s3 && `L15_PIPE3.noc1encoder_req_staled_s3)
        //     $display(" (staled)");
        // else if (!`L15_PIPE3.noc1_req_val_s3)
        //     $display(" (invalid)");
        // else if (`L15_PIPE3.noc1_req_val_s3 && !`L15_PIPE3.noc1encoder_req_staled_s3)
        // begin
        //     $display(" (fresh)");
        // end

        // $write("NoC1 pipe info: ");
        // if (`L15_PIPE3.noc1_req_val_s3 && `L15_PIPE3.noc1encoder_req_staled_s3)
        //     $display("staled");
        // else if (!`L15_PIPE3.noc1_req_val_s3)
        //     $display("invalid");
        // else if (`L15_PIPE3.noc1_req_val_s3 && !`L15_PIPE3.noc1encoder_req_staled_s3)
        // begin
        //     $display("fresh");
        // end

        // $write("NoC3 pipe info: ");
        // if (`L15_PIPE3.noc3_req_val_s3 && `L15_PIPE3.noc3encoder_req_staled_s3)
        //     $display("staled");
        // else if (!`L15_PIPE3.noc3_req_val_s3)
        //     $display("invalid");
        // else if (`L15_PIPE3.noc3_req_val_s3 && !`L15_PIPE3.noc3encoder_req_staled_s3)
        // begin
        //     $display("fresh");
        // end

        // $write("CPX pipe info: ");
        // if (`L15_PIPE3.cpx_req_val_s3 && `L15_PIPE3.cpxencoder_req_staled_s3)
        //     $display("staled");
        // else if (!`L15_PIPE3.cpx_req_val_s3)
        //     $display("invalid");
        // else if (`L15_PIPE3.cpx_req_val_s3 && !`L15_PIPE3.cpxencoder_req_staled_s3)
        // begin
        //     $display("fresh");
        // end

            // Stage 1 debug information
        if (`L15_PIPE3.stall_s1 === 1'bx)
            $display("S1 stall is XXXXXXX");
        if (`L15_PIPE3.val_s1 && !`L15_PIPE3.stall_s1)
        begin
            $write("Stage 1 status: ");
            $write("   Operation: "); decode_predecode_reqtype(`L15_PIPE3.predecode_reqtype_s1);
            $display("   TILE3 S1 Address: 0x%x", `L15_PIPE3.predecode_address_s1);
            // if (`L15_PIPE3.decoder_dtag_operation_s1 == `L15_DTAG_OP_READ)
            // begin
            //     $display("   DTAG OP: L15_DTAG_OP_READ");
            //     $display("      Index: 0x%x", `L15_PIPE3.dtag_index);
            // end
            // if (`L15_PIPE3.l15_dtag_rw_s1 == `L15_DTAG_RW_WRITE)
            // begin
            //     $display("   DTAG OP: L15_DTAG_OP_WRITE");
            //     $display("      Data:  0x%x", `L15_PIPE3.dtag_write_tag_s1);
            //     $display("      Way:  0x%x", `L15_PIPE3.dtag_write_way_s1);
            //     // $display("      Mask: 0x%x", `L15_PIPE3.dtag_write_mask);
            // end
            // if (`L15_PIPE3.s1_mshr_write_val_s1)
            // begin
            //     $display("   DTAG OP: ");
            //     if (`L15_PIPE3.s1_mshr_write_type_s1 == `L15_MSHR_WRITE_TYPE_ALLOCATION)
            //     begin
            //         $write ("L15_MSHR_WRITE_TYPE_ALLOCATION");
            //         $display ("      MSRID: %d", `L15_PIPE3.s1_mshr_write_mshrid_s1);
            //     end
            //     else if (`L15_PIPE3.s1_mshr_write_type_s1 == `L15_S1_MSHR_OP_UPDATE_WRITECACHE)
            //     begin
            //         $write ("L15_S1_MSHR_OP_UPDATE_WRITECACHE");
            //         $display ("      MSRID:     %d", `L15_PIPE3.s1_mshr_write_mshrid_s1);
            //         $display ("      DATA:      0x%x", `L15_PIPE3.s1_mshr_write_data);
            //         $display ("      DATAMASK:  0x%x", `L15_PIPE3.s1_mshr_write_byte_mask);
            //     end
            // end
        end
        // Stage 2 debug information
        if (`L15_PIPE3.stall_s2 === 1'bx)
            $display("S2 stall is XXXXXXX");
        if (`L15_PIPE3.val_s2 && !`L15_PIPE3.stall_s2)
        begin
        $write("Stage 2 status: ");
            $write("   Operation: "); decode_predecode_reqtype(`L15_PIPE3.predecode_reqtype_s2);
            $display("   TILE3 S2 Address: 0x%x", `L15_PIPE3.address_s2);
            $display("   TILE3 S2 Cache index: %d", `L15_PIPE3.cache_index_s2);

            if (`L15_PIPE3.csm_req_val_s2)
            begin
                $display("   CSM op: %d", `L15_PIPE3.csm_op_s2);
                if (`L15_PIPE3.l15_csm_req_type_s2 == 1'b0)
                    $display("      CSM read ticket: 0x%x", `L15_PIPE3.l15_csm_req_ticket_s2);
                else
                begin
                    $display("      CSM write ticket: 0x%x", `L15_PIPE3.l15_csm_req_ticket_s2);
                    $display("      CSM write data: 0x%x", `L15_PIPE3.l15_csm_req_data_s2);
                end
            end

            // $display("   Source chipid: %d", `L15_PIPE3.noc2_src_homeid_s2[`PACKET_HOME_ID_CHIP_MASK]);
            // $display("   Source X: %d", `L15_PIPE3.noc2_src_homeid_s2[`PACKET_HOME_ID_X_MASK]);
            // $display("   Source Y: %d", `L15_PIPE3.noc2_src_homeid_s2[`PACKET_HOME_ID_Y_MASK]);
            // `ifdef L15_EXTRA_DEBUG
            // $display("   LRU state: %d", `L15_PIPE3.lru_state_s2);
            // $display("   LRU way: %d", `L15_PIPE3.lru_way_s2);
            // $display("   Tagcheck state: %d", `L15_PIPE3.tagcheck_state_s2);
            // $display("   Tagcheck way: %d", `L15_PIPE3.tagcheck_way_s2);

            if (`L15_PIPE3.decoder_dtag_operation_s2 == `L15_DTAG_OP_READ)
            begin
                $display("   DTAG way0 state: 0x%x", `L15_PIPE3.mesi_state_way0_s2);
                $display("   DTAG way0 data: 0x%x", dtag_tag_way0_s2_TILE3);
                $display("   DTAG way1 state: 0x%x", `L15_PIPE3.mesi_state_way1_s2);
                $display("   DTAG way1 data: 0x%x", dtag_tag_way1_s2_TILE3);
                $display("   DTAG way2 state: 0x%x", `L15_PIPE3.mesi_state_way2_s2);
                $display("   DTAG way2 data: 0x%x", dtag_tag_way2_s2_TILE3);
                $display("   DTAG way3 state: 0x%x", `L15_PIPE3.mesi_state_way3_s2);
                $display("   DTAG way3 data: 0x%x", dtag_tag_way3_s2_TILE3);
            end

            if (`L15_PIPE3.l15_mesi_write_val_s2)
            begin
                $display("   MESI write way: 0x%x", `L15_PIPE3.mesi_write_way_s2);
                $display("   MESI write data: 0x%x", `L15_PIPE3.mesi_write_state_s2);
            end

            // if (`L15_PIPE3.lruarray_write_op_s2 == `L15_LRU_EVICTION)
            // begin
            //     $display("   LRU EVICTION INDEX: %d, WAY: %d", `L15_PIPE3.cache_index_s2,
            //         `L15_PIPE3.lru_way_s2[1:0]);
            // end
            // `endif

            // if (`L15_PIPE3.s2_mesi_operation_s2 == `L15_S2_MESI_READ)
            // begin
            //     $display("   MESI OP: L15_S2_MESI_READ");
            //     $display ("      Index:     %d", `L15_PIPE3.s2_mesi_index_s2);
            // end
            // if (`L15_PIPE3.s2_mshr_val_s2)
            // begin
            //     $display("   MSHR OP: L15_S2_MSHR_OP_READ_WRITE_CACHE");
            //     $display ("      MSHR: %d", `L15_PIPE3.s2_mshr_read_mshrid);
            // end
            if (`L15_PIPE3.dcache_val_s2)
            begin
                // $write("   DCACHE OP: "); decode_dcache_op(`L15_PIPE3.dcache_operation_s2);
                // $display ("      RW:     %d", `L15_PIPE3.dcache_rw);
                // $display ("      Index:      0x%x", `L15_PIPE3.dcache_index);
                // $display ("      Data:  0x%x", `L15_PIPE3.dcache_write_data);
                // $display ("      Data mask:  0x%x", `L15_PIPE3.dcache_write_mask);
                if (`L15_PIPE3.l15_dcache_rw_s2 == 1'b0)
                begin
                    `ifndef NO_RTL_CSM
                    $display("HMT writing: %0b", `L15_PIPE3.l15_hmt_write_data_s2);
                    `endif
                    // TODO
                    // $display("HMT chip: %0b", `L15_PIPE3.wmt_fill_homeid_s2[`PACKET_HOME_ID_CHIP_MASK]);
                    // $display("HMT X: %0b", `L15_PIPE3.wmt_fill_homeid_s2[`PACKET_HOME_ID_X_MASK]);
                    // $display("HMT Y: %0b", `L15_PIPE3.wmt_fill_homeid_s2[`PACKET_HOME_ID_Y_MASK]);
                end
            end
        end

        // Stage 3 debug information
        if (`L15_PIPE3.stall_s3 === 1'bx)
            $display("S3 stall is XXXXXXX");
        if (`L15_PIPE3.val_s3 && !`L15_PIPE3.stall_s3)
        begin
            $write("Stage 3 status: ");
            $write("   Operation: "); decode_predecode_reqtype(`L15_PIPE3.predecode_reqtype_s3);
            $display("   TILE3 S3 Address: 0x%x", `L15_PIPE3.address_s3);
            `ifndef NO_RTL_CSM
            if ((`L15_PIPE3.noc1_homeid_source_s3 == `L15_HOMEID_SRC_HMT && `L15_PIPE3.noc1_req_val_s3)
                || (`L15_PIPE3.noc3_homeid_source_s3 == `L15_HOMEID_SRC_HMT && `L15_PIPE3.noc3_req_val_s3))
            begin
                `ifndef NO_RTL_CSM
                $display("   HMT chipid: %d", `L15_PIPE3.hmt_l15_dout_s3[`L15_CSM_GHID_CHIP_MASK]);
                $display("   HMT X: %d", `L15_PIPE3.hmt_l15_dout_s3[`L15_CSM_GHID_XPOS_MASK]);
                $display("   HMT Y: %d", `L15_PIPE3.hmt_l15_dout_s3[`L15_CSM_GHID_YPOS_MASK]);
                $display("   HMT reading: %0b", `L15_PIPE3.hmt_l15_dout_s3);
                `endif
            end
            `endif
            if (`L15_PIPE3.noc3_homeid_source_s3 == `L15_HOMEID_SRC_NOC2_SOURCE && `L15_PIPE3.noc3_req_val_s3)
            begin
                $display("   Source chipid: %d", `L15_PIPE3.noc2_src_homeid_s3[`PACKET_HOME_ID_CHIP_MASK]);
                $display("   Source X: %d", `L15_PIPE3.noc2_src_homeid_s3[`PACKET_HOME_ID_X_MASK]);
                $display("   Source Y: %d", `L15_PIPE3.noc2_src_homeid_s3[`PACKET_HOME_ID_Y_MASK]);
            end

            if (`L15_PIPE3.cpx_data_source_s3 == `L15_CPX_SOURCE_CSM)
                $display("      CSM read data: 0x%x", `L15_PIPE3.csm_l15_res_data_s3);
            // `ifdef L15_EXTRA_DEBUG
            // $display("   LRU state: %d", `L15_PIPE3.lru_state_s3);
            // $display("   LRU way: %d", `L15_PIPE3.lru_way_s3);
            // $display("   Tagcheck state: %d", `L15_PIPE3.tagcheck_state_s3);
            // $display("   Tagcheck way: %d", `L15_PIPE3.tagcheck_way_s3);
            // `endif

            // if (`L15_PIPE3.s3_mesi_val_s3)
            // begin
            //     $write("   MESI OP: "); decode_s3mesi_op(`L15_PIPE3.s3_mesi_operation_s3);
            //     $display ("      Index:      0x%x", `L15_PIPE3.mesi_write_index);
            //     $display ("      Data:  0x%x", `L15_PIPE3.mesi_write_data);
            //     $display ("      Data mask:  0x%x", `L15_PIPE3.mesi_write_mask);
            // end
            // if (`L15_PIPE3.wmc_val_s3)
            // begin
            //     $write("   WMC OP: "); decode_wmc_op(`L15_PIPE3.wmc_operation_s3);
            //     if (`L15_PIPE3.wmc_rw_s3 == `L15_WMC_OP_READ)
            //     begin
            //         $display ("      wmc_index_s3:      0x%x", `L15_PIPE3.wmc_index_s3);
            //         $display ("      wmc_invalidate_val_s3:      0x%x", `L15_PIPE3.wmc_invalidate_val_s3);
            //         $display ("      wmc_invalidate_way_s3:      0x%x", `L15_PIPE3.wmc_invalidate_way_s3);
            //     end
            //     else if (`L15_PIPE3.wmc_rw_s3 == `L15_WMC_OP_WRITE)
            //     begin
            //         $display ("      wmc_index_s3:      0x%x", `L15_PIPE3.wmc_index_s3);
            //         $display ("      wmc_update_way_s3:      0x%x", `L15_PIPE3.wmc_update_way_s3);
            //         $display ("      wmc_update_data_s3:      0x%x", `L15_PIPE3.wmc_update_data_s3);
            //         $display ("      wmc_invalidate_val_s3:      0x%x", `L15_PIPE3.wmc_invalidate_val_s3);
            //         $display ("      wmc_invalidate_way_s3:      0x%x", `L15_PIPE3.wmc_invalidate_way_s3);
            //     end
            //     $display ("      cpx_inval_way_s3:      0x%x", `L15_PIPE3.cpx_inval_way_s3);
            //     $display ("      wmc_read_way0_data_s3:      0x%x", `L15_PIPE3.wmc_read_way0_data_s3);
            //     $display ("      wmc_read_way1_data_s3:      0x%x", `L15_PIPE3.wmc_read_way1_data_s3);
            //     $display ("      wmc_read_way2_data_s3:      0x%x", `L15_PIPE3.wmc_read_way2_data_s3);
            //     $display ("      wmc_read_way3_data_s3:      0x%x", `L15_PIPE3.wmc_read_way3_data_s3);
            // end
            // if (`L15_PIPE3.s3_mshr_val_s3)
            // begin
            //     $write("   MSHR OP: "); decode_s3mshr_op(`L15_PIPE3.s3_mshr_operation_s3);
            //     $display ("      MSHR:      %d", `L15_PIPE3.s3_mshr_write_mshrid);
            //     $display ("      U.State:      0x%x", `L15_PIPE3.s3_mshr_write_update_state);
            //     $display ("      U.Way:  0x%x", `L15_PIPE3.s3_mshr_write_update_way);
            //     $display ("      St.mshr rand hit:   %d", `L15_PIPE3.LRU_st1_mshr_s3 || `L15_PIPE3.LRU_st2_mshr_s3);
            //     $display ("      St.mshr tag hit:   %d", `L15_PIPE3.tagcheck_st1_mshr_s3 || `L15_PIPE3.tagcheck_st2_mshr_s3);
            // end
            if (wmt_read_val_s3_TILE3)
            begin
                $display("   TILE3 WMT read index: %x", `L15_PIPE3.cache_index_l1d_s3[`L1D_SET_IDX_MASK]);
                // $display("   WMT way0: %x 0x%x", `L15_PIPE3.wmt_data_s3[0][`L15_WMT_VALID_MASK], `L15_PIPE3.wmt_data_s3[0][`L15_WMT_DATA_MASK]);
                // $display("   WMT way1: %x 0x%x", `L15_PIPE3.wmt_data_s3[1][`L15_WMT_VALID_MASK], `L15_PIPE3.wmt_data_s3[1][`L15_WMT_DATA_MASK]);
                // $display("   WMT way2: %x 0x%x", `L15_PIPE3.wmt_data_s3[2][`L15_WMT_VALID_MASK], `L15_PIPE3.wmt_data_s3[2][`L15_WMT_DATA_MASK]);
                // $display("   WMT way3: %x 0x%x", `L15_PIPE3.wmt_data_s3[3][`L15_WMT_VALID_MASK], `L15_PIPE3.wmt_data_s3[3][`L15_WMT_DATA_MASK]);
                for (i = 0; i < `L1D_WAY_COUNT; i = i + 1)
                begin
                    $display("   WMT way%d: %x 0x%x", i, `L15_PIPE3.wmt_data_s3[i][`L15_WMT_VALID_MASK], `L15_PIPE3.wmt_data_s3[i][`L15_WMT_DATA_MASK]);
                end
            end
            if (`L15_PIPE3.l15_wmt_write_val_s3)
            begin
                $display("   TILE3 WMT write index: %x", `L15_PIPE3.cache_index_l1d_s3[`L1D_SET_IDX_MASK]);
                // $display("   WMT write mask: %x", `L15_PIPE3.l15_wmt_write_mask_s3);
                // $display("   WMT write data: %x", `L15_PIPE3.l15_wmt_write_data_s3);
                // $display("   WMT way0 m%x d0x%x", `L15_PIPE3.l15_wmt_write_mask_s3[`L15_WMT_ENTRY_0_MASK], `L15_PIPE3.wmt_write_data_s3[`L15_WMT_ENTRY_0_MASK]);
                // $display("   WMT way1 m%x d0x%x", `L15_PIPE3.l15_wmt_write_mask_s3[`L15_WMT_ENTRY_1_MASK], `L15_PIPE3.wmt_write_data_s3[`L15_WMT_ENTRY_1_MASK]);
                // $display("   WMT way2 m%x d0x%x", `L15_PIPE3.l15_wmt_write_mask_s3[`L15_WMT_ENTRY_2_MASK], `L15_PIPE3.wmt_write_data_s3[`L15_WMT_ENTRY_2_MASK]);
                // $display("   WMT way3 m%x d0x%x", `L15_PIPE3.l15_wmt_write_mask_s3[`L15_WMT_ENTRY_3_MASK], `L15_PIPE3.wmt_write_data_s3[`L15_WMT_ENTRY_3_MASK]);
            end
        end
        $display ("L15_MON_END");
        $display ("");
    end

//CSM monitor
    if(`L15_TOP3.l15_csm.l15_csm_req_val_s2)
    begin
        $display($time, ": TILE3 L15_CSM REQ MON:");
        $display("L15 CSM req addr: 0x%x", `L15_TOP3.l15_csm.l15_csm_req_address_s2);
        $display("L15 CSM req ticket: %d", `L15_TOP3.l15_csm.l15_csm_req_ticket_s2);
        $display("L15 CSM req type: %d", `L15_TOP3.l15_csm.l15_csm_req_type_s2);
        $display("L15 CSM req data: 0x%x", `L15_TOP3.l15_csm.l15_csm_req_data_s2);
        $display("L15 CSM req pcx data: 0x%x", `L15_TOP3.l15_csm.l15_csm_req_pcx_data_s2);
    end
    if(`L15_TOP3.l15_csm.csm_l15_res_val_s3)
    begin
        $display($time, ": TILE3 L15_CSM RES MON:");
        $display("L15 CSM res data: 0x%x", `L15_TOP3.l15_csm.csm_l15_res_data_s3);
    end
    if(`L15_TOP3.l15_csm.csm_l15_read_res_val)
    begin
        $display($time, ": TILE3 L15_CSM READ TICKET MON:");
        $display("L15 CSM read ticket: %d", `L15_TOP3.l15_csm.l15_csm_read_ticket);
        $display("L15 CSM read data: 0x%x", `L15_TOP3.l15_csm.csm_l15_read_res_data);
    end
    if(`L15_TOP3.l15_csm.csm_noc1encoder_req_val)
    begin
        $display($time, ": TILE3 L15_CSM NOC1 REQ MON:");
        $display("L15 CSM noc1 req addr: 0x%x", `L15_TOP3.l15_csm.csm_noc1encoder_req_address);
        $display("L15 CSM noc1 req type: %d", `L15_TOP3.l15_csm.csm_noc1encoder_req_type);
        $display("L15 CSM noc1 req mshrid: %d", `L15_TOP3.l15_csm.csm_noc1encoder_req_mshrid);
    end
    if(`L15_TOP3.l15_csm.noc1encoder_csm_req_ack)
    begin
        $display($time, ": TILE3 L15_CSM NOC1 REQ ACK MON:");
        $display("L15 CSM noc1 req ack: %b", `L15_TOP3.l15_csm.noc1encoder_csm_req_ack);
    end

    if(`L15_TOP3.l15_csm.write_val_s2 && (~`L15_TOP3.l15_csm.ghid_val_s2))
    begin
        $display("L1.5 MON: HMC refills invalid data");
        $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: HMC refills invalid data");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("L1.5 MON: HMC refills invalid data");
    end

// valid mshrid monitor
    // check for incoming messages
    if (`L15_PIPE3.noc2decoder_l15_val && `L15_PIPE3.val_s1 && !`L15_PIPE3.stall_s1)
    begin
        is_csm_mshrid_TILE3 = `L15_PIPE3.noc2decoder_l15_hmc_fill;
        if ((`L15_PIPE3.noc2decoder_l15_reqtype == `MSG_TYPE_NODATA_ACK ||
            `L15_PIPE3.noc2decoder_l15_reqtype == `MSG_TYPE_DATA_ACK)
            && !is_csm_mshrid_TILE3)
        begin
            // first check if mshrid is in range
            if (`L15_PIPE3.noc2decoder_l15_mshrid > 9)
            begin
                $display("L1.5 MON: Received NoC2 message with MSHRID greater than 9 (%d)", `L15_PIPE3.noc2decoder_l15_mshrid);
                $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: Received NoC2 message with MSHRID greater than 9");
                `ifndef VERILATOR
                repeat(5)@(posedge clk)
                `endif
                    `MONITOR_PATH.fail("L1.5 MON: Received NoC2 message with MSHRID greater than 9");
            end

            // now check if it's valid
            // TODO
            // if (`L15_TOP3.mshr.val_array[`L15_PIPE3.noc2decoder_l15_mshrid] != 1'b1)
            // begin
            //     $display("L1.5 MON: Received NoC2 message with invalid MSHRID (%d)", `L15_PIPE3.noc2decoder_l15_mshrid);
            //     $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: Received NoC2 message with invalid MSHRID");
            //     `ifndef VERILATOR
            //     repeat(5)@(posedge clk)
            //     `endif
                //     `MONITOR_PATH.fail("L1.5 MON: Received NoC2 message with invalid MSHRID");
            // end
        end
    end
    // if (`L15_PIPE3.l15_noc1buffer_req_val && !`L15_PIPE3.stall_s3)
    // begin
    //     if (`L15_PIPE3.l15_noc1buffer_req_type != `L15_NOC1_REQTYPE_WRITEBACK_GUARD
    //         && `L15_PIPE3.l15_noc1buffer_req_type != `L15_NOC1_REQTYPE_INTERRUPT_FWD)
    //     begin
    //         if (`L15_TOP3.mshr.val_array[`L15_PIPE3.l15_noc1buffer_req_mshrid] != 1'b1
    //             || `L15_PIPE3.l15_noc1buffer_req_mshrid > 9)
    //         begin
    //             $display("L1.5 MON: Sending NoC1 message with invalid MSHRID (%d)", `L15_PIPE3.l15_noc1buffer_req_mshrid);
    //             $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: Sending NoC1 message with invalid MSHRID");
    //             `ifndef VERILATOR
    //             repeat(5)@(posedge clk)
    //             `endif
        //             `MONITOR_PATH.fail("L1.5 MON: Sending NoC1 message with invalid MSHRID");
    //         end
    //     end
    // end

// monitor PCX buffer full compare to t1 internal buffer mon
`ifdef RTL_SPARC3
`ifndef RTL_SPU
    if ((`CCX_TRANSDUCER3.pcx_buffer.is_req_squashed == 1'b1) && (`SPARC_CORE3.sparc0.lsu.lsu.qctl1.pcx_req_squash == 1'b0))
`else
    if ((`CCX_TRANSDUCER3.pcx_buffer.is_req_squashed == 1'b1) && (`SPARC_CORE3.sparc0.lsu.qctl1.pcx_req_squash == 1'b0))
`endif
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "PCXTILE3 req was valid but squashed in L1.5");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("PCXTILE3 req was valid but squashed in L1.5");
    end
`ifndef RTL_SPU
    if ((`CCX_TRANSDUCER3.pcx_buffer.is_req_squashed == 1'b0) && (`SPARC_CORE3.sparc0.lsu.lsu.qctl1.pcx_req_squash == 1'b1))
`else
    if ((`CCX_TRANSDUCER3.pcx_buffer.is_req_squashed == 1'b0) && (`SPARC_CORE3.sparc0.lsu.qctl1.pcx_req_squash == 1'b1))
`endif
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "PCXTILE3 req was squashed but valid at L1.5");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("PCXTILE3 req was squashed but valid at L1.5");
    end

    // check for squashed atomic
    if ((`CCX_TRANSDUCER3.pcx_buffer.is_req_squashed == 1'b1) && (`CCX_TRANSDUCER3.pcx_buffer.spc_uncore_atomic_req == 1'b1))
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "PCXTILE3 atomic req squashed");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("PCXTILE3 atomic req squashed");
    end
`endif

// monitor FP transactions because it is not supported yet
//     if (`L15_PIPE3.pcxdecoder_l15_val && !`L15_PIPE3.pcx_message_staled_s1 && `L15_PIPE3.val_s1 && !`L15_PIPE3.stall_s1 && !`L15_PIPE3.noc2decoder_l15_val)
//     begin
//         if (`L15_PIPE3.pcxdecoder_l15_rqtype == `PCX_REQTYPE_FP1)
//         begin
//             $display("%d : Simulation -> FAIL(%0s)", $time, "FP requests received but not implemented");
//             `ifndef VERILATOR
//             repeat(5)@(posedge clk)
//             `endif
    //             `MONITOR_PATH.fail("FP requests received but not implemented");
//         end
//     end

// monitor INT_VEC_DIS requests
    if (`L15_PIPE3.pcxdecoder_l15_val && `L15_PIPE3.val_s1 && !`L15_PIPE3.stall_s1 && !`L15_PIPE3.noc2decoder_l15_val)
    begin
        if (`L15_PIPE3.pcxdecoder_l15_rqtype == `PCX_REQTYPE_STORE
            && `L15_PIPE3.pcxdecoder_l15_address == 40'h9800000800)
        begin
            $display("%d : PCX write to INT_VEC_DIS", $time);
            // $display("%d : Simulation -> FAIL(%0s)", $time, "Write to INT_VEC_DIS");
            // `ifndef VERILATOR
            // repeat(5)@(posedge clk)
            // `endif
                // `MONITOR_PATH.fail("Write to INT_VEC_DIS");
        end
    end

// monitor noc1 buffer credit for underflow
    if (`L15_PIPE3.creditman_noc1_avail == 4'd15)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE3 NOC1 credit underflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE3 NOC1 credit underflow");
    end
    if (`L15_PIPE3.creditman_noc1_avail > `NOC1_BUFFER_NUM_SLOTS)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE3 NOC1 credit overflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE3 NOC1 credit overflow");
    end
    if (`L15_PIPE3.creditman_noc1_data_avail == 4'd15)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE3 NOC1 data credit underflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE3 NOC1 data credit underflow");
    end
    if (`L15_PIPE3.creditman_noc1_data_avail > `NOC1_BUFFER_NUM_DATA_SLOTS)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE3 NOC1 data credit overflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE3 NOC1 data credit overflow");
    end

    // check noc1 reserve credit
    if (`L15_PIPE3.creditman_noc1_reserve == 4'd15)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE3 NOC1 reserve credit underflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE3 NOC1 reserve credit underflow");
    end
    if (`L15_PIPE3.creditman_noc1_reserve > `NOC1_BUFFER_NUM_SLOTS)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE3 NOC1 reserve credit overflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE3 NOC1 reserve credit overflow");
    end
    // check reserve logics
    // if (`L15_PIPE3.creditman_noc1_reserve_s3)
    // begin
    //     $display("%d : Simulation -> FAIL(%0s)", $time, "TILE3 NOC1 reserve credit underflow");
    //     `ifndef VERILATOR
    //     repeat(5)@(posedge clk)
    //     `endif
        //     `MONITOR_PATH.fail("TILE3 NOC1 reserve credit underflow");
    // end

// Monitor for "RESERVED" messages
    if (`L15_PIPE3.noc2decoder_l15_val && `L15_PIPE3.val_s1 && !`L15_PIPE3.stall_s1)
    begin
        if (`L15_PIPE3.noc2decoder_l15_reqtype == `MSG_TYPE_RESERVED)
        begin
            $display("%d : Simulation -> FAIL(%0s)", $time, "TILE3 L15 received MSG_TYPE_RESERVED");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("TILE3 L15 received MSG_TYPE_RESERVED");
        end
    end

// Monitor WMT duplicate error
    if (`L15_PIPE3.val_s3)
    begin
        {wmt_read_data_TILE3[3], wmt_read_data_TILE3[2], wmt_read_data_TILE3[1], wmt_read_data_TILE3[0]} = `L15_PIPE3.wmt_l15_data_s3;
        for (i_TILE3 = 0; i_TILE3 < 4; i_TILE3 = i_TILE3+1)
        begin
            for (j_TILE3 = 0; j_TILE3 < i_TILE3; j_TILE3 = j_TILE3 + 1)
            begin
                if ((wmt_read_data_TILE3[i_TILE3][`L15_WMT_VALID_MASK] && wmt_read_data_TILE3[j_TILE3][`L15_WMT_VALID_MASK]) && (wmt_read_data_TILE3[i_TILE3] == wmt_read_data_TILE3[j_TILE3]))
                begin
                    $display("%d : Simulation -> FAIL(%0s)", $time, "TILE3 L15 has error with WMT");
                    `ifndef VERILATOR
                    repeat(5)@(posedge clk)
                    `endif
                        `MONITOR_PATH.fail("TILE3 L15 has error with WMT");
                end
            end
        end
    end

// Monitor tags duplication error (bug #86)
    if (`L15_PIPE3.val_s2 && `L15_PIPE3.decoder_dtag_operation_s2 == `L15_DTAG_OP_READ)
    begin
        tag_data_TILE3[0] = `L15_PIPE3.dtag_tag_way0_s2[`L15_CACHE_TAG_WIDTH-1:0];
        tag_data_TILE3[1] = `L15_PIPE3.dtag_tag_way1_s2[`L15_CACHE_TAG_WIDTH-1:0];
        tag_data_TILE3[2] = `L15_PIPE3.dtag_tag_way2_s2[`L15_CACHE_TAG_WIDTH-1:0];
        tag_data_TILE3[3] = `L15_PIPE3.dtag_tag_way3_s2[`L15_CACHE_TAG_WIDTH-1:0];
        tag_val_TILE3[0] = `L15_PIPE3.mesi_state_way0_s2 != `L15_MESI_STATE_I;
        tag_val_TILE3[1] = `L15_PIPE3.mesi_state_way1_s2 != `L15_MESI_STATE_I;
        tag_val_TILE3[2] = `L15_PIPE3.mesi_state_way2_s2 != `L15_MESI_STATE_I;
        tag_val_TILE3[3] = `L15_PIPE3.mesi_state_way3_s2 != `L15_MESI_STATE_I;
        for (i_TILE3 = 0; i_TILE3 < 4; i_TILE3 = i_TILE3+1)
        begin
            for (j_TILE3 = 0; j_TILE3 < i_TILE3; j_TILE3 = j_TILE3 + 1)
            begin
                if ((tag_val_TILE3[i_TILE3] && tag_val_TILE3[j_TILE3]) && (tag_data_TILE3[i_TILE3] == tag_data_TILE3[j_TILE3]))
                begin
                    $display("%d : Simulation -> FAIL(%0s)", $time, "TILE3 L15 has duplicated tag entry");
                    `ifndef VERILATOR
                    repeat(5)@(posedge clk)
                    `endif
                        `MONITOR_PATH.fail("TILE3 L15 has duplicated tag entry");
                end
            end
        end
    end

// // monitor FP transactions because it is not supported yet
//     if (`L15_TOP3.noc1encoder.sending)
//     begin
//         $display("noc1 flit raw: 0x%x", `L15_TOP3.noc1encoder.flit);
//     end
//     if (`L15_PIPE3.pcxdecoder_l15_val && !`L15_PIPE3.pcx_message_staled_s1 && `L15_PIPE3.val_s1 && !`L15_PIPE3.stall_s1 && !`L15_PIPE3.noc2decoder_l15_val)
//     begin
//         $display("%d : Simulation -> FAIL(%0s)", $time, "FP requests received but not implemented");
//         `ifndef VERILATOR
//         repeat(5)@(posedge clk)
//         `endif
    //         `MONITOR_PATH.fail("FP requests received but not implemented");
//     end


// Monitor FP transactions
//    if (`TILE3.fpu_arb_wrap.pcx_fpio_data_px2[123]
//            && `TILE3.fpu_arb_wrap.pcx_fpio_data_px2[122:119] == 4'b0101)
//    begin
//        $display("TILE3 FPU th%d: Received FP%d",
//                    `TILE3.fpu_arb_wrap.pcx_fpio_data_px2[113:112],
//                    `TILE3.fpu_arb_wrap.pcx_fpio_data_px2[118]);
//    end
//    if (`TILE3.fpu_arb_wrap.fpu_arb_data_rdy
//            && !`TILE3.fpu_arb_wrap.l15_fp_rdy)
//        $display("TILE3 FPU th%d: Sent FP data",
//                    `TILE3.fpu_arb_wrap.fpu_arb_data[135:134]);

// monitor L1.5 way replacement error
    if (`L15_PIPE3.l15_dcache_val_s2
        && `L15_PIPE3.dcache_operation_s2 == `L15_DCACHE_READ_LRU_WAY_IF_M)
    begin
        if (`L15_PIPE3.lruarray_l15_dout_s2[`L15_PIPE3.lru_way_s2] == 1'b1)
        begin
            // replacing a valid line
            if (&`L15_PIPE3.lru_used_bits_s2[3:0] == 1'b0)
            begin
                // and an another entry is 0, then is an error
                $display("%d : Simulation -> FAIL(%0s)", $time, "TILE3 L15 picked the wrong LRU entry");
                `ifndef VERILATOR
                repeat(5)@(posedge clk)
                `endif
                    `MONITOR_PATH.fail("TILE3 L15 picked the wrong LRU entry");
            end
        end
    end

// monitor X's in stall signals
    if (`L15_PIPE3.val_s1 && (`L15_PIPE3.stall_s1 === 1'bx) ||
        `L15_PIPE3.val_s2 && (`L15_PIPE3.stall_s2 === 1'bx) ||
        `L15_PIPE3.val_s3 && (`L15_PIPE3.stall_s3 === 1'bx))
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "L15 has X's in the stall_s1 signal");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("L15 has X's in the stall_s1 signal");
    end

`ifdef RTL_SPARC3
// some checks for l15cpxencoder
    if (`L15_TOP3.l15_transducer_val)
    begin
        if (`L15_TOP3.l15_transducer_inval_icache_inval)
        begin
            $display("%d : Simulation -> FAIL(%0s)", $time, "l15 icache inval is not used");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("l15 icache inval is not used");
        end
        if (`L15_TOP3.l15_transducer_returntype == `CPX_RESTYPE_ATOMIC_RES
            && `L15_TOP3.l15_transducer_inval_dcache_inval)
        begin
            $display("%d : Simulation -> FAIL(%0s)", $time, "l15 CAS inval is not used");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("l15 CAS inval is not used");
        end
    end
`endif

// some checks for l15 noc1 encoder
    if (`L15_TOP3.noc1encoder.sending && `L15_TOP3.noc1encoder.req_type == 0)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "l15 noc1 message is null");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("l15 noc1 message is null");
    end

    end // disable_l15_mon
end

//CORE3 END


// CORE4

reg do_print_stage_TILE4;
integer i_TILE4;
wire [63:0] dtag_tag_way0_s2_TILE4;
wire [63:0] dtag_tag_way1_s2_TILE4;
wire [63:0] dtag_tag_way2_s2_TILE4;
wire [63:0] dtag_tag_way3_s2_TILE4;

assign dtag_tag_way0_s2_TILE4 = (`L15_PIPE4.dtag_tag_way0_s2 << 11);
assign dtag_tag_way1_s2_TILE4 = (`L15_PIPE4.dtag_tag_way1_s2 << 11);
assign dtag_tag_way2_s2_TILE4 = (`L15_PIPE4.dtag_tag_way2_s2 << 11);
assign dtag_tag_way3_s2_TILE4 = (`L15_PIPE4.dtag_tag_way3_s2 << 11);
reg [`L15_CACHE_TAG_WIDTH-1:0] tag_data_TILE4 [0:3];
reg [3:0] tag_val_TILE4;
reg [`L15_WMT_ENTRY_MASK] wmt_read_data_TILE4 [0:3];
integer j_TILE4;
reg is_csm_mshrid_TILE4;

reg wmt_read_val_s3_TILE4;
always @ (posedge clk)
    wmt_read_val_s3_TILE4 <= `L15_PIPE4.l15_wmt_read_val_s2;

always @ (negedge clk)
begin
    if(!$test$plusargs("disable_l15_mon"))
    begin

    // monitoring outgoing noc1/noc3 messages
    if (`L15_TOP4.noc1encoder.sending)
    begin
        $display($time);
        $display("TILE4 noc1 flit raw: 0x%x", `L15_TOP4.noc1encoder.flit);
        $display("   srcX: %d, srcY: %d", `L15_TOP4.noc1encoder.msg_src_xpos, `L15_TOP4.noc1encoder.msg_src_ypos);
        $display("   destX: %d, destY: %d", `L15_TOP4.noc1encoder.msg_dest_l2_xpos, `L15_TOP4.noc1encoder.msg_dest_l2_ypos);
        if ( ^`L15_TOP4.noc1encoder.flit === 1'bx)
        begin
            $display("%d : Simulation -> FAIL(TILE4 noc1 sends X data 0x%x)", $time, `L15_TOP4.noc1encoder.flit);
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("l15_mon: TILE4 noc1 sends X data");
        end

    end




    if (`L15_PIPE4.pcxdecoder_l15_val && `L15_PIPE4.val_s1 && !`L15_PIPE4.stall_s1 && !`L15_PIPE4.noc2decoder_l15_val
        && `L15_PIPE4.fetch_state_s1 == `L15_FETCH_STATE_NORMAL)
    begin
        $write("%0d TILE4 L1.5 th%d: Received PCX ", $time, `L15_PIPE4.pcxdecoder_l15_threadid); decode_pcx_op(`L15_PIPE4.pcxdecoder_l15_rqtype, `L15_PIPE4.pcxdecoder_l15_amo_op);
        $display("   Addr 0x%x, nc %d, size %d, invalall %d, pf %d, bs %d, bsi %d, l1way %d",
                                `L15_PIPE4.pcxdecoder_l15_address, `L15_PIPE4.pcxdecoder_l15_nc, `L15_PIPE4.pcxdecoder_l15_size, `L15_PIPE4.pcxdecoder_l15_invalidate_cacheline,
                                `L15_PIPE4.pcxdecoder_l15_prefetch, `L15_PIPE4.pcxdecoder_l15_blockstore, `L15_PIPE4.pcxdecoder_l15_blockinitstore, `L15_PIPE4.pcxdecoder_l15_l1rplway);
        $display("   Data: 0x%x", `L15_PIPE4.pcxdecoder_l15_data);
        if (`L15_PIPE4.pcxdecoder_l15_csm_data[`TLB_CSM_STATE] == `TLB_CSM_STATE_LOCAL)
        begin
            $display("   CSM HDID: %d, HD_SIZE: %d, SDID: %d, LSID: %d", `L15_PIPE4.pcxdecoder_l15_csm_data[`TLB_CSM_HDID], `L15_PIPE4.pcxdecoder_l15_csm_data[`TLB_CSM_HD_SIZE],
            `L15_PIPE4.pcxdecoder_l15_csm_data[`TLB_CSM_SDID], `L15_PIPE4.pcxdecoder_l15_csm_data[`TLB_CSM_LSID]);
        end
        else if (`L15_PIPE4.pcxdecoder_l15_csm_data[`TLB_CSM_STATE] == `TLB_CSM_STATE_GLOBAL)
        begin
            $display("   CSM CHIPID: %d, X: %d, Y: %d", `L15_PIPE4.pcxdecoder_l15_csm_data[`TLB_CSM_CHIPID], `L15_PIPE4.pcxdecoder_l15_csm_data[`TLB_CSM_X],`L15_PIPE4.pcxdecoder_l15_csm_data[`TLB_CSM_Y]);
        end
        $display("   CSM Data: 0x%x", `L15_PIPE4.pcxdecoder_l15_csm_data);
        /*
        if (noc2decoder_l15_reqtype == `PCX_REQTYPE_STORE)
        if (noc2decoder_l15_reqtype == `PCX_REQTYPE_CAS1)
        begin
        $display("   Cmp.data: 0x%x", `L15_PIPE4.pcxdecoder_l15_data);
        $display("   Swp.data: 0x%x", `L15_PIPE4.pcxdecoder_l15_data_next_entry);
        end
        if (noc2decoder_l15_reqtype == `PCX_REQTYPE_SWP_LOADSTUB)
        begin
        $display("   Swp.data: 0x%x", `L15_PIPE4.pcxdecoder_l15_data);
        end
        */
        if (`L15_PIPE4.pcxdecoder_l15_rqtype == `PCX_REQTYPE_INTERRUPT && `L15_PIPE4.pcxdecoder_l15_data[63] == 1'b0)
        begin
            pcx_interrupt_type = `L15_PIPE4.pcxdecoder_l15_data[17:16];
            pcx_interrupt_dst_chipid = `L15_PIPE4.pcxdecoder_l15_data[31:18];
            pcx_interrupt_dst_y = `L15_PIPE4.pcxdecoder_l15_data[14:12];
            pcx_interrupt_dst_x = `L15_PIPE4.pcxdecoder_l15_data[11:9];
            pcx_interrupt_threadid = `L15_PIPE4.pcxdecoder_l15_data[8];
            pcx_interrupt_vector = `L15_PIPE4.pcxdecoder_l15_data[5:0];
            $display("Interrupt info:");
            $write("    Type: ");
            case(pcx_interrupt_type)
                2'b00:
                    $display("hw int");
                2'b01:
                    $display("reset");
                2'b10:
                    $display("idle");
                2'b11:
                    $display("resume");
            endcase

            $display("    Dst CHIP ID: %d", pcx_interrupt_dst_chipid);
            $display("    Dst X: %d", pcx_interrupt_dst_x);
            $display("    Dst Y: %d", pcx_interrupt_dst_y);
            $display("    Thread ID: %d", pcx_interrupt_threadid);
            $display("    Vector: %d", pcx_interrupt_vector);
        end
    end

    if (`L15_PIPE4.noc2decoder_l15_val && `L15_PIPE4.val_s1 && !`L15_PIPE4.stall_s1)
    begin
        noc2 = 0;
        case(`L15_PIPE4.noc2decoder_l15_reqtype)
        `MSG_TYPE_RESERVED:
            noc2 = "MSG_TYPE_RESERVED";
        `MSG_TYPE_LOAD_FWD:
            noc2 = "MSG_TYPE_LOAD_FWD";
        `MSG_TYPE_STORE_FWD:
            noc2 = "MSG_TYPE_STORE_FWD";
        `MSG_TYPE_INV_FWD:
            noc2 = "MSG_TYPE_INV_FWD";
        `MSG_TYPE_NODATA_ACK:
            noc2 = "MSG_TYPE_NODATA_ACK";
        `MSG_TYPE_DATA_ACK:
            noc2 = "MSG_TYPE_DATA_ACK";
        `MSG_TYPE_NC_LOAD_MEM_ACK:
            noc2 = "MSG_TYPE_NC_LOAD_MEM_ACK";
        `MSG_TYPE_NC_STORE_MEM_ACK:
            noc2 = "MSG_TYPE_NC_STORE_MEM_ACK";
        `MSG_TYPE_INTERRUPT:
            noc2 = "MSG_TYPE_L2_INTERRUPT";
        default:
        begin
            noc2 = "MSG_TYPE_UNKNOWN_ERROR";
            $display("%d : Simulation -> FAIL(%0s)", $time, "L15 mon: error message type from L2");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("L15 mon: error message type from L2");
        end
        endcase

        $write("%0d TILE4 L1.5: Received NOC2 %s", $time, noc2);
        $display("   mshrid %d, l2miss %d, f4b %d, ackstate %d, address 0x%x",
                    `L15_PIPE4.noc2decoder_l15_mshrid, `L15_PIPE4.noc2decoder_l15_l2miss, `L15_PIPE4.noc2decoder_l15_f4b,
                    `L15_PIPE4.noc2decoder_l15_ack_state, `L15_PIPE4.noc2decoder_l15_address);
        $display("   Data1: 0x%x", `L15_PIPE4.noc2decoder_l15_data_0);
        $display("   Data2: 0x%x", `L15_PIPE4.noc2decoder_l15_data_1);
        $display("   Data3: 0x%x", `L15_PIPE4.noc2decoder_l15_data_2);
        $display("   Data4: 0x%x", `L15_PIPE4.noc2decoder_l15_data_3);
    end

    if (`L15_PIPE4.l15_cpxencoder_val && !`L15_PIPE4.stall_s3)
    begin
        cpx = 0;
        case(`L15_PIPE4.l15_cpxencoder_returntype)
            `LOAD_RET:
                cpx = "LOAD_RET";
            `INV_RET:
                cpx = "INV_RET";
            `ST_ACK:
                cpx = "ST_ACK";
            `AT_ACK:
                cpx = "AT_ACK";
            `INT_RET:
                cpx = "INT_RET";
            `TEST_RET:
                cpx = "TEST_RET";
            `FP_RET:
                cpx = "FP_RET";
            `IFILL_RET:
                cpx = "IFILL_RET";
            `EVICT_REQ:
                cpx = "EVICT_REQ";
            `ERR_RET:
                cpx = "ERR_RET";
            `STRLOAD_RET:
                cpx = "STRLOAD_RET";
            `STRST_ACK:
                cpx = "STRST_ACK";
            `FWD_RQ_RET:
                cpx = "FWD_RQ_RET";
            `FWD_RPY_RET:
                cpx = "FWD_RPY_RET";
            `RSVD_RET:
                cpx = "RSVD_RET";
            4'b1110:
                cpx = "ATOMIC_ACK";
            default:
                cpx = "CPX_UNKNOWN";
        endcase
        $write("%0d TILE4 L1.5 th%d: Sent CPX %0s", $time, `L15_PIPE4.l15_cpxencoder_threadid, cpx);
        $display("   l2miss %d, nc %d, atomic %d, threadid %d, pf %d, f4b %d, iia %d, dia %d, dinval %d, iinval %d, invalway %d, blkinit %d",
                    `L15_PIPE4.l15_cpxencoder_l2miss, `L15_PIPE4.l15_cpxencoder_noncacheable, `L15_PIPE4.l15_cpxencoder_atomic,
                    `L15_PIPE4.l15_cpxencoder_threadid, `L15_PIPE4.l15_cpxencoder_prefetch,
                    `L15_PIPE4.l15_cpxencoder_f4b, `L15_PIPE4.l15_cpxencoder_inval_icache_all_way,
                    `L15_PIPE4.l15_cpxencoder_inval_dcache_all_way, `L15_PIPE4.l15_cpxencoder_inval_dcache_inval,
                    `L15_PIPE4.l15_cpxencoder_inval_icache_inval, `L15_PIPE4.l15_cpxencoder_inval_way,
                    `L15_PIPE4.l15_cpxencoder_blockinitstore);
        $display("   Data0: 0x%x", `L15_PIPE4.l15_cpxencoder_data_0);
        $display("   Data1: 0x%x", `L15_PIPE4.l15_cpxencoder_data_1);
        $display("   Data2: 0x%x", `L15_PIPE4.l15_cpxencoder_data_2);
        $display("   Data3: 0x%x", `L15_PIPE4.l15_cpxencoder_data_3);
    end

    if (`L15_TOP4.noc1encoder.noc1encoder_noc1out_val && `L15_TOP4.noc1encoder.noc1encoder_noc1buffer_req_ack)
    begin
        noc1 = 0;
        case(`L15_TOP4.noc1encoder.req_type)
        `L15_NOC1_REQTYPE_WRITEBACK_GUARD:
            noc1 = "L15_NOC1_REQTYPE_WRITEBACK_GUARD";
        `L15_NOC1_REQTYPE_LD_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_LD_REQUEST";
        `L15_NOC1_REQTYPE_IFILL_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_IFILL_REQUEST";
        `L15_NOC1_REQTYPE_WRITETHROUGH_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_WRITETHROUGH_REQUEST";
        `L15_NOC1_REQTYPE_ST_UPGRADE_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_ST_UPGRADE_REQUEST";
        `L15_NOC1_REQTYPE_ST_FILL_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_ST_FILL_REQUEST";
        `L15_NOC1_REQTYPE_CAS_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_CAS_REQUEST";
        `L15_NOC1_REQTYPE_SWAP_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_SWAP_REQUEST";
        `L15_NOC1_REQTYPE_INTERRUPT_FWD:
            noc1 = "L15_NOC1_REQTYPE_INTERRUPT_FWD";
        `L15_NOC1_REQTYPE_AMO_ADD_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_ADD_REQUEST";
        `L15_NOC1_REQTYPE_AMO_AND_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_AND_REQUEST";
        `L15_NOC1_REQTYPE_AMO_OR_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_OR_REQUEST";
        `L15_NOC1_REQTYPE_AMO_XOR_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_XOR_REQUEST";
        `L15_NOC1_REQTYPE_AMO_MAX_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_MAX_REQUEST";
        `L15_NOC1_REQTYPE_AMO_MAXU_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_MAXU_REQUEST";
        `L15_NOC1_REQTYPE_AMO_MIN_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_MIN_REQUEST";
        `L15_NOC1_REQTYPE_AMO_MINU_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_MINU_REQUEST";
        default:
            noc1 = "ERROR noc1";
        endcase

        $write("%0d TILE4 L1.5: Sending NOC1 %s", $time, noc1);
        $display("   mshrid %d, nc %d, size %d, pf %d, address %0x",
                    `L15_TOP4.noc1encoder.noc1buffer_noc1encoder_req_mshrid, `L15_TOP4.noc1encoder.noc1buffer_noc1encoder_req_non_cacheable,
                    `L15_TOP4.noc1encoder.noc1buffer_noc1encoder_req_size, `L15_TOP4.noc1encoder.noc1buffer_noc1encoder_req_prefetch, `L15_TOP4.noc1encoder.noc1buffer_noc1encoder_req_address);
        $display("   Data0: 0x%x", `L15_TOP4.noc1encoder.noc1buffer_noc1encoder_req_data_0);
        $display("   Data1: 0x%x", `L15_TOP4.noc1encoder.noc1buffer_noc1encoder_req_data_1);
        $display("   Destination X: %d Y: %d", `L15_TOP4.noc1encoder.msg_dest_l2_xpos, `L15_TOP4.noc1encoder.msg_dest_l2_ypos);
    end

    if (`L15_TOP4.noc3encoder.noc3encoder_noc3out_val && `L15_TOP4.noc3encoder.noc3encoder_l15_req_ack)
    begin
        noc3 = 0;
        case(`L15_TOP4.noc3encoder.l15_noc3encoder_req_type)
        `L15_NOC3_REQTYPE_WRITEBACK:
            noc3 = "L15_NOC3_REQTYPE_WRITEBACK";
        `L15_NOC3_REQTYPE_INVAL_ACK:
            noc3 = "L15_NOC3_REQTYPE_INVAL_ACK";
        `L15_NOC3_REQTYPE_DOWNGRADE_ACK:
            noc3 = "L15_NOC3_REQTYPE_DOWNGRADE_ACK";
        `L15_NOC3_REQTYPE_ICACHE_INVAL_ACK:
            noc3 = "L15_NOC3_REQTYPE_ICACHE_INVAL_ACK";
        default:
            noc3 = "ERROR NOC3";
        endcase

        // quick check for an error case
        if (`L15_TOP4.noc3encoder.msg_type == `MSG_TYPE_INV_FWDACK
            && `L15_TOP4.noc3encoder.l15_noc3encoder_req_with_data)
        begin
            $display("L1.5 MON: sending back invalid ack with data");
            $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: sending back invalid ack with data");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("L1.5 MON: sending back invalid ack with data");
        end


        $write("%0d TILE4 L1.5: Sent NOC3 %s", $time, noc3);
        $display("   mshrid %d, seqid %d, address %0x",
                    `L15_TOP4.noc3encoder.l15_noc3encoder_req_mshrid, `L15_TOP4.noc3encoder.l15_noc3encoder_req_sequenceid, `L15_TOP4.noc3encoder.l15_noc3encoder_req_address);
        $display("   srcX: %d, srcY: %d", `L15_TOP4.noc3encoder.src_l2_xpos, `L15_TOP4.noc3encoder.src_l2_ypos);
        $display("   destX: %d, destY: %d", `L15_TOP4.noc3encoder.dest_l2_xpos, `L15_TOP4.noc3encoder.dest_l2_ypos);
        $display("   Data0: 0x%x", `L15_TOP4.noc3encoder.l15_noc3encoder_req_data_0);
        $display("   Data1: 0x%x", `L15_TOP4.noc3encoder.l15_noc3encoder_req_data_1);
    end

    do_print_stage_TILE4 = ((`L15_PIPE4.val_s1 && !`L15_PIPE4.stall_s1) || (`L15_PIPE4.val_s2 && !`L15_PIPE4.stall_s2) || (`L15_PIPE4.val_s3 && !`L15_PIPE4.stall_s3));
    if (do_print_stage_TILE4)
    begin
        // $display("");
        $display("");
        $display($time, " L15 TILE4:");
        $display("NoC1 credit: %d", `L15_PIPE4.creditman_noc1_avail);
        $display("NoC1 reserved credit: %d", `L15_PIPE4.creditman_noc1_reserve);
        // $display("NoC1 r down: %d", `L15_PIPE4.creditman_noc1_reserve_minus1);
        // $display("NoC1 r up: %d", `L15_PIPE4.creditman_noc1_reserve_add1);

        // monitor the MSHRID allocation
        // $display("MSHRID allocation info:");
        // for (i_TILE4 = 0; i_TILE4 < `L15_MSHR_COUNT; i_TILE4 = i_TILE4 + 1)
        //     $write("%d:%d", i_TILE4, `L15_PIPE4.mshr_val_array[i_TILE4]);
            // $write("%d %d", i_TILE4, i_TILE4);
        // $display("");

`ifdef RTL_SPARC4
        $display("Core STB info:");
        $display("  STB0: %d", `SPARC_CORE4.sparc0.ifu.lsu_ifu_stbcnt0);
        $display("  STB1: %d", `SPARC_CORE4.sparc0.ifu.lsu_ifu_stbcnt1);
            // $write("%d %d", i_TILE4, i_TILE4);
`endif

        $write("TILE4 Pipeline:");
        if (`L15_PIPE4.val_s1 && !`L15_PIPE4.stall_s1)
            $write(" * ");
        else if (`L15_PIPE4.val_s1 && `L15_PIPE4.stall_s1)
            $write(" = ");
        else
            $write(" X ");

        if (`L15_PIPE4.val_s2 && !`L15_PIPE4.stall_s2)
            $write(" * ");
        else if (`L15_PIPE4.val_s2 && `L15_PIPE4.stall_s2)
            $write(" = ");
        else
            $write(" X ");

        if (`L15_PIPE4.val_s3 && !`L15_PIPE4.stall_s3)
            $write(" * ");
        else if (`L15_PIPE4.val_s3 && `L15_PIPE4.stall_s3)
            $write(" = ");
        else
            $write(" X ");
        $display("");

        // $write("PCX pipe info: "); decode_pcx_op(`L15_PIPE4.pcxdecoder_l15_rqtype, L15_PIPE4.pcxdecoder_l15_amo_op);
        // if (`L15_PIPE4.noc1_req_val_s3 && `L15_PIPE4.noc1encoder_req_staled_s3)
        //     $display(" (staled)");
        // else if (!`L15_PIPE4.noc1_req_val_s3)
        //     $display(" (invalid)");
        // else if (`L15_PIPE4.noc1_req_val_s3 && !`L15_PIPE4.noc1encoder_req_staled_s3)
        // begin
        //     $display(" (fresh)");
        // end

        // $write("NoC1 pipe info: ");
        // if (`L15_PIPE4.noc1_req_val_s3 && `L15_PIPE4.noc1encoder_req_staled_s3)
        //     $display("staled");
        // else if (!`L15_PIPE4.noc1_req_val_s3)
        //     $display("invalid");
        // else if (`L15_PIPE4.noc1_req_val_s3 && !`L15_PIPE4.noc1encoder_req_staled_s3)
        // begin
        //     $display("fresh");
        // end

        // $write("NoC3 pipe info: ");
        // if (`L15_PIPE4.noc3_req_val_s3 && `L15_PIPE4.noc3encoder_req_staled_s3)
        //     $display("staled");
        // else if (!`L15_PIPE4.noc3_req_val_s3)
        //     $display("invalid");
        // else if (`L15_PIPE4.noc3_req_val_s3 && !`L15_PIPE4.noc3encoder_req_staled_s3)
        // begin
        //     $display("fresh");
        // end

        // $write("CPX pipe info: ");
        // if (`L15_PIPE4.cpx_req_val_s3 && `L15_PIPE4.cpxencoder_req_staled_s3)
        //     $display("staled");
        // else if (!`L15_PIPE4.cpx_req_val_s3)
        //     $display("invalid");
        // else if (`L15_PIPE4.cpx_req_val_s3 && !`L15_PIPE4.cpxencoder_req_staled_s3)
        // begin
        //     $display("fresh");
        // end

            // Stage 1 debug information
        if (`L15_PIPE4.stall_s1 === 1'bx)
            $display("S1 stall is XXXXXXX");
        if (`L15_PIPE4.val_s1 && !`L15_PIPE4.stall_s1)
        begin
            $write("Stage 1 status: ");
            $write("   Operation: "); decode_predecode_reqtype(`L15_PIPE4.predecode_reqtype_s1);
            $display("   TILE4 S1 Address: 0x%x", `L15_PIPE4.predecode_address_s1);
            // if (`L15_PIPE4.decoder_dtag_operation_s1 == `L15_DTAG_OP_READ)
            // begin
            //     $display("   DTAG OP: L15_DTAG_OP_READ");
            //     $display("      Index: 0x%x", `L15_PIPE4.dtag_index);
            // end
            // if (`L15_PIPE4.l15_dtag_rw_s1 == `L15_DTAG_RW_WRITE)
            // begin
            //     $display("   DTAG OP: L15_DTAG_OP_WRITE");
            //     $display("      Data:  0x%x", `L15_PIPE4.dtag_write_tag_s1);
            //     $display("      Way:  0x%x", `L15_PIPE4.dtag_write_way_s1);
            //     // $display("      Mask: 0x%x", `L15_PIPE4.dtag_write_mask);
            // end
            // if (`L15_PIPE4.s1_mshr_write_val_s1)
            // begin
            //     $display("   DTAG OP: ");
            //     if (`L15_PIPE4.s1_mshr_write_type_s1 == `L15_MSHR_WRITE_TYPE_ALLOCATION)
            //     begin
            //         $write ("L15_MSHR_WRITE_TYPE_ALLOCATION");
            //         $display ("      MSRID: %d", `L15_PIPE4.s1_mshr_write_mshrid_s1);
            //     end
            //     else if (`L15_PIPE4.s1_mshr_write_type_s1 == `L15_S1_MSHR_OP_UPDATE_WRITECACHE)
            //     begin
            //         $write ("L15_S1_MSHR_OP_UPDATE_WRITECACHE");
            //         $display ("      MSRID:     %d", `L15_PIPE4.s1_mshr_write_mshrid_s1);
            //         $display ("      DATA:      0x%x", `L15_PIPE4.s1_mshr_write_data);
            //         $display ("      DATAMASK:  0x%x", `L15_PIPE4.s1_mshr_write_byte_mask);
            //     end
            // end
        end
        // Stage 2 debug information
        if (`L15_PIPE4.stall_s2 === 1'bx)
            $display("S2 stall is XXXXXXX");
        if (`L15_PIPE4.val_s2 && !`L15_PIPE4.stall_s2)
        begin
        $write("Stage 2 status: ");
            $write("   Operation: "); decode_predecode_reqtype(`L15_PIPE4.predecode_reqtype_s2);
            $display("   TILE4 S2 Address: 0x%x", `L15_PIPE4.address_s2);
            $display("   TILE4 S2 Cache index: %d", `L15_PIPE4.cache_index_s2);

            if (`L15_PIPE4.csm_req_val_s2)
            begin
                $display("   CSM op: %d", `L15_PIPE4.csm_op_s2);
                if (`L15_PIPE4.l15_csm_req_type_s2 == 1'b0)
                    $display("      CSM read ticket: 0x%x", `L15_PIPE4.l15_csm_req_ticket_s2);
                else
                begin
                    $display("      CSM write ticket: 0x%x", `L15_PIPE4.l15_csm_req_ticket_s2);
                    $display("      CSM write data: 0x%x", `L15_PIPE4.l15_csm_req_data_s2);
                end
            end

            // $display("   Source chipid: %d", `L15_PIPE4.noc2_src_homeid_s2[`PACKET_HOME_ID_CHIP_MASK]);
            // $display("   Source X: %d", `L15_PIPE4.noc2_src_homeid_s2[`PACKET_HOME_ID_X_MASK]);
            // $display("   Source Y: %d", `L15_PIPE4.noc2_src_homeid_s2[`PACKET_HOME_ID_Y_MASK]);
            // `ifdef L15_EXTRA_DEBUG
            // $display("   LRU state: %d", `L15_PIPE4.lru_state_s2);
            // $display("   LRU way: %d", `L15_PIPE4.lru_way_s2);
            // $display("   Tagcheck state: %d", `L15_PIPE4.tagcheck_state_s2);
            // $display("   Tagcheck way: %d", `L15_PIPE4.tagcheck_way_s2);

            if (`L15_PIPE4.decoder_dtag_operation_s2 == `L15_DTAG_OP_READ)
            begin
                $display("   DTAG way0 state: 0x%x", `L15_PIPE4.mesi_state_way0_s2);
                $display("   DTAG way0 data: 0x%x", dtag_tag_way0_s2_TILE4);
                $display("   DTAG way1 state: 0x%x", `L15_PIPE4.mesi_state_way1_s2);
                $display("   DTAG way1 data: 0x%x", dtag_tag_way1_s2_TILE4);
                $display("   DTAG way2 state: 0x%x", `L15_PIPE4.mesi_state_way2_s2);
                $display("   DTAG way2 data: 0x%x", dtag_tag_way2_s2_TILE4);
                $display("   DTAG way3 state: 0x%x", `L15_PIPE4.mesi_state_way3_s2);
                $display("   DTAG way3 data: 0x%x", dtag_tag_way3_s2_TILE4);
            end

            if (`L15_PIPE4.l15_mesi_write_val_s2)
            begin
                $display("   MESI write way: 0x%x", `L15_PIPE4.mesi_write_way_s2);
                $display("   MESI write data: 0x%x", `L15_PIPE4.mesi_write_state_s2);
            end

            // if (`L15_PIPE4.lruarray_write_op_s2 == `L15_LRU_EVICTION)
            // begin
            //     $display("   LRU EVICTION INDEX: %d, WAY: %d", `L15_PIPE4.cache_index_s2,
            //         `L15_PIPE4.lru_way_s2[1:0]);
            // end
            // `endif

            // if (`L15_PIPE4.s2_mesi_operation_s2 == `L15_S2_MESI_READ)
            // begin
            //     $display("   MESI OP: L15_S2_MESI_READ");
            //     $display ("      Index:     %d", `L15_PIPE4.s2_mesi_index_s2);
            // end
            // if (`L15_PIPE4.s2_mshr_val_s2)
            // begin
            //     $display("   MSHR OP: L15_S2_MSHR_OP_READ_WRITE_CACHE");
            //     $display ("      MSHR: %d", `L15_PIPE4.s2_mshr_read_mshrid);
            // end
            if (`L15_PIPE4.dcache_val_s2)
            begin
                // $write("   DCACHE OP: "); decode_dcache_op(`L15_PIPE4.dcache_operation_s2);
                // $display ("      RW:     %d", `L15_PIPE4.dcache_rw);
                // $display ("      Index:      0x%x", `L15_PIPE4.dcache_index);
                // $display ("      Data:  0x%x", `L15_PIPE4.dcache_write_data);
                // $display ("      Data mask:  0x%x", `L15_PIPE4.dcache_write_mask);
                if (`L15_PIPE4.l15_dcache_rw_s2 == 1'b0)
                begin
                    `ifndef NO_RTL_CSM
                    $display("HMT writing: %0b", `L15_PIPE4.l15_hmt_write_data_s2);
                    `endif
                    // TODO
                    // $display("HMT chip: %0b", `L15_PIPE4.wmt_fill_homeid_s2[`PACKET_HOME_ID_CHIP_MASK]);
                    // $display("HMT X: %0b", `L15_PIPE4.wmt_fill_homeid_s2[`PACKET_HOME_ID_X_MASK]);
                    // $display("HMT Y: %0b", `L15_PIPE4.wmt_fill_homeid_s2[`PACKET_HOME_ID_Y_MASK]);
                end
            end
        end

        // Stage 3 debug information
        if (`L15_PIPE4.stall_s3 === 1'bx)
            $display("S3 stall is XXXXXXX");
        if (`L15_PIPE4.val_s3 && !`L15_PIPE4.stall_s3)
        begin
            $write("Stage 3 status: ");
            $write("   Operation: "); decode_predecode_reqtype(`L15_PIPE4.predecode_reqtype_s3);
            $display("   TILE4 S3 Address: 0x%x", `L15_PIPE4.address_s3);
            `ifndef NO_RTL_CSM
            if ((`L15_PIPE4.noc1_homeid_source_s3 == `L15_HOMEID_SRC_HMT && `L15_PIPE4.noc1_req_val_s3)
                || (`L15_PIPE4.noc3_homeid_source_s3 == `L15_HOMEID_SRC_HMT && `L15_PIPE4.noc3_req_val_s3))
            begin
                `ifndef NO_RTL_CSM
                $display("   HMT chipid: %d", `L15_PIPE4.hmt_l15_dout_s3[`L15_CSM_GHID_CHIP_MASK]);
                $display("   HMT X: %d", `L15_PIPE4.hmt_l15_dout_s3[`L15_CSM_GHID_XPOS_MASK]);
                $display("   HMT Y: %d", `L15_PIPE4.hmt_l15_dout_s3[`L15_CSM_GHID_YPOS_MASK]);
                $display("   HMT reading: %0b", `L15_PIPE4.hmt_l15_dout_s3);
                `endif
            end
            `endif
            if (`L15_PIPE4.noc3_homeid_source_s3 == `L15_HOMEID_SRC_NOC2_SOURCE && `L15_PIPE4.noc3_req_val_s3)
            begin
                $display("   Source chipid: %d", `L15_PIPE4.noc2_src_homeid_s3[`PACKET_HOME_ID_CHIP_MASK]);
                $display("   Source X: %d", `L15_PIPE4.noc2_src_homeid_s3[`PACKET_HOME_ID_X_MASK]);
                $display("   Source Y: %d", `L15_PIPE4.noc2_src_homeid_s3[`PACKET_HOME_ID_Y_MASK]);
            end

            if (`L15_PIPE4.cpx_data_source_s3 == `L15_CPX_SOURCE_CSM)
                $display("      CSM read data: 0x%x", `L15_PIPE4.csm_l15_res_data_s3);
            // `ifdef L15_EXTRA_DEBUG
            // $display("   LRU state: %d", `L15_PIPE4.lru_state_s3);
            // $display("   LRU way: %d", `L15_PIPE4.lru_way_s3);
            // $display("   Tagcheck state: %d", `L15_PIPE4.tagcheck_state_s3);
            // $display("   Tagcheck way: %d", `L15_PIPE4.tagcheck_way_s3);
            // `endif

            // if (`L15_PIPE4.s3_mesi_val_s3)
            // begin
            //     $write("   MESI OP: "); decode_s3mesi_op(`L15_PIPE4.s3_mesi_operation_s3);
            //     $display ("      Index:      0x%x", `L15_PIPE4.mesi_write_index);
            //     $display ("      Data:  0x%x", `L15_PIPE4.mesi_write_data);
            //     $display ("      Data mask:  0x%x", `L15_PIPE4.mesi_write_mask);
            // end
            // if (`L15_PIPE4.wmc_val_s3)
            // begin
            //     $write("   WMC OP: "); decode_wmc_op(`L15_PIPE4.wmc_operation_s3);
            //     if (`L15_PIPE4.wmc_rw_s3 == `L15_WMC_OP_READ)
            //     begin
            //         $display ("      wmc_index_s3:      0x%x", `L15_PIPE4.wmc_index_s3);
            //         $display ("      wmc_invalidate_val_s3:      0x%x", `L15_PIPE4.wmc_invalidate_val_s3);
            //         $display ("      wmc_invalidate_way_s3:      0x%x", `L15_PIPE4.wmc_invalidate_way_s3);
            //     end
            //     else if (`L15_PIPE4.wmc_rw_s3 == `L15_WMC_OP_WRITE)
            //     begin
            //         $display ("      wmc_index_s3:      0x%x", `L15_PIPE4.wmc_index_s3);
            //         $display ("      wmc_update_way_s3:      0x%x", `L15_PIPE4.wmc_update_way_s3);
            //         $display ("      wmc_update_data_s3:      0x%x", `L15_PIPE4.wmc_update_data_s3);
            //         $display ("      wmc_invalidate_val_s3:      0x%x", `L15_PIPE4.wmc_invalidate_val_s3);
            //         $display ("      wmc_invalidate_way_s3:      0x%x", `L15_PIPE4.wmc_invalidate_way_s3);
            //     end
            //     $display ("      cpx_inval_way_s3:      0x%x", `L15_PIPE4.cpx_inval_way_s3);
            //     $display ("      wmc_read_way0_data_s3:      0x%x", `L15_PIPE4.wmc_read_way0_data_s3);
            //     $display ("      wmc_read_way1_data_s3:      0x%x", `L15_PIPE4.wmc_read_way1_data_s3);
            //     $display ("      wmc_read_way2_data_s3:      0x%x", `L15_PIPE4.wmc_read_way2_data_s3);
            //     $display ("      wmc_read_way3_data_s3:      0x%x", `L15_PIPE4.wmc_read_way3_data_s3);
            // end
            // if (`L15_PIPE4.s3_mshr_val_s3)
            // begin
            //     $write("   MSHR OP: "); decode_s3mshr_op(`L15_PIPE4.s3_mshr_operation_s3);
            //     $display ("      MSHR:      %d", `L15_PIPE4.s3_mshr_write_mshrid);
            //     $display ("      U.State:      0x%x", `L15_PIPE4.s3_mshr_write_update_state);
            //     $display ("      U.Way:  0x%x", `L15_PIPE4.s3_mshr_write_update_way);
            //     $display ("      St.mshr rand hit:   %d", `L15_PIPE4.LRU_st1_mshr_s3 || `L15_PIPE4.LRU_st2_mshr_s3);
            //     $display ("      St.mshr tag hit:   %d", `L15_PIPE4.tagcheck_st1_mshr_s3 || `L15_PIPE4.tagcheck_st2_mshr_s3);
            // end
            if (wmt_read_val_s3_TILE4)
            begin
                $display("   TILE4 WMT read index: %x", `L15_PIPE4.cache_index_l1d_s3[`L1D_SET_IDX_MASK]);
                // $display("   WMT way0: %x 0x%x", `L15_PIPE4.wmt_data_s3[0][`L15_WMT_VALID_MASK], `L15_PIPE4.wmt_data_s3[0][`L15_WMT_DATA_MASK]);
                // $display("   WMT way1: %x 0x%x", `L15_PIPE4.wmt_data_s3[1][`L15_WMT_VALID_MASK], `L15_PIPE4.wmt_data_s3[1][`L15_WMT_DATA_MASK]);
                // $display("   WMT way2: %x 0x%x", `L15_PIPE4.wmt_data_s3[2][`L15_WMT_VALID_MASK], `L15_PIPE4.wmt_data_s3[2][`L15_WMT_DATA_MASK]);
                // $display("   WMT way3: %x 0x%x", `L15_PIPE4.wmt_data_s3[3][`L15_WMT_VALID_MASK], `L15_PIPE4.wmt_data_s3[3][`L15_WMT_DATA_MASK]);
                for (i = 0; i < `L1D_WAY_COUNT; i = i + 1)
                begin
                    $display("   WMT way%d: %x 0x%x", i, `L15_PIPE4.wmt_data_s3[i][`L15_WMT_VALID_MASK], `L15_PIPE4.wmt_data_s3[i][`L15_WMT_DATA_MASK]);
                end
            end
            if (`L15_PIPE4.l15_wmt_write_val_s3)
            begin
                $display("   TILE4 WMT write index: %x", `L15_PIPE4.cache_index_l1d_s3[`L1D_SET_IDX_MASK]);
                // $display("   WMT write mask: %x", `L15_PIPE4.l15_wmt_write_mask_s3);
                // $display("   WMT write data: %x", `L15_PIPE4.l15_wmt_write_data_s3);
                // $display("   WMT way0 m%x d0x%x", `L15_PIPE4.l15_wmt_write_mask_s3[`L15_WMT_ENTRY_0_MASK], `L15_PIPE4.wmt_write_data_s3[`L15_WMT_ENTRY_0_MASK]);
                // $display("   WMT way1 m%x d0x%x", `L15_PIPE4.l15_wmt_write_mask_s3[`L15_WMT_ENTRY_1_MASK], `L15_PIPE4.wmt_write_data_s3[`L15_WMT_ENTRY_1_MASK]);
                // $display("   WMT way2 m%x d0x%x", `L15_PIPE4.l15_wmt_write_mask_s3[`L15_WMT_ENTRY_2_MASK], `L15_PIPE4.wmt_write_data_s3[`L15_WMT_ENTRY_2_MASK]);
                // $display("   WMT way3 m%x d0x%x", `L15_PIPE4.l15_wmt_write_mask_s3[`L15_WMT_ENTRY_3_MASK], `L15_PIPE4.wmt_write_data_s3[`L15_WMT_ENTRY_3_MASK]);
            end
        end
        $display ("L15_MON_END");
        $display ("");
    end

//CSM monitor
    if(`L15_TOP4.l15_csm.l15_csm_req_val_s2)
    begin
        $display($time, ": TILE4 L15_CSM REQ MON:");
        $display("L15 CSM req addr: 0x%x", `L15_TOP4.l15_csm.l15_csm_req_address_s2);
        $display("L15 CSM req ticket: %d", `L15_TOP4.l15_csm.l15_csm_req_ticket_s2);
        $display("L15 CSM req type: %d", `L15_TOP4.l15_csm.l15_csm_req_type_s2);
        $display("L15 CSM req data: 0x%x", `L15_TOP4.l15_csm.l15_csm_req_data_s2);
        $display("L15 CSM req pcx data: 0x%x", `L15_TOP4.l15_csm.l15_csm_req_pcx_data_s2);
    end
    if(`L15_TOP4.l15_csm.csm_l15_res_val_s3)
    begin
        $display($time, ": TILE4 L15_CSM RES MON:");
        $display("L15 CSM res data: 0x%x", `L15_TOP4.l15_csm.csm_l15_res_data_s3);
    end
    if(`L15_TOP4.l15_csm.csm_l15_read_res_val)
    begin
        $display($time, ": TILE4 L15_CSM READ TICKET MON:");
        $display("L15 CSM read ticket: %d", `L15_TOP4.l15_csm.l15_csm_read_ticket);
        $display("L15 CSM read data: 0x%x", `L15_TOP4.l15_csm.csm_l15_read_res_data);
    end
    if(`L15_TOP4.l15_csm.csm_noc1encoder_req_val)
    begin
        $display($time, ": TILE4 L15_CSM NOC1 REQ MON:");
        $display("L15 CSM noc1 req addr: 0x%x", `L15_TOP4.l15_csm.csm_noc1encoder_req_address);
        $display("L15 CSM noc1 req type: %d", `L15_TOP4.l15_csm.csm_noc1encoder_req_type);
        $display("L15 CSM noc1 req mshrid: %d", `L15_TOP4.l15_csm.csm_noc1encoder_req_mshrid);
    end
    if(`L15_TOP4.l15_csm.noc1encoder_csm_req_ack)
    begin
        $display($time, ": TILE4 L15_CSM NOC1 REQ ACK MON:");
        $display("L15 CSM noc1 req ack: %b", `L15_TOP4.l15_csm.noc1encoder_csm_req_ack);
    end

    if(`L15_TOP4.l15_csm.write_val_s2 && (~`L15_TOP4.l15_csm.ghid_val_s2))
    begin
        $display("L1.5 MON: HMC refills invalid data");
        $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: HMC refills invalid data");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("L1.5 MON: HMC refills invalid data");
    end

// valid mshrid monitor
    // check for incoming messages
    if (`L15_PIPE4.noc2decoder_l15_val && `L15_PIPE4.val_s1 && !`L15_PIPE4.stall_s1)
    begin
        is_csm_mshrid_TILE4 = `L15_PIPE4.noc2decoder_l15_hmc_fill;
        if ((`L15_PIPE4.noc2decoder_l15_reqtype == `MSG_TYPE_NODATA_ACK ||
            `L15_PIPE4.noc2decoder_l15_reqtype == `MSG_TYPE_DATA_ACK)
            && !is_csm_mshrid_TILE4)
        begin
            // first check if mshrid is in range
            if (`L15_PIPE4.noc2decoder_l15_mshrid > 9)
            begin
                $display("L1.5 MON: Received NoC2 message with MSHRID greater than 9 (%d)", `L15_PIPE4.noc2decoder_l15_mshrid);
                $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: Received NoC2 message with MSHRID greater than 9");
                `ifndef VERILATOR
                repeat(5)@(posedge clk)
                `endif
                    `MONITOR_PATH.fail("L1.5 MON: Received NoC2 message with MSHRID greater than 9");
            end

            // now check if it's valid
            // TODO
            // if (`L15_TOP4.mshr.val_array[`L15_PIPE4.noc2decoder_l15_mshrid] != 1'b1)
            // begin
            //     $display("L1.5 MON: Received NoC2 message with invalid MSHRID (%d)", `L15_PIPE4.noc2decoder_l15_mshrid);
            //     $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: Received NoC2 message with invalid MSHRID");
            //     `ifndef VERILATOR
            //     repeat(5)@(posedge clk)
            //     `endif
                //     `MONITOR_PATH.fail("L1.5 MON: Received NoC2 message with invalid MSHRID");
            // end
        end
    end
    // if (`L15_PIPE4.l15_noc1buffer_req_val && !`L15_PIPE4.stall_s3)
    // begin
    //     if (`L15_PIPE4.l15_noc1buffer_req_type != `L15_NOC1_REQTYPE_WRITEBACK_GUARD
    //         && `L15_PIPE4.l15_noc1buffer_req_type != `L15_NOC1_REQTYPE_INTERRUPT_FWD)
    //     begin
    //         if (`L15_TOP4.mshr.val_array[`L15_PIPE4.l15_noc1buffer_req_mshrid] != 1'b1
    //             || `L15_PIPE4.l15_noc1buffer_req_mshrid > 9)
    //         begin
    //             $display("L1.5 MON: Sending NoC1 message with invalid MSHRID (%d)", `L15_PIPE4.l15_noc1buffer_req_mshrid);
    //             $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: Sending NoC1 message with invalid MSHRID");
    //             `ifndef VERILATOR
    //             repeat(5)@(posedge clk)
    //             `endif
        //             `MONITOR_PATH.fail("L1.5 MON: Sending NoC1 message with invalid MSHRID");
    //         end
    //     end
    // end

// monitor PCX buffer full compare to t1 internal buffer mon
`ifdef RTL_SPARC4
`ifndef RTL_SPU
    if ((`CCX_TRANSDUCER4.pcx_buffer.is_req_squashed == 1'b1) && (`SPARC_CORE4.sparc0.lsu.lsu.qctl1.pcx_req_squash == 1'b0))
`else
    if ((`CCX_TRANSDUCER4.pcx_buffer.is_req_squashed == 1'b1) && (`SPARC_CORE4.sparc0.lsu.qctl1.pcx_req_squash == 1'b0))
`endif
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "PCXTILE4 req was valid but squashed in L1.5");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("PCXTILE4 req was valid but squashed in L1.5");
    end
`ifndef RTL_SPU
    if ((`CCX_TRANSDUCER4.pcx_buffer.is_req_squashed == 1'b0) && (`SPARC_CORE4.sparc0.lsu.lsu.qctl1.pcx_req_squash == 1'b1))
`else
    if ((`CCX_TRANSDUCER4.pcx_buffer.is_req_squashed == 1'b0) && (`SPARC_CORE4.sparc0.lsu.qctl1.pcx_req_squash == 1'b1))
`endif
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "PCXTILE4 req was squashed but valid at L1.5");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("PCXTILE4 req was squashed but valid at L1.5");
    end

    // check for squashed atomic
    if ((`CCX_TRANSDUCER4.pcx_buffer.is_req_squashed == 1'b1) && (`CCX_TRANSDUCER4.pcx_buffer.spc_uncore_atomic_req == 1'b1))
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "PCXTILE4 atomic req squashed");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("PCXTILE4 atomic req squashed");
    end
`endif

// monitor FP transactions because it is not supported yet
//     if (`L15_PIPE4.pcxdecoder_l15_val && !`L15_PIPE4.pcx_message_staled_s1 && `L15_PIPE4.val_s1 && !`L15_PIPE4.stall_s1 && !`L15_PIPE4.noc2decoder_l15_val)
//     begin
//         if (`L15_PIPE4.pcxdecoder_l15_rqtype == `PCX_REQTYPE_FP1)
//         begin
//             $display("%d : Simulation -> FAIL(%0s)", $time, "FP requests received but not implemented");
//             `ifndef VERILATOR
//             repeat(5)@(posedge clk)
//             `endif
    //             `MONITOR_PATH.fail("FP requests received but not implemented");
//         end
//     end

// monitor INT_VEC_DIS requests
    if (`L15_PIPE4.pcxdecoder_l15_val && `L15_PIPE4.val_s1 && !`L15_PIPE4.stall_s1 && !`L15_PIPE4.noc2decoder_l15_val)
    begin
        if (`L15_PIPE4.pcxdecoder_l15_rqtype == `PCX_REQTYPE_STORE
            && `L15_PIPE4.pcxdecoder_l15_address == 40'h9800000800)
        begin
            $display("%d : PCX write to INT_VEC_DIS", $time);
            // $display("%d : Simulation -> FAIL(%0s)", $time, "Write to INT_VEC_DIS");
            // `ifndef VERILATOR
            // repeat(5)@(posedge clk)
            // `endif
                // `MONITOR_PATH.fail("Write to INT_VEC_DIS");
        end
    end

// monitor noc1 buffer credit for underflow
    if (`L15_PIPE4.creditman_noc1_avail == 4'd15)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE4 NOC1 credit underflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE4 NOC1 credit underflow");
    end
    if (`L15_PIPE4.creditman_noc1_avail > `NOC1_BUFFER_NUM_SLOTS)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE4 NOC1 credit overflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE4 NOC1 credit overflow");
    end
    if (`L15_PIPE4.creditman_noc1_data_avail == 4'd15)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE4 NOC1 data credit underflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE4 NOC1 data credit underflow");
    end
    if (`L15_PIPE4.creditman_noc1_data_avail > `NOC1_BUFFER_NUM_DATA_SLOTS)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE4 NOC1 data credit overflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE4 NOC1 data credit overflow");
    end

    // check noc1 reserve credit
    if (`L15_PIPE4.creditman_noc1_reserve == 4'd15)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE4 NOC1 reserve credit underflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE4 NOC1 reserve credit underflow");
    end
    if (`L15_PIPE4.creditman_noc1_reserve > `NOC1_BUFFER_NUM_SLOTS)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE4 NOC1 reserve credit overflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE4 NOC1 reserve credit overflow");
    end
    // check reserve logics
    // if (`L15_PIPE4.creditman_noc1_reserve_s3)
    // begin
    //     $display("%d : Simulation -> FAIL(%0s)", $time, "TILE4 NOC1 reserve credit underflow");
    //     `ifndef VERILATOR
    //     repeat(5)@(posedge clk)
    //     `endif
        //     `MONITOR_PATH.fail("TILE4 NOC1 reserve credit underflow");
    // end

// Monitor for "RESERVED" messages
    if (`L15_PIPE4.noc2decoder_l15_val && `L15_PIPE4.val_s1 && !`L15_PIPE4.stall_s1)
    begin
        if (`L15_PIPE4.noc2decoder_l15_reqtype == `MSG_TYPE_RESERVED)
        begin
            $display("%d : Simulation -> FAIL(%0s)", $time, "TILE4 L15 received MSG_TYPE_RESERVED");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("TILE4 L15 received MSG_TYPE_RESERVED");
        end
    end

// Monitor WMT duplicate error
    if (`L15_PIPE4.val_s3)
    begin
        {wmt_read_data_TILE4[3], wmt_read_data_TILE4[2], wmt_read_data_TILE4[1], wmt_read_data_TILE4[0]} = `L15_PIPE4.wmt_l15_data_s3;
        for (i_TILE4 = 0; i_TILE4 < 4; i_TILE4 = i_TILE4+1)
        begin
            for (j_TILE4 = 0; j_TILE4 < i_TILE4; j_TILE4 = j_TILE4 + 1)
            begin
                if ((wmt_read_data_TILE4[i_TILE4][`L15_WMT_VALID_MASK] && wmt_read_data_TILE4[j_TILE4][`L15_WMT_VALID_MASK]) && (wmt_read_data_TILE4[i_TILE4] == wmt_read_data_TILE4[j_TILE4]))
                begin
                    $display("%d : Simulation -> FAIL(%0s)", $time, "TILE4 L15 has error with WMT");
                    `ifndef VERILATOR
                    repeat(5)@(posedge clk)
                    `endif
                        `MONITOR_PATH.fail("TILE4 L15 has error with WMT");
                end
            end
        end
    end

// Monitor tags duplication error (bug #86)
    if (`L15_PIPE4.val_s2 && `L15_PIPE4.decoder_dtag_operation_s2 == `L15_DTAG_OP_READ)
    begin
        tag_data_TILE4[0] = `L15_PIPE4.dtag_tag_way0_s2[`L15_CACHE_TAG_WIDTH-1:0];
        tag_data_TILE4[1] = `L15_PIPE4.dtag_tag_way1_s2[`L15_CACHE_TAG_WIDTH-1:0];
        tag_data_TILE4[2] = `L15_PIPE4.dtag_tag_way2_s2[`L15_CACHE_TAG_WIDTH-1:0];
        tag_data_TILE4[3] = `L15_PIPE4.dtag_tag_way3_s2[`L15_CACHE_TAG_WIDTH-1:0];
        tag_val_TILE4[0] = `L15_PIPE4.mesi_state_way0_s2 != `L15_MESI_STATE_I;
        tag_val_TILE4[1] = `L15_PIPE4.mesi_state_way1_s2 != `L15_MESI_STATE_I;
        tag_val_TILE4[2] = `L15_PIPE4.mesi_state_way2_s2 != `L15_MESI_STATE_I;
        tag_val_TILE4[3] = `L15_PIPE4.mesi_state_way3_s2 != `L15_MESI_STATE_I;
        for (i_TILE4 = 0; i_TILE4 < 4; i_TILE4 = i_TILE4+1)
        begin
            for (j_TILE4 = 0; j_TILE4 < i_TILE4; j_TILE4 = j_TILE4 + 1)
            begin
                if ((tag_val_TILE4[i_TILE4] && tag_val_TILE4[j_TILE4]) && (tag_data_TILE4[i_TILE4] == tag_data_TILE4[j_TILE4]))
                begin
                    $display("%d : Simulation -> FAIL(%0s)", $time, "TILE4 L15 has duplicated tag entry");
                    `ifndef VERILATOR
                    repeat(5)@(posedge clk)
                    `endif
                        `MONITOR_PATH.fail("TILE4 L15 has duplicated tag entry");
                end
            end
        end
    end

// // monitor FP transactions because it is not supported yet
//     if (`L15_TOP4.noc1encoder.sending)
//     begin
//         $display("noc1 flit raw: 0x%x", `L15_TOP4.noc1encoder.flit);
//     end
//     if (`L15_PIPE4.pcxdecoder_l15_val && !`L15_PIPE4.pcx_message_staled_s1 && `L15_PIPE4.val_s1 && !`L15_PIPE4.stall_s1 && !`L15_PIPE4.noc2decoder_l15_val)
//     begin
//         $display("%d : Simulation -> FAIL(%0s)", $time, "FP requests received but not implemented");
//         `ifndef VERILATOR
//         repeat(5)@(posedge clk)
//         `endif
    //         `MONITOR_PATH.fail("FP requests received but not implemented");
//     end


// Monitor FP transactions
//    if (`TILE4.fpu_arb_wrap.pcx_fpio_data_px2[123]
//            && `TILE4.fpu_arb_wrap.pcx_fpio_data_px2[122:119] == 4'b0101)
//    begin
//        $display("TILE4 FPU th%d: Received FP%d",
//                    `TILE4.fpu_arb_wrap.pcx_fpio_data_px2[113:112],
//                    `TILE4.fpu_arb_wrap.pcx_fpio_data_px2[118]);
//    end
//    if (`TILE4.fpu_arb_wrap.fpu_arb_data_rdy
//            && !`TILE4.fpu_arb_wrap.l15_fp_rdy)
//        $display("TILE4 FPU th%d: Sent FP data",
//                    `TILE4.fpu_arb_wrap.fpu_arb_data[135:134]);

// monitor L1.5 way replacement error
    if (`L15_PIPE4.l15_dcache_val_s2
        && `L15_PIPE4.dcache_operation_s2 == `L15_DCACHE_READ_LRU_WAY_IF_M)
    begin
        if (`L15_PIPE4.lruarray_l15_dout_s2[`L15_PIPE4.lru_way_s2] == 1'b1)
        begin
            // replacing a valid line
            if (&`L15_PIPE4.lru_used_bits_s2[3:0] == 1'b0)
            begin
                // and an another entry is 0, then is an error
                $display("%d : Simulation -> FAIL(%0s)", $time, "TILE4 L15 picked the wrong LRU entry");
                `ifndef VERILATOR
                repeat(5)@(posedge clk)
                `endif
                    `MONITOR_PATH.fail("TILE4 L15 picked the wrong LRU entry");
            end
        end
    end

// monitor X's in stall signals
    if (`L15_PIPE4.val_s1 && (`L15_PIPE4.stall_s1 === 1'bx) ||
        `L15_PIPE4.val_s2 && (`L15_PIPE4.stall_s2 === 1'bx) ||
        `L15_PIPE4.val_s3 && (`L15_PIPE4.stall_s3 === 1'bx))
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "L15 has X's in the stall_s1 signal");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("L15 has X's in the stall_s1 signal");
    end

`ifdef RTL_SPARC4
// some checks for l15cpxencoder
    if (`L15_TOP4.l15_transducer_val)
    begin
        if (`L15_TOP4.l15_transducer_inval_icache_inval)
        begin
            $display("%d : Simulation -> FAIL(%0s)", $time, "l15 icache inval is not used");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("l15 icache inval is not used");
        end
        if (`L15_TOP4.l15_transducer_returntype == `CPX_RESTYPE_ATOMIC_RES
            && `L15_TOP4.l15_transducer_inval_dcache_inval)
        begin
            $display("%d : Simulation -> FAIL(%0s)", $time, "l15 CAS inval is not used");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("l15 CAS inval is not used");
        end
    end
`endif

// some checks for l15 noc1 encoder
    if (`L15_TOP4.noc1encoder.sending && `L15_TOP4.noc1encoder.req_type == 0)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "l15 noc1 message is null");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("l15 noc1 message is null");
    end

    end // disable_l15_mon
end

//CORE4 END


// CORE5

reg do_print_stage_TILE5;
integer i_TILE5;
wire [63:0] dtag_tag_way0_s2_TILE5;
wire [63:0] dtag_tag_way1_s2_TILE5;
wire [63:0] dtag_tag_way2_s2_TILE5;
wire [63:0] dtag_tag_way3_s2_TILE5;

assign dtag_tag_way0_s2_TILE5 = (`L15_PIPE5.dtag_tag_way0_s2 << 11);
assign dtag_tag_way1_s2_TILE5 = (`L15_PIPE5.dtag_tag_way1_s2 << 11);
assign dtag_tag_way2_s2_TILE5 = (`L15_PIPE5.dtag_tag_way2_s2 << 11);
assign dtag_tag_way3_s2_TILE5 = (`L15_PIPE5.dtag_tag_way3_s2 << 11);
reg [`L15_CACHE_TAG_WIDTH-1:0] tag_data_TILE5 [0:3];
reg [3:0] tag_val_TILE5;
reg [`L15_WMT_ENTRY_MASK] wmt_read_data_TILE5 [0:3];
integer j_TILE5;
reg is_csm_mshrid_TILE5;

reg wmt_read_val_s3_TILE5;
always @ (posedge clk)
    wmt_read_val_s3_TILE5 <= `L15_PIPE5.l15_wmt_read_val_s2;

always @ (negedge clk)
begin
    if(!$test$plusargs("disable_l15_mon"))
    begin

    // monitoring outgoing noc1/noc3 messages
    if (`L15_TOP5.noc1encoder.sending)
    begin
        $display($time);
        $display("TILE5 noc1 flit raw: 0x%x", `L15_TOP5.noc1encoder.flit);
        $display("   srcX: %d, srcY: %d", `L15_TOP5.noc1encoder.msg_src_xpos, `L15_TOP5.noc1encoder.msg_src_ypos);
        $display("   destX: %d, destY: %d", `L15_TOP5.noc1encoder.msg_dest_l2_xpos, `L15_TOP5.noc1encoder.msg_dest_l2_ypos);
        if ( ^`L15_TOP5.noc1encoder.flit === 1'bx)
        begin
            $display("%d : Simulation -> FAIL(TILE5 noc1 sends X data 0x%x)", $time, `L15_TOP5.noc1encoder.flit);
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("l15_mon: TILE5 noc1 sends X data");
        end

    end




    if (`L15_PIPE5.pcxdecoder_l15_val && `L15_PIPE5.val_s1 && !`L15_PIPE5.stall_s1 && !`L15_PIPE5.noc2decoder_l15_val
        && `L15_PIPE5.fetch_state_s1 == `L15_FETCH_STATE_NORMAL)
    begin
        $write("%0d TILE5 L1.5 th%d: Received PCX ", $time, `L15_PIPE5.pcxdecoder_l15_threadid); decode_pcx_op(`L15_PIPE5.pcxdecoder_l15_rqtype, `L15_PIPE5.pcxdecoder_l15_amo_op);
        $display("   Addr 0x%x, nc %d, size %d, invalall %d, pf %d, bs %d, bsi %d, l1way %d",
                                `L15_PIPE5.pcxdecoder_l15_address, `L15_PIPE5.pcxdecoder_l15_nc, `L15_PIPE5.pcxdecoder_l15_size, `L15_PIPE5.pcxdecoder_l15_invalidate_cacheline,
                                `L15_PIPE5.pcxdecoder_l15_prefetch, `L15_PIPE5.pcxdecoder_l15_blockstore, `L15_PIPE5.pcxdecoder_l15_blockinitstore, `L15_PIPE5.pcxdecoder_l15_l1rplway);
        $display("   Data: 0x%x", `L15_PIPE5.pcxdecoder_l15_data);
        if (`L15_PIPE5.pcxdecoder_l15_csm_data[`TLB_CSM_STATE] == `TLB_CSM_STATE_LOCAL)
        begin
            $display("   CSM HDID: %d, HD_SIZE: %d, SDID: %d, LSID: %d", `L15_PIPE5.pcxdecoder_l15_csm_data[`TLB_CSM_HDID], `L15_PIPE5.pcxdecoder_l15_csm_data[`TLB_CSM_HD_SIZE],
            `L15_PIPE5.pcxdecoder_l15_csm_data[`TLB_CSM_SDID], `L15_PIPE5.pcxdecoder_l15_csm_data[`TLB_CSM_LSID]);
        end
        else if (`L15_PIPE5.pcxdecoder_l15_csm_data[`TLB_CSM_STATE] == `TLB_CSM_STATE_GLOBAL)
        begin
            $display("   CSM CHIPID: %d, X: %d, Y: %d", `L15_PIPE5.pcxdecoder_l15_csm_data[`TLB_CSM_CHIPID], `L15_PIPE5.pcxdecoder_l15_csm_data[`TLB_CSM_X],`L15_PIPE5.pcxdecoder_l15_csm_data[`TLB_CSM_Y]);
        end
        $display("   CSM Data: 0x%x", `L15_PIPE5.pcxdecoder_l15_csm_data);
        /*
        if (noc2decoder_l15_reqtype == `PCX_REQTYPE_STORE)
        if (noc2decoder_l15_reqtype == `PCX_REQTYPE_CAS1)
        begin
        $display("   Cmp.data: 0x%x", `L15_PIPE5.pcxdecoder_l15_data);
        $display("   Swp.data: 0x%x", `L15_PIPE5.pcxdecoder_l15_data_next_entry);
        end
        if (noc2decoder_l15_reqtype == `PCX_REQTYPE_SWP_LOADSTUB)
        begin
        $display("   Swp.data: 0x%x", `L15_PIPE5.pcxdecoder_l15_data);
        end
        */
        if (`L15_PIPE5.pcxdecoder_l15_rqtype == `PCX_REQTYPE_INTERRUPT && `L15_PIPE5.pcxdecoder_l15_data[63] == 1'b0)
        begin
            pcx_interrupt_type = `L15_PIPE5.pcxdecoder_l15_data[17:16];
            pcx_interrupt_dst_chipid = `L15_PIPE5.pcxdecoder_l15_data[31:18];
            pcx_interrupt_dst_y = `L15_PIPE5.pcxdecoder_l15_data[14:12];
            pcx_interrupt_dst_x = `L15_PIPE5.pcxdecoder_l15_data[11:9];
            pcx_interrupt_threadid = `L15_PIPE5.pcxdecoder_l15_data[8];
            pcx_interrupt_vector = `L15_PIPE5.pcxdecoder_l15_data[5:0];
            $display("Interrupt info:");
            $write("    Type: ");
            case(pcx_interrupt_type)
                2'b00:
                    $display("hw int");
                2'b01:
                    $display("reset");
                2'b10:
                    $display("idle");
                2'b11:
                    $display("resume");
            endcase

            $display("    Dst CHIP ID: %d", pcx_interrupt_dst_chipid);
            $display("    Dst X: %d", pcx_interrupt_dst_x);
            $display("    Dst Y: %d", pcx_interrupt_dst_y);
            $display("    Thread ID: %d", pcx_interrupt_threadid);
            $display("    Vector: %d", pcx_interrupt_vector);
        end
    end

    if (`L15_PIPE5.noc2decoder_l15_val && `L15_PIPE5.val_s1 && !`L15_PIPE5.stall_s1)
    begin
        noc2 = 0;
        case(`L15_PIPE5.noc2decoder_l15_reqtype)
        `MSG_TYPE_RESERVED:
            noc2 = "MSG_TYPE_RESERVED";
        `MSG_TYPE_LOAD_FWD:
            noc2 = "MSG_TYPE_LOAD_FWD";
        `MSG_TYPE_STORE_FWD:
            noc2 = "MSG_TYPE_STORE_FWD";
        `MSG_TYPE_INV_FWD:
            noc2 = "MSG_TYPE_INV_FWD";
        `MSG_TYPE_NODATA_ACK:
            noc2 = "MSG_TYPE_NODATA_ACK";
        `MSG_TYPE_DATA_ACK:
            noc2 = "MSG_TYPE_DATA_ACK";
        `MSG_TYPE_NC_LOAD_MEM_ACK:
            noc2 = "MSG_TYPE_NC_LOAD_MEM_ACK";
        `MSG_TYPE_NC_STORE_MEM_ACK:
            noc2 = "MSG_TYPE_NC_STORE_MEM_ACK";
        `MSG_TYPE_INTERRUPT:
            noc2 = "MSG_TYPE_L2_INTERRUPT";
        default:
        begin
            noc2 = "MSG_TYPE_UNKNOWN_ERROR";
            $display("%d : Simulation -> FAIL(%0s)", $time, "L15 mon: error message type from L2");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("L15 mon: error message type from L2");
        end
        endcase

        $write("%0d TILE5 L1.5: Received NOC2 %s", $time, noc2);
        $display("   mshrid %d, l2miss %d, f4b %d, ackstate %d, address 0x%x",
                    `L15_PIPE5.noc2decoder_l15_mshrid, `L15_PIPE5.noc2decoder_l15_l2miss, `L15_PIPE5.noc2decoder_l15_f4b,
                    `L15_PIPE5.noc2decoder_l15_ack_state, `L15_PIPE5.noc2decoder_l15_address);
        $display("   Data1: 0x%x", `L15_PIPE5.noc2decoder_l15_data_0);
        $display("   Data2: 0x%x", `L15_PIPE5.noc2decoder_l15_data_1);
        $display("   Data3: 0x%x", `L15_PIPE5.noc2decoder_l15_data_2);
        $display("   Data4: 0x%x", `L15_PIPE5.noc2decoder_l15_data_3);
    end

    if (`L15_PIPE5.l15_cpxencoder_val && !`L15_PIPE5.stall_s3)
    begin
        cpx = 0;
        case(`L15_PIPE5.l15_cpxencoder_returntype)
            `LOAD_RET:
                cpx = "LOAD_RET";
            `INV_RET:
                cpx = "INV_RET";
            `ST_ACK:
                cpx = "ST_ACK";
            `AT_ACK:
                cpx = "AT_ACK";
            `INT_RET:
                cpx = "INT_RET";
            `TEST_RET:
                cpx = "TEST_RET";
            `FP_RET:
                cpx = "FP_RET";
            `IFILL_RET:
                cpx = "IFILL_RET";
            `EVICT_REQ:
                cpx = "EVICT_REQ";
            `ERR_RET:
                cpx = "ERR_RET";
            `STRLOAD_RET:
                cpx = "STRLOAD_RET";
            `STRST_ACK:
                cpx = "STRST_ACK";
            `FWD_RQ_RET:
                cpx = "FWD_RQ_RET";
            `FWD_RPY_RET:
                cpx = "FWD_RPY_RET";
            `RSVD_RET:
                cpx = "RSVD_RET";
            4'b1110:
                cpx = "ATOMIC_ACK";
            default:
                cpx = "CPX_UNKNOWN";
        endcase
        $write("%0d TILE5 L1.5 th%d: Sent CPX %0s", $time, `L15_PIPE5.l15_cpxencoder_threadid, cpx);
        $display("   l2miss %d, nc %d, atomic %d, threadid %d, pf %d, f4b %d, iia %d, dia %d, dinval %d, iinval %d, invalway %d, blkinit %d",
                    `L15_PIPE5.l15_cpxencoder_l2miss, `L15_PIPE5.l15_cpxencoder_noncacheable, `L15_PIPE5.l15_cpxencoder_atomic,
                    `L15_PIPE5.l15_cpxencoder_threadid, `L15_PIPE5.l15_cpxencoder_prefetch,
                    `L15_PIPE5.l15_cpxencoder_f4b, `L15_PIPE5.l15_cpxencoder_inval_icache_all_way,
                    `L15_PIPE5.l15_cpxencoder_inval_dcache_all_way, `L15_PIPE5.l15_cpxencoder_inval_dcache_inval,
                    `L15_PIPE5.l15_cpxencoder_inval_icache_inval, `L15_PIPE5.l15_cpxencoder_inval_way,
                    `L15_PIPE5.l15_cpxencoder_blockinitstore);
        $display("   Data0: 0x%x", `L15_PIPE5.l15_cpxencoder_data_0);
        $display("   Data1: 0x%x", `L15_PIPE5.l15_cpxencoder_data_1);
        $display("   Data2: 0x%x", `L15_PIPE5.l15_cpxencoder_data_2);
        $display("   Data3: 0x%x", `L15_PIPE5.l15_cpxencoder_data_3);
    end

    if (`L15_TOP5.noc1encoder.noc1encoder_noc1out_val && `L15_TOP5.noc1encoder.noc1encoder_noc1buffer_req_ack)
    begin
        noc1 = 0;
        case(`L15_TOP5.noc1encoder.req_type)
        `L15_NOC1_REQTYPE_WRITEBACK_GUARD:
            noc1 = "L15_NOC1_REQTYPE_WRITEBACK_GUARD";
        `L15_NOC1_REQTYPE_LD_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_LD_REQUEST";
        `L15_NOC1_REQTYPE_IFILL_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_IFILL_REQUEST";
        `L15_NOC1_REQTYPE_WRITETHROUGH_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_WRITETHROUGH_REQUEST";
        `L15_NOC1_REQTYPE_ST_UPGRADE_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_ST_UPGRADE_REQUEST";
        `L15_NOC1_REQTYPE_ST_FILL_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_ST_FILL_REQUEST";
        `L15_NOC1_REQTYPE_CAS_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_CAS_REQUEST";
        `L15_NOC1_REQTYPE_SWAP_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_SWAP_REQUEST";
        `L15_NOC1_REQTYPE_INTERRUPT_FWD:
            noc1 = "L15_NOC1_REQTYPE_INTERRUPT_FWD";
        `L15_NOC1_REQTYPE_AMO_ADD_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_ADD_REQUEST";
        `L15_NOC1_REQTYPE_AMO_AND_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_AND_REQUEST";
        `L15_NOC1_REQTYPE_AMO_OR_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_OR_REQUEST";
        `L15_NOC1_REQTYPE_AMO_XOR_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_XOR_REQUEST";
        `L15_NOC1_REQTYPE_AMO_MAX_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_MAX_REQUEST";
        `L15_NOC1_REQTYPE_AMO_MAXU_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_MAXU_REQUEST";
        `L15_NOC1_REQTYPE_AMO_MIN_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_MIN_REQUEST";
        `L15_NOC1_REQTYPE_AMO_MINU_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_MINU_REQUEST";
        default:
            noc1 = "ERROR noc1";
        endcase

        $write("%0d TILE5 L1.5: Sending NOC1 %s", $time, noc1);
        $display("   mshrid %d, nc %d, size %d, pf %d, address %0x",
                    `L15_TOP5.noc1encoder.noc1buffer_noc1encoder_req_mshrid, `L15_TOP5.noc1encoder.noc1buffer_noc1encoder_req_non_cacheable,
                    `L15_TOP5.noc1encoder.noc1buffer_noc1encoder_req_size, `L15_TOP5.noc1encoder.noc1buffer_noc1encoder_req_prefetch, `L15_TOP5.noc1encoder.noc1buffer_noc1encoder_req_address);
        $display("   Data0: 0x%x", `L15_TOP5.noc1encoder.noc1buffer_noc1encoder_req_data_0);
        $display("   Data1: 0x%x", `L15_TOP5.noc1encoder.noc1buffer_noc1encoder_req_data_1);
        $display("   Destination X: %d Y: %d", `L15_TOP5.noc1encoder.msg_dest_l2_xpos, `L15_TOP5.noc1encoder.msg_dest_l2_ypos);
    end

    if (`L15_TOP5.noc3encoder.noc3encoder_noc3out_val && `L15_TOP5.noc3encoder.noc3encoder_l15_req_ack)
    begin
        noc3 = 0;
        case(`L15_TOP5.noc3encoder.l15_noc3encoder_req_type)
        `L15_NOC3_REQTYPE_WRITEBACK:
            noc3 = "L15_NOC3_REQTYPE_WRITEBACK";
        `L15_NOC3_REQTYPE_INVAL_ACK:
            noc3 = "L15_NOC3_REQTYPE_INVAL_ACK";
        `L15_NOC3_REQTYPE_DOWNGRADE_ACK:
            noc3 = "L15_NOC3_REQTYPE_DOWNGRADE_ACK";
        `L15_NOC3_REQTYPE_ICACHE_INVAL_ACK:
            noc3 = "L15_NOC3_REQTYPE_ICACHE_INVAL_ACK";
        default:
            noc3 = "ERROR NOC3";
        endcase

        // quick check for an error case
        if (`L15_TOP5.noc3encoder.msg_type == `MSG_TYPE_INV_FWDACK
            && `L15_TOP5.noc3encoder.l15_noc3encoder_req_with_data)
        begin
            $display("L1.5 MON: sending back invalid ack with data");
            $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: sending back invalid ack with data");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("L1.5 MON: sending back invalid ack with data");
        end


        $write("%0d TILE5 L1.5: Sent NOC3 %s", $time, noc3);
        $display("   mshrid %d, seqid %d, address %0x",
                    `L15_TOP5.noc3encoder.l15_noc3encoder_req_mshrid, `L15_TOP5.noc3encoder.l15_noc3encoder_req_sequenceid, `L15_TOP5.noc3encoder.l15_noc3encoder_req_address);
        $display("   srcX: %d, srcY: %d", `L15_TOP5.noc3encoder.src_l2_xpos, `L15_TOP5.noc3encoder.src_l2_ypos);
        $display("   destX: %d, destY: %d", `L15_TOP5.noc3encoder.dest_l2_xpos, `L15_TOP5.noc3encoder.dest_l2_ypos);
        $display("   Data0: 0x%x", `L15_TOP5.noc3encoder.l15_noc3encoder_req_data_0);
        $display("   Data1: 0x%x", `L15_TOP5.noc3encoder.l15_noc3encoder_req_data_1);
    end

    do_print_stage_TILE5 = ((`L15_PIPE5.val_s1 && !`L15_PIPE5.stall_s1) || (`L15_PIPE5.val_s2 && !`L15_PIPE5.stall_s2) || (`L15_PIPE5.val_s3 && !`L15_PIPE5.stall_s3));
    if (do_print_stage_TILE5)
    begin
        // $display("");
        $display("");
        $display($time, " L15 TILE5:");
        $display("NoC1 credit: %d", `L15_PIPE5.creditman_noc1_avail);
        $display("NoC1 reserved credit: %d", `L15_PIPE5.creditman_noc1_reserve);
        // $display("NoC1 r down: %d", `L15_PIPE5.creditman_noc1_reserve_minus1);
        // $display("NoC1 r up: %d", `L15_PIPE5.creditman_noc1_reserve_add1);

        // monitor the MSHRID allocation
        // $display("MSHRID allocation info:");
        // for (i_TILE5 = 0; i_TILE5 < `L15_MSHR_COUNT; i_TILE5 = i_TILE5 + 1)
        //     $write("%d:%d", i_TILE5, `L15_PIPE5.mshr_val_array[i_TILE5]);
            // $write("%d %d", i_TILE5, i_TILE5);
        // $display("");

`ifdef RTL_SPARC5
        $display("Core STB info:");
        $display("  STB0: %d", `SPARC_CORE5.sparc0.ifu.lsu_ifu_stbcnt0);
        $display("  STB1: %d", `SPARC_CORE5.sparc0.ifu.lsu_ifu_stbcnt1);
            // $write("%d %d", i_TILE5, i_TILE5);
`endif

        $write("TILE5 Pipeline:");
        if (`L15_PIPE5.val_s1 && !`L15_PIPE5.stall_s1)
            $write(" * ");
        else if (`L15_PIPE5.val_s1 && `L15_PIPE5.stall_s1)
            $write(" = ");
        else
            $write(" X ");

        if (`L15_PIPE5.val_s2 && !`L15_PIPE5.stall_s2)
            $write(" * ");
        else if (`L15_PIPE5.val_s2 && `L15_PIPE5.stall_s2)
            $write(" = ");
        else
            $write(" X ");

        if (`L15_PIPE5.val_s3 && !`L15_PIPE5.stall_s3)
            $write(" * ");
        else if (`L15_PIPE5.val_s3 && `L15_PIPE5.stall_s3)
            $write(" = ");
        else
            $write(" X ");
        $display("");

        // $write("PCX pipe info: "); decode_pcx_op(`L15_PIPE5.pcxdecoder_l15_rqtype, L15_PIPE5.pcxdecoder_l15_amo_op);
        // if (`L15_PIPE5.noc1_req_val_s3 && `L15_PIPE5.noc1encoder_req_staled_s3)
        //     $display(" (staled)");
        // else if (!`L15_PIPE5.noc1_req_val_s3)
        //     $display(" (invalid)");
        // else if (`L15_PIPE5.noc1_req_val_s3 && !`L15_PIPE5.noc1encoder_req_staled_s3)
        // begin
        //     $display(" (fresh)");
        // end

        // $write("NoC1 pipe info: ");
        // if (`L15_PIPE5.noc1_req_val_s3 && `L15_PIPE5.noc1encoder_req_staled_s3)
        //     $display("staled");
        // else if (!`L15_PIPE5.noc1_req_val_s3)
        //     $display("invalid");
        // else if (`L15_PIPE5.noc1_req_val_s3 && !`L15_PIPE5.noc1encoder_req_staled_s3)
        // begin
        //     $display("fresh");
        // end

        // $write("NoC3 pipe info: ");
        // if (`L15_PIPE5.noc3_req_val_s3 && `L15_PIPE5.noc3encoder_req_staled_s3)
        //     $display("staled");
        // else if (!`L15_PIPE5.noc3_req_val_s3)
        //     $display("invalid");
        // else if (`L15_PIPE5.noc3_req_val_s3 && !`L15_PIPE5.noc3encoder_req_staled_s3)
        // begin
        //     $display("fresh");
        // end

        // $write("CPX pipe info: ");
        // if (`L15_PIPE5.cpx_req_val_s3 && `L15_PIPE5.cpxencoder_req_staled_s3)
        //     $display("staled");
        // else if (!`L15_PIPE5.cpx_req_val_s3)
        //     $display("invalid");
        // else if (`L15_PIPE5.cpx_req_val_s3 && !`L15_PIPE5.cpxencoder_req_staled_s3)
        // begin
        //     $display("fresh");
        // end

            // Stage 1 debug information
        if (`L15_PIPE5.stall_s1 === 1'bx)
            $display("S1 stall is XXXXXXX");
        if (`L15_PIPE5.val_s1 && !`L15_PIPE5.stall_s1)
        begin
            $write("Stage 1 status: ");
            $write("   Operation: "); decode_predecode_reqtype(`L15_PIPE5.predecode_reqtype_s1);
            $display("   TILE5 S1 Address: 0x%x", `L15_PIPE5.predecode_address_s1);
            // if (`L15_PIPE5.decoder_dtag_operation_s1 == `L15_DTAG_OP_READ)
            // begin
            //     $display("   DTAG OP: L15_DTAG_OP_READ");
            //     $display("      Index: 0x%x", `L15_PIPE5.dtag_index);
            // end
            // if (`L15_PIPE5.l15_dtag_rw_s1 == `L15_DTAG_RW_WRITE)
            // begin
            //     $display("   DTAG OP: L15_DTAG_OP_WRITE");
            //     $display("      Data:  0x%x", `L15_PIPE5.dtag_write_tag_s1);
            //     $display("      Way:  0x%x", `L15_PIPE5.dtag_write_way_s1);
            //     // $display("      Mask: 0x%x", `L15_PIPE5.dtag_write_mask);
            // end
            // if (`L15_PIPE5.s1_mshr_write_val_s1)
            // begin
            //     $display("   DTAG OP: ");
            //     if (`L15_PIPE5.s1_mshr_write_type_s1 == `L15_MSHR_WRITE_TYPE_ALLOCATION)
            //     begin
            //         $write ("L15_MSHR_WRITE_TYPE_ALLOCATION");
            //         $display ("      MSRID: %d", `L15_PIPE5.s1_mshr_write_mshrid_s1);
            //     end
            //     else if (`L15_PIPE5.s1_mshr_write_type_s1 == `L15_S1_MSHR_OP_UPDATE_WRITECACHE)
            //     begin
            //         $write ("L15_S1_MSHR_OP_UPDATE_WRITECACHE");
            //         $display ("      MSRID:     %d", `L15_PIPE5.s1_mshr_write_mshrid_s1);
            //         $display ("      DATA:      0x%x", `L15_PIPE5.s1_mshr_write_data);
            //         $display ("      DATAMASK:  0x%x", `L15_PIPE5.s1_mshr_write_byte_mask);
            //     end
            // end
        end
        // Stage 2 debug information
        if (`L15_PIPE5.stall_s2 === 1'bx)
            $display("S2 stall is XXXXXXX");
        if (`L15_PIPE5.val_s2 && !`L15_PIPE5.stall_s2)
        begin
        $write("Stage 2 status: ");
            $write("   Operation: "); decode_predecode_reqtype(`L15_PIPE5.predecode_reqtype_s2);
            $display("   TILE5 S2 Address: 0x%x", `L15_PIPE5.address_s2);
            $display("   TILE5 S2 Cache index: %d", `L15_PIPE5.cache_index_s2);

            if (`L15_PIPE5.csm_req_val_s2)
            begin
                $display("   CSM op: %d", `L15_PIPE5.csm_op_s2);
                if (`L15_PIPE5.l15_csm_req_type_s2 == 1'b0)
                    $display("      CSM read ticket: 0x%x", `L15_PIPE5.l15_csm_req_ticket_s2);
                else
                begin
                    $display("      CSM write ticket: 0x%x", `L15_PIPE5.l15_csm_req_ticket_s2);
                    $display("      CSM write data: 0x%x", `L15_PIPE5.l15_csm_req_data_s2);
                end
            end

            // $display("   Source chipid: %d", `L15_PIPE5.noc2_src_homeid_s2[`PACKET_HOME_ID_CHIP_MASK]);
            // $display("   Source X: %d", `L15_PIPE5.noc2_src_homeid_s2[`PACKET_HOME_ID_X_MASK]);
            // $display("   Source Y: %d", `L15_PIPE5.noc2_src_homeid_s2[`PACKET_HOME_ID_Y_MASK]);
            // `ifdef L15_EXTRA_DEBUG
            // $display("   LRU state: %d", `L15_PIPE5.lru_state_s2);
            // $display("   LRU way: %d", `L15_PIPE5.lru_way_s2);
            // $display("   Tagcheck state: %d", `L15_PIPE5.tagcheck_state_s2);
            // $display("   Tagcheck way: %d", `L15_PIPE5.tagcheck_way_s2);

            if (`L15_PIPE5.decoder_dtag_operation_s2 == `L15_DTAG_OP_READ)
            begin
                $display("   DTAG way0 state: 0x%x", `L15_PIPE5.mesi_state_way0_s2);
                $display("   DTAG way0 data: 0x%x", dtag_tag_way0_s2_TILE5);
                $display("   DTAG way1 state: 0x%x", `L15_PIPE5.mesi_state_way1_s2);
                $display("   DTAG way1 data: 0x%x", dtag_tag_way1_s2_TILE5);
                $display("   DTAG way2 state: 0x%x", `L15_PIPE5.mesi_state_way2_s2);
                $display("   DTAG way2 data: 0x%x", dtag_tag_way2_s2_TILE5);
                $display("   DTAG way3 state: 0x%x", `L15_PIPE5.mesi_state_way3_s2);
                $display("   DTAG way3 data: 0x%x", dtag_tag_way3_s2_TILE5);
            end

            if (`L15_PIPE5.l15_mesi_write_val_s2)
            begin
                $display("   MESI write way: 0x%x", `L15_PIPE5.mesi_write_way_s2);
                $display("   MESI write data: 0x%x", `L15_PIPE5.mesi_write_state_s2);
            end

            // if (`L15_PIPE5.lruarray_write_op_s2 == `L15_LRU_EVICTION)
            // begin
            //     $display("   LRU EVICTION INDEX: %d, WAY: %d", `L15_PIPE5.cache_index_s2,
            //         `L15_PIPE5.lru_way_s2[1:0]);
            // end
            // `endif

            // if (`L15_PIPE5.s2_mesi_operation_s2 == `L15_S2_MESI_READ)
            // begin
            //     $display("   MESI OP: L15_S2_MESI_READ");
            //     $display ("      Index:     %d", `L15_PIPE5.s2_mesi_index_s2);
            // end
            // if (`L15_PIPE5.s2_mshr_val_s2)
            // begin
            //     $display("   MSHR OP: L15_S2_MSHR_OP_READ_WRITE_CACHE");
            //     $display ("      MSHR: %d", `L15_PIPE5.s2_mshr_read_mshrid);
            // end
            if (`L15_PIPE5.dcache_val_s2)
            begin
                // $write("   DCACHE OP: "); decode_dcache_op(`L15_PIPE5.dcache_operation_s2);
                // $display ("      RW:     %d", `L15_PIPE5.dcache_rw);
                // $display ("      Index:      0x%x", `L15_PIPE5.dcache_index);
                // $display ("      Data:  0x%x", `L15_PIPE5.dcache_write_data);
                // $display ("      Data mask:  0x%x", `L15_PIPE5.dcache_write_mask);
                if (`L15_PIPE5.l15_dcache_rw_s2 == 1'b0)
                begin
                    `ifndef NO_RTL_CSM
                    $display("HMT writing: %0b", `L15_PIPE5.l15_hmt_write_data_s2);
                    `endif
                    // TODO
                    // $display("HMT chip: %0b", `L15_PIPE5.wmt_fill_homeid_s2[`PACKET_HOME_ID_CHIP_MASK]);
                    // $display("HMT X: %0b", `L15_PIPE5.wmt_fill_homeid_s2[`PACKET_HOME_ID_X_MASK]);
                    // $display("HMT Y: %0b", `L15_PIPE5.wmt_fill_homeid_s2[`PACKET_HOME_ID_Y_MASK]);
                end
            end
        end

        // Stage 3 debug information
        if (`L15_PIPE5.stall_s3 === 1'bx)
            $display("S3 stall is XXXXXXX");
        if (`L15_PIPE5.val_s3 && !`L15_PIPE5.stall_s3)
        begin
            $write("Stage 3 status: ");
            $write("   Operation: "); decode_predecode_reqtype(`L15_PIPE5.predecode_reqtype_s3);
            $display("   TILE5 S3 Address: 0x%x", `L15_PIPE5.address_s3);
            `ifndef NO_RTL_CSM
            if ((`L15_PIPE5.noc1_homeid_source_s3 == `L15_HOMEID_SRC_HMT && `L15_PIPE5.noc1_req_val_s3)
                || (`L15_PIPE5.noc3_homeid_source_s3 == `L15_HOMEID_SRC_HMT && `L15_PIPE5.noc3_req_val_s3))
            begin
                `ifndef NO_RTL_CSM
                $display("   HMT chipid: %d", `L15_PIPE5.hmt_l15_dout_s3[`L15_CSM_GHID_CHIP_MASK]);
                $display("   HMT X: %d", `L15_PIPE5.hmt_l15_dout_s3[`L15_CSM_GHID_XPOS_MASK]);
                $display("   HMT Y: %d", `L15_PIPE5.hmt_l15_dout_s3[`L15_CSM_GHID_YPOS_MASK]);
                $display("   HMT reading: %0b", `L15_PIPE5.hmt_l15_dout_s3);
                `endif
            end
            `endif
            if (`L15_PIPE5.noc3_homeid_source_s3 == `L15_HOMEID_SRC_NOC2_SOURCE && `L15_PIPE5.noc3_req_val_s3)
            begin
                $display("   Source chipid: %d", `L15_PIPE5.noc2_src_homeid_s3[`PACKET_HOME_ID_CHIP_MASK]);
                $display("   Source X: %d", `L15_PIPE5.noc2_src_homeid_s3[`PACKET_HOME_ID_X_MASK]);
                $display("   Source Y: %d", `L15_PIPE5.noc2_src_homeid_s3[`PACKET_HOME_ID_Y_MASK]);
            end

            if (`L15_PIPE5.cpx_data_source_s3 == `L15_CPX_SOURCE_CSM)
                $display("      CSM read data: 0x%x", `L15_PIPE5.csm_l15_res_data_s3);
            // `ifdef L15_EXTRA_DEBUG
            // $display("   LRU state: %d", `L15_PIPE5.lru_state_s3);
            // $display("   LRU way: %d", `L15_PIPE5.lru_way_s3);
            // $display("   Tagcheck state: %d", `L15_PIPE5.tagcheck_state_s3);
            // $display("   Tagcheck way: %d", `L15_PIPE5.tagcheck_way_s3);
            // `endif

            // if (`L15_PIPE5.s3_mesi_val_s3)
            // begin
            //     $write("   MESI OP: "); decode_s3mesi_op(`L15_PIPE5.s3_mesi_operation_s3);
            //     $display ("      Index:      0x%x", `L15_PIPE5.mesi_write_index);
            //     $display ("      Data:  0x%x", `L15_PIPE5.mesi_write_data);
            //     $display ("      Data mask:  0x%x", `L15_PIPE5.mesi_write_mask);
            // end
            // if (`L15_PIPE5.wmc_val_s3)
            // begin
            //     $write("   WMC OP: "); decode_wmc_op(`L15_PIPE5.wmc_operation_s3);
            //     if (`L15_PIPE5.wmc_rw_s3 == `L15_WMC_OP_READ)
            //     begin
            //         $display ("      wmc_index_s3:      0x%x", `L15_PIPE5.wmc_index_s3);
            //         $display ("      wmc_invalidate_val_s3:      0x%x", `L15_PIPE5.wmc_invalidate_val_s3);
            //         $display ("      wmc_invalidate_way_s3:      0x%x", `L15_PIPE5.wmc_invalidate_way_s3);
            //     end
            //     else if (`L15_PIPE5.wmc_rw_s3 == `L15_WMC_OP_WRITE)
            //     begin
            //         $display ("      wmc_index_s3:      0x%x", `L15_PIPE5.wmc_index_s3);
            //         $display ("      wmc_update_way_s3:      0x%x", `L15_PIPE5.wmc_update_way_s3);
            //         $display ("      wmc_update_data_s3:      0x%x", `L15_PIPE5.wmc_update_data_s3);
            //         $display ("      wmc_invalidate_val_s3:      0x%x", `L15_PIPE5.wmc_invalidate_val_s3);
            //         $display ("      wmc_invalidate_way_s3:      0x%x", `L15_PIPE5.wmc_invalidate_way_s3);
            //     end
            //     $display ("      cpx_inval_way_s3:      0x%x", `L15_PIPE5.cpx_inval_way_s3);
            //     $display ("      wmc_read_way0_data_s3:      0x%x", `L15_PIPE5.wmc_read_way0_data_s3);
            //     $display ("      wmc_read_way1_data_s3:      0x%x", `L15_PIPE5.wmc_read_way1_data_s3);
            //     $display ("      wmc_read_way2_data_s3:      0x%x", `L15_PIPE5.wmc_read_way2_data_s3);
            //     $display ("      wmc_read_way3_data_s3:      0x%x", `L15_PIPE5.wmc_read_way3_data_s3);
            // end
            // if (`L15_PIPE5.s3_mshr_val_s3)
            // begin
            //     $write("   MSHR OP: "); decode_s3mshr_op(`L15_PIPE5.s3_mshr_operation_s3);
            //     $display ("      MSHR:      %d", `L15_PIPE5.s3_mshr_write_mshrid);
            //     $display ("      U.State:      0x%x", `L15_PIPE5.s3_mshr_write_update_state);
            //     $display ("      U.Way:  0x%x", `L15_PIPE5.s3_mshr_write_update_way);
            //     $display ("      St.mshr rand hit:   %d", `L15_PIPE5.LRU_st1_mshr_s3 || `L15_PIPE5.LRU_st2_mshr_s3);
            //     $display ("      St.mshr tag hit:   %d", `L15_PIPE5.tagcheck_st1_mshr_s3 || `L15_PIPE5.tagcheck_st2_mshr_s3);
            // end
            if (wmt_read_val_s3_TILE5)
            begin
                $display("   TILE5 WMT read index: %x", `L15_PIPE5.cache_index_l1d_s3[`L1D_SET_IDX_MASK]);
                // $display("   WMT way0: %x 0x%x", `L15_PIPE5.wmt_data_s3[0][`L15_WMT_VALID_MASK], `L15_PIPE5.wmt_data_s3[0][`L15_WMT_DATA_MASK]);
                // $display("   WMT way1: %x 0x%x", `L15_PIPE5.wmt_data_s3[1][`L15_WMT_VALID_MASK], `L15_PIPE5.wmt_data_s3[1][`L15_WMT_DATA_MASK]);
                // $display("   WMT way2: %x 0x%x", `L15_PIPE5.wmt_data_s3[2][`L15_WMT_VALID_MASK], `L15_PIPE5.wmt_data_s3[2][`L15_WMT_DATA_MASK]);
                // $display("   WMT way3: %x 0x%x", `L15_PIPE5.wmt_data_s3[3][`L15_WMT_VALID_MASK], `L15_PIPE5.wmt_data_s3[3][`L15_WMT_DATA_MASK]);
                for (i = 0; i < `L1D_WAY_COUNT; i = i + 1)
                begin
                    $display("   WMT way%d: %x 0x%x", i, `L15_PIPE5.wmt_data_s3[i][`L15_WMT_VALID_MASK], `L15_PIPE5.wmt_data_s3[i][`L15_WMT_DATA_MASK]);
                end
            end
            if (`L15_PIPE5.l15_wmt_write_val_s3)
            begin
                $display("   TILE5 WMT write index: %x", `L15_PIPE5.cache_index_l1d_s3[`L1D_SET_IDX_MASK]);
                // $display("   WMT write mask: %x", `L15_PIPE5.l15_wmt_write_mask_s3);
                // $display("   WMT write data: %x", `L15_PIPE5.l15_wmt_write_data_s3);
                // $display("   WMT way0 m%x d0x%x", `L15_PIPE5.l15_wmt_write_mask_s3[`L15_WMT_ENTRY_0_MASK], `L15_PIPE5.wmt_write_data_s3[`L15_WMT_ENTRY_0_MASK]);
                // $display("   WMT way1 m%x d0x%x", `L15_PIPE5.l15_wmt_write_mask_s3[`L15_WMT_ENTRY_1_MASK], `L15_PIPE5.wmt_write_data_s3[`L15_WMT_ENTRY_1_MASK]);
                // $display("   WMT way2 m%x d0x%x", `L15_PIPE5.l15_wmt_write_mask_s3[`L15_WMT_ENTRY_2_MASK], `L15_PIPE5.wmt_write_data_s3[`L15_WMT_ENTRY_2_MASK]);
                // $display("   WMT way3 m%x d0x%x", `L15_PIPE5.l15_wmt_write_mask_s3[`L15_WMT_ENTRY_3_MASK], `L15_PIPE5.wmt_write_data_s3[`L15_WMT_ENTRY_3_MASK]);
            end
        end
        $display ("L15_MON_END");
        $display ("");
    end

//CSM monitor
    if(`L15_TOP5.l15_csm.l15_csm_req_val_s2)
    begin
        $display($time, ": TILE5 L15_CSM REQ MON:");
        $display("L15 CSM req addr: 0x%x", `L15_TOP5.l15_csm.l15_csm_req_address_s2);
        $display("L15 CSM req ticket: %d", `L15_TOP5.l15_csm.l15_csm_req_ticket_s2);
        $display("L15 CSM req type: %d", `L15_TOP5.l15_csm.l15_csm_req_type_s2);
        $display("L15 CSM req data: 0x%x", `L15_TOP5.l15_csm.l15_csm_req_data_s2);
        $display("L15 CSM req pcx data: 0x%x", `L15_TOP5.l15_csm.l15_csm_req_pcx_data_s2);
    end
    if(`L15_TOP5.l15_csm.csm_l15_res_val_s3)
    begin
        $display($time, ": TILE5 L15_CSM RES MON:");
        $display("L15 CSM res data: 0x%x", `L15_TOP5.l15_csm.csm_l15_res_data_s3);
    end
    if(`L15_TOP5.l15_csm.csm_l15_read_res_val)
    begin
        $display($time, ": TILE5 L15_CSM READ TICKET MON:");
        $display("L15 CSM read ticket: %d", `L15_TOP5.l15_csm.l15_csm_read_ticket);
        $display("L15 CSM read data: 0x%x", `L15_TOP5.l15_csm.csm_l15_read_res_data);
    end
    if(`L15_TOP5.l15_csm.csm_noc1encoder_req_val)
    begin
        $display($time, ": TILE5 L15_CSM NOC1 REQ MON:");
        $display("L15 CSM noc1 req addr: 0x%x", `L15_TOP5.l15_csm.csm_noc1encoder_req_address);
        $display("L15 CSM noc1 req type: %d", `L15_TOP5.l15_csm.csm_noc1encoder_req_type);
        $display("L15 CSM noc1 req mshrid: %d", `L15_TOP5.l15_csm.csm_noc1encoder_req_mshrid);
    end
    if(`L15_TOP5.l15_csm.noc1encoder_csm_req_ack)
    begin
        $display($time, ": TILE5 L15_CSM NOC1 REQ ACK MON:");
        $display("L15 CSM noc1 req ack: %b", `L15_TOP5.l15_csm.noc1encoder_csm_req_ack);
    end

    if(`L15_TOP5.l15_csm.write_val_s2 && (~`L15_TOP5.l15_csm.ghid_val_s2))
    begin
        $display("L1.5 MON: HMC refills invalid data");
        $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: HMC refills invalid data");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("L1.5 MON: HMC refills invalid data");
    end

// valid mshrid monitor
    // check for incoming messages
    if (`L15_PIPE5.noc2decoder_l15_val && `L15_PIPE5.val_s1 && !`L15_PIPE5.stall_s1)
    begin
        is_csm_mshrid_TILE5 = `L15_PIPE5.noc2decoder_l15_hmc_fill;
        if ((`L15_PIPE5.noc2decoder_l15_reqtype == `MSG_TYPE_NODATA_ACK ||
            `L15_PIPE5.noc2decoder_l15_reqtype == `MSG_TYPE_DATA_ACK)
            && !is_csm_mshrid_TILE5)
        begin
            // first check if mshrid is in range
            if (`L15_PIPE5.noc2decoder_l15_mshrid > 9)
            begin
                $display("L1.5 MON: Received NoC2 message with MSHRID greater than 9 (%d)", `L15_PIPE5.noc2decoder_l15_mshrid);
                $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: Received NoC2 message with MSHRID greater than 9");
                `ifndef VERILATOR
                repeat(5)@(posedge clk)
                `endif
                    `MONITOR_PATH.fail("L1.5 MON: Received NoC2 message with MSHRID greater than 9");
            end

            // now check if it's valid
            // TODO
            // if (`L15_TOP5.mshr.val_array[`L15_PIPE5.noc2decoder_l15_mshrid] != 1'b1)
            // begin
            //     $display("L1.5 MON: Received NoC2 message with invalid MSHRID (%d)", `L15_PIPE5.noc2decoder_l15_mshrid);
            //     $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: Received NoC2 message with invalid MSHRID");
            //     `ifndef VERILATOR
            //     repeat(5)@(posedge clk)
            //     `endif
                //     `MONITOR_PATH.fail("L1.5 MON: Received NoC2 message with invalid MSHRID");
            // end
        end
    end
    // if (`L15_PIPE5.l15_noc1buffer_req_val && !`L15_PIPE5.stall_s3)
    // begin
    //     if (`L15_PIPE5.l15_noc1buffer_req_type != `L15_NOC1_REQTYPE_WRITEBACK_GUARD
    //         && `L15_PIPE5.l15_noc1buffer_req_type != `L15_NOC1_REQTYPE_INTERRUPT_FWD)
    //     begin
    //         if (`L15_TOP5.mshr.val_array[`L15_PIPE5.l15_noc1buffer_req_mshrid] != 1'b1
    //             || `L15_PIPE5.l15_noc1buffer_req_mshrid > 9)
    //         begin
    //             $display("L1.5 MON: Sending NoC1 message with invalid MSHRID (%d)", `L15_PIPE5.l15_noc1buffer_req_mshrid);
    //             $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: Sending NoC1 message with invalid MSHRID");
    //             `ifndef VERILATOR
    //             repeat(5)@(posedge clk)
    //             `endif
        //             `MONITOR_PATH.fail("L1.5 MON: Sending NoC1 message with invalid MSHRID");
    //         end
    //     end
    // end

// monitor PCX buffer full compare to t1 internal buffer mon
`ifdef RTL_SPARC5
`ifndef RTL_SPU
    if ((`CCX_TRANSDUCER5.pcx_buffer.is_req_squashed == 1'b1) && (`SPARC_CORE5.sparc0.lsu.lsu.qctl1.pcx_req_squash == 1'b0))
`else
    if ((`CCX_TRANSDUCER5.pcx_buffer.is_req_squashed == 1'b1) && (`SPARC_CORE5.sparc0.lsu.qctl1.pcx_req_squash == 1'b0))
`endif
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "PCXTILE5 req was valid but squashed in L1.5");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("PCXTILE5 req was valid but squashed in L1.5");
    end
`ifndef RTL_SPU
    if ((`CCX_TRANSDUCER5.pcx_buffer.is_req_squashed == 1'b0) && (`SPARC_CORE5.sparc0.lsu.lsu.qctl1.pcx_req_squash == 1'b1))
`else
    if ((`CCX_TRANSDUCER5.pcx_buffer.is_req_squashed == 1'b0) && (`SPARC_CORE5.sparc0.lsu.qctl1.pcx_req_squash == 1'b1))
`endif
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "PCXTILE5 req was squashed but valid at L1.5");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("PCXTILE5 req was squashed but valid at L1.5");
    end

    // check for squashed atomic
    if ((`CCX_TRANSDUCER5.pcx_buffer.is_req_squashed == 1'b1) && (`CCX_TRANSDUCER5.pcx_buffer.spc_uncore_atomic_req == 1'b1))
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "PCXTILE5 atomic req squashed");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("PCXTILE5 atomic req squashed");
    end
`endif

// monitor FP transactions because it is not supported yet
//     if (`L15_PIPE5.pcxdecoder_l15_val && !`L15_PIPE5.pcx_message_staled_s1 && `L15_PIPE5.val_s1 && !`L15_PIPE5.stall_s1 && !`L15_PIPE5.noc2decoder_l15_val)
//     begin
//         if (`L15_PIPE5.pcxdecoder_l15_rqtype == `PCX_REQTYPE_FP1)
//         begin
//             $display("%d : Simulation -> FAIL(%0s)", $time, "FP requests received but not implemented");
//             `ifndef VERILATOR
//             repeat(5)@(posedge clk)
//             `endif
    //             `MONITOR_PATH.fail("FP requests received but not implemented");
//         end
//     end

// monitor INT_VEC_DIS requests
    if (`L15_PIPE5.pcxdecoder_l15_val && `L15_PIPE5.val_s1 && !`L15_PIPE5.stall_s1 && !`L15_PIPE5.noc2decoder_l15_val)
    begin
        if (`L15_PIPE5.pcxdecoder_l15_rqtype == `PCX_REQTYPE_STORE
            && `L15_PIPE5.pcxdecoder_l15_address == 40'h9800000800)
        begin
            $display("%d : PCX write to INT_VEC_DIS", $time);
            // $display("%d : Simulation -> FAIL(%0s)", $time, "Write to INT_VEC_DIS");
            // `ifndef VERILATOR
            // repeat(5)@(posedge clk)
            // `endif
                // `MONITOR_PATH.fail("Write to INT_VEC_DIS");
        end
    end

// monitor noc1 buffer credit for underflow
    if (`L15_PIPE5.creditman_noc1_avail == 4'd15)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE5 NOC1 credit underflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE5 NOC1 credit underflow");
    end
    if (`L15_PIPE5.creditman_noc1_avail > `NOC1_BUFFER_NUM_SLOTS)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE5 NOC1 credit overflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE5 NOC1 credit overflow");
    end
    if (`L15_PIPE5.creditman_noc1_data_avail == 4'd15)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE5 NOC1 data credit underflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE5 NOC1 data credit underflow");
    end
    if (`L15_PIPE5.creditman_noc1_data_avail > `NOC1_BUFFER_NUM_DATA_SLOTS)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE5 NOC1 data credit overflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE5 NOC1 data credit overflow");
    end

    // check noc1 reserve credit
    if (`L15_PIPE5.creditman_noc1_reserve == 4'd15)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE5 NOC1 reserve credit underflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE5 NOC1 reserve credit underflow");
    end
    if (`L15_PIPE5.creditman_noc1_reserve > `NOC1_BUFFER_NUM_SLOTS)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE5 NOC1 reserve credit overflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE5 NOC1 reserve credit overflow");
    end
    // check reserve logics
    // if (`L15_PIPE5.creditman_noc1_reserve_s3)
    // begin
    //     $display("%d : Simulation -> FAIL(%0s)", $time, "TILE5 NOC1 reserve credit underflow");
    //     `ifndef VERILATOR
    //     repeat(5)@(posedge clk)
    //     `endif
        //     `MONITOR_PATH.fail("TILE5 NOC1 reserve credit underflow");
    // end

// Monitor for "RESERVED" messages
    if (`L15_PIPE5.noc2decoder_l15_val && `L15_PIPE5.val_s1 && !`L15_PIPE5.stall_s1)
    begin
        if (`L15_PIPE5.noc2decoder_l15_reqtype == `MSG_TYPE_RESERVED)
        begin
            $display("%d : Simulation -> FAIL(%0s)", $time, "TILE5 L15 received MSG_TYPE_RESERVED");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("TILE5 L15 received MSG_TYPE_RESERVED");
        end
    end

// Monitor WMT duplicate error
    if (`L15_PIPE5.val_s3)
    begin
        {wmt_read_data_TILE5[3], wmt_read_data_TILE5[2], wmt_read_data_TILE5[1], wmt_read_data_TILE5[0]} = `L15_PIPE5.wmt_l15_data_s3;
        for (i_TILE5 = 0; i_TILE5 < 4; i_TILE5 = i_TILE5+1)
        begin
            for (j_TILE5 = 0; j_TILE5 < i_TILE5; j_TILE5 = j_TILE5 + 1)
            begin
                if ((wmt_read_data_TILE5[i_TILE5][`L15_WMT_VALID_MASK] && wmt_read_data_TILE5[j_TILE5][`L15_WMT_VALID_MASK]) && (wmt_read_data_TILE5[i_TILE5] == wmt_read_data_TILE5[j_TILE5]))
                begin
                    $display("%d : Simulation -> FAIL(%0s)", $time, "TILE5 L15 has error with WMT");
                    `ifndef VERILATOR
                    repeat(5)@(posedge clk)
                    `endif
                        `MONITOR_PATH.fail("TILE5 L15 has error with WMT");
                end
            end
        end
    end

// Monitor tags duplication error (bug #86)
    if (`L15_PIPE5.val_s2 && `L15_PIPE5.decoder_dtag_operation_s2 == `L15_DTAG_OP_READ)
    begin
        tag_data_TILE5[0] = `L15_PIPE5.dtag_tag_way0_s2[`L15_CACHE_TAG_WIDTH-1:0];
        tag_data_TILE5[1] = `L15_PIPE5.dtag_tag_way1_s2[`L15_CACHE_TAG_WIDTH-1:0];
        tag_data_TILE5[2] = `L15_PIPE5.dtag_tag_way2_s2[`L15_CACHE_TAG_WIDTH-1:0];
        tag_data_TILE5[3] = `L15_PIPE5.dtag_tag_way3_s2[`L15_CACHE_TAG_WIDTH-1:0];
        tag_val_TILE5[0] = `L15_PIPE5.mesi_state_way0_s2 != `L15_MESI_STATE_I;
        tag_val_TILE5[1] = `L15_PIPE5.mesi_state_way1_s2 != `L15_MESI_STATE_I;
        tag_val_TILE5[2] = `L15_PIPE5.mesi_state_way2_s2 != `L15_MESI_STATE_I;
        tag_val_TILE5[3] = `L15_PIPE5.mesi_state_way3_s2 != `L15_MESI_STATE_I;
        for (i_TILE5 = 0; i_TILE5 < 4; i_TILE5 = i_TILE5+1)
        begin
            for (j_TILE5 = 0; j_TILE5 < i_TILE5; j_TILE5 = j_TILE5 + 1)
            begin
                if ((tag_val_TILE5[i_TILE5] && tag_val_TILE5[j_TILE5]) && (tag_data_TILE5[i_TILE5] == tag_data_TILE5[j_TILE5]))
                begin
                    $display("%d : Simulation -> FAIL(%0s)", $time, "TILE5 L15 has duplicated tag entry");
                    `ifndef VERILATOR
                    repeat(5)@(posedge clk)
                    `endif
                        `MONITOR_PATH.fail("TILE5 L15 has duplicated tag entry");
                end
            end
        end
    end

// // monitor FP transactions because it is not supported yet
//     if (`L15_TOP5.noc1encoder.sending)
//     begin
//         $display("noc1 flit raw: 0x%x", `L15_TOP5.noc1encoder.flit);
//     end
//     if (`L15_PIPE5.pcxdecoder_l15_val && !`L15_PIPE5.pcx_message_staled_s1 && `L15_PIPE5.val_s1 && !`L15_PIPE5.stall_s1 && !`L15_PIPE5.noc2decoder_l15_val)
//     begin
//         $display("%d : Simulation -> FAIL(%0s)", $time, "FP requests received but not implemented");
//         `ifndef VERILATOR
//         repeat(5)@(posedge clk)
//         `endif
    //         `MONITOR_PATH.fail("FP requests received but not implemented");
//     end


// Monitor FP transactions
//    if (`TILE5.fpu_arb_wrap.pcx_fpio_data_px2[123]
//            && `TILE5.fpu_arb_wrap.pcx_fpio_data_px2[122:119] == 4'b0101)
//    begin
//        $display("TILE5 FPU th%d: Received FP%d",
//                    `TILE5.fpu_arb_wrap.pcx_fpio_data_px2[113:112],
//                    `TILE5.fpu_arb_wrap.pcx_fpio_data_px2[118]);
//    end
//    if (`TILE5.fpu_arb_wrap.fpu_arb_data_rdy
//            && !`TILE5.fpu_arb_wrap.l15_fp_rdy)
//        $display("TILE5 FPU th%d: Sent FP data",
//                    `TILE5.fpu_arb_wrap.fpu_arb_data[135:134]);

// monitor L1.5 way replacement error
    if (`L15_PIPE5.l15_dcache_val_s2
        && `L15_PIPE5.dcache_operation_s2 == `L15_DCACHE_READ_LRU_WAY_IF_M)
    begin
        if (`L15_PIPE5.lruarray_l15_dout_s2[`L15_PIPE5.lru_way_s2] == 1'b1)
        begin
            // replacing a valid line
            if (&`L15_PIPE5.lru_used_bits_s2[3:0] == 1'b0)
            begin
                // and an another entry is 0, then is an error
                $display("%d : Simulation -> FAIL(%0s)", $time, "TILE5 L15 picked the wrong LRU entry");
                `ifndef VERILATOR
                repeat(5)@(posedge clk)
                `endif
                    `MONITOR_PATH.fail("TILE5 L15 picked the wrong LRU entry");
            end
        end
    end

// monitor X's in stall signals
    if (`L15_PIPE5.val_s1 && (`L15_PIPE5.stall_s1 === 1'bx) ||
        `L15_PIPE5.val_s2 && (`L15_PIPE5.stall_s2 === 1'bx) ||
        `L15_PIPE5.val_s3 && (`L15_PIPE5.stall_s3 === 1'bx))
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "L15 has X's in the stall_s1 signal");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("L15 has X's in the stall_s1 signal");
    end

`ifdef RTL_SPARC5
// some checks for l15cpxencoder
    if (`L15_TOP5.l15_transducer_val)
    begin
        if (`L15_TOP5.l15_transducer_inval_icache_inval)
        begin
            $display("%d : Simulation -> FAIL(%0s)", $time, "l15 icache inval is not used");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("l15 icache inval is not used");
        end
        if (`L15_TOP5.l15_transducer_returntype == `CPX_RESTYPE_ATOMIC_RES
            && `L15_TOP5.l15_transducer_inval_dcache_inval)
        begin
            $display("%d : Simulation -> FAIL(%0s)", $time, "l15 CAS inval is not used");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("l15 CAS inval is not used");
        end
    end
`endif

// some checks for l15 noc1 encoder
    if (`L15_TOP5.noc1encoder.sending && `L15_TOP5.noc1encoder.req_type == 0)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "l15 noc1 message is null");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("l15 noc1 message is null");
    end

    end // disable_l15_mon
end

//CORE5 END


// CORE6

reg do_print_stage_TILE6;
integer i_TILE6;
wire [63:0] dtag_tag_way0_s2_TILE6;
wire [63:0] dtag_tag_way1_s2_TILE6;
wire [63:0] dtag_tag_way2_s2_TILE6;
wire [63:0] dtag_tag_way3_s2_TILE6;

assign dtag_tag_way0_s2_TILE6 = (`L15_PIPE6.dtag_tag_way0_s2 << 11);
assign dtag_tag_way1_s2_TILE6 = (`L15_PIPE6.dtag_tag_way1_s2 << 11);
assign dtag_tag_way2_s2_TILE6 = (`L15_PIPE6.dtag_tag_way2_s2 << 11);
assign dtag_tag_way3_s2_TILE6 = (`L15_PIPE6.dtag_tag_way3_s2 << 11);
reg [`L15_CACHE_TAG_WIDTH-1:0] tag_data_TILE6 [0:3];
reg [3:0] tag_val_TILE6;
reg [`L15_WMT_ENTRY_MASK] wmt_read_data_TILE6 [0:3];
integer j_TILE6;
reg is_csm_mshrid_TILE6;

reg wmt_read_val_s3_TILE6;
always @ (posedge clk)
    wmt_read_val_s3_TILE6 <= `L15_PIPE6.l15_wmt_read_val_s2;

always @ (negedge clk)
begin
    if(!$test$plusargs("disable_l15_mon"))
    begin

    // monitoring outgoing noc1/noc3 messages
    if (`L15_TOP6.noc1encoder.sending)
    begin
        $display($time);
        $display("TILE6 noc1 flit raw: 0x%x", `L15_TOP6.noc1encoder.flit);
        $display("   srcX: %d, srcY: %d", `L15_TOP6.noc1encoder.msg_src_xpos, `L15_TOP6.noc1encoder.msg_src_ypos);
        $display("   destX: %d, destY: %d", `L15_TOP6.noc1encoder.msg_dest_l2_xpos, `L15_TOP6.noc1encoder.msg_dest_l2_ypos);
        if ( ^`L15_TOP6.noc1encoder.flit === 1'bx)
        begin
            $display("%d : Simulation -> FAIL(TILE6 noc1 sends X data 0x%x)", $time, `L15_TOP6.noc1encoder.flit);
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("l15_mon: TILE6 noc1 sends X data");
        end

    end




    if (`L15_PIPE6.pcxdecoder_l15_val && `L15_PIPE6.val_s1 && !`L15_PIPE6.stall_s1 && !`L15_PIPE6.noc2decoder_l15_val
        && `L15_PIPE6.fetch_state_s1 == `L15_FETCH_STATE_NORMAL)
    begin
        $write("%0d TILE6 L1.5 th%d: Received PCX ", $time, `L15_PIPE6.pcxdecoder_l15_threadid); decode_pcx_op(`L15_PIPE6.pcxdecoder_l15_rqtype, `L15_PIPE6.pcxdecoder_l15_amo_op);
        $display("   Addr 0x%x, nc %d, size %d, invalall %d, pf %d, bs %d, bsi %d, l1way %d",
                                `L15_PIPE6.pcxdecoder_l15_address, `L15_PIPE6.pcxdecoder_l15_nc, `L15_PIPE6.pcxdecoder_l15_size, `L15_PIPE6.pcxdecoder_l15_invalidate_cacheline,
                                `L15_PIPE6.pcxdecoder_l15_prefetch, `L15_PIPE6.pcxdecoder_l15_blockstore, `L15_PIPE6.pcxdecoder_l15_blockinitstore, `L15_PIPE6.pcxdecoder_l15_l1rplway);
        $display("   Data: 0x%x", `L15_PIPE6.pcxdecoder_l15_data);
        if (`L15_PIPE6.pcxdecoder_l15_csm_data[`TLB_CSM_STATE] == `TLB_CSM_STATE_LOCAL)
        begin
            $display("   CSM HDID: %d, HD_SIZE: %d, SDID: %d, LSID: %d", `L15_PIPE6.pcxdecoder_l15_csm_data[`TLB_CSM_HDID], `L15_PIPE6.pcxdecoder_l15_csm_data[`TLB_CSM_HD_SIZE],
            `L15_PIPE6.pcxdecoder_l15_csm_data[`TLB_CSM_SDID], `L15_PIPE6.pcxdecoder_l15_csm_data[`TLB_CSM_LSID]);
        end
        else if (`L15_PIPE6.pcxdecoder_l15_csm_data[`TLB_CSM_STATE] == `TLB_CSM_STATE_GLOBAL)
        begin
            $display("   CSM CHIPID: %d, X: %d, Y: %d", `L15_PIPE6.pcxdecoder_l15_csm_data[`TLB_CSM_CHIPID], `L15_PIPE6.pcxdecoder_l15_csm_data[`TLB_CSM_X],`L15_PIPE6.pcxdecoder_l15_csm_data[`TLB_CSM_Y]);
        end
        $display("   CSM Data: 0x%x", `L15_PIPE6.pcxdecoder_l15_csm_data);
        /*
        if (noc2decoder_l15_reqtype == `PCX_REQTYPE_STORE)
        if (noc2decoder_l15_reqtype == `PCX_REQTYPE_CAS1)
        begin
        $display("   Cmp.data: 0x%x", `L15_PIPE6.pcxdecoder_l15_data);
        $display("   Swp.data: 0x%x", `L15_PIPE6.pcxdecoder_l15_data_next_entry);
        end
        if (noc2decoder_l15_reqtype == `PCX_REQTYPE_SWP_LOADSTUB)
        begin
        $display("   Swp.data: 0x%x", `L15_PIPE6.pcxdecoder_l15_data);
        end
        */
        if (`L15_PIPE6.pcxdecoder_l15_rqtype == `PCX_REQTYPE_INTERRUPT && `L15_PIPE6.pcxdecoder_l15_data[63] == 1'b0)
        begin
            pcx_interrupt_type = `L15_PIPE6.pcxdecoder_l15_data[17:16];
            pcx_interrupt_dst_chipid = `L15_PIPE6.pcxdecoder_l15_data[31:18];
            pcx_interrupt_dst_y = `L15_PIPE6.pcxdecoder_l15_data[14:12];
            pcx_interrupt_dst_x = `L15_PIPE6.pcxdecoder_l15_data[11:9];
            pcx_interrupt_threadid = `L15_PIPE6.pcxdecoder_l15_data[8];
            pcx_interrupt_vector = `L15_PIPE6.pcxdecoder_l15_data[5:0];
            $display("Interrupt info:");
            $write("    Type: ");
            case(pcx_interrupt_type)
                2'b00:
                    $display("hw int");
                2'b01:
                    $display("reset");
                2'b10:
                    $display("idle");
                2'b11:
                    $display("resume");
            endcase

            $display("    Dst CHIP ID: %d", pcx_interrupt_dst_chipid);
            $display("    Dst X: %d", pcx_interrupt_dst_x);
            $display("    Dst Y: %d", pcx_interrupt_dst_y);
            $display("    Thread ID: %d", pcx_interrupt_threadid);
            $display("    Vector: %d", pcx_interrupt_vector);
        end
    end

    if (`L15_PIPE6.noc2decoder_l15_val && `L15_PIPE6.val_s1 && !`L15_PIPE6.stall_s1)
    begin
        noc2 = 0;
        case(`L15_PIPE6.noc2decoder_l15_reqtype)
        `MSG_TYPE_RESERVED:
            noc2 = "MSG_TYPE_RESERVED";
        `MSG_TYPE_LOAD_FWD:
            noc2 = "MSG_TYPE_LOAD_FWD";
        `MSG_TYPE_STORE_FWD:
            noc2 = "MSG_TYPE_STORE_FWD";
        `MSG_TYPE_INV_FWD:
            noc2 = "MSG_TYPE_INV_FWD";
        `MSG_TYPE_NODATA_ACK:
            noc2 = "MSG_TYPE_NODATA_ACK";
        `MSG_TYPE_DATA_ACK:
            noc2 = "MSG_TYPE_DATA_ACK";
        `MSG_TYPE_NC_LOAD_MEM_ACK:
            noc2 = "MSG_TYPE_NC_LOAD_MEM_ACK";
        `MSG_TYPE_NC_STORE_MEM_ACK:
            noc2 = "MSG_TYPE_NC_STORE_MEM_ACK";
        `MSG_TYPE_INTERRUPT:
            noc2 = "MSG_TYPE_L2_INTERRUPT";
        default:
        begin
            noc2 = "MSG_TYPE_UNKNOWN_ERROR";
            $display("%d : Simulation -> FAIL(%0s)", $time, "L15 mon: error message type from L2");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("L15 mon: error message type from L2");
        end
        endcase

        $write("%0d TILE6 L1.5: Received NOC2 %s", $time, noc2);
        $display("   mshrid %d, l2miss %d, f4b %d, ackstate %d, address 0x%x",
                    `L15_PIPE6.noc2decoder_l15_mshrid, `L15_PIPE6.noc2decoder_l15_l2miss, `L15_PIPE6.noc2decoder_l15_f4b,
                    `L15_PIPE6.noc2decoder_l15_ack_state, `L15_PIPE6.noc2decoder_l15_address);
        $display("   Data1: 0x%x", `L15_PIPE6.noc2decoder_l15_data_0);
        $display("   Data2: 0x%x", `L15_PIPE6.noc2decoder_l15_data_1);
        $display("   Data3: 0x%x", `L15_PIPE6.noc2decoder_l15_data_2);
        $display("   Data4: 0x%x", `L15_PIPE6.noc2decoder_l15_data_3);
    end

    if (`L15_PIPE6.l15_cpxencoder_val && !`L15_PIPE6.stall_s3)
    begin
        cpx = 0;
        case(`L15_PIPE6.l15_cpxencoder_returntype)
            `LOAD_RET:
                cpx = "LOAD_RET";
            `INV_RET:
                cpx = "INV_RET";
            `ST_ACK:
                cpx = "ST_ACK";
            `AT_ACK:
                cpx = "AT_ACK";
            `INT_RET:
                cpx = "INT_RET";
            `TEST_RET:
                cpx = "TEST_RET";
            `FP_RET:
                cpx = "FP_RET";
            `IFILL_RET:
                cpx = "IFILL_RET";
            `EVICT_REQ:
                cpx = "EVICT_REQ";
            `ERR_RET:
                cpx = "ERR_RET";
            `STRLOAD_RET:
                cpx = "STRLOAD_RET";
            `STRST_ACK:
                cpx = "STRST_ACK";
            `FWD_RQ_RET:
                cpx = "FWD_RQ_RET";
            `FWD_RPY_RET:
                cpx = "FWD_RPY_RET";
            `RSVD_RET:
                cpx = "RSVD_RET";
            4'b1110:
                cpx = "ATOMIC_ACK";
            default:
                cpx = "CPX_UNKNOWN";
        endcase
        $write("%0d TILE6 L1.5 th%d: Sent CPX %0s", $time, `L15_PIPE6.l15_cpxencoder_threadid, cpx);
        $display("   l2miss %d, nc %d, atomic %d, threadid %d, pf %d, f4b %d, iia %d, dia %d, dinval %d, iinval %d, invalway %d, blkinit %d",
                    `L15_PIPE6.l15_cpxencoder_l2miss, `L15_PIPE6.l15_cpxencoder_noncacheable, `L15_PIPE6.l15_cpxencoder_atomic,
                    `L15_PIPE6.l15_cpxencoder_threadid, `L15_PIPE6.l15_cpxencoder_prefetch,
                    `L15_PIPE6.l15_cpxencoder_f4b, `L15_PIPE6.l15_cpxencoder_inval_icache_all_way,
                    `L15_PIPE6.l15_cpxencoder_inval_dcache_all_way, `L15_PIPE6.l15_cpxencoder_inval_dcache_inval,
                    `L15_PIPE6.l15_cpxencoder_inval_icache_inval, `L15_PIPE6.l15_cpxencoder_inval_way,
                    `L15_PIPE6.l15_cpxencoder_blockinitstore);
        $display("   Data0: 0x%x", `L15_PIPE6.l15_cpxencoder_data_0);
        $display("   Data1: 0x%x", `L15_PIPE6.l15_cpxencoder_data_1);
        $display("   Data2: 0x%x", `L15_PIPE6.l15_cpxencoder_data_2);
        $display("   Data3: 0x%x", `L15_PIPE6.l15_cpxencoder_data_3);
    end

    if (`L15_TOP6.noc1encoder.noc1encoder_noc1out_val && `L15_TOP6.noc1encoder.noc1encoder_noc1buffer_req_ack)
    begin
        noc1 = 0;
        case(`L15_TOP6.noc1encoder.req_type)
        `L15_NOC1_REQTYPE_WRITEBACK_GUARD:
            noc1 = "L15_NOC1_REQTYPE_WRITEBACK_GUARD";
        `L15_NOC1_REQTYPE_LD_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_LD_REQUEST";
        `L15_NOC1_REQTYPE_IFILL_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_IFILL_REQUEST";
        `L15_NOC1_REQTYPE_WRITETHROUGH_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_WRITETHROUGH_REQUEST";
        `L15_NOC1_REQTYPE_ST_UPGRADE_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_ST_UPGRADE_REQUEST";
        `L15_NOC1_REQTYPE_ST_FILL_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_ST_FILL_REQUEST";
        `L15_NOC1_REQTYPE_CAS_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_CAS_REQUEST";
        `L15_NOC1_REQTYPE_SWAP_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_SWAP_REQUEST";
        `L15_NOC1_REQTYPE_INTERRUPT_FWD:
            noc1 = "L15_NOC1_REQTYPE_INTERRUPT_FWD";
        `L15_NOC1_REQTYPE_AMO_ADD_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_ADD_REQUEST";
        `L15_NOC1_REQTYPE_AMO_AND_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_AND_REQUEST";
        `L15_NOC1_REQTYPE_AMO_OR_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_OR_REQUEST";
        `L15_NOC1_REQTYPE_AMO_XOR_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_XOR_REQUEST";
        `L15_NOC1_REQTYPE_AMO_MAX_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_MAX_REQUEST";
        `L15_NOC1_REQTYPE_AMO_MAXU_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_MAXU_REQUEST";
        `L15_NOC1_REQTYPE_AMO_MIN_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_MIN_REQUEST";
        `L15_NOC1_REQTYPE_AMO_MINU_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_MINU_REQUEST";
        default:
            noc1 = "ERROR noc1";
        endcase

        $write("%0d TILE6 L1.5: Sending NOC1 %s", $time, noc1);
        $display("   mshrid %d, nc %d, size %d, pf %d, address %0x",
                    `L15_TOP6.noc1encoder.noc1buffer_noc1encoder_req_mshrid, `L15_TOP6.noc1encoder.noc1buffer_noc1encoder_req_non_cacheable,
                    `L15_TOP6.noc1encoder.noc1buffer_noc1encoder_req_size, `L15_TOP6.noc1encoder.noc1buffer_noc1encoder_req_prefetch, `L15_TOP6.noc1encoder.noc1buffer_noc1encoder_req_address);
        $display("   Data0: 0x%x", `L15_TOP6.noc1encoder.noc1buffer_noc1encoder_req_data_0);
        $display("   Data1: 0x%x", `L15_TOP6.noc1encoder.noc1buffer_noc1encoder_req_data_1);
        $display("   Destination X: %d Y: %d", `L15_TOP6.noc1encoder.msg_dest_l2_xpos, `L15_TOP6.noc1encoder.msg_dest_l2_ypos);
    end

    if (`L15_TOP6.noc3encoder.noc3encoder_noc3out_val && `L15_TOP6.noc3encoder.noc3encoder_l15_req_ack)
    begin
        noc3 = 0;
        case(`L15_TOP6.noc3encoder.l15_noc3encoder_req_type)
        `L15_NOC3_REQTYPE_WRITEBACK:
            noc3 = "L15_NOC3_REQTYPE_WRITEBACK";
        `L15_NOC3_REQTYPE_INVAL_ACK:
            noc3 = "L15_NOC3_REQTYPE_INVAL_ACK";
        `L15_NOC3_REQTYPE_DOWNGRADE_ACK:
            noc3 = "L15_NOC3_REQTYPE_DOWNGRADE_ACK";
        `L15_NOC3_REQTYPE_ICACHE_INVAL_ACK:
            noc3 = "L15_NOC3_REQTYPE_ICACHE_INVAL_ACK";
        default:
            noc3 = "ERROR NOC3";
        endcase

        // quick check for an error case
        if (`L15_TOP6.noc3encoder.msg_type == `MSG_TYPE_INV_FWDACK
            && `L15_TOP6.noc3encoder.l15_noc3encoder_req_with_data)
        begin
            $display("L1.5 MON: sending back invalid ack with data");
            $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: sending back invalid ack with data");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("L1.5 MON: sending back invalid ack with data");
        end


        $write("%0d TILE6 L1.5: Sent NOC3 %s", $time, noc3);
        $display("   mshrid %d, seqid %d, address %0x",
                    `L15_TOP6.noc3encoder.l15_noc3encoder_req_mshrid, `L15_TOP6.noc3encoder.l15_noc3encoder_req_sequenceid, `L15_TOP6.noc3encoder.l15_noc3encoder_req_address);
        $display("   srcX: %d, srcY: %d", `L15_TOP6.noc3encoder.src_l2_xpos, `L15_TOP6.noc3encoder.src_l2_ypos);
        $display("   destX: %d, destY: %d", `L15_TOP6.noc3encoder.dest_l2_xpos, `L15_TOP6.noc3encoder.dest_l2_ypos);
        $display("   Data0: 0x%x", `L15_TOP6.noc3encoder.l15_noc3encoder_req_data_0);
        $display("   Data1: 0x%x", `L15_TOP6.noc3encoder.l15_noc3encoder_req_data_1);
    end

    do_print_stage_TILE6 = ((`L15_PIPE6.val_s1 && !`L15_PIPE6.stall_s1) || (`L15_PIPE6.val_s2 && !`L15_PIPE6.stall_s2) || (`L15_PIPE6.val_s3 && !`L15_PIPE6.stall_s3));
    if (do_print_stage_TILE6)
    begin
        // $display("");
        $display("");
        $display($time, " L15 TILE6:");
        $display("NoC1 credit: %d", `L15_PIPE6.creditman_noc1_avail);
        $display("NoC1 reserved credit: %d", `L15_PIPE6.creditman_noc1_reserve);
        // $display("NoC1 r down: %d", `L15_PIPE6.creditman_noc1_reserve_minus1);
        // $display("NoC1 r up: %d", `L15_PIPE6.creditman_noc1_reserve_add1);

        // monitor the MSHRID allocation
        // $display("MSHRID allocation info:");
        // for (i_TILE6 = 0; i_TILE6 < `L15_MSHR_COUNT; i_TILE6 = i_TILE6 + 1)
        //     $write("%d:%d", i_TILE6, `L15_PIPE6.mshr_val_array[i_TILE6]);
            // $write("%d %d", i_TILE6, i_TILE6);
        // $display("");

`ifdef RTL_SPARC6
        $display("Core STB info:");
        $display("  STB0: %d", `SPARC_CORE6.sparc0.ifu.lsu_ifu_stbcnt0);
        $display("  STB1: %d", `SPARC_CORE6.sparc0.ifu.lsu_ifu_stbcnt1);
            // $write("%d %d", i_TILE6, i_TILE6);
`endif

        $write("TILE6 Pipeline:");
        if (`L15_PIPE6.val_s1 && !`L15_PIPE6.stall_s1)
            $write(" * ");
        else if (`L15_PIPE6.val_s1 && `L15_PIPE6.stall_s1)
            $write(" = ");
        else
            $write(" X ");

        if (`L15_PIPE6.val_s2 && !`L15_PIPE6.stall_s2)
            $write(" * ");
        else if (`L15_PIPE6.val_s2 && `L15_PIPE6.stall_s2)
            $write(" = ");
        else
            $write(" X ");

        if (`L15_PIPE6.val_s3 && !`L15_PIPE6.stall_s3)
            $write(" * ");
        else if (`L15_PIPE6.val_s3 && `L15_PIPE6.stall_s3)
            $write(" = ");
        else
            $write(" X ");
        $display("");

        // $write("PCX pipe info: "); decode_pcx_op(`L15_PIPE6.pcxdecoder_l15_rqtype, L15_PIPE6.pcxdecoder_l15_amo_op);
        // if (`L15_PIPE6.noc1_req_val_s3 && `L15_PIPE6.noc1encoder_req_staled_s3)
        //     $display(" (staled)");
        // else if (!`L15_PIPE6.noc1_req_val_s3)
        //     $display(" (invalid)");
        // else if (`L15_PIPE6.noc1_req_val_s3 && !`L15_PIPE6.noc1encoder_req_staled_s3)
        // begin
        //     $display(" (fresh)");
        // end

        // $write("NoC1 pipe info: ");
        // if (`L15_PIPE6.noc1_req_val_s3 && `L15_PIPE6.noc1encoder_req_staled_s3)
        //     $display("staled");
        // else if (!`L15_PIPE6.noc1_req_val_s3)
        //     $display("invalid");
        // else if (`L15_PIPE6.noc1_req_val_s3 && !`L15_PIPE6.noc1encoder_req_staled_s3)
        // begin
        //     $display("fresh");
        // end

        // $write("NoC3 pipe info: ");
        // if (`L15_PIPE6.noc3_req_val_s3 && `L15_PIPE6.noc3encoder_req_staled_s3)
        //     $display("staled");
        // else if (!`L15_PIPE6.noc3_req_val_s3)
        //     $display("invalid");
        // else if (`L15_PIPE6.noc3_req_val_s3 && !`L15_PIPE6.noc3encoder_req_staled_s3)
        // begin
        //     $display("fresh");
        // end

        // $write("CPX pipe info: ");
        // if (`L15_PIPE6.cpx_req_val_s3 && `L15_PIPE6.cpxencoder_req_staled_s3)
        //     $display("staled");
        // else if (!`L15_PIPE6.cpx_req_val_s3)
        //     $display("invalid");
        // else if (`L15_PIPE6.cpx_req_val_s3 && !`L15_PIPE6.cpxencoder_req_staled_s3)
        // begin
        //     $display("fresh");
        // end

            // Stage 1 debug information
        if (`L15_PIPE6.stall_s1 === 1'bx)
            $display("S1 stall is XXXXXXX");
        if (`L15_PIPE6.val_s1 && !`L15_PIPE6.stall_s1)
        begin
            $write("Stage 1 status: ");
            $write("   Operation: "); decode_predecode_reqtype(`L15_PIPE6.predecode_reqtype_s1);
            $display("   TILE6 S1 Address: 0x%x", `L15_PIPE6.predecode_address_s1);
            // if (`L15_PIPE6.decoder_dtag_operation_s1 == `L15_DTAG_OP_READ)
            // begin
            //     $display("   DTAG OP: L15_DTAG_OP_READ");
            //     $display("      Index: 0x%x", `L15_PIPE6.dtag_index);
            // end
            // if (`L15_PIPE6.l15_dtag_rw_s1 == `L15_DTAG_RW_WRITE)
            // begin
            //     $display("   DTAG OP: L15_DTAG_OP_WRITE");
            //     $display("      Data:  0x%x", `L15_PIPE6.dtag_write_tag_s1);
            //     $display("      Way:  0x%x", `L15_PIPE6.dtag_write_way_s1);
            //     // $display("      Mask: 0x%x", `L15_PIPE6.dtag_write_mask);
            // end
            // if (`L15_PIPE6.s1_mshr_write_val_s1)
            // begin
            //     $display("   DTAG OP: ");
            //     if (`L15_PIPE6.s1_mshr_write_type_s1 == `L15_MSHR_WRITE_TYPE_ALLOCATION)
            //     begin
            //         $write ("L15_MSHR_WRITE_TYPE_ALLOCATION");
            //         $display ("      MSRID: %d", `L15_PIPE6.s1_mshr_write_mshrid_s1);
            //     end
            //     else if (`L15_PIPE6.s1_mshr_write_type_s1 == `L15_S1_MSHR_OP_UPDATE_WRITECACHE)
            //     begin
            //         $write ("L15_S1_MSHR_OP_UPDATE_WRITECACHE");
            //         $display ("      MSRID:     %d", `L15_PIPE6.s1_mshr_write_mshrid_s1);
            //         $display ("      DATA:      0x%x", `L15_PIPE6.s1_mshr_write_data);
            //         $display ("      DATAMASK:  0x%x", `L15_PIPE6.s1_mshr_write_byte_mask);
            //     end
            // end
        end
        // Stage 2 debug information
        if (`L15_PIPE6.stall_s2 === 1'bx)
            $display("S2 stall is XXXXXXX");
        if (`L15_PIPE6.val_s2 && !`L15_PIPE6.stall_s2)
        begin
        $write("Stage 2 status: ");
            $write("   Operation: "); decode_predecode_reqtype(`L15_PIPE6.predecode_reqtype_s2);
            $display("   TILE6 S2 Address: 0x%x", `L15_PIPE6.address_s2);
            $display("   TILE6 S2 Cache index: %d", `L15_PIPE6.cache_index_s2);

            if (`L15_PIPE6.csm_req_val_s2)
            begin
                $display("   CSM op: %d", `L15_PIPE6.csm_op_s2);
                if (`L15_PIPE6.l15_csm_req_type_s2 == 1'b0)
                    $display("      CSM read ticket: 0x%x", `L15_PIPE6.l15_csm_req_ticket_s2);
                else
                begin
                    $display("      CSM write ticket: 0x%x", `L15_PIPE6.l15_csm_req_ticket_s2);
                    $display("      CSM write data: 0x%x", `L15_PIPE6.l15_csm_req_data_s2);
                end
            end

            // $display("   Source chipid: %d", `L15_PIPE6.noc2_src_homeid_s2[`PACKET_HOME_ID_CHIP_MASK]);
            // $display("   Source X: %d", `L15_PIPE6.noc2_src_homeid_s2[`PACKET_HOME_ID_X_MASK]);
            // $display("   Source Y: %d", `L15_PIPE6.noc2_src_homeid_s2[`PACKET_HOME_ID_Y_MASK]);
            // `ifdef L15_EXTRA_DEBUG
            // $display("   LRU state: %d", `L15_PIPE6.lru_state_s2);
            // $display("   LRU way: %d", `L15_PIPE6.lru_way_s2);
            // $display("   Tagcheck state: %d", `L15_PIPE6.tagcheck_state_s2);
            // $display("   Tagcheck way: %d", `L15_PIPE6.tagcheck_way_s2);

            if (`L15_PIPE6.decoder_dtag_operation_s2 == `L15_DTAG_OP_READ)
            begin
                $display("   DTAG way0 state: 0x%x", `L15_PIPE6.mesi_state_way0_s2);
                $display("   DTAG way0 data: 0x%x", dtag_tag_way0_s2_TILE6);
                $display("   DTAG way1 state: 0x%x", `L15_PIPE6.mesi_state_way1_s2);
                $display("   DTAG way1 data: 0x%x", dtag_tag_way1_s2_TILE6);
                $display("   DTAG way2 state: 0x%x", `L15_PIPE6.mesi_state_way2_s2);
                $display("   DTAG way2 data: 0x%x", dtag_tag_way2_s2_TILE6);
                $display("   DTAG way3 state: 0x%x", `L15_PIPE6.mesi_state_way3_s2);
                $display("   DTAG way3 data: 0x%x", dtag_tag_way3_s2_TILE6);
            end

            if (`L15_PIPE6.l15_mesi_write_val_s2)
            begin
                $display("   MESI write way: 0x%x", `L15_PIPE6.mesi_write_way_s2);
                $display("   MESI write data: 0x%x", `L15_PIPE6.mesi_write_state_s2);
            end

            // if (`L15_PIPE6.lruarray_write_op_s2 == `L15_LRU_EVICTION)
            // begin
            //     $display("   LRU EVICTION INDEX: %d, WAY: %d", `L15_PIPE6.cache_index_s2,
            //         `L15_PIPE6.lru_way_s2[1:0]);
            // end
            // `endif

            // if (`L15_PIPE6.s2_mesi_operation_s2 == `L15_S2_MESI_READ)
            // begin
            //     $display("   MESI OP: L15_S2_MESI_READ");
            //     $display ("      Index:     %d", `L15_PIPE6.s2_mesi_index_s2);
            // end
            // if (`L15_PIPE6.s2_mshr_val_s2)
            // begin
            //     $display("   MSHR OP: L15_S2_MSHR_OP_READ_WRITE_CACHE");
            //     $display ("      MSHR: %d", `L15_PIPE6.s2_mshr_read_mshrid);
            // end
            if (`L15_PIPE6.dcache_val_s2)
            begin
                // $write("   DCACHE OP: "); decode_dcache_op(`L15_PIPE6.dcache_operation_s2);
                // $display ("      RW:     %d", `L15_PIPE6.dcache_rw);
                // $display ("      Index:      0x%x", `L15_PIPE6.dcache_index);
                // $display ("      Data:  0x%x", `L15_PIPE6.dcache_write_data);
                // $display ("      Data mask:  0x%x", `L15_PIPE6.dcache_write_mask);
                if (`L15_PIPE6.l15_dcache_rw_s2 == 1'b0)
                begin
                    `ifndef NO_RTL_CSM
                    $display("HMT writing: %0b", `L15_PIPE6.l15_hmt_write_data_s2);
                    `endif
                    // TODO
                    // $display("HMT chip: %0b", `L15_PIPE6.wmt_fill_homeid_s2[`PACKET_HOME_ID_CHIP_MASK]);
                    // $display("HMT X: %0b", `L15_PIPE6.wmt_fill_homeid_s2[`PACKET_HOME_ID_X_MASK]);
                    // $display("HMT Y: %0b", `L15_PIPE6.wmt_fill_homeid_s2[`PACKET_HOME_ID_Y_MASK]);
                end
            end
        end

        // Stage 3 debug information
        if (`L15_PIPE6.stall_s3 === 1'bx)
            $display("S3 stall is XXXXXXX");
        if (`L15_PIPE6.val_s3 && !`L15_PIPE6.stall_s3)
        begin
            $write("Stage 3 status: ");
            $write("   Operation: "); decode_predecode_reqtype(`L15_PIPE6.predecode_reqtype_s3);
            $display("   TILE6 S3 Address: 0x%x", `L15_PIPE6.address_s3);
            `ifndef NO_RTL_CSM
            if ((`L15_PIPE6.noc1_homeid_source_s3 == `L15_HOMEID_SRC_HMT && `L15_PIPE6.noc1_req_val_s3)
                || (`L15_PIPE6.noc3_homeid_source_s3 == `L15_HOMEID_SRC_HMT && `L15_PIPE6.noc3_req_val_s3))
            begin
                `ifndef NO_RTL_CSM
                $display("   HMT chipid: %d", `L15_PIPE6.hmt_l15_dout_s3[`L15_CSM_GHID_CHIP_MASK]);
                $display("   HMT X: %d", `L15_PIPE6.hmt_l15_dout_s3[`L15_CSM_GHID_XPOS_MASK]);
                $display("   HMT Y: %d", `L15_PIPE6.hmt_l15_dout_s3[`L15_CSM_GHID_YPOS_MASK]);
                $display("   HMT reading: %0b", `L15_PIPE6.hmt_l15_dout_s3);
                `endif
            end
            `endif
            if (`L15_PIPE6.noc3_homeid_source_s3 == `L15_HOMEID_SRC_NOC2_SOURCE && `L15_PIPE6.noc3_req_val_s3)
            begin
                $display("   Source chipid: %d", `L15_PIPE6.noc2_src_homeid_s3[`PACKET_HOME_ID_CHIP_MASK]);
                $display("   Source X: %d", `L15_PIPE6.noc2_src_homeid_s3[`PACKET_HOME_ID_X_MASK]);
                $display("   Source Y: %d", `L15_PIPE6.noc2_src_homeid_s3[`PACKET_HOME_ID_Y_MASK]);
            end

            if (`L15_PIPE6.cpx_data_source_s3 == `L15_CPX_SOURCE_CSM)
                $display("      CSM read data: 0x%x", `L15_PIPE6.csm_l15_res_data_s3);
            // `ifdef L15_EXTRA_DEBUG
            // $display("   LRU state: %d", `L15_PIPE6.lru_state_s3);
            // $display("   LRU way: %d", `L15_PIPE6.lru_way_s3);
            // $display("   Tagcheck state: %d", `L15_PIPE6.tagcheck_state_s3);
            // $display("   Tagcheck way: %d", `L15_PIPE6.tagcheck_way_s3);
            // `endif

            // if (`L15_PIPE6.s3_mesi_val_s3)
            // begin
            //     $write("   MESI OP: "); decode_s3mesi_op(`L15_PIPE6.s3_mesi_operation_s3);
            //     $display ("      Index:      0x%x", `L15_PIPE6.mesi_write_index);
            //     $display ("      Data:  0x%x", `L15_PIPE6.mesi_write_data);
            //     $display ("      Data mask:  0x%x", `L15_PIPE6.mesi_write_mask);
            // end
            // if (`L15_PIPE6.wmc_val_s3)
            // begin
            //     $write("   WMC OP: "); decode_wmc_op(`L15_PIPE6.wmc_operation_s3);
            //     if (`L15_PIPE6.wmc_rw_s3 == `L15_WMC_OP_READ)
            //     begin
            //         $display ("      wmc_index_s3:      0x%x", `L15_PIPE6.wmc_index_s3);
            //         $display ("      wmc_invalidate_val_s3:      0x%x", `L15_PIPE6.wmc_invalidate_val_s3);
            //         $display ("      wmc_invalidate_way_s3:      0x%x", `L15_PIPE6.wmc_invalidate_way_s3);
            //     end
            //     else if (`L15_PIPE6.wmc_rw_s3 == `L15_WMC_OP_WRITE)
            //     begin
            //         $display ("      wmc_index_s3:      0x%x", `L15_PIPE6.wmc_index_s3);
            //         $display ("      wmc_update_way_s3:      0x%x", `L15_PIPE6.wmc_update_way_s3);
            //         $display ("      wmc_update_data_s3:      0x%x", `L15_PIPE6.wmc_update_data_s3);
            //         $display ("      wmc_invalidate_val_s3:      0x%x", `L15_PIPE6.wmc_invalidate_val_s3);
            //         $display ("      wmc_invalidate_way_s3:      0x%x", `L15_PIPE6.wmc_invalidate_way_s3);
            //     end
            //     $display ("      cpx_inval_way_s3:      0x%x", `L15_PIPE6.cpx_inval_way_s3);
            //     $display ("      wmc_read_way0_data_s3:      0x%x", `L15_PIPE6.wmc_read_way0_data_s3);
            //     $display ("      wmc_read_way1_data_s3:      0x%x", `L15_PIPE6.wmc_read_way1_data_s3);
            //     $display ("      wmc_read_way2_data_s3:      0x%x", `L15_PIPE6.wmc_read_way2_data_s3);
            //     $display ("      wmc_read_way3_data_s3:      0x%x", `L15_PIPE6.wmc_read_way3_data_s3);
            // end
            // if (`L15_PIPE6.s3_mshr_val_s3)
            // begin
            //     $write("   MSHR OP: "); decode_s3mshr_op(`L15_PIPE6.s3_mshr_operation_s3);
            //     $display ("      MSHR:      %d", `L15_PIPE6.s3_mshr_write_mshrid);
            //     $display ("      U.State:      0x%x", `L15_PIPE6.s3_mshr_write_update_state);
            //     $display ("      U.Way:  0x%x", `L15_PIPE6.s3_mshr_write_update_way);
            //     $display ("      St.mshr rand hit:   %d", `L15_PIPE6.LRU_st1_mshr_s3 || `L15_PIPE6.LRU_st2_mshr_s3);
            //     $display ("      St.mshr tag hit:   %d", `L15_PIPE6.tagcheck_st1_mshr_s3 || `L15_PIPE6.tagcheck_st2_mshr_s3);
            // end
            if (wmt_read_val_s3_TILE6)
            begin
                $display("   TILE6 WMT read index: %x", `L15_PIPE6.cache_index_l1d_s3[`L1D_SET_IDX_MASK]);
                // $display("   WMT way0: %x 0x%x", `L15_PIPE6.wmt_data_s3[0][`L15_WMT_VALID_MASK], `L15_PIPE6.wmt_data_s3[0][`L15_WMT_DATA_MASK]);
                // $display("   WMT way1: %x 0x%x", `L15_PIPE6.wmt_data_s3[1][`L15_WMT_VALID_MASK], `L15_PIPE6.wmt_data_s3[1][`L15_WMT_DATA_MASK]);
                // $display("   WMT way2: %x 0x%x", `L15_PIPE6.wmt_data_s3[2][`L15_WMT_VALID_MASK], `L15_PIPE6.wmt_data_s3[2][`L15_WMT_DATA_MASK]);
                // $display("   WMT way3: %x 0x%x", `L15_PIPE6.wmt_data_s3[3][`L15_WMT_VALID_MASK], `L15_PIPE6.wmt_data_s3[3][`L15_WMT_DATA_MASK]);
                for (i = 0; i < `L1D_WAY_COUNT; i = i + 1)
                begin
                    $display("   WMT way%d: %x 0x%x", i, `L15_PIPE6.wmt_data_s3[i][`L15_WMT_VALID_MASK], `L15_PIPE6.wmt_data_s3[i][`L15_WMT_DATA_MASK]);
                end
            end
            if (`L15_PIPE6.l15_wmt_write_val_s3)
            begin
                $display("   TILE6 WMT write index: %x", `L15_PIPE6.cache_index_l1d_s3[`L1D_SET_IDX_MASK]);
                // $display("   WMT write mask: %x", `L15_PIPE6.l15_wmt_write_mask_s3);
                // $display("   WMT write data: %x", `L15_PIPE6.l15_wmt_write_data_s3);
                // $display("   WMT way0 m%x d0x%x", `L15_PIPE6.l15_wmt_write_mask_s3[`L15_WMT_ENTRY_0_MASK], `L15_PIPE6.wmt_write_data_s3[`L15_WMT_ENTRY_0_MASK]);
                // $display("   WMT way1 m%x d0x%x", `L15_PIPE6.l15_wmt_write_mask_s3[`L15_WMT_ENTRY_1_MASK], `L15_PIPE6.wmt_write_data_s3[`L15_WMT_ENTRY_1_MASK]);
                // $display("   WMT way2 m%x d0x%x", `L15_PIPE6.l15_wmt_write_mask_s3[`L15_WMT_ENTRY_2_MASK], `L15_PIPE6.wmt_write_data_s3[`L15_WMT_ENTRY_2_MASK]);
                // $display("   WMT way3 m%x d0x%x", `L15_PIPE6.l15_wmt_write_mask_s3[`L15_WMT_ENTRY_3_MASK], `L15_PIPE6.wmt_write_data_s3[`L15_WMT_ENTRY_3_MASK]);
            end
        end
        $display ("L15_MON_END");
        $display ("");
    end

//CSM monitor
    if(`L15_TOP6.l15_csm.l15_csm_req_val_s2)
    begin
        $display($time, ": TILE6 L15_CSM REQ MON:");
        $display("L15 CSM req addr: 0x%x", `L15_TOP6.l15_csm.l15_csm_req_address_s2);
        $display("L15 CSM req ticket: %d", `L15_TOP6.l15_csm.l15_csm_req_ticket_s2);
        $display("L15 CSM req type: %d", `L15_TOP6.l15_csm.l15_csm_req_type_s2);
        $display("L15 CSM req data: 0x%x", `L15_TOP6.l15_csm.l15_csm_req_data_s2);
        $display("L15 CSM req pcx data: 0x%x", `L15_TOP6.l15_csm.l15_csm_req_pcx_data_s2);
    end
    if(`L15_TOP6.l15_csm.csm_l15_res_val_s3)
    begin
        $display($time, ": TILE6 L15_CSM RES MON:");
        $display("L15 CSM res data: 0x%x", `L15_TOP6.l15_csm.csm_l15_res_data_s3);
    end
    if(`L15_TOP6.l15_csm.csm_l15_read_res_val)
    begin
        $display($time, ": TILE6 L15_CSM READ TICKET MON:");
        $display("L15 CSM read ticket: %d", `L15_TOP6.l15_csm.l15_csm_read_ticket);
        $display("L15 CSM read data: 0x%x", `L15_TOP6.l15_csm.csm_l15_read_res_data);
    end
    if(`L15_TOP6.l15_csm.csm_noc1encoder_req_val)
    begin
        $display($time, ": TILE6 L15_CSM NOC1 REQ MON:");
        $display("L15 CSM noc1 req addr: 0x%x", `L15_TOP6.l15_csm.csm_noc1encoder_req_address);
        $display("L15 CSM noc1 req type: %d", `L15_TOP6.l15_csm.csm_noc1encoder_req_type);
        $display("L15 CSM noc1 req mshrid: %d", `L15_TOP6.l15_csm.csm_noc1encoder_req_mshrid);
    end
    if(`L15_TOP6.l15_csm.noc1encoder_csm_req_ack)
    begin
        $display($time, ": TILE6 L15_CSM NOC1 REQ ACK MON:");
        $display("L15 CSM noc1 req ack: %b", `L15_TOP6.l15_csm.noc1encoder_csm_req_ack);
    end

    if(`L15_TOP6.l15_csm.write_val_s2 && (~`L15_TOP6.l15_csm.ghid_val_s2))
    begin
        $display("L1.5 MON: HMC refills invalid data");
        $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: HMC refills invalid data");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("L1.5 MON: HMC refills invalid data");
    end

// valid mshrid monitor
    // check for incoming messages
    if (`L15_PIPE6.noc2decoder_l15_val && `L15_PIPE6.val_s1 && !`L15_PIPE6.stall_s1)
    begin
        is_csm_mshrid_TILE6 = `L15_PIPE6.noc2decoder_l15_hmc_fill;
        if ((`L15_PIPE6.noc2decoder_l15_reqtype == `MSG_TYPE_NODATA_ACK ||
            `L15_PIPE6.noc2decoder_l15_reqtype == `MSG_TYPE_DATA_ACK)
            && !is_csm_mshrid_TILE6)
        begin
            // first check if mshrid is in range
            if (`L15_PIPE6.noc2decoder_l15_mshrid > 9)
            begin
                $display("L1.5 MON: Received NoC2 message with MSHRID greater than 9 (%d)", `L15_PIPE6.noc2decoder_l15_mshrid);
                $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: Received NoC2 message with MSHRID greater than 9");
                `ifndef VERILATOR
                repeat(5)@(posedge clk)
                `endif
                    `MONITOR_PATH.fail("L1.5 MON: Received NoC2 message with MSHRID greater than 9");
            end

            // now check if it's valid
            // TODO
            // if (`L15_TOP6.mshr.val_array[`L15_PIPE6.noc2decoder_l15_mshrid] != 1'b1)
            // begin
            //     $display("L1.5 MON: Received NoC2 message with invalid MSHRID (%d)", `L15_PIPE6.noc2decoder_l15_mshrid);
            //     $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: Received NoC2 message with invalid MSHRID");
            //     `ifndef VERILATOR
            //     repeat(5)@(posedge clk)
            //     `endif
                //     `MONITOR_PATH.fail("L1.5 MON: Received NoC2 message with invalid MSHRID");
            // end
        end
    end
    // if (`L15_PIPE6.l15_noc1buffer_req_val && !`L15_PIPE6.stall_s3)
    // begin
    //     if (`L15_PIPE6.l15_noc1buffer_req_type != `L15_NOC1_REQTYPE_WRITEBACK_GUARD
    //         && `L15_PIPE6.l15_noc1buffer_req_type != `L15_NOC1_REQTYPE_INTERRUPT_FWD)
    //     begin
    //         if (`L15_TOP6.mshr.val_array[`L15_PIPE6.l15_noc1buffer_req_mshrid] != 1'b1
    //             || `L15_PIPE6.l15_noc1buffer_req_mshrid > 9)
    //         begin
    //             $display("L1.5 MON: Sending NoC1 message with invalid MSHRID (%d)", `L15_PIPE6.l15_noc1buffer_req_mshrid);
    //             $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: Sending NoC1 message with invalid MSHRID");
    //             `ifndef VERILATOR
    //             repeat(5)@(posedge clk)
    //             `endif
        //             `MONITOR_PATH.fail("L1.5 MON: Sending NoC1 message with invalid MSHRID");
    //         end
    //     end
    // end

// monitor PCX buffer full compare to t1 internal buffer mon
`ifdef RTL_SPARC6
`ifndef RTL_SPU
    if ((`CCX_TRANSDUCER6.pcx_buffer.is_req_squashed == 1'b1) && (`SPARC_CORE6.sparc0.lsu.lsu.qctl1.pcx_req_squash == 1'b0))
`else
    if ((`CCX_TRANSDUCER6.pcx_buffer.is_req_squashed == 1'b1) && (`SPARC_CORE6.sparc0.lsu.qctl1.pcx_req_squash == 1'b0))
`endif
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "PCXTILE6 req was valid but squashed in L1.5");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("PCXTILE6 req was valid but squashed in L1.5");
    end
`ifndef RTL_SPU
    if ((`CCX_TRANSDUCER6.pcx_buffer.is_req_squashed == 1'b0) && (`SPARC_CORE6.sparc0.lsu.lsu.qctl1.pcx_req_squash == 1'b1))
`else
    if ((`CCX_TRANSDUCER6.pcx_buffer.is_req_squashed == 1'b0) && (`SPARC_CORE6.sparc0.lsu.qctl1.pcx_req_squash == 1'b1))
`endif
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "PCXTILE6 req was squashed but valid at L1.5");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("PCXTILE6 req was squashed but valid at L1.5");
    end

    // check for squashed atomic
    if ((`CCX_TRANSDUCER6.pcx_buffer.is_req_squashed == 1'b1) && (`CCX_TRANSDUCER6.pcx_buffer.spc_uncore_atomic_req == 1'b1))
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "PCXTILE6 atomic req squashed");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("PCXTILE6 atomic req squashed");
    end
`endif

// monitor FP transactions because it is not supported yet
//     if (`L15_PIPE6.pcxdecoder_l15_val && !`L15_PIPE6.pcx_message_staled_s1 && `L15_PIPE6.val_s1 && !`L15_PIPE6.stall_s1 && !`L15_PIPE6.noc2decoder_l15_val)
//     begin
//         if (`L15_PIPE6.pcxdecoder_l15_rqtype == `PCX_REQTYPE_FP1)
//         begin
//             $display("%d : Simulation -> FAIL(%0s)", $time, "FP requests received but not implemented");
//             `ifndef VERILATOR
//             repeat(5)@(posedge clk)
//             `endif
    //             `MONITOR_PATH.fail("FP requests received but not implemented");
//         end
//     end

// monitor INT_VEC_DIS requests
    if (`L15_PIPE6.pcxdecoder_l15_val && `L15_PIPE6.val_s1 && !`L15_PIPE6.stall_s1 && !`L15_PIPE6.noc2decoder_l15_val)
    begin
        if (`L15_PIPE6.pcxdecoder_l15_rqtype == `PCX_REQTYPE_STORE
            && `L15_PIPE6.pcxdecoder_l15_address == 40'h9800000800)
        begin
            $display("%d : PCX write to INT_VEC_DIS", $time);
            // $display("%d : Simulation -> FAIL(%0s)", $time, "Write to INT_VEC_DIS");
            // `ifndef VERILATOR
            // repeat(5)@(posedge clk)
            // `endif
                // `MONITOR_PATH.fail("Write to INT_VEC_DIS");
        end
    end

// monitor noc1 buffer credit for underflow
    if (`L15_PIPE6.creditman_noc1_avail == 4'd15)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE6 NOC1 credit underflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE6 NOC1 credit underflow");
    end
    if (`L15_PIPE6.creditman_noc1_avail > `NOC1_BUFFER_NUM_SLOTS)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE6 NOC1 credit overflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE6 NOC1 credit overflow");
    end
    if (`L15_PIPE6.creditman_noc1_data_avail == 4'd15)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE6 NOC1 data credit underflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE6 NOC1 data credit underflow");
    end
    if (`L15_PIPE6.creditman_noc1_data_avail > `NOC1_BUFFER_NUM_DATA_SLOTS)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE6 NOC1 data credit overflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE6 NOC1 data credit overflow");
    end

    // check noc1 reserve credit
    if (`L15_PIPE6.creditman_noc1_reserve == 4'd15)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE6 NOC1 reserve credit underflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE6 NOC1 reserve credit underflow");
    end
    if (`L15_PIPE6.creditman_noc1_reserve > `NOC1_BUFFER_NUM_SLOTS)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE6 NOC1 reserve credit overflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE6 NOC1 reserve credit overflow");
    end
    // check reserve logics
    // if (`L15_PIPE6.creditman_noc1_reserve_s3)
    // begin
    //     $display("%d : Simulation -> FAIL(%0s)", $time, "TILE6 NOC1 reserve credit underflow");
    //     `ifndef VERILATOR
    //     repeat(5)@(posedge clk)
    //     `endif
        //     `MONITOR_PATH.fail("TILE6 NOC1 reserve credit underflow");
    // end

// Monitor for "RESERVED" messages
    if (`L15_PIPE6.noc2decoder_l15_val && `L15_PIPE6.val_s1 && !`L15_PIPE6.stall_s1)
    begin
        if (`L15_PIPE6.noc2decoder_l15_reqtype == `MSG_TYPE_RESERVED)
        begin
            $display("%d : Simulation -> FAIL(%0s)", $time, "TILE6 L15 received MSG_TYPE_RESERVED");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("TILE6 L15 received MSG_TYPE_RESERVED");
        end
    end

// Monitor WMT duplicate error
    if (`L15_PIPE6.val_s3)
    begin
        {wmt_read_data_TILE6[3], wmt_read_data_TILE6[2], wmt_read_data_TILE6[1], wmt_read_data_TILE6[0]} = `L15_PIPE6.wmt_l15_data_s3;
        for (i_TILE6 = 0; i_TILE6 < 4; i_TILE6 = i_TILE6+1)
        begin
            for (j_TILE6 = 0; j_TILE6 < i_TILE6; j_TILE6 = j_TILE6 + 1)
            begin
                if ((wmt_read_data_TILE6[i_TILE6][`L15_WMT_VALID_MASK] && wmt_read_data_TILE6[j_TILE6][`L15_WMT_VALID_MASK]) && (wmt_read_data_TILE6[i_TILE6] == wmt_read_data_TILE6[j_TILE6]))
                begin
                    $display("%d : Simulation -> FAIL(%0s)", $time, "TILE6 L15 has error with WMT");
                    `ifndef VERILATOR
                    repeat(5)@(posedge clk)
                    `endif
                        `MONITOR_PATH.fail("TILE6 L15 has error with WMT");
                end
            end
        end
    end

// Monitor tags duplication error (bug #86)
    if (`L15_PIPE6.val_s2 && `L15_PIPE6.decoder_dtag_operation_s2 == `L15_DTAG_OP_READ)
    begin
        tag_data_TILE6[0] = `L15_PIPE6.dtag_tag_way0_s2[`L15_CACHE_TAG_WIDTH-1:0];
        tag_data_TILE6[1] = `L15_PIPE6.dtag_tag_way1_s2[`L15_CACHE_TAG_WIDTH-1:0];
        tag_data_TILE6[2] = `L15_PIPE6.dtag_tag_way2_s2[`L15_CACHE_TAG_WIDTH-1:0];
        tag_data_TILE6[3] = `L15_PIPE6.dtag_tag_way3_s2[`L15_CACHE_TAG_WIDTH-1:0];
        tag_val_TILE6[0] = `L15_PIPE6.mesi_state_way0_s2 != `L15_MESI_STATE_I;
        tag_val_TILE6[1] = `L15_PIPE6.mesi_state_way1_s2 != `L15_MESI_STATE_I;
        tag_val_TILE6[2] = `L15_PIPE6.mesi_state_way2_s2 != `L15_MESI_STATE_I;
        tag_val_TILE6[3] = `L15_PIPE6.mesi_state_way3_s2 != `L15_MESI_STATE_I;
        for (i_TILE6 = 0; i_TILE6 < 4; i_TILE6 = i_TILE6+1)
        begin
            for (j_TILE6 = 0; j_TILE6 < i_TILE6; j_TILE6 = j_TILE6 + 1)
            begin
                if ((tag_val_TILE6[i_TILE6] && tag_val_TILE6[j_TILE6]) && (tag_data_TILE6[i_TILE6] == tag_data_TILE6[j_TILE6]))
                begin
                    $display("%d : Simulation -> FAIL(%0s)", $time, "TILE6 L15 has duplicated tag entry");
                    `ifndef VERILATOR
                    repeat(5)@(posedge clk)
                    `endif
                        `MONITOR_PATH.fail("TILE6 L15 has duplicated tag entry");
                end
            end
        end
    end

// // monitor FP transactions because it is not supported yet
//     if (`L15_TOP6.noc1encoder.sending)
//     begin
//         $display("noc1 flit raw: 0x%x", `L15_TOP6.noc1encoder.flit);
//     end
//     if (`L15_PIPE6.pcxdecoder_l15_val && !`L15_PIPE6.pcx_message_staled_s1 && `L15_PIPE6.val_s1 && !`L15_PIPE6.stall_s1 && !`L15_PIPE6.noc2decoder_l15_val)
//     begin
//         $display("%d : Simulation -> FAIL(%0s)", $time, "FP requests received but not implemented");
//         `ifndef VERILATOR
//         repeat(5)@(posedge clk)
//         `endif
    //         `MONITOR_PATH.fail("FP requests received but not implemented");
//     end


// Monitor FP transactions
//    if (`TILE6.fpu_arb_wrap.pcx_fpio_data_px2[123]
//            && `TILE6.fpu_arb_wrap.pcx_fpio_data_px2[122:119] == 4'b0101)
//    begin
//        $display("TILE6 FPU th%d: Received FP%d",
//                    `TILE6.fpu_arb_wrap.pcx_fpio_data_px2[113:112],
//                    `TILE6.fpu_arb_wrap.pcx_fpio_data_px2[118]);
//    end
//    if (`TILE6.fpu_arb_wrap.fpu_arb_data_rdy
//            && !`TILE6.fpu_arb_wrap.l15_fp_rdy)
//        $display("TILE6 FPU th%d: Sent FP data",
//                    `TILE6.fpu_arb_wrap.fpu_arb_data[135:134]);

// monitor L1.5 way replacement error
    if (`L15_PIPE6.l15_dcache_val_s2
        && `L15_PIPE6.dcache_operation_s2 == `L15_DCACHE_READ_LRU_WAY_IF_M)
    begin
        if (`L15_PIPE6.lruarray_l15_dout_s2[`L15_PIPE6.lru_way_s2] == 1'b1)
        begin
            // replacing a valid line
            if (&`L15_PIPE6.lru_used_bits_s2[3:0] == 1'b0)
            begin
                // and an another entry is 0, then is an error
                $display("%d : Simulation -> FAIL(%0s)", $time, "TILE6 L15 picked the wrong LRU entry");
                `ifndef VERILATOR
                repeat(5)@(posedge clk)
                `endif
                    `MONITOR_PATH.fail("TILE6 L15 picked the wrong LRU entry");
            end
        end
    end

// monitor X's in stall signals
    if (`L15_PIPE6.val_s1 && (`L15_PIPE6.stall_s1 === 1'bx) ||
        `L15_PIPE6.val_s2 && (`L15_PIPE6.stall_s2 === 1'bx) ||
        `L15_PIPE6.val_s3 && (`L15_PIPE6.stall_s3 === 1'bx))
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "L15 has X's in the stall_s1 signal");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("L15 has X's in the stall_s1 signal");
    end

`ifdef RTL_SPARC6
// some checks for l15cpxencoder
    if (`L15_TOP6.l15_transducer_val)
    begin
        if (`L15_TOP6.l15_transducer_inval_icache_inval)
        begin
            $display("%d : Simulation -> FAIL(%0s)", $time, "l15 icache inval is not used");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("l15 icache inval is not used");
        end
        if (`L15_TOP6.l15_transducer_returntype == `CPX_RESTYPE_ATOMIC_RES
            && `L15_TOP6.l15_transducer_inval_dcache_inval)
        begin
            $display("%d : Simulation -> FAIL(%0s)", $time, "l15 CAS inval is not used");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("l15 CAS inval is not used");
        end
    end
`endif

// some checks for l15 noc1 encoder
    if (`L15_TOP6.noc1encoder.sending && `L15_TOP6.noc1encoder.req_type == 0)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "l15 noc1 message is null");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("l15 noc1 message is null");
    end

    end // disable_l15_mon
end

//CORE6 END


// CORE7

reg do_print_stage_TILE7;
integer i_TILE7;
wire [63:0] dtag_tag_way0_s2_TILE7;
wire [63:0] dtag_tag_way1_s2_TILE7;
wire [63:0] dtag_tag_way2_s2_TILE7;
wire [63:0] dtag_tag_way3_s2_TILE7;

assign dtag_tag_way0_s2_TILE7 = (`L15_PIPE7.dtag_tag_way0_s2 << 11);
assign dtag_tag_way1_s2_TILE7 = (`L15_PIPE7.dtag_tag_way1_s2 << 11);
assign dtag_tag_way2_s2_TILE7 = (`L15_PIPE7.dtag_tag_way2_s2 << 11);
assign dtag_tag_way3_s2_TILE7 = (`L15_PIPE7.dtag_tag_way3_s2 << 11);
reg [`L15_CACHE_TAG_WIDTH-1:0] tag_data_TILE7 [0:3];
reg [3:0] tag_val_TILE7;
reg [`L15_WMT_ENTRY_MASK] wmt_read_data_TILE7 [0:3];
integer j_TILE7;
reg is_csm_mshrid_TILE7;

reg wmt_read_val_s3_TILE7;
always @ (posedge clk)
    wmt_read_val_s3_TILE7 <= `L15_PIPE7.l15_wmt_read_val_s2;

always @ (negedge clk)
begin
    if(!$test$plusargs("disable_l15_mon"))
    begin

    // monitoring outgoing noc1/noc3 messages
    if (`L15_TOP7.noc1encoder.sending)
    begin
        $display($time);
        $display("TILE7 noc1 flit raw: 0x%x", `L15_TOP7.noc1encoder.flit);
        $display("   srcX: %d, srcY: %d", `L15_TOP7.noc1encoder.msg_src_xpos, `L15_TOP7.noc1encoder.msg_src_ypos);
        $display("   destX: %d, destY: %d", `L15_TOP7.noc1encoder.msg_dest_l2_xpos, `L15_TOP7.noc1encoder.msg_dest_l2_ypos);
        if ( ^`L15_TOP7.noc1encoder.flit === 1'bx)
        begin
            $display("%d : Simulation -> FAIL(TILE7 noc1 sends X data 0x%x)", $time, `L15_TOP7.noc1encoder.flit);
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("l15_mon: TILE7 noc1 sends X data");
        end

    end




    if (`L15_PIPE7.pcxdecoder_l15_val && `L15_PIPE7.val_s1 && !`L15_PIPE7.stall_s1 && !`L15_PIPE7.noc2decoder_l15_val
        && `L15_PIPE7.fetch_state_s1 == `L15_FETCH_STATE_NORMAL)
    begin
        $write("%0d TILE7 L1.5 th%d: Received PCX ", $time, `L15_PIPE7.pcxdecoder_l15_threadid); decode_pcx_op(`L15_PIPE7.pcxdecoder_l15_rqtype, `L15_PIPE7.pcxdecoder_l15_amo_op);
        $display("   Addr 0x%x, nc %d, size %d, invalall %d, pf %d, bs %d, bsi %d, l1way %d",
                                `L15_PIPE7.pcxdecoder_l15_address, `L15_PIPE7.pcxdecoder_l15_nc, `L15_PIPE7.pcxdecoder_l15_size, `L15_PIPE7.pcxdecoder_l15_invalidate_cacheline,
                                `L15_PIPE7.pcxdecoder_l15_prefetch, `L15_PIPE7.pcxdecoder_l15_blockstore, `L15_PIPE7.pcxdecoder_l15_blockinitstore, `L15_PIPE7.pcxdecoder_l15_l1rplway);
        $display("   Data: 0x%x", `L15_PIPE7.pcxdecoder_l15_data);
        if (`L15_PIPE7.pcxdecoder_l15_csm_data[`TLB_CSM_STATE] == `TLB_CSM_STATE_LOCAL)
        begin
            $display("   CSM HDID: %d, HD_SIZE: %d, SDID: %d, LSID: %d", `L15_PIPE7.pcxdecoder_l15_csm_data[`TLB_CSM_HDID], `L15_PIPE7.pcxdecoder_l15_csm_data[`TLB_CSM_HD_SIZE],
            `L15_PIPE7.pcxdecoder_l15_csm_data[`TLB_CSM_SDID], `L15_PIPE7.pcxdecoder_l15_csm_data[`TLB_CSM_LSID]);
        end
        else if (`L15_PIPE7.pcxdecoder_l15_csm_data[`TLB_CSM_STATE] == `TLB_CSM_STATE_GLOBAL)
        begin
            $display("   CSM CHIPID: %d, X: %d, Y: %d", `L15_PIPE7.pcxdecoder_l15_csm_data[`TLB_CSM_CHIPID], `L15_PIPE7.pcxdecoder_l15_csm_data[`TLB_CSM_X],`L15_PIPE7.pcxdecoder_l15_csm_data[`TLB_CSM_Y]);
        end
        $display("   CSM Data: 0x%x", `L15_PIPE7.pcxdecoder_l15_csm_data);
        /*
        if (noc2decoder_l15_reqtype == `PCX_REQTYPE_STORE)
        if (noc2decoder_l15_reqtype == `PCX_REQTYPE_CAS1)
        begin
        $display("   Cmp.data: 0x%x", `L15_PIPE7.pcxdecoder_l15_data);
        $display("   Swp.data: 0x%x", `L15_PIPE7.pcxdecoder_l15_data_next_entry);
        end
        if (noc2decoder_l15_reqtype == `PCX_REQTYPE_SWP_LOADSTUB)
        begin
        $display("   Swp.data: 0x%x", `L15_PIPE7.pcxdecoder_l15_data);
        end
        */
        if (`L15_PIPE7.pcxdecoder_l15_rqtype == `PCX_REQTYPE_INTERRUPT && `L15_PIPE7.pcxdecoder_l15_data[63] == 1'b0)
        begin
            pcx_interrupt_type = `L15_PIPE7.pcxdecoder_l15_data[17:16];
            pcx_interrupt_dst_chipid = `L15_PIPE7.pcxdecoder_l15_data[31:18];
            pcx_interrupt_dst_y = `L15_PIPE7.pcxdecoder_l15_data[14:12];
            pcx_interrupt_dst_x = `L15_PIPE7.pcxdecoder_l15_data[11:9];
            pcx_interrupt_threadid = `L15_PIPE7.pcxdecoder_l15_data[8];
            pcx_interrupt_vector = `L15_PIPE7.pcxdecoder_l15_data[5:0];
            $display("Interrupt info:");
            $write("    Type: ");
            case(pcx_interrupt_type)
                2'b00:
                    $display("hw int");
                2'b01:
                    $display("reset");
                2'b10:
                    $display("idle");
                2'b11:
                    $display("resume");
            endcase

            $display("    Dst CHIP ID: %d", pcx_interrupt_dst_chipid);
            $display("    Dst X: %d", pcx_interrupt_dst_x);
            $display("    Dst Y: %d", pcx_interrupt_dst_y);
            $display("    Thread ID: %d", pcx_interrupt_threadid);
            $display("    Vector: %d", pcx_interrupt_vector);
        end
    end

    if (`L15_PIPE7.noc2decoder_l15_val && `L15_PIPE7.val_s1 && !`L15_PIPE7.stall_s1)
    begin
        noc2 = 0;
        case(`L15_PIPE7.noc2decoder_l15_reqtype)
        `MSG_TYPE_RESERVED:
            noc2 = "MSG_TYPE_RESERVED";
        `MSG_TYPE_LOAD_FWD:
            noc2 = "MSG_TYPE_LOAD_FWD";
        `MSG_TYPE_STORE_FWD:
            noc2 = "MSG_TYPE_STORE_FWD";
        `MSG_TYPE_INV_FWD:
            noc2 = "MSG_TYPE_INV_FWD";
        `MSG_TYPE_NODATA_ACK:
            noc2 = "MSG_TYPE_NODATA_ACK";
        `MSG_TYPE_DATA_ACK:
            noc2 = "MSG_TYPE_DATA_ACK";
        `MSG_TYPE_NC_LOAD_MEM_ACK:
            noc2 = "MSG_TYPE_NC_LOAD_MEM_ACK";
        `MSG_TYPE_NC_STORE_MEM_ACK:
            noc2 = "MSG_TYPE_NC_STORE_MEM_ACK";
        `MSG_TYPE_INTERRUPT:
            noc2 = "MSG_TYPE_L2_INTERRUPT";
        default:
        begin
            noc2 = "MSG_TYPE_UNKNOWN_ERROR";
            $display("%d : Simulation -> FAIL(%0s)", $time, "L15 mon: error message type from L2");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("L15 mon: error message type from L2");
        end
        endcase

        $write("%0d TILE7 L1.5: Received NOC2 %s", $time, noc2);
        $display("   mshrid %d, l2miss %d, f4b %d, ackstate %d, address 0x%x",
                    `L15_PIPE7.noc2decoder_l15_mshrid, `L15_PIPE7.noc2decoder_l15_l2miss, `L15_PIPE7.noc2decoder_l15_f4b,
                    `L15_PIPE7.noc2decoder_l15_ack_state, `L15_PIPE7.noc2decoder_l15_address);
        $display("   Data1: 0x%x", `L15_PIPE7.noc2decoder_l15_data_0);
        $display("   Data2: 0x%x", `L15_PIPE7.noc2decoder_l15_data_1);
        $display("   Data3: 0x%x", `L15_PIPE7.noc2decoder_l15_data_2);
        $display("   Data4: 0x%x", `L15_PIPE7.noc2decoder_l15_data_3);
    end

    if (`L15_PIPE7.l15_cpxencoder_val && !`L15_PIPE7.stall_s3)
    begin
        cpx = 0;
        case(`L15_PIPE7.l15_cpxencoder_returntype)
            `LOAD_RET:
                cpx = "LOAD_RET";
            `INV_RET:
                cpx = "INV_RET";
            `ST_ACK:
                cpx = "ST_ACK";
            `AT_ACK:
                cpx = "AT_ACK";
            `INT_RET:
                cpx = "INT_RET";
            `TEST_RET:
                cpx = "TEST_RET";
            `FP_RET:
                cpx = "FP_RET";
            `IFILL_RET:
                cpx = "IFILL_RET";
            `EVICT_REQ:
                cpx = "EVICT_REQ";
            `ERR_RET:
                cpx = "ERR_RET";
            `STRLOAD_RET:
                cpx = "STRLOAD_RET";
            `STRST_ACK:
                cpx = "STRST_ACK";
            `FWD_RQ_RET:
                cpx = "FWD_RQ_RET";
            `FWD_RPY_RET:
                cpx = "FWD_RPY_RET";
            `RSVD_RET:
                cpx = "RSVD_RET";
            4'b1110:
                cpx = "ATOMIC_ACK";
            default:
                cpx = "CPX_UNKNOWN";
        endcase
        $write("%0d TILE7 L1.5 th%d: Sent CPX %0s", $time, `L15_PIPE7.l15_cpxencoder_threadid, cpx);
        $display("   l2miss %d, nc %d, atomic %d, threadid %d, pf %d, f4b %d, iia %d, dia %d, dinval %d, iinval %d, invalway %d, blkinit %d",
                    `L15_PIPE7.l15_cpxencoder_l2miss, `L15_PIPE7.l15_cpxencoder_noncacheable, `L15_PIPE7.l15_cpxencoder_atomic,
                    `L15_PIPE7.l15_cpxencoder_threadid, `L15_PIPE7.l15_cpxencoder_prefetch,
                    `L15_PIPE7.l15_cpxencoder_f4b, `L15_PIPE7.l15_cpxencoder_inval_icache_all_way,
                    `L15_PIPE7.l15_cpxencoder_inval_dcache_all_way, `L15_PIPE7.l15_cpxencoder_inval_dcache_inval,
                    `L15_PIPE7.l15_cpxencoder_inval_icache_inval, `L15_PIPE7.l15_cpxencoder_inval_way,
                    `L15_PIPE7.l15_cpxencoder_blockinitstore);
        $display("   Data0: 0x%x", `L15_PIPE7.l15_cpxencoder_data_0);
        $display("   Data1: 0x%x", `L15_PIPE7.l15_cpxencoder_data_1);
        $display("   Data2: 0x%x", `L15_PIPE7.l15_cpxencoder_data_2);
        $display("   Data3: 0x%x", `L15_PIPE7.l15_cpxencoder_data_3);
    end

    if (`L15_TOP7.noc1encoder.noc1encoder_noc1out_val && `L15_TOP7.noc1encoder.noc1encoder_noc1buffer_req_ack)
    begin
        noc1 = 0;
        case(`L15_TOP7.noc1encoder.req_type)
        `L15_NOC1_REQTYPE_WRITEBACK_GUARD:
            noc1 = "L15_NOC1_REQTYPE_WRITEBACK_GUARD";
        `L15_NOC1_REQTYPE_LD_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_LD_REQUEST";
        `L15_NOC1_REQTYPE_IFILL_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_IFILL_REQUEST";
        `L15_NOC1_REQTYPE_WRITETHROUGH_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_WRITETHROUGH_REQUEST";
        `L15_NOC1_REQTYPE_ST_UPGRADE_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_ST_UPGRADE_REQUEST";
        `L15_NOC1_REQTYPE_ST_FILL_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_ST_FILL_REQUEST";
        `L15_NOC1_REQTYPE_CAS_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_CAS_REQUEST";
        `L15_NOC1_REQTYPE_SWAP_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_SWAP_REQUEST";
        `L15_NOC1_REQTYPE_INTERRUPT_FWD:
            noc1 = "L15_NOC1_REQTYPE_INTERRUPT_FWD";
        `L15_NOC1_REQTYPE_AMO_ADD_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_ADD_REQUEST";
        `L15_NOC1_REQTYPE_AMO_AND_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_AND_REQUEST";
        `L15_NOC1_REQTYPE_AMO_OR_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_OR_REQUEST";
        `L15_NOC1_REQTYPE_AMO_XOR_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_XOR_REQUEST";
        `L15_NOC1_REQTYPE_AMO_MAX_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_MAX_REQUEST";
        `L15_NOC1_REQTYPE_AMO_MAXU_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_MAXU_REQUEST";
        `L15_NOC1_REQTYPE_AMO_MIN_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_MIN_REQUEST";
        `L15_NOC1_REQTYPE_AMO_MINU_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_MINU_REQUEST";
        default:
            noc1 = "ERROR noc1";
        endcase

        $write("%0d TILE7 L1.5: Sending NOC1 %s", $time, noc1);
        $display("   mshrid %d, nc %d, size %d, pf %d, address %0x",
                    `L15_TOP7.noc1encoder.noc1buffer_noc1encoder_req_mshrid, `L15_TOP7.noc1encoder.noc1buffer_noc1encoder_req_non_cacheable,
                    `L15_TOP7.noc1encoder.noc1buffer_noc1encoder_req_size, `L15_TOP7.noc1encoder.noc1buffer_noc1encoder_req_prefetch, `L15_TOP7.noc1encoder.noc1buffer_noc1encoder_req_address);
        $display("   Data0: 0x%x", `L15_TOP7.noc1encoder.noc1buffer_noc1encoder_req_data_0);
        $display("   Data1: 0x%x", `L15_TOP7.noc1encoder.noc1buffer_noc1encoder_req_data_1);
        $display("   Destination X: %d Y: %d", `L15_TOP7.noc1encoder.msg_dest_l2_xpos, `L15_TOP7.noc1encoder.msg_dest_l2_ypos);
    end

    if (`L15_TOP7.noc3encoder.noc3encoder_noc3out_val && `L15_TOP7.noc3encoder.noc3encoder_l15_req_ack)
    begin
        noc3 = 0;
        case(`L15_TOP7.noc3encoder.l15_noc3encoder_req_type)
        `L15_NOC3_REQTYPE_WRITEBACK:
            noc3 = "L15_NOC3_REQTYPE_WRITEBACK";
        `L15_NOC3_REQTYPE_INVAL_ACK:
            noc3 = "L15_NOC3_REQTYPE_INVAL_ACK";
        `L15_NOC3_REQTYPE_DOWNGRADE_ACK:
            noc3 = "L15_NOC3_REQTYPE_DOWNGRADE_ACK";
        `L15_NOC3_REQTYPE_ICACHE_INVAL_ACK:
            noc3 = "L15_NOC3_REQTYPE_ICACHE_INVAL_ACK";
        default:
            noc3 = "ERROR NOC3";
        endcase

        // quick check for an error case
        if (`L15_TOP7.noc3encoder.msg_type == `MSG_TYPE_INV_FWDACK
            && `L15_TOP7.noc3encoder.l15_noc3encoder_req_with_data)
        begin
            $display("L1.5 MON: sending back invalid ack with data");
            $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: sending back invalid ack with data");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("L1.5 MON: sending back invalid ack with data");
        end


        $write("%0d TILE7 L1.5: Sent NOC3 %s", $time, noc3);
        $display("   mshrid %d, seqid %d, address %0x",
                    `L15_TOP7.noc3encoder.l15_noc3encoder_req_mshrid, `L15_TOP7.noc3encoder.l15_noc3encoder_req_sequenceid, `L15_TOP7.noc3encoder.l15_noc3encoder_req_address);
        $display("   srcX: %d, srcY: %d", `L15_TOP7.noc3encoder.src_l2_xpos, `L15_TOP7.noc3encoder.src_l2_ypos);
        $display("   destX: %d, destY: %d", `L15_TOP7.noc3encoder.dest_l2_xpos, `L15_TOP7.noc3encoder.dest_l2_ypos);
        $display("   Data0: 0x%x", `L15_TOP7.noc3encoder.l15_noc3encoder_req_data_0);
        $display("   Data1: 0x%x", `L15_TOP7.noc3encoder.l15_noc3encoder_req_data_1);
    end

    do_print_stage_TILE7 = ((`L15_PIPE7.val_s1 && !`L15_PIPE7.stall_s1) || (`L15_PIPE7.val_s2 && !`L15_PIPE7.stall_s2) || (`L15_PIPE7.val_s3 && !`L15_PIPE7.stall_s3));
    if (do_print_stage_TILE7)
    begin
        // $display("");
        $display("");
        $display($time, " L15 TILE7:");
        $display("NoC1 credit: %d", `L15_PIPE7.creditman_noc1_avail);
        $display("NoC1 reserved credit: %d", `L15_PIPE7.creditman_noc1_reserve);
        // $display("NoC1 r down: %d", `L15_PIPE7.creditman_noc1_reserve_minus1);
        // $display("NoC1 r up: %d", `L15_PIPE7.creditman_noc1_reserve_add1);

        // monitor the MSHRID allocation
        // $display("MSHRID allocation info:");
        // for (i_TILE7 = 0; i_TILE7 < `L15_MSHR_COUNT; i_TILE7 = i_TILE7 + 1)
        //     $write("%d:%d", i_TILE7, `L15_PIPE7.mshr_val_array[i_TILE7]);
            // $write("%d %d", i_TILE7, i_TILE7);
        // $display("");

`ifdef RTL_SPARC7
        $display("Core STB info:");
        $display("  STB0: %d", `SPARC_CORE7.sparc0.ifu.lsu_ifu_stbcnt0);
        $display("  STB1: %d", `SPARC_CORE7.sparc0.ifu.lsu_ifu_stbcnt1);
            // $write("%d %d", i_TILE7, i_TILE7);
`endif

        $write("TILE7 Pipeline:");
        if (`L15_PIPE7.val_s1 && !`L15_PIPE7.stall_s1)
            $write(" * ");
        else if (`L15_PIPE7.val_s1 && `L15_PIPE7.stall_s1)
            $write(" = ");
        else
            $write(" X ");

        if (`L15_PIPE7.val_s2 && !`L15_PIPE7.stall_s2)
            $write(" * ");
        else if (`L15_PIPE7.val_s2 && `L15_PIPE7.stall_s2)
            $write(" = ");
        else
            $write(" X ");

        if (`L15_PIPE7.val_s3 && !`L15_PIPE7.stall_s3)
            $write(" * ");
        else if (`L15_PIPE7.val_s3 && `L15_PIPE7.stall_s3)
            $write(" = ");
        else
            $write(" X ");
        $display("");

        // $write("PCX pipe info: "); decode_pcx_op(`L15_PIPE7.pcxdecoder_l15_rqtype, L15_PIPE7.pcxdecoder_l15_amo_op);
        // if (`L15_PIPE7.noc1_req_val_s3 && `L15_PIPE7.noc1encoder_req_staled_s3)
        //     $display(" (staled)");
        // else if (!`L15_PIPE7.noc1_req_val_s3)
        //     $display(" (invalid)");
        // else if (`L15_PIPE7.noc1_req_val_s3 && !`L15_PIPE7.noc1encoder_req_staled_s3)
        // begin
        //     $display(" (fresh)");
        // end

        // $write("NoC1 pipe info: ");
        // if (`L15_PIPE7.noc1_req_val_s3 && `L15_PIPE7.noc1encoder_req_staled_s3)
        //     $display("staled");
        // else if (!`L15_PIPE7.noc1_req_val_s3)
        //     $display("invalid");
        // else if (`L15_PIPE7.noc1_req_val_s3 && !`L15_PIPE7.noc1encoder_req_staled_s3)
        // begin
        //     $display("fresh");
        // end

        // $write("NoC3 pipe info: ");
        // if (`L15_PIPE7.noc3_req_val_s3 && `L15_PIPE7.noc3encoder_req_staled_s3)
        //     $display("staled");
        // else if (!`L15_PIPE7.noc3_req_val_s3)
        //     $display("invalid");
        // else if (`L15_PIPE7.noc3_req_val_s3 && !`L15_PIPE7.noc3encoder_req_staled_s3)
        // begin
        //     $display("fresh");
        // end

        // $write("CPX pipe info: ");
        // if (`L15_PIPE7.cpx_req_val_s3 && `L15_PIPE7.cpxencoder_req_staled_s3)
        //     $display("staled");
        // else if (!`L15_PIPE7.cpx_req_val_s3)
        //     $display("invalid");
        // else if (`L15_PIPE7.cpx_req_val_s3 && !`L15_PIPE7.cpxencoder_req_staled_s3)
        // begin
        //     $display("fresh");
        // end

            // Stage 1 debug information
        if (`L15_PIPE7.stall_s1 === 1'bx)
            $display("S1 stall is XXXXXXX");
        if (`L15_PIPE7.val_s1 && !`L15_PIPE7.stall_s1)
        begin
            $write("Stage 1 status: ");
            $write("   Operation: "); decode_predecode_reqtype(`L15_PIPE7.predecode_reqtype_s1);
            $display("   TILE7 S1 Address: 0x%x", `L15_PIPE7.predecode_address_s1);
            // if (`L15_PIPE7.decoder_dtag_operation_s1 == `L15_DTAG_OP_READ)
            // begin
            //     $display("   DTAG OP: L15_DTAG_OP_READ");
            //     $display("      Index: 0x%x", `L15_PIPE7.dtag_index);
            // end
            // if (`L15_PIPE7.l15_dtag_rw_s1 == `L15_DTAG_RW_WRITE)
            // begin
            //     $display("   DTAG OP: L15_DTAG_OP_WRITE");
            //     $display("      Data:  0x%x", `L15_PIPE7.dtag_write_tag_s1);
            //     $display("      Way:  0x%x", `L15_PIPE7.dtag_write_way_s1);
            //     // $display("      Mask: 0x%x", `L15_PIPE7.dtag_write_mask);
            // end
            // if (`L15_PIPE7.s1_mshr_write_val_s1)
            // begin
            //     $display("   DTAG OP: ");
            //     if (`L15_PIPE7.s1_mshr_write_type_s1 == `L15_MSHR_WRITE_TYPE_ALLOCATION)
            //     begin
            //         $write ("L15_MSHR_WRITE_TYPE_ALLOCATION");
            //         $display ("      MSRID: %d", `L15_PIPE7.s1_mshr_write_mshrid_s1);
            //     end
            //     else if (`L15_PIPE7.s1_mshr_write_type_s1 == `L15_S1_MSHR_OP_UPDATE_WRITECACHE)
            //     begin
            //         $write ("L15_S1_MSHR_OP_UPDATE_WRITECACHE");
            //         $display ("      MSRID:     %d", `L15_PIPE7.s1_mshr_write_mshrid_s1);
            //         $display ("      DATA:      0x%x", `L15_PIPE7.s1_mshr_write_data);
            //         $display ("      DATAMASK:  0x%x", `L15_PIPE7.s1_mshr_write_byte_mask);
            //     end
            // end
        end
        // Stage 2 debug information
        if (`L15_PIPE7.stall_s2 === 1'bx)
            $display("S2 stall is XXXXXXX");
        if (`L15_PIPE7.val_s2 && !`L15_PIPE7.stall_s2)
        begin
        $write("Stage 2 status: ");
            $write("   Operation: "); decode_predecode_reqtype(`L15_PIPE7.predecode_reqtype_s2);
            $display("   TILE7 S2 Address: 0x%x", `L15_PIPE7.address_s2);
            $display("   TILE7 S2 Cache index: %d", `L15_PIPE7.cache_index_s2);

            if (`L15_PIPE7.csm_req_val_s2)
            begin
                $display("   CSM op: %d", `L15_PIPE7.csm_op_s2);
                if (`L15_PIPE7.l15_csm_req_type_s2 == 1'b0)
                    $display("      CSM read ticket: 0x%x", `L15_PIPE7.l15_csm_req_ticket_s2);
                else
                begin
                    $display("      CSM write ticket: 0x%x", `L15_PIPE7.l15_csm_req_ticket_s2);
                    $display("      CSM write data: 0x%x", `L15_PIPE7.l15_csm_req_data_s2);
                end
            end

            // $display("   Source chipid: %d", `L15_PIPE7.noc2_src_homeid_s2[`PACKET_HOME_ID_CHIP_MASK]);
            // $display("   Source X: %d", `L15_PIPE7.noc2_src_homeid_s2[`PACKET_HOME_ID_X_MASK]);
            // $display("   Source Y: %d", `L15_PIPE7.noc2_src_homeid_s2[`PACKET_HOME_ID_Y_MASK]);
            // `ifdef L15_EXTRA_DEBUG
            // $display("   LRU state: %d", `L15_PIPE7.lru_state_s2);
            // $display("   LRU way: %d", `L15_PIPE7.lru_way_s2);
            // $display("   Tagcheck state: %d", `L15_PIPE7.tagcheck_state_s2);
            // $display("   Tagcheck way: %d", `L15_PIPE7.tagcheck_way_s2);

            if (`L15_PIPE7.decoder_dtag_operation_s2 == `L15_DTAG_OP_READ)
            begin
                $display("   DTAG way0 state: 0x%x", `L15_PIPE7.mesi_state_way0_s2);
                $display("   DTAG way0 data: 0x%x", dtag_tag_way0_s2_TILE7);
                $display("   DTAG way1 state: 0x%x", `L15_PIPE7.mesi_state_way1_s2);
                $display("   DTAG way1 data: 0x%x", dtag_tag_way1_s2_TILE7);
                $display("   DTAG way2 state: 0x%x", `L15_PIPE7.mesi_state_way2_s2);
                $display("   DTAG way2 data: 0x%x", dtag_tag_way2_s2_TILE7);
                $display("   DTAG way3 state: 0x%x", `L15_PIPE7.mesi_state_way3_s2);
                $display("   DTAG way3 data: 0x%x", dtag_tag_way3_s2_TILE7);
            end

            if (`L15_PIPE7.l15_mesi_write_val_s2)
            begin
                $display("   MESI write way: 0x%x", `L15_PIPE7.mesi_write_way_s2);
                $display("   MESI write data: 0x%x", `L15_PIPE7.mesi_write_state_s2);
            end

            // if (`L15_PIPE7.lruarray_write_op_s2 == `L15_LRU_EVICTION)
            // begin
            //     $display("   LRU EVICTION INDEX: %d, WAY: %d", `L15_PIPE7.cache_index_s2,
            //         `L15_PIPE7.lru_way_s2[1:0]);
            // end
            // `endif

            // if (`L15_PIPE7.s2_mesi_operation_s2 == `L15_S2_MESI_READ)
            // begin
            //     $display("   MESI OP: L15_S2_MESI_READ");
            //     $display ("      Index:     %d", `L15_PIPE7.s2_mesi_index_s2);
            // end
            // if (`L15_PIPE7.s2_mshr_val_s2)
            // begin
            //     $display("   MSHR OP: L15_S2_MSHR_OP_READ_WRITE_CACHE");
            //     $display ("      MSHR: %d", `L15_PIPE7.s2_mshr_read_mshrid);
            // end
            if (`L15_PIPE7.dcache_val_s2)
            begin
                // $write("   DCACHE OP: "); decode_dcache_op(`L15_PIPE7.dcache_operation_s2);
                // $display ("      RW:     %d", `L15_PIPE7.dcache_rw);
                // $display ("      Index:      0x%x", `L15_PIPE7.dcache_index);
                // $display ("      Data:  0x%x", `L15_PIPE7.dcache_write_data);
                // $display ("      Data mask:  0x%x", `L15_PIPE7.dcache_write_mask);
                if (`L15_PIPE7.l15_dcache_rw_s2 == 1'b0)
                begin
                    `ifndef NO_RTL_CSM
                    $display("HMT writing: %0b", `L15_PIPE7.l15_hmt_write_data_s2);
                    `endif
                    // TODO
                    // $display("HMT chip: %0b", `L15_PIPE7.wmt_fill_homeid_s2[`PACKET_HOME_ID_CHIP_MASK]);
                    // $display("HMT X: %0b", `L15_PIPE7.wmt_fill_homeid_s2[`PACKET_HOME_ID_X_MASK]);
                    // $display("HMT Y: %0b", `L15_PIPE7.wmt_fill_homeid_s2[`PACKET_HOME_ID_Y_MASK]);
                end
            end
        end

        // Stage 3 debug information
        if (`L15_PIPE7.stall_s3 === 1'bx)
            $display("S3 stall is XXXXXXX");
        if (`L15_PIPE7.val_s3 && !`L15_PIPE7.stall_s3)
        begin
            $write("Stage 3 status: ");
            $write("   Operation: "); decode_predecode_reqtype(`L15_PIPE7.predecode_reqtype_s3);
            $display("   TILE7 S3 Address: 0x%x", `L15_PIPE7.address_s3);
            `ifndef NO_RTL_CSM
            if ((`L15_PIPE7.noc1_homeid_source_s3 == `L15_HOMEID_SRC_HMT && `L15_PIPE7.noc1_req_val_s3)
                || (`L15_PIPE7.noc3_homeid_source_s3 == `L15_HOMEID_SRC_HMT && `L15_PIPE7.noc3_req_val_s3))
            begin
                `ifndef NO_RTL_CSM
                $display("   HMT chipid: %d", `L15_PIPE7.hmt_l15_dout_s3[`L15_CSM_GHID_CHIP_MASK]);
                $display("   HMT X: %d", `L15_PIPE7.hmt_l15_dout_s3[`L15_CSM_GHID_XPOS_MASK]);
                $display("   HMT Y: %d", `L15_PIPE7.hmt_l15_dout_s3[`L15_CSM_GHID_YPOS_MASK]);
                $display("   HMT reading: %0b", `L15_PIPE7.hmt_l15_dout_s3);
                `endif
            end
            `endif
            if (`L15_PIPE7.noc3_homeid_source_s3 == `L15_HOMEID_SRC_NOC2_SOURCE && `L15_PIPE7.noc3_req_val_s3)
            begin
                $display("   Source chipid: %d", `L15_PIPE7.noc2_src_homeid_s3[`PACKET_HOME_ID_CHIP_MASK]);
                $display("   Source X: %d", `L15_PIPE7.noc2_src_homeid_s3[`PACKET_HOME_ID_X_MASK]);
                $display("   Source Y: %d", `L15_PIPE7.noc2_src_homeid_s3[`PACKET_HOME_ID_Y_MASK]);
            end

            if (`L15_PIPE7.cpx_data_source_s3 == `L15_CPX_SOURCE_CSM)
                $display("      CSM read data: 0x%x", `L15_PIPE7.csm_l15_res_data_s3);
            // `ifdef L15_EXTRA_DEBUG
            // $display("   LRU state: %d", `L15_PIPE7.lru_state_s3);
            // $display("   LRU way: %d", `L15_PIPE7.lru_way_s3);
            // $display("   Tagcheck state: %d", `L15_PIPE7.tagcheck_state_s3);
            // $display("   Tagcheck way: %d", `L15_PIPE7.tagcheck_way_s3);
            // `endif

            // if (`L15_PIPE7.s3_mesi_val_s3)
            // begin
            //     $write("   MESI OP: "); decode_s3mesi_op(`L15_PIPE7.s3_mesi_operation_s3);
            //     $display ("      Index:      0x%x", `L15_PIPE7.mesi_write_index);
            //     $display ("      Data:  0x%x", `L15_PIPE7.mesi_write_data);
            //     $display ("      Data mask:  0x%x", `L15_PIPE7.mesi_write_mask);
            // end
            // if (`L15_PIPE7.wmc_val_s3)
            // begin
            //     $write("   WMC OP: "); decode_wmc_op(`L15_PIPE7.wmc_operation_s3);
            //     if (`L15_PIPE7.wmc_rw_s3 == `L15_WMC_OP_READ)
            //     begin
            //         $display ("      wmc_index_s3:      0x%x", `L15_PIPE7.wmc_index_s3);
            //         $display ("      wmc_invalidate_val_s3:      0x%x", `L15_PIPE7.wmc_invalidate_val_s3);
            //         $display ("      wmc_invalidate_way_s3:      0x%x", `L15_PIPE7.wmc_invalidate_way_s3);
            //     end
            //     else if (`L15_PIPE7.wmc_rw_s3 == `L15_WMC_OP_WRITE)
            //     begin
            //         $display ("      wmc_index_s3:      0x%x", `L15_PIPE7.wmc_index_s3);
            //         $display ("      wmc_update_way_s3:      0x%x", `L15_PIPE7.wmc_update_way_s3);
            //         $display ("      wmc_update_data_s3:      0x%x", `L15_PIPE7.wmc_update_data_s3);
            //         $display ("      wmc_invalidate_val_s3:      0x%x", `L15_PIPE7.wmc_invalidate_val_s3);
            //         $display ("      wmc_invalidate_way_s3:      0x%x", `L15_PIPE7.wmc_invalidate_way_s3);
            //     end
            //     $display ("      cpx_inval_way_s3:      0x%x", `L15_PIPE7.cpx_inval_way_s3);
            //     $display ("      wmc_read_way0_data_s3:      0x%x", `L15_PIPE7.wmc_read_way0_data_s3);
            //     $display ("      wmc_read_way1_data_s3:      0x%x", `L15_PIPE7.wmc_read_way1_data_s3);
            //     $display ("      wmc_read_way2_data_s3:      0x%x", `L15_PIPE7.wmc_read_way2_data_s3);
            //     $display ("      wmc_read_way3_data_s3:      0x%x", `L15_PIPE7.wmc_read_way3_data_s3);
            // end
            // if (`L15_PIPE7.s3_mshr_val_s3)
            // begin
            //     $write("   MSHR OP: "); decode_s3mshr_op(`L15_PIPE7.s3_mshr_operation_s3);
            //     $display ("      MSHR:      %d", `L15_PIPE7.s3_mshr_write_mshrid);
            //     $display ("      U.State:      0x%x", `L15_PIPE7.s3_mshr_write_update_state);
            //     $display ("      U.Way:  0x%x", `L15_PIPE7.s3_mshr_write_update_way);
            //     $display ("      St.mshr rand hit:   %d", `L15_PIPE7.LRU_st1_mshr_s3 || `L15_PIPE7.LRU_st2_mshr_s3);
            //     $display ("      St.mshr tag hit:   %d", `L15_PIPE7.tagcheck_st1_mshr_s3 || `L15_PIPE7.tagcheck_st2_mshr_s3);
            // end
            if (wmt_read_val_s3_TILE7)
            begin
                $display("   TILE7 WMT read index: %x", `L15_PIPE7.cache_index_l1d_s3[`L1D_SET_IDX_MASK]);
                // $display("   WMT way0: %x 0x%x", `L15_PIPE7.wmt_data_s3[0][`L15_WMT_VALID_MASK], `L15_PIPE7.wmt_data_s3[0][`L15_WMT_DATA_MASK]);
                // $display("   WMT way1: %x 0x%x", `L15_PIPE7.wmt_data_s3[1][`L15_WMT_VALID_MASK], `L15_PIPE7.wmt_data_s3[1][`L15_WMT_DATA_MASK]);
                // $display("   WMT way2: %x 0x%x", `L15_PIPE7.wmt_data_s3[2][`L15_WMT_VALID_MASK], `L15_PIPE7.wmt_data_s3[2][`L15_WMT_DATA_MASK]);
                // $display("   WMT way3: %x 0x%x", `L15_PIPE7.wmt_data_s3[3][`L15_WMT_VALID_MASK], `L15_PIPE7.wmt_data_s3[3][`L15_WMT_DATA_MASK]);
                for (i = 0; i < `L1D_WAY_COUNT; i = i + 1)
                begin
                    $display("   WMT way%d: %x 0x%x", i, `L15_PIPE7.wmt_data_s3[i][`L15_WMT_VALID_MASK], `L15_PIPE7.wmt_data_s3[i][`L15_WMT_DATA_MASK]);
                end
            end
            if (`L15_PIPE7.l15_wmt_write_val_s3)
            begin
                $display("   TILE7 WMT write index: %x", `L15_PIPE7.cache_index_l1d_s3[`L1D_SET_IDX_MASK]);
                // $display("   WMT write mask: %x", `L15_PIPE7.l15_wmt_write_mask_s3);
                // $display("   WMT write data: %x", `L15_PIPE7.l15_wmt_write_data_s3);
                // $display("   WMT way0 m%x d0x%x", `L15_PIPE7.l15_wmt_write_mask_s3[`L15_WMT_ENTRY_0_MASK], `L15_PIPE7.wmt_write_data_s3[`L15_WMT_ENTRY_0_MASK]);
                // $display("   WMT way1 m%x d0x%x", `L15_PIPE7.l15_wmt_write_mask_s3[`L15_WMT_ENTRY_1_MASK], `L15_PIPE7.wmt_write_data_s3[`L15_WMT_ENTRY_1_MASK]);
                // $display("   WMT way2 m%x d0x%x", `L15_PIPE7.l15_wmt_write_mask_s3[`L15_WMT_ENTRY_2_MASK], `L15_PIPE7.wmt_write_data_s3[`L15_WMT_ENTRY_2_MASK]);
                // $display("   WMT way3 m%x d0x%x", `L15_PIPE7.l15_wmt_write_mask_s3[`L15_WMT_ENTRY_3_MASK], `L15_PIPE7.wmt_write_data_s3[`L15_WMT_ENTRY_3_MASK]);
            end
        end
        $display ("L15_MON_END");
        $display ("");
    end

//CSM monitor
    if(`L15_TOP7.l15_csm.l15_csm_req_val_s2)
    begin
        $display($time, ": TILE7 L15_CSM REQ MON:");
        $display("L15 CSM req addr: 0x%x", `L15_TOP7.l15_csm.l15_csm_req_address_s2);
        $display("L15 CSM req ticket: %d", `L15_TOP7.l15_csm.l15_csm_req_ticket_s2);
        $display("L15 CSM req type: %d", `L15_TOP7.l15_csm.l15_csm_req_type_s2);
        $display("L15 CSM req data: 0x%x", `L15_TOP7.l15_csm.l15_csm_req_data_s2);
        $display("L15 CSM req pcx data: 0x%x", `L15_TOP7.l15_csm.l15_csm_req_pcx_data_s2);
    end
    if(`L15_TOP7.l15_csm.csm_l15_res_val_s3)
    begin
        $display($time, ": TILE7 L15_CSM RES MON:");
        $display("L15 CSM res data: 0x%x", `L15_TOP7.l15_csm.csm_l15_res_data_s3);
    end
    if(`L15_TOP7.l15_csm.csm_l15_read_res_val)
    begin
        $display($time, ": TILE7 L15_CSM READ TICKET MON:");
        $display("L15 CSM read ticket: %d", `L15_TOP7.l15_csm.l15_csm_read_ticket);
        $display("L15 CSM read data: 0x%x", `L15_TOP7.l15_csm.csm_l15_read_res_data);
    end
    if(`L15_TOP7.l15_csm.csm_noc1encoder_req_val)
    begin
        $display($time, ": TILE7 L15_CSM NOC1 REQ MON:");
        $display("L15 CSM noc1 req addr: 0x%x", `L15_TOP7.l15_csm.csm_noc1encoder_req_address);
        $display("L15 CSM noc1 req type: %d", `L15_TOP7.l15_csm.csm_noc1encoder_req_type);
        $display("L15 CSM noc1 req mshrid: %d", `L15_TOP7.l15_csm.csm_noc1encoder_req_mshrid);
    end
    if(`L15_TOP7.l15_csm.noc1encoder_csm_req_ack)
    begin
        $display($time, ": TILE7 L15_CSM NOC1 REQ ACK MON:");
        $display("L15 CSM noc1 req ack: %b", `L15_TOP7.l15_csm.noc1encoder_csm_req_ack);
    end

    if(`L15_TOP7.l15_csm.write_val_s2 && (~`L15_TOP7.l15_csm.ghid_val_s2))
    begin
        $display("L1.5 MON: HMC refills invalid data");
        $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: HMC refills invalid data");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("L1.5 MON: HMC refills invalid data");
    end

// valid mshrid monitor
    // check for incoming messages
    if (`L15_PIPE7.noc2decoder_l15_val && `L15_PIPE7.val_s1 && !`L15_PIPE7.stall_s1)
    begin
        is_csm_mshrid_TILE7 = `L15_PIPE7.noc2decoder_l15_hmc_fill;
        if ((`L15_PIPE7.noc2decoder_l15_reqtype == `MSG_TYPE_NODATA_ACK ||
            `L15_PIPE7.noc2decoder_l15_reqtype == `MSG_TYPE_DATA_ACK)
            && !is_csm_mshrid_TILE7)
        begin
            // first check if mshrid is in range
            if (`L15_PIPE7.noc2decoder_l15_mshrid > 9)
            begin
                $display("L1.5 MON: Received NoC2 message with MSHRID greater than 9 (%d)", `L15_PIPE7.noc2decoder_l15_mshrid);
                $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: Received NoC2 message with MSHRID greater than 9");
                `ifndef VERILATOR
                repeat(5)@(posedge clk)
                `endif
                    `MONITOR_PATH.fail("L1.5 MON: Received NoC2 message with MSHRID greater than 9");
            end

            // now check if it's valid
            // TODO
            // if (`L15_TOP7.mshr.val_array[`L15_PIPE7.noc2decoder_l15_mshrid] != 1'b1)
            // begin
            //     $display("L1.5 MON: Received NoC2 message with invalid MSHRID (%d)", `L15_PIPE7.noc2decoder_l15_mshrid);
            //     $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: Received NoC2 message with invalid MSHRID");
            //     `ifndef VERILATOR
            //     repeat(5)@(posedge clk)
            //     `endif
                //     `MONITOR_PATH.fail("L1.5 MON: Received NoC2 message with invalid MSHRID");
            // end
        end
    end
    // if (`L15_PIPE7.l15_noc1buffer_req_val && !`L15_PIPE7.stall_s3)
    // begin
    //     if (`L15_PIPE7.l15_noc1buffer_req_type != `L15_NOC1_REQTYPE_WRITEBACK_GUARD
    //         && `L15_PIPE7.l15_noc1buffer_req_type != `L15_NOC1_REQTYPE_INTERRUPT_FWD)
    //     begin
    //         if (`L15_TOP7.mshr.val_array[`L15_PIPE7.l15_noc1buffer_req_mshrid] != 1'b1
    //             || `L15_PIPE7.l15_noc1buffer_req_mshrid > 9)
    //         begin
    //             $display("L1.5 MON: Sending NoC1 message with invalid MSHRID (%d)", `L15_PIPE7.l15_noc1buffer_req_mshrid);
    //             $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: Sending NoC1 message with invalid MSHRID");
    //             `ifndef VERILATOR
    //             repeat(5)@(posedge clk)
    //             `endif
        //             `MONITOR_PATH.fail("L1.5 MON: Sending NoC1 message with invalid MSHRID");
    //         end
    //     end
    // end

// monitor PCX buffer full compare to t1 internal buffer mon
`ifdef RTL_SPARC7
`ifndef RTL_SPU
    if ((`CCX_TRANSDUCER7.pcx_buffer.is_req_squashed == 1'b1) && (`SPARC_CORE7.sparc0.lsu.lsu.qctl1.pcx_req_squash == 1'b0))
`else
    if ((`CCX_TRANSDUCER7.pcx_buffer.is_req_squashed == 1'b1) && (`SPARC_CORE7.sparc0.lsu.qctl1.pcx_req_squash == 1'b0))
`endif
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "PCXTILE7 req was valid but squashed in L1.5");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("PCXTILE7 req was valid but squashed in L1.5");
    end
`ifndef RTL_SPU
    if ((`CCX_TRANSDUCER7.pcx_buffer.is_req_squashed == 1'b0) && (`SPARC_CORE7.sparc0.lsu.lsu.qctl1.pcx_req_squash == 1'b1))
`else
    if ((`CCX_TRANSDUCER7.pcx_buffer.is_req_squashed == 1'b0) && (`SPARC_CORE7.sparc0.lsu.qctl1.pcx_req_squash == 1'b1))
`endif
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "PCXTILE7 req was squashed but valid at L1.5");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("PCXTILE7 req was squashed but valid at L1.5");
    end

    // check for squashed atomic
    if ((`CCX_TRANSDUCER7.pcx_buffer.is_req_squashed == 1'b1) && (`CCX_TRANSDUCER7.pcx_buffer.spc_uncore_atomic_req == 1'b1))
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "PCXTILE7 atomic req squashed");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("PCXTILE7 atomic req squashed");
    end
`endif

// monitor FP transactions because it is not supported yet
//     if (`L15_PIPE7.pcxdecoder_l15_val && !`L15_PIPE7.pcx_message_staled_s1 && `L15_PIPE7.val_s1 && !`L15_PIPE7.stall_s1 && !`L15_PIPE7.noc2decoder_l15_val)
//     begin
//         if (`L15_PIPE7.pcxdecoder_l15_rqtype == `PCX_REQTYPE_FP1)
//         begin
//             $display("%d : Simulation -> FAIL(%0s)", $time, "FP requests received but not implemented");
//             `ifndef VERILATOR
//             repeat(5)@(posedge clk)
//             `endif
    //             `MONITOR_PATH.fail("FP requests received but not implemented");
//         end
//     end

// monitor INT_VEC_DIS requests
    if (`L15_PIPE7.pcxdecoder_l15_val && `L15_PIPE7.val_s1 && !`L15_PIPE7.stall_s1 && !`L15_PIPE7.noc2decoder_l15_val)
    begin
        if (`L15_PIPE7.pcxdecoder_l15_rqtype == `PCX_REQTYPE_STORE
            && `L15_PIPE7.pcxdecoder_l15_address == 40'h9800000800)
        begin
            $display("%d : PCX write to INT_VEC_DIS", $time);
            // $display("%d : Simulation -> FAIL(%0s)", $time, "Write to INT_VEC_DIS");
            // `ifndef VERILATOR
            // repeat(5)@(posedge clk)
            // `endif
                // `MONITOR_PATH.fail("Write to INT_VEC_DIS");
        end
    end

// monitor noc1 buffer credit for underflow
    if (`L15_PIPE7.creditman_noc1_avail == 4'd15)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE7 NOC1 credit underflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE7 NOC1 credit underflow");
    end
    if (`L15_PIPE7.creditman_noc1_avail > `NOC1_BUFFER_NUM_SLOTS)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE7 NOC1 credit overflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE7 NOC1 credit overflow");
    end
    if (`L15_PIPE7.creditman_noc1_data_avail == 4'd15)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE7 NOC1 data credit underflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE7 NOC1 data credit underflow");
    end
    if (`L15_PIPE7.creditman_noc1_data_avail > `NOC1_BUFFER_NUM_DATA_SLOTS)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE7 NOC1 data credit overflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE7 NOC1 data credit overflow");
    end

    // check noc1 reserve credit
    if (`L15_PIPE7.creditman_noc1_reserve == 4'd15)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE7 NOC1 reserve credit underflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE7 NOC1 reserve credit underflow");
    end
    if (`L15_PIPE7.creditman_noc1_reserve > `NOC1_BUFFER_NUM_SLOTS)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE7 NOC1 reserve credit overflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE7 NOC1 reserve credit overflow");
    end
    // check reserve logics
    // if (`L15_PIPE7.creditman_noc1_reserve_s3)
    // begin
    //     $display("%d : Simulation -> FAIL(%0s)", $time, "TILE7 NOC1 reserve credit underflow");
    //     `ifndef VERILATOR
    //     repeat(5)@(posedge clk)
    //     `endif
        //     `MONITOR_PATH.fail("TILE7 NOC1 reserve credit underflow");
    // end

// Monitor for "RESERVED" messages
    if (`L15_PIPE7.noc2decoder_l15_val && `L15_PIPE7.val_s1 && !`L15_PIPE7.stall_s1)
    begin
        if (`L15_PIPE7.noc2decoder_l15_reqtype == `MSG_TYPE_RESERVED)
        begin
            $display("%d : Simulation -> FAIL(%0s)", $time, "TILE7 L15 received MSG_TYPE_RESERVED");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("TILE7 L15 received MSG_TYPE_RESERVED");
        end
    end

// Monitor WMT duplicate error
    if (`L15_PIPE7.val_s3)
    begin
        {wmt_read_data_TILE7[3], wmt_read_data_TILE7[2], wmt_read_data_TILE7[1], wmt_read_data_TILE7[0]} = `L15_PIPE7.wmt_l15_data_s3;
        for (i_TILE7 = 0; i_TILE7 < 4; i_TILE7 = i_TILE7+1)
        begin
            for (j_TILE7 = 0; j_TILE7 < i_TILE7; j_TILE7 = j_TILE7 + 1)
            begin
                if ((wmt_read_data_TILE7[i_TILE7][`L15_WMT_VALID_MASK] && wmt_read_data_TILE7[j_TILE7][`L15_WMT_VALID_MASK]) && (wmt_read_data_TILE7[i_TILE7] == wmt_read_data_TILE7[j_TILE7]))
                begin
                    $display("%d : Simulation -> FAIL(%0s)", $time, "TILE7 L15 has error with WMT");
                    `ifndef VERILATOR
                    repeat(5)@(posedge clk)
                    `endif
                        `MONITOR_PATH.fail("TILE7 L15 has error with WMT");
                end
            end
        end
    end

// Monitor tags duplication error (bug #86)
    if (`L15_PIPE7.val_s2 && `L15_PIPE7.decoder_dtag_operation_s2 == `L15_DTAG_OP_READ)
    begin
        tag_data_TILE7[0] = `L15_PIPE7.dtag_tag_way0_s2[`L15_CACHE_TAG_WIDTH-1:0];
        tag_data_TILE7[1] = `L15_PIPE7.dtag_tag_way1_s2[`L15_CACHE_TAG_WIDTH-1:0];
        tag_data_TILE7[2] = `L15_PIPE7.dtag_tag_way2_s2[`L15_CACHE_TAG_WIDTH-1:0];
        tag_data_TILE7[3] = `L15_PIPE7.dtag_tag_way3_s2[`L15_CACHE_TAG_WIDTH-1:0];
        tag_val_TILE7[0] = `L15_PIPE7.mesi_state_way0_s2 != `L15_MESI_STATE_I;
        tag_val_TILE7[1] = `L15_PIPE7.mesi_state_way1_s2 != `L15_MESI_STATE_I;
        tag_val_TILE7[2] = `L15_PIPE7.mesi_state_way2_s2 != `L15_MESI_STATE_I;
        tag_val_TILE7[3] = `L15_PIPE7.mesi_state_way3_s2 != `L15_MESI_STATE_I;
        for (i_TILE7 = 0; i_TILE7 < 4; i_TILE7 = i_TILE7+1)
        begin
            for (j_TILE7 = 0; j_TILE7 < i_TILE7; j_TILE7 = j_TILE7 + 1)
            begin
                if ((tag_val_TILE7[i_TILE7] && tag_val_TILE7[j_TILE7]) && (tag_data_TILE7[i_TILE7] == tag_data_TILE7[j_TILE7]))
                begin
                    $display("%d : Simulation -> FAIL(%0s)", $time, "TILE7 L15 has duplicated tag entry");
                    `ifndef VERILATOR
                    repeat(5)@(posedge clk)
                    `endif
                        `MONITOR_PATH.fail("TILE7 L15 has duplicated tag entry");
                end
            end
        end
    end

// // monitor FP transactions because it is not supported yet
//     if (`L15_TOP7.noc1encoder.sending)
//     begin
//         $display("noc1 flit raw: 0x%x", `L15_TOP7.noc1encoder.flit);
//     end
//     if (`L15_PIPE7.pcxdecoder_l15_val && !`L15_PIPE7.pcx_message_staled_s1 && `L15_PIPE7.val_s1 && !`L15_PIPE7.stall_s1 && !`L15_PIPE7.noc2decoder_l15_val)
//     begin
//         $display("%d : Simulation -> FAIL(%0s)", $time, "FP requests received but not implemented");
//         `ifndef VERILATOR
//         repeat(5)@(posedge clk)
//         `endif
    //         `MONITOR_PATH.fail("FP requests received but not implemented");
//     end


// Monitor FP transactions
//    if (`TILE7.fpu_arb_wrap.pcx_fpio_data_px2[123]
//            && `TILE7.fpu_arb_wrap.pcx_fpio_data_px2[122:119] == 4'b0101)
//    begin
//        $display("TILE7 FPU th%d: Received FP%d",
//                    `TILE7.fpu_arb_wrap.pcx_fpio_data_px2[113:112],
//                    `TILE7.fpu_arb_wrap.pcx_fpio_data_px2[118]);
//    end
//    if (`TILE7.fpu_arb_wrap.fpu_arb_data_rdy
//            && !`TILE7.fpu_arb_wrap.l15_fp_rdy)
//        $display("TILE7 FPU th%d: Sent FP data",
//                    `TILE7.fpu_arb_wrap.fpu_arb_data[135:134]);

// monitor L1.5 way replacement error
    if (`L15_PIPE7.l15_dcache_val_s2
        && `L15_PIPE7.dcache_operation_s2 == `L15_DCACHE_READ_LRU_WAY_IF_M)
    begin
        if (`L15_PIPE7.lruarray_l15_dout_s2[`L15_PIPE7.lru_way_s2] == 1'b1)
        begin
            // replacing a valid line
            if (&`L15_PIPE7.lru_used_bits_s2[3:0] == 1'b0)
            begin
                // and an another entry is 0, then is an error
                $display("%d : Simulation -> FAIL(%0s)", $time, "TILE7 L15 picked the wrong LRU entry");
                `ifndef VERILATOR
                repeat(5)@(posedge clk)
                `endif
                    `MONITOR_PATH.fail("TILE7 L15 picked the wrong LRU entry");
            end
        end
    end

// monitor X's in stall signals
    if (`L15_PIPE7.val_s1 && (`L15_PIPE7.stall_s1 === 1'bx) ||
        `L15_PIPE7.val_s2 && (`L15_PIPE7.stall_s2 === 1'bx) ||
        `L15_PIPE7.val_s3 && (`L15_PIPE7.stall_s3 === 1'bx))
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "L15 has X's in the stall_s1 signal");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("L15 has X's in the stall_s1 signal");
    end

`ifdef RTL_SPARC7
// some checks for l15cpxencoder
    if (`L15_TOP7.l15_transducer_val)
    begin
        if (`L15_TOP7.l15_transducer_inval_icache_inval)
        begin
            $display("%d : Simulation -> FAIL(%0s)", $time, "l15 icache inval is not used");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("l15 icache inval is not used");
        end
        if (`L15_TOP7.l15_transducer_returntype == `CPX_RESTYPE_ATOMIC_RES
            && `L15_TOP7.l15_transducer_inval_dcache_inval)
        begin
            $display("%d : Simulation -> FAIL(%0s)", $time, "l15 CAS inval is not used");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("l15 CAS inval is not used");
        end
    end
`endif

// some checks for l15 noc1 encoder
    if (`L15_TOP7.noc1encoder.sending && `L15_TOP7.noc1encoder.req_type == 0)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "l15 noc1 message is null");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("l15 noc1 message is null");
    end

    end // disable_l15_mon
end

//CORE7 END


// CORE8

reg do_print_stage_TILE8;
integer i_TILE8;
wire [63:0] dtag_tag_way0_s2_TILE8;
wire [63:0] dtag_tag_way1_s2_TILE8;
wire [63:0] dtag_tag_way2_s2_TILE8;
wire [63:0] dtag_tag_way3_s2_TILE8;

assign dtag_tag_way0_s2_TILE8 = (`L15_PIPE8.dtag_tag_way0_s2 << 11);
assign dtag_tag_way1_s2_TILE8 = (`L15_PIPE8.dtag_tag_way1_s2 << 11);
assign dtag_tag_way2_s2_TILE8 = (`L15_PIPE8.dtag_tag_way2_s2 << 11);
assign dtag_tag_way3_s2_TILE8 = (`L15_PIPE8.dtag_tag_way3_s2 << 11);
reg [`L15_CACHE_TAG_WIDTH-1:0] tag_data_TILE8 [0:3];
reg [3:0] tag_val_TILE8;
reg [`L15_WMT_ENTRY_MASK] wmt_read_data_TILE8 [0:3];
integer j_TILE8;
reg is_csm_mshrid_TILE8;

reg wmt_read_val_s3_TILE8;
always @ (posedge clk)
    wmt_read_val_s3_TILE8 <= `L15_PIPE8.l15_wmt_read_val_s2;

always @ (negedge clk)
begin
    if(!$test$plusargs("disable_l15_mon"))
    begin

    // monitoring outgoing noc1/noc3 messages
    if (`L15_TOP8.noc1encoder.sending)
    begin
        $display($time);
        $display("TILE8 noc1 flit raw: 0x%x", `L15_TOP8.noc1encoder.flit);
        $display("   srcX: %d, srcY: %d", `L15_TOP8.noc1encoder.msg_src_xpos, `L15_TOP8.noc1encoder.msg_src_ypos);
        $display("   destX: %d, destY: %d", `L15_TOP8.noc1encoder.msg_dest_l2_xpos, `L15_TOP8.noc1encoder.msg_dest_l2_ypos);
        if ( ^`L15_TOP8.noc1encoder.flit === 1'bx)
        begin
            $display("%d : Simulation -> FAIL(TILE8 noc1 sends X data 0x%x)", $time, `L15_TOP8.noc1encoder.flit);
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("l15_mon: TILE8 noc1 sends X data");
        end

    end




    if (`L15_PIPE8.pcxdecoder_l15_val && `L15_PIPE8.val_s1 && !`L15_PIPE8.stall_s1 && !`L15_PIPE8.noc2decoder_l15_val
        && `L15_PIPE8.fetch_state_s1 == `L15_FETCH_STATE_NORMAL)
    begin
        $write("%0d TILE8 L1.5 th%d: Received PCX ", $time, `L15_PIPE8.pcxdecoder_l15_threadid); decode_pcx_op(`L15_PIPE8.pcxdecoder_l15_rqtype, `L15_PIPE8.pcxdecoder_l15_amo_op);
        $display("   Addr 0x%x, nc %d, size %d, invalall %d, pf %d, bs %d, bsi %d, l1way %d",
                                `L15_PIPE8.pcxdecoder_l15_address, `L15_PIPE8.pcxdecoder_l15_nc, `L15_PIPE8.pcxdecoder_l15_size, `L15_PIPE8.pcxdecoder_l15_invalidate_cacheline,
                                `L15_PIPE8.pcxdecoder_l15_prefetch, `L15_PIPE8.pcxdecoder_l15_blockstore, `L15_PIPE8.pcxdecoder_l15_blockinitstore, `L15_PIPE8.pcxdecoder_l15_l1rplway);
        $display("   Data: 0x%x", `L15_PIPE8.pcxdecoder_l15_data);
        if (`L15_PIPE8.pcxdecoder_l15_csm_data[`TLB_CSM_STATE] == `TLB_CSM_STATE_LOCAL)
        begin
            $display("   CSM HDID: %d, HD_SIZE: %d, SDID: %d, LSID: %d", `L15_PIPE8.pcxdecoder_l15_csm_data[`TLB_CSM_HDID], `L15_PIPE8.pcxdecoder_l15_csm_data[`TLB_CSM_HD_SIZE],
            `L15_PIPE8.pcxdecoder_l15_csm_data[`TLB_CSM_SDID], `L15_PIPE8.pcxdecoder_l15_csm_data[`TLB_CSM_LSID]);
        end
        else if (`L15_PIPE8.pcxdecoder_l15_csm_data[`TLB_CSM_STATE] == `TLB_CSM_STATE_GLOBAL)
        begin
            $display("   CSM CHIPID: %d, X: %d, Y: %d", `L15_PIPE8.pcxdecoder_l15_csm_data[`TLB_CSM_CHIPID], `L15_PIPE8.pcxdecoder_l15_csm_data[`TLB_CSM_X],`L15_PIPE8.pcxdecoder_l15_csm_data[`TLB_CSM_Y]);
        end
        $display("   CSM Data: 0x%x", `L15_PIPE8.pcxdecoder_l15_csm_data);
        /*
        if (noc2decoder_l15_reqtype == `PCX_REQTYPE_STORE)
        if (noc2decoder_l15_reqtype == `PCX_REQTYPE_CAS1)
        begin
        $display("   Cmp.data: 0x%x", `L15_PIPE8.pcxdecoder_l15_data);
        $display("   Swp.data: 0x%x", `L15_PIPE8.pcxdecoder_l15_data_next_entry);
        end
        if (noc2decoder_l15_reqtype == `PCX_REQTYPE_SWP_LOADSTUB)
        begin
        $display("   Swp.data: 0x%x", `L15_PIPE8.pcxdecoder_l15_data);
        end
        */
        if (`L15_PIPE8.pcxdecoder_l15_rqtype == `PCX_REQTYPE_INTERRUPT && `L15_PIPE8.pcxdecoder_l15_data[63] == 1'b0)
        begin
            pcx_interrupt_type = `L15_PIPE8.pcxdecoder_l15_data[17:16];
            pcx_interrupt_dst_chipid = `L15_PIPE8.pcxdecoder_l15_data[31:18];
            pcx_interrupt_dst_y = `L15_PIPE8.pcxdecoder_l15_data[14:12];
            pcx_interrupt_dst_x = `L15_PIPE8.pcxdecoder_l15_data[11:9];
            pcx_interrupt_threadid = `L15_PIPE8.pcxdecoder_l15_data[8];
            pcx_interrupt_vector = `L15_PIPE8.pcxdecoder_l15_data[5:0];
            $display("Interrupt info:");
            $write("    Type: ");
            case(pcx_interrupt_type)
                2'b00:
                    $display("hw int");
                2'b01:
                    $display("reset");
                2'b10:
                    $display("idle");
                2'b11:
                    $display("resume");
            endcase

            $display("    Dst CHIP ID: %d", pcx_interrupt_dst_chipid);
            $display("    Dst X: %d", pcx_interrupt_dst_x);
            $display("    Dst Y: %d", pcx_interrupt_dst_y);
            $display("    Thread ID: %d", pcx_interrupt_threadid);
            $display("    Vector: %d", pcx_interrupt_vector);
        end
    end

    if (`L15_PIPE8.noc2decoder_l15_val && `L15_PIPE8.val_s1 && !`L15_PIPE8.stall_s1)
    begin
        noc2 = 0;
        case(`L15_PIPE8.noc2decoder_l15_reqtype)
        `MSG_TYPE_RESERVED:
            noc2 = "MSG_TYPE_RESERVED";
        `MSG_TYPE_LOAD_FWD:
            noc2 = "MSG_TYPE_LOAD_FWD";
        `MSG_TYPE_STORE_FWD:
            noc2 = "MSG_TYPE_STORE_FWD";
        `MSG_TYPE_INV_FWD:
            noc2 = "MSG_TYPE_INV_FWD";
        `MSG_TYPE_NODATA_ACK:
            noc2 = "MSG_TYPE_NODATA_ACK";
        `MSG_TYPE_DATA_ACK:
            noc2 = "MSG_TYPE_DATA_ACK";
        `MSG_TYPE_NC_LOAD_MEM_ACK:
            noc2 = "MSG_TYPE_NC_LOAD_MEM_ACK";
        `MSG_TYPE_NC_STORE_MEM_ACK:
            noc2 = "MSG_TYPE_NC_STORE_MEM_ACK";
        `MSG_TYPE_INTERRUPT:
            noc2 = "MSG_TYPE_L2_INTERRUPT";
        default:
        begin
            noc2 = "MSG_TYPE_UNKNOWN_ERROR";
            $display("%d : Simulation -> FAIL(%0s)", $time, "L15 mon: error message type from L2");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("L15 mon: error message type from L2");
        end
        endcase

        $write("%0d TILE8 L1.5: Received NOC2 %s", $time, noc2);
        $display("   mshrid %d, l2miss %d, f4b %d, ackstate %d, address 0x%x",
                    `L15_PIPE8.noc2decoder_l15_mshrid, `L15_PIPE8.noc2decoder_l15_l2miss, `L15_PIPE8.noc2decoder_l15_f4b,
                    `L15_PIPE8.noc2decoder_l15_ack_state, `L15_PIPE8.noc2decoder_l15_address);
        $display("   Data1: 0x%x", `L15_PIPE8.noc2decoder_l15_data_0);
        $display("   Data2: 0x%x", `L15_PIPE8.noc2decoder_l15_data_1);
        $display("   Data3: 0x%x", `L15_PIPE8.noc2decoder_l15_data_2);
        $display("   Data4: 0x%x", `L15_PIPE8.noc2decoder_l15_data_3);
    end

    if (`L15_PIPE8.l15_cpxencoder_val && !`L15_PIPE8.stall_s3)
    begin
        cpx = 0;
        case(`L15_PIPE8.l15_cpxencoder_returntype)
            `LOAD_RET:
                cpx = "LOAD_RET";
            `INV_RET:
                cpx = "INV_RET";
            `ST_ACK:
                cpx = "ST_ACK";
            `AT_ACK:
                cpx = "AT_ACK";
            `INT_RET:
                cpx = "INT_RET";
            `TEST_RET:
                cpx = "TEST_RET";
            `FP_RET:
                cpx = "FP_RET";
            `IFILL_RET:
                cpx = "IFILL_RET";
            `EVICT_REQ:
                cpx = "EVICT_REQ";
            `ERR_RET:
                cpx = "ERR_RET";
            `STRLOAD_RET:
                cpx = "STRLOAD_RET";
            `STRST_ACK:
                cpx = "STRST_ACK";
            `FWD_RQ_RET:
                cpx = "FWD_RQ_RET";
            `FWD_RPY_RET:
                cpx = "FWD_RPY_RET";
            `RSVD_RET:
                cpx = "RSVD_RET";
            4'b1110:
                cpx = "ATOMIC_ACK";
            default:
                cpx = "CPX_UNKNOWN";
        endcase
        $write("%0d TILE8 L1.5 th%d: Sent CPX %0s", $time, `L15_PIPE8.l15_cpxencoder_threadid, cpx);
        $display("   l2miss %d, nc %d, atomic %d, threadid %d, pf %d, f4b %d, iia %d, dia %d, dinval %d, iinval %d, invalway %d, blkinit %d",
                    `L15_PIPE8.l15_cpxencoder_l2miss, `L15_PIPE8.l15_cpxencoder_noncacheable, `L15_PIPE8.l15_cpxencoder_atomic,
                    `L15_PIPE8.l15_cpxencoder_threadid, `L15_PIPE8.l15_cpxencoder_prefetch,
                    `L15_PIPE8.l15_cpxencoder_f4b, `L15_PIPE8.l15_cpxencoder_inval_icache_all_way,
                    `L15_PIPE8.l15_cpxencoder_inval_dcache_all_way, `L15_PIPE8.l15_cpxencoder_inval_dcache_inval,
                    `L15_PIPE8.l15_cpxencoder_inval_icache_inval, `L15_PIPE8.l15_cpxencoder_inval_way,
                    `L15_PIPE8.l15_cpxencoder_blockinitstore);
        $display("   Data0: 0x%x", `L15_PIPE8.l15_cpxencoder_data_0);
        $display("   Data1: 0x%x", `L15_PIPE8.l15_cpxencoder_data_1);
        $display("   Data2: 0x%x", `L15_PIPE8.l15_cpxencoder_data_2);
        $display("   Data3: 0x%x", `L15_PIPE8.l15_cpxencoder_data_3);
    end

    if (`L15_TOP8.noc1encoder.noc1encoder_noc1out_val && `L15_TOP8.noc1encoder.noc1encoder_noc1buffer_req_ack)
    begin
        noc1 = 0;
        case(`L15_TOP8.noc1encoder.req_type)
        `L15_NOC1_REQTYPE_WRITEBACK_GUARD:
            noc1 = "L15_NOC1_REQTYPE_WRITEBACK_GUARD";
        `L15_NOC1_REQTYPE_LD_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_LD_REQUEST";
        `L15_NOC1_REQTYPE_IFILL_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_IFILL_REQUEST";
        `L15_NOC1_REQTYPE_WRITETHROUGH_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_WRITETHROUGH_REQUEST";
        `L15_NOC1_REQTYPE_ST_UPGRADE_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_ST_UPGRADE_REQUEST";
        `L15_NOC1_REQTYPE_ST_FILL_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_ST_FILL_REQUEST";
        `L15_NOC1_REQTYPE_CAS_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_CAS_REQUEST";
        `L15_NOC1_REQTYPE_SWAP_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_SWAP_REQUEST";
        `L15_NOC1_REQTYPE_INTERRUPT_FWD:
            noc1 = "L15_NOC1_REQTYPE_INTERRUPT_FWD";
        `L15_NOC1_REQTYPE_AMO_ADD_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_ADD_REQUEST";
        `L15_NOC1_REQTYPE_AMO_AND_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_AND_REQUEST";
        `L15_NOC1_REQTYPE_AMO_OR_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_OR_REQUEST";
        `L15_NOC1_REQTYPE_AMO_XOR_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_XOR_REQUEST";
        `L15_NOC1_REQTYPE_AMO_MAX_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_MAX_REQUEST";
        `L15_NOC1_REQTYPE_AMO_MAXU_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_MAXU_REQUEST";
        `L15_NOC1_REQTYPE_AMO_MIN_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_MIN_REQUEST";
        `L15_NOC1_REQTYPE_AMO_MINU_REQUEST:
            noc1 = "L15_NOC1_REQTYPE_AMO_MINU_REQUEST";
        default:
            noc1 = "ERROR noc1";
        endcase

        $write("%0d TILE8 L1.5: Sending NOC1 %s", $time, noc1);
        $display("   mshrid %d, nc %d, size %d, pf %d, address %0x",
                    `L15_TOP8.noc1encoder.noc1buffer_noc1encoder_req_mshrid, `L15_TOP8.noc1encoder.noc1buffer_noc1encoder_req_non_cacheable,
                    `L15_TOP8.noc1encoder.noc1buffer_noc1encoder_req_size, `L15_TOP8.noc1encoder.noc1buffer_noc1encoder_req_prefetch, `L15_TOP8.noc1encoder.noc1buffer_noc1encoder_req_address);
        $display("   Data0: 0x%x", `L15_TOP8.noc1encoder.noc1buffer_noc1encoder_req_data_0);
        $display("   Data1: 0x%x", `L15_TOP8.noc1encoder.noc1buffer_noc1encoder_req_data_1);
        $display("   Destination X: %d Y: %d", `L15_TOP8.noc1encoder.msg_dest_l2_xpos, `L15_TOP8.noc1encoder.msg_dest_l2_ypos);
    end

    if (`L15_TOP8.noc3encoder.noc3encoder_noc3out_val && `L15_TOP8.noc3encoder.noc3encoder_l15_req_ack)
    begin
        noc3 = 0;
        case(`L15_TOP8.noc3encoder.l15_noc3encoder_req_type)
        `L15_NOC3_REQTYPE_WRITEBACK:
            noc3 = "L15_NOC3_REQTYPE_WRITEBACK";
        `L15_NOC3_REQTYPE_INVAL_ACK:
            noc3 = "L15_NOC3_REQTYPE_INVAL_ACK";
        `L15_NOC3_REQTYPE_DOWNGRADE_ACK:
            noc3 = "L15_NOC3_REQTYPE_DOWNGRADE_ACK";
        `L15_NOC3_REQTYPE_ICACHE_INVAL_ACK:
            noc3 = "L15_NOC3_REQTYPE_ICACHE_INVAL_ACK";
        default:
            noc3 = "ERROR NOC3";
        endcase

        // quick check for an error case
        if (`L15_TOP8.noc3encoder.msg_type == `MSG_TYPE_INV_FWDACK
            && `L15_TOP8.noc3encoder.l15_noc3encoder_req_with_data)
        begin
            $display("L1.5 MON: sending back invalid ack with data");
            $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: sending back invalid ack with data");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("L1.5 MON: sending back invalid ack with data");
        end


        $write("%0d TILE8 L1.5: Sent NOC3 %s", $time, noc3);
        $display("   mshrid %d, seqid %d, address %0x",
                    `L15_TOP8.noc3encoder.l15_noc3encoder_req_mshrid, `L15_TOP8.noc3encoder.l15_noc3encoder_req_sequenceid, `L15_TOP8.noc3encoder.l15_noc3encoder_req_address);
        $display("   srcX: %d, srcY: %d", `L15_TOP8.noc3encoder.src_l2_xpos, `L15_TOP8.noc3encoder.src_l2_ypos);
        $display("   destX: %d, destY: %d", `L15_TOP8.noc3encoder.dest_l2_xpos, `L15_TOP8.noc3encoder.dest_l2_ypos);
        $display("   Data0: 0x%x", `L15_TOP8.noc3encoder.l15_noc3encoder_req_data_0);
        $display("   Data1: 0x%x", `L15_TOP8.noc3encoder.l15_noc3encoder_req_data_1);
    end

    do_print_stage_TILE8 = ((`L15_PIPE8.val_s1 && !`L15_PIPE8.stall_s1) || (`L15_PIPE8.val_s2 && !`L15_PIPE8.stall_s2) || (`L15_PIPE8.val_s3 && !`L15_PIPE8.stall_s3));
    if (do_print_stage_TILE8)
    begin
        // $display("");
        $display("");
        $display($time, " L15 TILE8:");
        $display("NoC1 credit: %d", `L15_PIPE8.creditman_noc1_avail);
        $display("NoC1 reserved credit: %d", `L15_PIPE8.creditman_noc1_reserve);
        // $display("NoC1 r down: %d", `L15_PIPE8.creditman_noc1_reserve_minus1);
        // $display("NoC1 r up: %d", `L15_PIPE8.creditman_noc1_reserve_add1);

        // monitor the MSHRID allocation
        // $display("MSHRID allocation info:");
        // for (i_TILE8 = 0; i_TILE8 < `L15_MSHR_COUNT; i_TILE8 = i_TILE8 + 1)
        //     $write("%d:%d", i_TILE8, `L15_PIPE8.mshr_val_array[i_TILE8]);
            // $write("%d %d", i_TILE8, i_TILE8);
        // $display("");

`ifdef RTL_SPARC8
        $display("Core STB info:");
        $display("  STB0: %d", `SPARC_CORE8.sparc0.ifu.lsu_ifu_stbcnt0);
        $display("  STB1: %d", `SPARC_CORE8.sparc0.ifu.lsu_ifu_stbcnt1);
            // $write("%d %d", i_TILE8, i_TILE8);
`endif

        $write("TILE8 Pipeline:");
        if (`L15_PIPE8.val_s1 && !`L15_PIPE8.stall_s1)
            $write(" * ");
        else if (`L15_PIPE8.val_s1 && `L15_PIPE8.stall_s1)
            $write(" = ");
        else
            $write(" X ");

        if (`L15_PIPE8.val_s2 && !`L15_PIPE8.stall_s2)
            $write(" * ");
        else if (`L15_PIPE8.val_s2 && `L15_PIPE8.stall_s2)
            $write(" = ");
        else
            $write(" X ");

        if (`L15_PIPE8.val_s3 && !`L15_PIPE8.stall_s3)
            $write(" * ");
        else if (`L15_PIPE8.val_s3 && `L15_PIPE8.stall_s3)
            $write(" = ");
        else
            $write(" X ");
        $display("");

        // $write("PCX pipe info: "); decode_pcx_op(`L15_PIPE8.pcxdecoder_l15_rqtype, L15_PIPE8.pcxdecoder_l15_amo_op);
        // if (`L15_PIPE8.noc1_req_val_s3 && `L15_PIPE8.noc1encoder_req_staled_s3)
        //     $display(" (staled)");
        // else if (!`L15_PIPE8.noc1_req_val_s3)
        //     $display(" (invalid)");
        // else if (`L15_PIPE8.noc1_req_val_s3 && !`L15_PIPE8.noc1encoder_req_staled_s3)
        // begin
        //     $display(" (fresh)");
        // end

        // $write("NoC1 pipe info: ");
        // if (`L15_PIPE8.noc1_req_val_s3 && `L15_PIPE8.noc1encoder_req_staled_s3)
        //     $display("staled");
        // else if (!`L15_PIPE8.noc1_req_val_s3)
        //     $display("invalid");
        // else if (`L15_PIPE8.noc1_req_val_s3 && !`L15_PIPE8.noc1encoder_req_staled_s3)
        // begin
        //     $display("fresh");
        // end

        // $write("NoC3 pipe info: ");
        // if (`L15_PIPE8.noc3_req_val_s3 && `L15_PIPE8.noc3encoder_req_staled_s3)
        //     $display("staled");
        // else if (!`L15_PIPE8.noc3_req_val_s3)
        //     $display("invalid");
        // else if (`L15_PIPE8.noc3_req_val_s3 && !`L15_PIPE8.noc3encoder_req_staled_s3)
        // begin
        //     $display("fresh");
        // end

        // $write("CPX pipe info: ");
        // if (`L15_PIPE8.cpx_req_val_s3 && `L15_PIPE8.cpxencoder_req_staled_s3)
        //     $display("staled");
        // else if (!`L15_PIPE8.cpx_req_val_s3)
        //     $display("invalid");
        // else if (`L15_PIPE8.cpx_req_val_s3 && !`L15_PIPE8.cpxencoder_req_staled_s3)
        // begin
        //     $display("fresh");
        // end

            // Stage 1 debug information
        if (`L15_PIPE8.stall_s1 === 1'bx)
            $display("S1 stall is XXXXXXX");
        if (`L15_PIPE8.val_s1 && !`L15_PIPE8.stall_s1)
        begin
            $write("Stage 1 status: ");
            $write("   Operation: "); decode_predecode_reqtype(`L15_PIPE8.predecode_reqtype_s1);
            $display("   TILE8 S1 Address: 0x%x", `L15_PIPE8.predecode_address_s1);
            // if (`L15_PIPE8.decoder_dtag_operation_s1 == `L15_DTAG_OP_READ)
            // begin
            //     $display("   DTAG OP: L15_DTAG_OP_READ");
            //     $display("      Index: 0x%x", `L15_PIPE8.dtag_index);
            // end
            // if (`L15_PIPE8.l15_dtag_rw_s1 == `L15_DTAG_RW_WRITE)
            // begin
            //     $display("   DTAG OP: L15_DTAG_OP_WRITE");
            //     $display("      Data:  0x%x", `L15_PIPE8.dtag_write_tag_s1);
            //     $display("      Way:  0x%x", `L15_PIPE8.dtag_write_way_s1);
            //     // $display("      Mask: 0x%x", `L15_PIPE8.dtag_write_mask);
            // end
            // if (`L15_PIPE8.s1_mshr_write_val_s1)
            // begin
            //     $display("   DTAG OP: ");
            //     if (`L15_PIPE8.s1_mshr_write_type_s1 == `L15_MSHR_WRITE_TYPE_ALLOCATION)
            //     begin
            //         $write ("L15_MSHR_WRITE_TYPE_ALLOCATION");
            //         $display ("      MSRID: %d", `L15_PIPE8.s1_mshr_write_mshrid_s1);
            //     end
            //     else if (`L15_PIPE8.s1_mshr_write_type_s1 == `L15_S1_MSHR_OP_UPDATE_WRITECACHE)
            //     begin
            //         $write ("L15_S1_MSHR_OP_UPDATE_WRITECACHE");
            //         $display ("      MSRID:     %d", `L15_PIPE8.s1_mshr_write_mshrid_s1);
            //         $display ("      DATA:      0x%x", `L15_PIPE8.s1_mshr_write_data);
            //         $display ("      DATAMASK:  0x%x", `L15_PIPE8.s1_mshr_write_byte_mask);
            //     end
            // end
        end
        // Stage 2 debug information
        if (`L15_PIPE8.stall_s2 === 1'bx)
            $display("S2 stall is XXXXXXX");
        if (`L15_PIPE8.val_s2 && !`L15_PIPE8.stall_s2)
        begin
        $write("Stage 2 status: ");
            $write("   Operation: "); decode_predecode_reqtype(`L15_PIPE8.predecode_reqtype_s2);
            $display("   TILE8 S2 Address: 0x%x", `L15_PIPE8.address_s2);
            $display("   TILE8 S2 Cache index: %d", `L15_PIPE8.cache_index_s2);

            if (`L15_PIPE8.csm_req_val_s2)
            begin
                $display("   CSM op: %d", `L15_PIPE8.csm_op_s2);
                if (`L15_PIPE8.l15_csm_req_type_s2 == 1'b0)
                    $display("      CSM read ticket: 0x%x", `L15_PIPE8.l15_csm_req_ticket_s2);
                else
                begin
                    $display("      CSM write ticket: 0x%x", `L15_PIPE8.l15_csm_req_ticket_s2);
                    $display("      CSM write data: 0x%x", `L15_PIPE8.l15_csm_req_data_s2);
                end
            end

            // $display("   Source chipid: %d", `L15_PIPE8.noc2_src_homeid_s2[`PACKET_HOME_ID_CHIP_MASK]);
            // $display("   Source X: %d", `L15_PIPE8.noc2_src_homeid_s2[`PACKET_HOME_ID_X_MASK]);
            // $display("   Source Y: %d", `L15_PIPE8.noc2_src_homeid_s2[`PACKET_HOME_ID_Y_MASK]);
            // `ifdef L15_EXTRA_DEBUG
            // $display("   LRU state: %d", `L15_PIPE8.lru_state_s2);
            // $display("   LRU way: %d", `L15_PIPE8.lru_way_s2);
            // $display("   Tagcheck state: %d", `L15_PIPE8.tagcheck_state_s2);
            // $display("   Tagcheck way: %d", `L15_PIPE8.tagcheck_way_s2);

            if (`L15_PIPE8.decoder_dtag_operation_s2 == `L15_DTAG_OP_READ)
            begin
                $display("   DTAG way0 state: 0x%x", `L15_PIPE8.mesi_state_way0_s2);
                $display("   DTAG way0 data: 0x%x", dtag_tag_way0_s2_TILE8);
                $display("   DTAG way1 state: 0x%x", `L15_PIPE8.mesi_state_way1_s2);
                $display("   DTAG way1 data: 0x%x", dtag_tag_way1_s2_TILE8);
                $display("   DTAG way2 state: 0x%x", `L15_PIPE8.mesi_state_way2_s2);
                $display("   DTAG way2 data: 0x%x", dtag_tag_way2_s2_TILE8);
                $display("   DTAG way3 state: 0x%x", `L15_PIPE8.mesi_state_way3_s2);
                $display("   DTAG way3 data: 0x%x", dtag_tag_way3_s2_TILE8);
            end

            if (`L15_PIPE8.l15_mesi_write_val_s2)
            begin
                $display("   MESI write way: 0x%x", `L15_PIPE8.mesi_write_way_s2);
                $display("   MESI write data: 0x%x", `L15_PIPE8.mesi_write_state_s2);
            end

            // if (`L15_PIPE8.lruarray_write_op_s2 == `L15_LRU_EVICTION)
            // begin
            //     $display("   LRU EVICTION INDEX: %d, WAY: %d", `L15_PIPE8.cache_index_s2,
            //         `L15_PIPE8.lru_way_s2[1:0]);
            // end
            // `endif

            // if (`L15_PIPE8.s2_mesi_operation_s2 == `L15_S2_MESI_READ)
            // begin
            //     $display("   MESI OP: L15_S2_MESI_READ");
            //     $display ("      Index:     %d", `L15_PIPE8.s2_mesi_index_s2);
            // end
            // if (`L15_PIPE8.s2_mshr_val_s2)
            // begin
            //     $display("   MSHR OP: L15_S2_MSHR_OP_READ_WRITE_CACHE");
            //     $display ("      MSHR: %d", `L15_PIPE8.s2_mshr_read_mshrid);
            // end
            if (`L15_PIPE8.dcache_val_s2)
            begin
                // $write("   DCACHE OP: "); decode_dcache_op(`L15_PIPE8.dcache_operation_s2);
                // $display ("      RW:     %d", `L15_PIPE8.dcache_rw);
                // $display ("      Index:      0x%x", `L15_PIPE8.dcache_index);
                // $display ("      Data:  0x%x", `L15_PIPE8.dcache_write_data);
                // $display ("      Data mask:  0x%x", `L15_PIPE8.dcache_write_mask);
                if (`L15_PIPE8.l15_dcache_rw_s2 == 1'b0)
                begin
                    `ifndef NO_RTL_CSM
                    $display("HMT writing: %0b", `L15_PIPE8.l15_hmt_write_data_s2);
                    `endif
                    // TODO
                    // $display("HMT chip: %0b", `L15_PIPE8.wmt_fill_homeid_s2[`PACKET_HOME_ID_CHIP_MASK]);
                    // $display("HMT X: %0b", `L15_PIPE8.wmt_fill_homeid_s2[`PACKET_HOME_ID_X_MASK]);
                    // $display("HMT Y: %0b", `L15_PIPE8.wmt_fill_homeid_s2[`PACKET_HOME_ID_Y_MASK]);
                end
            end
        end

        // Stage 3 debug information
        if (`L15_PIPE8.stall_s3 === 1'bx)
            $display("S3 stall is XXXXXXX");
        if (`L15_PIPE8.val_s3 && !`L15_PIPE8.stall_s3)
        begin
            $write("Stage 3 status: ");
            $write("   Operation: "); decode_predecode_reqtype(`L15_PIPE8.predecode_reqtype_s3);
            $display("   TILE8 S3 Address: 0x%x", `L15_PIPE8.address_s3);
            `ifndef NO_RTL_CSM
            if ((`L15_PIPE8.noc1_homeid_source_s3 == `L15_HOMEID_SRC_HMT && `L15_PIPE8.noc1_req_val_s3)
                || (`L15_PIPE8.noc3_homeid_source_s3 == `L15_HOMEID_SRC_HMT && `L15_PIPE8.noc3_req_val_s3))
            begin
                `ifndef NO_RTL_CSM
                $display("   HMT chipid: %d", `L15_PIPE8.hmt_l15_dout_s3[`L15_CSM_GHID_CHIP_MASK]);
                $display("   HMT X: %d", `L15_PIPE8.hmt_l15_dout_s3[`L15_CSM_GHID_XPOS_MASK]);
                $display("   HMT Y: %d", `L15_PIPE8.hmt_l15_dout_s3[`L15_CSM_GHID_YPOS_MASK]);
                $display("   HMT reading: %0b", `L15_PIPE8.hmt_l15_dout_s3);
                `endif
            end
            `endif
            if (`L15_PIPE8.noc3_homeid_source_s3 == `L15_HOMEID_SRC_NOC2_SOURCE && `L15_PIPE8.noc3_req_val_s3)
            begin
                $display("   Source chipid: %d", `L15_PIPE8.noc2_src_homeid_s3[`PACKET_HOME_ID_CHIP_MASK]);
                $display("   Source X: %d", `L15_PIPE8.noc2_src_homeid_s3[`PACKET_HOME_ID_X_MASK]);
                $display("   Source Y: %d", `L15_PIPE8.noc2_src_homeid_s3[`PACKET_HOME_ID_Y_MASK]);
            end

            if (`L15_PIPE8.cpx_data_source_s3 == `L15_CPX_SOURCE_CSM)
                $display("      CSM read data: 0x%x", `L15_PIPE8.csm_l15_res_data_s3);
            // `ifdef L15_EXTRA_DEBUG
            // $display("   LRU state: %d", `L15_PIPE8.lru_state_s3);
            // $display("   LRU way: %d", `L15_PIPE8.lru_way_s3);
            // $display("   Tagcheck state: %d", `L15_PIPE8.tagcheck_state_s3);
            // $display("   Tagcheck way: %d", `L15_PIPE8.tagcheck_way_s3);
            // `endif

            // if (`L15_PIPE8.s3_mesi_val_s3)
            // begin
            //     $write("   MESI OP: "); decode_s3mesi_op(`L15_PIPE8.s3_mesi_operation_s3);
            //     $display ("      Index:      0x%x", `L15_PIPE8.mesi_write_index);
            //     $display ("      Data:  0x%x", `L15_PIPE8.mesi_write_data);
            //     $display ("      Data mask:  0x%x", `L15_PIPE8.mesi_write_mask);
            // end
            // if (`L15_PIPE8.wmc_val_s3)
            // begin
            //     $write("   WMC OP: "); decode_wmc_op(`L15_PIPE8.wmc_operation_s3);
            //     if (`L15_PIPE8.wmc_rw_s3 == `L15_WMC_OP_READ)
            //     begin
            //         $display ("      wmc_index_s3:      0x%x", `L15_PIPE8.wmc_index_s3);
            //         $display ("      wmc_invalidate_val_s3:      0x%x", `L15_PIPE8.wmc_invalidate_val_s3);
            //         $display ("      wmc_invalidate_way_s3:      0x%x", `L15_PIPE8.wmc_invalidate_way_s3);
            //     end
            //     else if (`L15_PIPE8.wmc_rw_s3 == `L15_WMC_OP_WRITE)
            //     begin
            //         $display ("      wmc_index_s3:      0x%x", `L15_PIPE8.wmc_index_s3);
            //         $display ("      wmc_update_way_s3:      0x%x", `L15_PIPE8.wmc_update_way_s3);
            //         $display ("      wmc_update_data_s3:      0x%x", `L15_PIPE8.wmc_update_data_s3);
            //         $display ("      wmc_invalidate_val_s3:      0x%x", `L15_PIPE8.wmc_invalidate_val_s3);
            //         $display ("      wmc_invalidate_way_s3:      0x%x", `L15_PIPE8.wmc_invalidate_way_s3);
            //     end
            //     $display ("      cpx_inval_way_s3:      0x%x", `L15_PIPE8.cpx_inval_way_s3);
            //     $display ("      wmc_read_way0_data_s3:      0x%x", `L15_PIPE8.wmc_read_way0_data_s3);
            //     $display ("      wmc_read_way1_data_s3:      0x%x", `L15_PIPE8.wmc_read_way1_data_s3);
            //     $display ("      wmc_read_way2_data_s3:      0x%x", `L15_PIPE8.wmc_read_way2_data_s3);
            //     $display ("      wmc_read_way3_data_s3:      0x%x", `L15_PIPE8.wmc_read_way3_data_s3);
            // end
            // if (`L15_PIPE8.s3_mshr_val_s3)
            // begin
            //     $write("   MSHR OP: "); decode_s3mshr_op(`L15_PIPE8.s3_mshr_operation_s3);
            //     $display ("      MSHR:      %d", `L15_PIPE8.s3_mshr_write_mshrid);
            //     $display ("      U.State:      0x%x", `L15_PIPE8.s3_mshr_write_update_state);
            //     $display ("      U.Way:  0x%x", `L15_PIPE8.s3_mshr_write_update_way);
            //     $display ("      St.mshr rand hit:   %d", `L15_PIPE8.LRU_st1_mshr_s3 || `L15_PIPE8.LRU_st2_mshr_s3);
            //     $display ("      St.mshr tag hit:   %d", `L15_PIPE8.tagcheck_st1_mshr_s3 || `L15_PIPE8.tagcheck_st2_mshr_s3);
            // end
            if (wmt_read_val_s3_TILE8)
            begin
                $display("   TILE8 WMT read index: %x", `L15_PIPE8.cache_index_l1d_s3[`L1D_SET_IDX_MASK]);
                // $display("   WMT way0: %x 0x%x", `L15_PIPE8.wmt_data_s3[0][`L15_WMT_VALID_MASK], `L15_PIPE8.wmt_data_s3[0][`L15_WMT_DATA_MASK]);
                // $display("   WMT way1: %x 0x%x", `L15_PIPE8.wmt_data_s3[1][`L15_WMT_VALID_MASK], `L15_PIPE8.wmt_data_s3[1][`L15_WMT_DATA_MASK]);
                // $display("   WMT way2: %x 0x%x", `L15_PIPE8.wmt_data_s3[2][`L15_WMT_VALID_MASK], `L15_PIPE8.wmt_data_s3[2][`L15_WMT_DATA_MASK]);
                // $display("   WMT way3: %x 0x%x", `L15_PIPE8.wmt_data_s3[3][`L15_WMT_VALID_MASK], `L15_PIPE8.wmt_data_s3[3][`L15_WMT_DATA_MASK]);
                for (i = 0; i < `L1D_WAY_COUNT; i = i + 1)
                begin
                    $display("   WMT way%d: %x 0x%x", i, `L15_PIPE8.wmt_data_s3[i][`L15_WMT_VALID_MASK], `L15_PIPE8.wmt_data_s3[i][`L15_WMT_DATA_MASK]);
                end
            end
            if (`L15_PIPE8.l15_wmt_write_val_s3)
            begin
                $display("   TILE8 WMT write index: %x", `L15_PIPE8.cache_index_l1d_s3[`L1D_SET_IDX_MASK]);
                // $display("   WMT write mask: %x", `L15_PIPE8.l15_wmt_write_mask_s3);
                // $display("   WMT write data: %x", `L15_PIPE8.l15_wmt_write_data_s3);
                // $display("   WMT way0 m%x d0x%x", `L15_PIPE8.l15_wmt_write_mask_s3[`L15_WMT_ENTRY_0_MASK], `L15_PIPE8.wmt_write_data_s3[`L15_WMT_ENTRY_0_MASK]);
                // $display("   WMT way1 m%x d0x%x", `L15_PIPE8.l15_wmt_write_mask_s3[`L15_WMT_ENTRY_1_MASK], `L15_PIPE8.wmt_write_data_s3[`L15_WMT_ENTRY_1_MASK]);
                // $display("   WMT way2 m%x d0x%x", `L15_PIPE8.l15_wmt_write_mask_s3[`L15_WMT_ENTRY_2_MASK], `L15_PIPE8.wmt_write_data_s3[`L15_WMT_ENTRY_2_MASK]);
                // $display("   WMT way3 m%x d0x%x", `L15_PIPE8.l15_wmt_write_mask_s3[`L15_WMT_ENTRY_3_MASK], `L15_PIPE8.wmt_write_data_s3[`L15_WMT_ENTRY_3_MASK]);
            end
        end
        $display ("L15_MON_END");
        $display ("");
    end

//CSM monitor
    if(`L15_TOP8.l15_csm.l15_csm_req_val_s2)
    begin
        $display($time, ": TILE8 L15_CSM REQ MON:");
        $display("L15 CSM req addr: 0x%x", `L15_TOP8.l15_csm.l15_csm_req_address_s2);
        $display("L15 CSM req ticket: %d", `L15_TOP8.l15_csm.l15_csm_req_ticket_s2);
        $display("L15 CSM req type: %d", `L15_TOP8.l15_csm.l15_csm_req_type_s2);
        $display("L15 CSM req data: 0x%x", `L15_TOP8.l15_csm.l15_csm_req_data_s2);
        $display("L15 CSM req pcx data: 0x%x", `L15_TOP8.l15_csm.l15_csm_req_pcx_data_s2);
    end
    if(`L15_TOP8.l15_csm.csm_l15_res_val_s3)
    begin
        $display($time, ": TILE8 L15_CSM RES MON:");
        $display("L15 CSM res data: 0x%x", `L15_TOP8.l15_csm.csm_l15_res_data_s3);
    end
    if(`L15_TOP8.l15_csm.csm_l15_read_res_val)
    begin
        $display($time, ": TILE8 L15_CSM READ TICKET MON:");
        $display("L15 CSM read ticket: %d", `L15_TOP8.l15_csm.l15_csm_read_ticket);
        $display("L15 CSM read data: 0x%x", `L15_TOP8.l15_csm.csm_l15_read_res_data);
    end
    if(`L15_TOP8.l15_csm.csm_noc1encoder_req_val)
    begin
        $display($time, ": TILE8 L15_CSM NOC1 REQ MON:");
        $display("L15 CSM noc1 req addr: 0x%x", `L15_TOP8.l15_csm.csm_noc1encoder_req_address);
        $display("L15 CSM noc1 req type: %d", `L15_TOP8.l15_csm.csm_noc1encoder_req_type);
        $display("L15 CSM noc1 req mshrid: %d", `L15_TOP8.l15_csm.csm_noc1encoder_req_mshrid);
    end
    if(`L15_TOP8.l15_csm.noc1encoder_csm_req_ack)
    begin
        $display($time, ": TILE8 L15_CSM NOC1 REQ ACK MON:");
        $display("L15 CSM noc1 req ack: %b", `L15_TOP8.l15_csm.noc1encoder_csm_req_ack);
    end

    if(`L15_TOP8.l15_csm.write_val_s2 && (~`L15_TOP8.l15_csm.ghid_val_s2))
    begin
        $display("L1.5 MON: HMC refills invalid data");
        $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: HMC refills invalid data");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("L1.5 MON: HMC refills invalid data");
    end

// valid mshrid monitor
    // check for incoming messages
    if (`L15_PIPE8.noc2decoder_l15_val && `L15_PIPE8.val_s1 && !`L15_PIPE8.stall_s1)
    begin
        is_csm_mshrid_TILE8 = `L15_PIPE8.noc2decoder_l15_hmc_fill;
        if ((`L15_PIPE8.noc2decoder_l15_reqtype == `MSG_TYPE_NODATA_ACK ||
            `L15_PIPE8.noc2decoder_l15_reqtype == `MSG_TYPE_DATA_ACK)
            && !is_csm_mshrid_TILE8)
        begin
            // first check if mshrid is in range
            if (`L15_PIPE8.noc2decoder_l15_mshrid > 9)
            begin
                $display("L1.5 MON: Received NoC2 message with MSHRID greater than 9 (%d)", `L15_PIPE8.noc2decoder_l15_mshrid);
                $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: Received NoC2 message with MSHRID greater than 9");
                `ifndef VERILATOR
                repeat(5)@(posedge clk)
                `endif
                    `MONITOR_PATH.fail("L1.5 MON: Received NoC2 message with MSHRID greater than 9");
            end

            // now check if it's valid
            // TODO
            // if (`L15_TOP8.mshr.val_array[`L15_PIPE8.noc2decoder_l15_mshrid] != 1'b1)
            // begin
            //     $display("L1.5 MON: Received NoC2 message with invalid MSHRID (%d)", `L15_PIPE8.noc2decoder_l15_mshrid);
            //     $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: Received NoC2 message with invalid MSHRID");
            //     `ifndef VERILATOR
            //     repeat(5)@(posedge clk)
            //     `endif
                //     `MONITOR_PATH.fail("L1.5 MON: Received NoC2 message with invalid MSHRID");
            // end
        end
    end
    // if (`L15_PIPE8.l15_noc1buffer_req_val && !`L15_PIPE8.stall_s3)
    // begin
    //     if (`L15_PIPE8.l15_noc1buffer_req_type != `L15_NOC1_REQTYPE_WRITEBACK_GUARD
    //         && `L15_PIPE8.l15_noc1buffer_req_type != `L15_NOC1_REQTYPE_INTERRUPT_FWD)
    //     begin
    //         if (`L15_TOP8.mshr.val_array[`L15_PIPE8.l15_noc1buffer_req_mshrid] != 1'b1
    //             || `L15_PIPE8.l15_noc1buffer_req_mshrid > 9)
    //         begin
    //             $display("L1.5 MON: Sending NoC1 message with invalid MSHRID (%d)", `L15_PIPE8.l15_noc1buffer_req_mshrid);
    //             $display("%d : Simulation -> FAIL(%0s)", $time, "L1.5 MON: Sending NoC1 message with invalid MSHRID");
    //             `ifndef VERILATOR
    //             repeat(5)@(posedge clk)
    //             `endif
        //             `MONITOR_PATH.fail("L1.5 MON: Sending NoC1 message with invalid MSHRID");
    //         end
    //     end
    // end

// monitor PCX buffer full compare to t1 internal buffer mon
`ifdef RTL_SPARC8
`ifndef RTL_SPU
    if ((`CCX_TRANSDUCER8.pcx_buffer.is_req_squashed == 1'b1) && (`SPARC_CORE8.sparc0.lsu.lsu.qctl1.pcx_req_squash == 1'b0))
`else
    if ((`CCX_TRANSDUCER8.pcx_buffer.is_req_squashed == 1'b1) && (`SPARC_CORE8.sparc0.lsu.qctl1.pcx_req_squash == 1'b0))
`endif
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "PCXTILE8 req was valid but squashed in L1.5");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("PCXTILE8 req was valid but squashed in L1.5");
    end
`ifndef RTL_SPU
    if ((`CCX_TRANSDUCER8.pcx_buffer.is_req_squashed == 1'b0) && (`SPARC_CORE8.sparc0.lsu.lsu.qctl1.pcx_req_squash == 1'b1))
`else
    if ((`CCX_TRANSDUCER8.pcx_buffer.is_req_squashed == 1'b0) && (`SPARC_CORE8.sparc0.lsu.qctl1.pcx_req_squash == 1'b1))
`endif
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "PCXTILE8 req was squashed but valid at L1.5");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("PCXTILE8 req was squashed but valid at L1.5");
    end

    // check for squashed atomic
    if ((`CCX_TRANSDUCER8.pcx_buffer.is_req_squashed == 1'b1) && (`CCX_TRANSDUCER8.pcx_buffer.spc_uncore_atomic_req == 1'b1))
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "PCXTILE8 atomic req squashed");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("PCXTILE8 atomic req squashed");
    end
`endif

// monitor FP transactions because it is not supported yet
//     if (`L15_PIPE8.pcxdecoder_l15_val && !`L15_PIPE8.pcx_message_staled_s1 && `L15_PIPE8.val_s1 && !`L15_PIPE8.stall_s1 && !`L15_PIPE8.noc2decoder_l15_val)
//     begin
//         if (`L15_PIPE8.pcxdecoder_l15_rqtype == `PCX_REQTYPE_FP1)
//         begin
//             $display("%d : Simulation -> FAIL(%0s)", $time, "FP requests received but not implemented");
//             `ifndef VERILATOR
//             repeat(5)@(posedge clk)
//             `endif
    //             `MONITOR_PATH.fail("FP requests received but not implemented");
//         end
//     end

// monitor INT_VEC_DIS requests
    if (`L15_PIPE8.pcxdecoder_l15_val && `L15_PIPE8.val_s1 && !`L15_PIPE8.stall_s1 && !`L15_PIPE8.noc2decoder_l15_val)
    begin
        if (`L15_PIPE8.pcxdecoder_l15_rqtype == `PCX_REQTYPE_STORE
            && `L15_PIPE8.pcxdecoder_l15_address == 40'h9800000800)
        begin
            $display("%d : PCX write to INT_VEC_DIS", $time);
            // $display("%d : Simulation -> FAIL(%0s)", $time, "Write to INT_VEC_DIS");
            // `ifndef VERILATOR
            // repeat(5)@(posedge clk)
            // `endif
                // `MONITOR_PATH.fail("Write to INT_VEC_DIS");
        end
    end

// monitor noc1 buffer credit for underflow
    if (`L15_PIPE8.creditman_noc1_avail == 4'd15)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE8 NOC1 credit underflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE8 NOC1 credit underflow");
    end
    if (`L15_PIPE8.creditman_noc1_avail > `NOC1_BUFFER_NUM_SLOTS)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE8 NOC1 credit overflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE8 NOC1 credit overflow");
    end
    if (`L15_PIPE8.creditman_noc1_data_avail == 4'd15)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE8 NOC1 data credit underflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE8 NOC1 data credit underflow");
    end
    if (`L15_PIPE8.creditman_noc1_data_avail > `NOC1_BUFFER_NUM_DATA_SLOTS)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE8 NOC1 data credit overflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE8 NOC1 data credit overflow");
    end

    // check noc1 reserve credit
    if (`L15_PIPE8.creditman_noc1_reserve == 4'd15)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE8 NOC1 reserve credit underflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE8 NOC1 reserve credit underflow");
    end
    if (`L15_PIPE8.creditman_noc1_reserve > `NOC1_BUFFER_NUM_SLOTS)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "TILE8 NOC1 reserve credit overflow");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("TILE8 NOC1 reserve credit overflow");
    end
    // check reserve logics
    // if (`L15_PIPE8.creditman_noc1_reserve_s3)
    // begin
    //     $display("%d : Simulation -> FAIL(%0s)", $time, "TILE8 NOC1 reserve credit underflow");
    //     `ifndef VERILATOR
    //     repeat(5)@(posedge clk)
    //     `endif
        //     `MONITOR_PATH.fail("TILE8 NOC1 reserve credit underflow");
    // end

// Monitor for "RESERVED" messages
    if (`L15_PIPE8.noc2decoder_l15_val && `L15_PIPE8.val_s1 && !`L15_PIPE8.stall_s1)
    begin
        if (`L15_PIPE8.noc2decoder_l15_reqtype == `MSG_TYPE_RESERVED)
        begin
            $display("%d : Simulation -> FAIL(%0s)", $time, "TILE8 L15 received MSG_TYPE_RESERVED");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("TILE8 L15 received MSG_TYPE_RESERVED");
        end
    end

// Monitor WMT duplicate error
    if (`L15_PIPE8.val_s3)
    begin
        {wmt_read_data_TILE8[3], wmt_read_data_TILE8[2], wmt_read_data_TILE8[1], wmt_read_data_TILE8[0]} = `L15_PIPE8.wmt_l15_data_s3;
        for (i_TILE8 = 0; i_TILE8 < 4; i_TILE8 = i_TILE8+1)
        begin
            for (j_TILE8 = 0; j_TILE8 < i_TILE8; j_TILE8 = j_TILE8 + 1)
            begin
                if ((wmt_read_data_TILE8[i_TILE8][`L15_WMT_VALID_MASK] && wmt_read_data_TILE8[j_TILE8][`L15_WMT_VALID_MASK]) && (wmt_read_data_TILE8[i_TILE8] == wmt_read_data_TILE8[j_TILE8]))
                begin
                    $display("%d : Simulation -> FAIL(%0s)", $time, "TILE8 L15 has error with WMT");
                    `ifndef VERILATOR
                    repeat(5)@(posedge clk)
                    `endif
                        `MONITOR_PATH.fail("TILE8 L15 has error with WMT");
                end
            end
        end
    end

// Monitor tags duplication error (bug #86)
    if (`L15_PIPE8.val_s2 && `L15_PIPE8.decoder_dtag_operation_s2 == `L15_DTAG_OP_READ)
    begin
        tag_data_TILE8[0] = `L15_PIPE8.dtag_tag_way0_s2[`L15_CACHE_TAG_WIDTH-1:0];
        tag_data_TILE8[1] = `L15_PIPE8.dtag_tag_way1_s2[`L15_CACHE_TAG_WIDTH-1:0];
        tag_data_TILE8[2] = `L15_PIPE8.dtag_tag_way2_s2[`L15_CACHE_TAG_WIDTH-1:0];
        tag_data_TILE8[3] = `L15_PIPE8.dtag_tag_way3_s2[`L15_CACHE_TAG_WIDTH-1:0];
        tag_val_TILE8[0] = `L15_PIPE8.mesi_state_way0_s2 != `L15_MESI_STATE_I;
        tag_val_TILE8[1] = `L15_PIPE8.mesi_state_way1_s2 != `L15_MESI_STATE_I;
        tag_val_TILE8[2] = `L15_PIPE8.mesi_state_way2_s2 != `L15_MESI_STATE_I;
        tag_val_TILE8[3] = `L15_PIPE8.mesi_state_way3_s2 != `L15_MESI_STATE_I;
        for (i_TILE8 = 0; i_TILE8 < 4; i_TILE8 = i_TILE8+1)
        begin
            for (j_TILE8 = 0; j_TILE8 < i_TILE8; j_TILE8 = j_TILE8 + 1)
            begin
                if ((tag_val_TILE8[i_TILE8] && tag_val_TILE8[j_TILE8]) && (tag_data_TILE8[i_TILE8] == tag_data_TILE8[j_TILE8]))
                begin
                    $display("%d : Simulation -> FAIL(%0s)", $time, "TILE8 L15 has duplicated tag entry");
                    `ifndef VERILATOR
                    repeat(5)@(posedge clk)
                    `endif
                        `MONITOR_PATH.fail("TILE8 L15 has duplicated tag entry");
                end
            end
        end
    end

// // monitor FP transactions because it is not supported yet
//     if (`L15_TOP8.noc1encoder.sending)
//     begin
//         $display("noc1 flit raw: 0x%x", `L15_TOP8.noc1encoder.flit);
//     end
//     if (`L15_PIPE8.pcxdecoder_l15_val && !`L15_PIPE8.pcx_message_staled_s1 && `L15_PIPE8.val_s1 && !`L15_PIPE8.stall_s1 && !`L15_PIPE8.noc2decoder_l15_val)
//     begin
//         $display("%d : Simulation -> FAIL(%0s)", $time, "FP requests received but not implemented");
//         `ifndef VERILATOR
//         repeat(5)@(posedge clk)
//         `endif
    //         `MONITOR_PATH.fail("FP requests received but not implemented");
//     end


// Monitor FP transactions
//    if (`TILE8.fpu_arb_wrap.pcx_fpio_data_px2[123]
//            && `TILE8.fpu_arb_wrap.pcx_fpio_data_px2[122:119] == 4'b0101)
//    begin
//        $display("TILE8 FPU th%d: Received FP%d",
//                    `TILE8.fpu_arb_wrap.pcx_fpio_data_px2[113:112],
//                    `TILE8.fpu_arb_wrap.pcx_fpio_data_px2[118]);
//    end
//    if (`TILE8.fpu_arb_wrap.fpu_arb_data_rdy
//            && !`TILE8.fpu_arb_wrap.l15_fp_rdy)
//        $display("TILE8 FPU th%d: Sent FP data",
//                    `TILE8.fpu_arb_wrap.fpu_arb_data[135:134]);

// monitor L1.5 way replacement error
    if (`L15_PIPE8.l15_dcache_val_s2
        && `L15_PIPE8.dcache_operation_s2 == `L15_DCACHE_READ_LRU_WAY_IF_M)
    begin
        if (`L15_PIPE8.lruarray_l15_dout_s2[`L15_PIPE8.lru_way_s2] == 1'b1)
        begin
            // replacing a valid line
            if (&`L15_PIPE8.lru_used_bits_s2[3:0] == 1'b0)
            begin
                // and an another entry is 0, then is an error
                $display("%d : Simulation -> FAIL(%0s)", $time, "TILE8 L15 picked the wrong LRU entry");
                `ifndef VERILATOR
                repeat(5)@(posedge clk)
                `endif
                    `MONITOR_PATH.fail("TILE8 L15 picked the wrong LRU entry");
            end
        end
    end

// monitor X's in stall signals
    if (`L15_PIPE8.val_s1 && (`L15_PIPE8.stall_s1 === 1'bx) ||
        `L15_PIPE8.val_s2 && (`L15_PIPE8.stall_s2 === 1'bx) ||
        `L15_PIPE8.val_s3 && (`L15_PIPE8.stall_s3 === 1'bx))
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "L15 has X's in the stall_s1 signal");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("L15 has X's in the stall_s1 signal");
    end

`ifdef RTL_SPARC8
// some checks for l15cpxencoder
    if (`L15_TOP8.l15_transducer_val)
    begin
        if (`L15_TOP8.l15_transducer_inval_icache_inval)
        begin
            $display("%d : Simulation -> FAIL(%0s)", $time, "l15 icache inval is not used");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("l15 icache inval is not used");
        end
        if (`L15_TOP8.l15_transducer_returntype == `CPX_RESTYPE_ATOMIC_RES
            && `L15_TOP8.l15_transducer_inval_dcache_inval)
        begin
            $display("%d : Simulation -> FAIL(%0s)", $time, "l15 CAS inval is not used");
            `ifndef VERILATOR
            repeat(5)@(posedge clk)
            `endif
                `MONITOR_PATH.fail("l15 CAS inval is not used");
        end
    end
`endif

// some checks for l15 noc1 encoder
    if (`L15_TOP8.noc1encoder.sending && `L15_TOP8.noc1encoder.req_type == 0)
    begin
        $display("%d : Simulation -> FAIL(%0s)", $time, "l15 noc1 message is null");
        `ifndef VERILATOR
        repeat(5)@(posedge clk)
        `endif
            `MONITOR_PATH.fail("l15 noc1 message is null");
    end

    end // disable_l15_mon
end

//CORE8 END



// // add temporary monitor for jtag
// always @ (negedge `JTAG.io_clk)
// begin
//     // write out the states of the JTAG state machine

//     //

endmodule