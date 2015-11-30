module mips_main
  (
    input wire signed [31:0] mem_imem_35_q,
    input wire signed [31:0] mem_dmem_36_q,
    input wire CLK,
    input wire RST,
    input wire mips_main_READY,
    input wire mips_main_ACCEPT,
    output reg signed [31:0] mips_main_OUT0,
    output reg mem_imem_35_req,
    output reg signed [31:0] mem_imem_35_d,
    output reg signed [5:0] mem_imem_35_addr,
    output reg mem_imem_35_we,
    output reg mem_dmem_36_req,
    output reg signed [31:0] mem_dmem_36_d,
    output reg signed [6:0] mem_dmem_36_addr,
    output reg mem_dmem_36_we,
    output reg mips_main_VALID  );

  //localparams
  localparam mips_main_grp_top0_INIT = 0;
  localparam mips_main_grp_top0_S0 = 1;
  localparam mips_main_grp_top0_S1 = 2;
  localparam mips_main_grp_top0_S2 = 3;
  localparam mips_main_grp_top0_S3 = 4;
  localparam mips_main_grp_top0_S4 = 5;
  localparam mips_main_grp_top0_S5 = 6;
  localparam mips_main_grp_top0_S6 = 7;
  localparam mips_main_grp_top0_S7 = 8;
  localparam mips_main_grp_top0_S8 = 9;
  localparam mips_main_grp_top0_S9 = 10;
  localparam mips_main_grp_top0_S10 = 11;
  localparam mips_main_grp_top0_S11 = 12;
  localparam mips_main_grp_top0_S12 = 13;
  localparam mips_main_grp_top0_S13 = 14;
  localparam mips_main_grp_top0_S14 = 15;
  localparam mips_main_grp_top0_S15 = 16;
  localparam mips_main_grp_top0_S16 = 17;
  localparam mips_main_grp_top0_S17 = 18;
  localparam mips_main_grp_top0_S18 = 19;
  localparam mips_main_grp_top0_S19 = 20;
  localparam mips_main_grp_top0_S20 = 21;
  localparam mips_main_grp_top0_S21 = 22;
  localparam mips_main_grp_top0_S22 = 23;
  localparam mips_main_grp_top0_S23 = 24;
  localparam mips_main_grp_top0_S24 = 25;
  localparam mips_main_grp_top0_S25 = 26;
  localparam mips_main_grp_top0_S26 = 27;
  localparam mips_main_grp_top0_S27 = 28;
  localparam mips_main_grp_top0_S28 = 29;
  localparam mips_main_grp_top0_S29 = 30;
  localparam mips_main_grp_top0_S30 = 31;
  localparam mips_main_grp_top0_S31 = 32;
  localparam mips_main_grp_top0_S32 = 33;
  localparam mips_main_grp_top0_S64 = 34;
  localparam mips_main_grp_top0_S65 = 35;
  localparam mips_main_grp_top0_S70 = 36;
  localparam mips_main_grp_top0_FINISH = 37;
  localparam L1_grp_top0_S0 = 38;
  localparam L1_grp_whilebody1_S0 = 39;
  localparam L1_grp_whilebody1_S1 = 40;
  localparam L1_grp_whilebody1_S2 = 41;
  localparam L1_grp_whilebody1_S3 = 42;
  localparam L1_grp_whilebody1_S4 = 43;
  localparam L1_grp_whilebody1_S5 = 44;
  localparam L1_grp_whilebody1_S6 = 45;
  localparam L1_grp_whilebody1_S11 = 46;
  localparam L1_grp_whilebody1_S23 = 47;
  localparam L1_grp_whilebody1_S26 = 48;
  localparam L1_grp_whilebody1_S33 = 49;
  localparam L1_grp_whilebody1_S34 = 50;
  localparam L1_grp_ifelse31_S12 = 51;
  localparam L1_grp_ifelse31_S13 = 52;
  localparam L1_grp_ifelse31_S15 = 53;
  localparam L1_grp_ifthen2_S12 = 54;
  localparam L1_grp_ifthen2_S13 = 55;
  localparam L1_grp_ifthen2_S15 = 56;
  localparam L1_grp_ifthen2_S16 = 57;
  localparam L1_grp_ifthen28_S12 = 58;
  localparam L1_grp_ifthen28_S13 = 59;
  localparam L1_grp_ifthen28_S14 = 60;
  localparam L1_grp_ifthen30_S12 = 61;
  localparam L1_grp_ifthen30_S13 = 62;
  localparam L1_grp_ifthen30_S14 = 63;
  localparam L1_grp_ifelse26_S17 = 64;
  localparam L1_grp_ifelse61_S16 = 65;
  localparam L1_grp_ifthen11_S17 = 66;
  localparam L1_grp_ifthen11_S18 = 67;
  localparam L1_grp_ifthen11_S19 = 68;
  localparam L1_grp_ifthen11_S20 = 69;
  localparam L1_grp_ifthen11_S21 = 70;
  localparam L1_grp_ifthen11_S22 = 71;
  localparam L1_grp_ifthen11_S23 = 72;
  localparam L1_grp_ifthen11_S24 = 73;
  localparam L1_grp_ifthen11_S25 = 74;
  localparam L1_grp_ifthen13_S17 = 75;
  localparam L1_grp_ifthen13_S18 = 76;
  localparam L1_grp_ifthen13_S19 = 77;
  localparam L1_grp_ifthen13_S20 = 78;
  localparam L1_grp_ifthen13_S21 = 79;
  localparam L1_grp_ifthen13_S22 = 80;
  localparam L1_grp_ifthen15_S17 = 81;
  localparam L1_grp_ifthen15_S18 = 82;
  localparam L1_grp_ifthen15_S19 = 83;
  localparam L1_grp_ifthen15_S20 = 84;
  localparam L1_grp_ifthen15_S21 = 85;
  localparam L1_grp_ifthen15_S22 = 86;
  localparam L1_grp_ifthen17_S17 = 87;
  localparam L1_grp_ifthen17_S18 = 88;
  localparam L1_grp_ifthen17_S19 = 89;
  localparam L1_grp_ifthen17_S20 = 90;
  localparam L1_grp_ifthen17_S21 = 91;
  localparam L1_grp_ifthen17_S22 = 92;
  localparam L1_grp_ifthen17_S23 = 93;
  localparam L1_grp_ifthen17_S24 = 94;
  localparam L1_grp_ifthen17_S25 = 95;
  localparam L1_grp_ifthen19_S17 = 96;
  localparam L1_grp_ifthen19_S18 = 97;
  localparam L1_grp_ifthen19_S19 = 98;
  localparam L1_grp_ifthen19_S20 = 99;
  localparam L1_grp_ifthen19_S21 = 100;
  localparam L1_grp_ifthen19_S22 = 101;
  localparam L1_grp_ifthen19_S23 = 102;
  localparam L1_grp_ifthen19_S24 = 103;
  localparam L1_grp_ifthen19_S25 = 104;
  localparam L1_grp_ifthen21_S17 = 105;
  localparam L1_grp_ifthen21_S18 = 106;
  localparam L1_grp_ifthen21_S19 = 107;
  localparam L1_grp_ifthen21_S20 = 108;
  localparam L1_grp_ifthen21_S21 = 109;
  localparam L1_grp_ifthen21_S22 = 110;
  localparam L1_grp_ifthen21_S23 = 111;
  localparam L1_grp_ifthen21_S24 = 112;
  localparam L1_grp_ifthen23_S17 = 113;
  localparam L1_grp_ifthen23_S18 = 114;
  localparam L1_grp_ifthen23_S19 = 115;
  localparam L1_grp_ifthen23_S20 = 116;
  localparam L1_grp_ifthen23_S21 = 117;
  localparam L1_grp_ifthen23_S22 = 118;
  localparam L1_grp_ifthen23_S23 = 119;
  localparam L1_grp_ifthen23_S24 = 120;
  localparam L1_grp_ifthen25_S17 = 121;
  localparam L1_grp_ifthen25_S18 = 122;
  localparam L1_grp_ifthen25_S19 = 123;
  localparam L1_grp_ifthen25_S20 = 124;
  localparam L1_grp_ifthen25_S21 = 125;
  localparam L1_grp_ifthen3_S17 = 126;
  localparam L1_grp_ifthen3_S18 = 127;
  localparam L1_grp_ifthen3_S19 = 128;
  localparam L1_grp_ifthen3_S20 = 129;
  localparam L1_grp_ifthen3_S21 = 130;
  localparam L1_grp_ifthen3_S22 = 131;
  localparam L1_grp_ifthen3_S23 = 132;
  localparam L1_grp_ifthen3_S24 = 133;
  localparam L1_grp_ifthen3_S25 = 134;
  localparam L1_grp_ifthen32_S16 = 135;
  localparam L1_grp_ifthen32_S17 = 136;
  localparam L1_grp_ifthen32_S18 = 137;
  localparam L1_grp_ifthen32_S19 = 138;
  localparam L1_grp_ifthen32_S20 = 139;
  localparam L1_grp_ifthen32_S21 = 140;
  localparam L1_grp_ifthen34_S16 = 141;
  localparam L1_grp_ifthen34_S17 = 142;
  localparam L1_grp_ifthen34_S18 = 143;
  localparam L1_grp_ifthen34_S19 = 144;
  localparam L1_grp_ifthen34_S20 = 145;
  localparam L1_grp_ifthen34_S21 = 146;
  localparam L1_grp_ifthen36_S16 = 147;
  localparam L1_grp_ifthen36_S17 = 148;
  localparam L1_grp_ifthen36_S18 = 149;
  localparam L1_grp_ifthen36_S19 = 150;
  localparam L1_grp_ifthen36_S20 = 151;
  localparam L1_grp_ifthen36_S21 = 152;
  localparam L1_grp_ifthen38_S16 = 153;
  localparam L1_grp_ifthen38_S17 = 154;
  localparam L1_grp_ifthen38_S18 = 155;
  localparam L1_grp_ifthen38_S19 = 156;
  localparam L1_grp_ifthen38_S20 = 157;
  localparam L1_grp_ifthen38_S21 = 158;
  localparam L1_grp_ifthen40_S16 = 159;
  localparam L1_grp_ifthen40_S17 = 160;
  localparam L1_grp_ifthen40_S18 = 161;
  localparam L1_grp_ifthen40_S19 = 162;
  localparam L1_grp_ifthen40_S20 = 163;
  localparam L1_grp_ifthen40_S21 = 164;
  localparam L1_grp_ifthen40_S22 = 165;
  localparam L1_grp_ifthen40_S29 = 166;
  localparam L1_grp_ifthen40_S30 = 167;
  localparam L1_grp_ifthen40_S31 = 168;
  localparam L1_grp_ifthen40_S32 = 169;
  localparam L1_grp_ifthen40_S33 = 170;
  localparam L1_grp_ifthen42_S16 = 171;
  localparam L1_grp_ifthen42_S17 = 172;
  localparam L1_grp_ifthen42_S18 = 173;
  localparam L1_grp_ifthen42_S19 = 174;
  localparam L1_grp_ifthen42_S20 = 175;
  localparam L1_grp_ifthen42_S21 = 176;
  localparam L1_grp_ifthen42_S22 = 177;
  localparam L1_grp_ifthen42_S25 = 178;
  localparam L1_grp_ifthen42_S26 = 179;
  localparam L1_grp_ifthen42_S27 = 180;
  localparam L1_grp_ifthen42_S28 = 181;
  localparam L1_grp_ifthen42_S29 = 182;
  localparam L1_grp_ifthen44_S16 = 183;
  localparam L1_grp_ifthen44_S17 = 184;
  localparam L1_grp_ifthen44_S18 = 185;
  localparam L1_grp_ifthen46_S16 = 186;
  localparam L1_grp_ifthen46_S17 = 187;
  localparam L1_grp_ifthen46_S18 = 188;
  localparam L1_grp_ifthen46_S19 = 189;
  localparam L1_grp_ifthen46_S20 = 190;
  localparam L1_grp_ifthen46_S21 = 191;
  localparam L1_grp_ifthen46_S22 = 192;
  localparam L1_grp_ifthen5_S17 = 193;
  localparam L1_grp_ifthen5_S18 = 194;
  localparam L1_grp_ifthen5_S19 = 195;
  localparam L1_grp_ifthen5_S20 = 196;
  localparam L1_grp_ifthen5_S21 = 197;
  localparam L1_grp_ifthen5_S22 = 198;
  localparam L1_grp_ifthen5_S23 = 199;
  localparam L1_grp_ifthen5_S24 = 200;
  localparam L1_grp_ifthen5_S25 = 201;
  localparam L1_grp_ifthen50_S16 = 202;
  localparam L1_grp_ifthen50_S17 = 203;
  localparam L1_grp_ifthen50_S18 = 204;
  localparam L1_grp_ifthen50_S19 = 205;
  localparam L1_grp_ifthen50_S20 = 206;
  localparam L1_grp_ifthen50_S21 = 207;
  localparam L1_grp_ifthen50_S22 = 208;
  localparam L1_grp_ifthen54_S16 = 209;
  localparam L1_grp_ifthen54_S17 = 210;
  localparam L1_grp_ifthen54_S18 = 211;
  localparam L1_grp_ifthen54_S19 = 212;
  localparam L1_grp_ifthen58_S16 = 213;
  localparam L1_grp_ifthen58_S17 = 214;
  localparam L1_grp_ifthen58_S18 = 215;
  localparam L1_grp_ifthen58_S19 = 216;
  localparam L1_grp_ifthen58_S20 = 217;
  localparam L1_grp_ifthen60_S16 = 218;
  localparam L1_grp_ifthen60_S17 = 219;
  localparam L1_grp_ifthen60_S18 = 220;
  localparam L1_grp_ifthen60_S19 = 221;
  localparam L1_grp_ifthen60_S20 = 222;
  localparam L1_grp_ifthen7_S17 = 223;
  localparam L1_grp_ifthen7_S18 = 224;
  localparam L1_grp_ifthen7_S19 = 225;
  localparam L1_grp_ifthen7_S20 = 226;
  localparam L1_grp_ifthen7_S21 = 227;
  localparam L1_grp_ifthen7_S22 = 228;
  localparam L1_grp_ifthen7_S23 = 229;
  localparam L1_grp_ifthen7_S24 = 230;
  localparam L1_grp_ifthen7_S25 = 231;
  localparam L1_grp_ifthen9_S17 = 232;
  localparam L1_grp_ifthen9_S18 = 233;
  localparam L1_grp_ifthen9_S19 = 234;
  localparam L1_grp_ifthen9_S20 = 235;
  localparam L1_grp_ifthen9_S21 = 236;
  localparam L1_grp_ifthen9_S22 = 237;
  localparam L1_grp_ifthen9_S23 = 238;
  localparam L1_grp_ifthen9_S24 = 239;
  localparam L1_grp_ifthen9_S25 = 240;
  localparam L1_grp_ifthen47_S23 = 241;
  localparam L1_grp_ifthen47_S24 = 242;
  localparam L1_grp_ifthen47_S25 = 243;
  localparam L1_grp_ifthen51_S23 = 244;
  localparam L1_grp_ifthen51_S24 = 245;
  localparam L1_grp_ifthen51_S25 = 246;
  localparam L1_grp_ifthen55_S20 = 247;
  localparam L1_grp_ifthen55_S21 = 248;
  localparam L1_grp_ifthen55_S22 = 249;
  localparam L1_grp_ifthen62_S35 = 250;
  localparam L1_grp_bridge64_S2 = 251;
  localparam L1_grp_bridge64_S6 = 252;
  localparam L1_grp_bridge64_S7 = 253;
  localparam L1_grp_bridge64_S24 = 254;
  localparam L1_grp_bridge64_S26 = 255;
  
  //internal regs
  reg signed [31:0] addr_1;
  reg signed [31:0] addr_2;
  reg signed [31:0] addr_3;
  reg signed [31:0] addr_4;
  reg signed [31:0] addr_5;
  reg signed [31:0] address_1;
  reg signed [31:0] address_2;
  reg signed [31:0] address_3;
  reg signed [31:0] address_4;
  reg signed [31:0] daddr_1;
  reg signed [31:0] daddr_2;
  reg signed [31:0] daddr_3;
  reg signed [31:0] daddr_4;
  reg signed [31:0] daddr_5;
  reg signed [31:0] funct_1;
  reg signed [31:0] funct_2;
  reg signed [31:0] funct_3;
  reg signed [31:0] funct_4;
  reg signed [31:0] iaddr_1;
  reg signed [31:0] iaddr_2;
  reg signed [31:0] iaddr_3;
  reg signed [31:0] ins_1;
  reg signed [31:0] ins_2;
  reg signed [31:0] ins_3;
  reg /*unsigned*/ [5:0] mem_reg_1_439_addr;
  reg signed [31:0] mem_reg_1_439_d;
  reg mem_reg_1_439_req;
  reg mem_reg_1_439_we;
  reg /*unsigned*/ [8:0] mips_main_state;
  reg signed [31:0] n_inst_2;
  reg signed [31:0] n_inst_3;
  reg signed [31:0] n_inst_4;
  reg signed [31:0] op_1;
  reg signed [31:0] op_2;
  reg signed [31:0] op_3;
  reg signed [31:0] pc_10;
  reg signed [31:0] pc_11;
  reg signed [31:0] pc_12;
  reg signed [31:0] pc_13;
  reg signed [31:0] pc_2;
  reg signed [31:0] pc_3;
  reg signed [31:0] pc_4;
  reg signed [31:0] pc_5;
  reg signed [31:0] pc_7;
  reg signed [31:0] pc_8;
  reg signed [31:0] rd_1;
  reg signed [31:0] rd_2;
  reg signed [31:0] rd_3;
  reg signed [31:0] rd_4;
  reg signed [31:0] rs_1;
  reg signed [31:0] rs_2;
  reg signed [31:0] rs_3;
  reg signed [31:0] rs_4;
  reg signed [31:0] rs_5;
  reg signed [31:0] rt_1;
  reg signed [31:0] rt_2;
  reg signed [31:0] rt_3;
  reg signed [31:0] rt_4;
  reg signed [31:0] rt_5;
  reg signed [31:0] shamt_1;
  reg signed [31:0] shamt_2;
  reg signed [31:0] shamt_3;
  reg signed [31:0] shamt_4;
  reg signed [31:0] t100;
  reg signed [31:0] t101;
  reg signed [31:0] t102;
  reg signed [31:0] t103;
  reg signed [31:0] t104;
  reg signed [31:0] t105;
  reg signed [31:0] t106;
  reg signed [31:0] t107;
  reg signed [31:0] t108;
  reg signed [31:0] t109;
  reg signed [31:0] t110;
  reg signed [31:0] t111;
  reg signed [31:0] t112;
  reg signed [31:0] t114;
  reg signed [31:0] t115;
  reg signed [31:0] t117;
  reg signed [31:0] t118;
  reg signed [31:0] t119;
  reg signed [31:0] t132;
  reg signed [31:0] t133;
  reg signed [31:0] t134;
  reg signed [31:0] t135;
  reg signed [31:0] t136;
  reg signed [31:0] t137;
  reg signed [31:0] t138;
  reg signed [31:0] t139;
  reg signed [31:0] t140;
  reg signed [31:0] t141;
  reg signed [31:0] t142;
  reg signed [31:0] t143;
  reg signed [31:0] t144;
  reg signed [31:0] t145;
  reg signed [31:0] t146;
  reg signed [31:0] t147;
  reg signed [31:0] t148;
  reg signed [31:0] t150;
  reg signed [31:0] t151;
  reg signed [31:0] t152;
  reg signed [31:0] t153;
  reg signed [31:0] t155;
  reg signed [31:0] t156;
  reg signed [31:0] t157;
  reg signed [31:0] t159;
  reg signed [31:0] t160;
  reg signed [31:0] t161;
  reg signed [31:0] t163;
  reg signed [31:0] t64;
  reg signed [31:0] t65;
  reg signed [31:0] t69;
  reg signed [31:0] t70;
  reg signed [31:0] t71;
  reg signed [31:0] t72;
  reg signed [31:0] t85;
  reg signed [31:0] t86;
  reg signed [31:0] t87;
  reg signed [31:0] t89;
  reg signed [31:0] t90;
  reg signed [31:0] t91;
  reg signed [31:0] t92;
  reg signed [31:0] t93;
  reg signed [31:0] t94;
  reg signed [31:0] t95;
  reg signed [31:0] t96;
  reg signed [31:0] t97;
  reg signed [31:0] t98;
  reg signed [31:0] t99;
  reg signed [31:0] tgtadr_1;
  reg signed [31:0] tgtadr_2;
  reg signed [31:0] tgtadr_3;
  reg signed [31:0] tgtadr_4;
  reg signed [31:0] tgtadr_5;
  
  
  //internal wires
  wire cond149;
  wire cond164;
  wire cond76;
  wire cond75;
  wire cond77;
  wire cond80;
  wire cond154;
  wire cond79;
  wire cond84;
  wire cond78;
  wire cond81;
  wire cond74;
  wire cond82;
  wire cond113;
  wire cond158;
  wire cond73;
  wire cond116;
  wire cond88;
  wire cond66;
  wire cond162;
  wire cond120;
  wire cond83;
  wire cond121;
  wire cond122;
  wire cond123;
  wire cond124;
  wire cond125;
  wire cond126;
  wire cond127;
  wire cond128;
  wire cond67;
  wire cond129;
  wire cond130;
  wire cond131;
  wire cond68;
  wire signed [31:0] mem_reg_1_439_q;
  
  //sub module instances
  SinglePortRam#(.DATA_WIDTH(32), .ADDR_WIDTH(6)) mem_reg_1_439(.CLK(CLK), .RST(RST), .D(mem_reg_1_439_d), .Q(mem_reg_1_439_q), .ADDR(mem_reg_1_439_addr), .WE(mem_reg_1_439_we));
  
  //assigns
  assign cond66 = (op_2 == 0);
  assign cond67 = (op_2 == 2);
  assign cond68 = (op_2 == 3);
  assign cond88 = (pc_12 == 0);
  assign cond120 = (op_2 == 9);
  assign cond121 = (op_2 == 12);
  assign cond122 = (op_2 == 13);
  assign cond123 = (op_2 == 14);
  assign cond124 = (op_2 == 35);
  assign cond125 = (op_2 == 43);
  assign cond126 = (op_2 == 15);
  assign cond127 = (op_2 == 4);
  assign cond128 = (op_2 == 5);
  assign cond129 = (op_2 == 1);
  assign cond130 = (op_2 == 10);
  assign cond131 = (op_2 == 11);
  assign cond73 = (funct_2 == 33);
  assign cond74 = (funct_2 == 35);
  assign cond75 = (funct_2 == 36);
  assign cond76 = (funct_2 == 37);
  assign cond77 = (funct_2 == 38);
  assign cond78 = (funct_2 == 0);
  assign cond79 = (funct_2 == 2);
  assign cond80 = (funct_2 == 4);
  assign cond81 = (funct_2 == 6);
  assign cond82 = (funct_2 == 42);
  assign cond83 = (funct_2 == 43);
  assign cond84 = (funct_2 == 8);
  assign cond113 = (t111 < t112);
  assign cond116 = (t114 < t115);
  assign cond149 = (t147 == t148);
  assign cond154 = (t152 != t153);
  assign cond158 = (t157 >= 0);
  assign cond162 = (t161 < address_2);
  assign cond164 = (t163 < address_2);
  
  always @(posedge CLK) begin
    if (RST) begin
      mips_main_OUT0 <= 0;
      mem_imem_35_req <= 0;
      mem_imem_35_d <= 0;
      mem_imem_35_addr <= 0;
      mem_imem_35_we <= 0;
      mem_dmem_36_req <= 0;
      mem_dmem_36_d <= 0;
      mem_dmem_36_addr <= 0;
      mem_dmem_36_we <= 0;
      mips_main_VALID <= 0;
      mips_main_state <= mips_main_grp_top0_INIT;
    end else begin //if (RST)
      case(mips_main_state)
      mips_main_grp_top0_INIT: begin
        if (mips_main_READY == 1) begin
          mips_main_VALID <= 0;
          mips_main_state <= mips_main_grp_top0_S0;
        end
      end
      mips_main_grp_top0_S0: begin
        mem_reg_1_439_req <= 1;
        mem_reg_1_439_addr <= 0;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= 0;
        pc_2 <= 4194304;
        n_inst_2 <= 0;
        mips_main_state <= mips_main_grp_top0_S1;
      end
      mips_main_grp_top0_S1: begin
        mem_reg_1_439_addr <= 1;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= 0;
        mips_main_state <= mips_main_grp_top0_S2;
      end
      mips_main_grp_top0_S2: begin
        mem_reg_1_439_addr <= 2;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= 0;
        mips_main_state <= mips_main_grp_top0_S3;
      end
      mips_main_grp_top0_S3: begin
        mem_reg_1_439_addr <= 3;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= 0;
        mips_main_state <= mips_main_grp_top0_S4;
      end
      mips_main_grp_top0_S4: begin
        mem_reg_1_439_addr <= 4;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= 0;
        mips_main_state <= mips_main_grp_top0_S5;
      end
      mips_main_grp_top0_S5: begin
        mem_reg_1_439_addr <= 5;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= 0;
        mips_main_state <= mips_main_grp_top0_S6;
      end
      mips_main_grp_top0_S6: begin
        mem_reg_1_439_addr <= 6;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= 0;
        mips_main_state <= mips_main_grp_top0_S7;
      end
      mips_main_grp_top0_S7: begin
        mem_reg_1_439_addr <= 7;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= 0;
        mips_main_state <= mips_main_grp_top0_S8;
      end
      mips_main_grp_top0_S8: begin
        mem_reg_1_439_addr <= 8;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= 0;
        mips_main_state <= mips_main_grp_top0_S9;
      end
      mips_main_grp_top0_S9: begin
        mem_reg_1_439_addr <= 9;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= 0;
        mips_main_state <= mips_main_grp_top0_S10;
      end
      mips_main_grp_top0_S10: begin
        mem_reg_1_439_addr <= 10;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= 0;
        mips_main_state <= mips_main_grp_top0_S11;
      end
      mips_main_grp_top0_S11: begin
        mem_reg_1_439_addr <= 11;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= 0;
        mips_main_state <= mips_main_grp_top0_S12;
      end
      mips_main_grp_top0_S12: begin
        mem_reg_1_439_addr <= 12;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= 0;
        mips_main_state <= mips_main_grp_top0_S13;
      end
      mips_main_grp_top0_S13: begin
        mem_reg_1_439_addr <= 13;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= 0;
        mips_main_state <= mips_main_grp_top0_S14;
      end
      mips_main_grp_top0_S14: begin
        mem_reg_1_439_addr <= 14;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= 0;
        mips_main_state <= mips_main_grp_top0_S15;
      end
      mips_main_grp_top0_S15: begin
        mem_reg_1_439_addr <= 15;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= 0;
        mips_main_state <= mips_main_grp_top0_S16;
      end
      mips_main_grp_top0_S16: begin
        mem_reg_1_439_addr <= 16;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= 0;
        mips_main_state <= mips_main_grp_top0_S17;
      end
      mips_main_grp_top0_S17: begin
        mem_reg_1_439_addr <= 17;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= 0;
        mips_main_state <= mips_main_grp_top0_S18;
      end
      mips_main_grp_top0_S18: begin
        mem_reg_1_439_addr <= 18;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= 0;
        mips_main_state <= mips_main_grp_top0_S19;
      end
      mips_main_grp_top0_S19: begin
        mem_reg_1_439_addr <= 19;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= 0;
        mips_main_state <= mips_main_grp_top0_S20;
      end
      mips_main_grp_top0_S20: begin
        mem_reg_1_439_addr <= 20;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= 0;
        mips_main_state <= mips_main_grp_top0_S21;
      end
      mips_main_grp_top0_S21: begin
        mem_reg_1_439_addr <= 21;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= 0;
        mips_main_state <= mips_main_grp_top0_S22;
      end
      mips_main_grp_top0_S22: begin
        mem_reg_1_439_addr <= 22;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= 0;
        mips_main_state <= mips_main_grp_top0_S23;
      end
      mips_main_grp_top0_S23: begin
        mem_reg_1_439_addr <= 23;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= 0;
        mips_main_state <= mips_main_grp_top0_S24;
      end
      mips_main_grp_top0_S24: begin
        mem_reg_1_439_addr <= 24;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= 0;
        mips_main_state <= mips_main_grp_top0_S25;
      end
      mips_main_grp_top0_S25: begin
        mem_reg_1_439_addr <= 25;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= 0;
        mips_main_state <= mips_main_grp_top0_S26;
      end
      mips_main_grp_top0_S26: begin
        mem_reg_1_439_addr <= 26;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= 0;
        mips_main_state <= mips_main_grp_top0_S27;
      end
      mips_main_grp_top0_S27: begin
        mem_reg_1_439_addr <= 27;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= 0;
        mips_main_state <= mips_main_grp_top0_S28;
      end
      mips_main_grp_top0_S28: begin
        mem_reg_1_439_addr <= 28;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= 0;
        mips_main_state <= mips_main_grp_top0_S29;
      end
      mips_main_grp_top0_S29: begin
        mem_reg_1_439_addr <= 29;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= 0;
        mips_main_state <= mips_main_grp_top0_S30;
      end
      mips_main_grp_top0_S30: begin
        mem_reg_1_439_addr <= 30;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= 0;
        mips_main_state <= mips_main_grp_top0_S31;
      end
      mips_main_grp_top0_S31: begin
        mem_reg_1_439_addr <= 31;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= 0;
        mips_main_state <= mips_main_grp_top0_S32;
      end
      mips_main_grp_top0_S32: begin
        mem_reg_1_439_req <= 0;
        mips_main_state <= mips_main_grp_top0_S64;
      end
      mips_main_grp_top0_S64: begin
        mem_reg_1_439_req <= 1;
        mem_reg_1_439_addr <= 29;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= 2147479548;
        mips_main_state <= mips_main_grp_top0_S65;
      end
      mips_main_grp_top0_S65: begin
        mem_reg_1_439_req <= 0;
        mips_main_state <= L1_grp_top0_S0;
      end
      mips_main_grp_top0_S70: begin
        mips_main_OUT0 <= n_inst_4;
        mips_main_state <= mips_main_grp_top0_FINISH;
      end
      mips_main_grp_top0_FINISH: begin
        mips_main_VALID <= 1;
        if (mips_main_ACCEPT == 1) begin
          mips_main_state <= mips_main_grp_top0_INIT;
        end
      end
      L1_grp_top0_S0: begin
        pc_13 <= pc_2;
        n_inst_4 <= n_inst_2;
        mips_main_state <= L1_grp_whilebody1_S0;
      end
      L1_grp_whilebody1_S0: begin
        pc_3 <= (pc_2 + 4);
        t64 <= (pc_2 & 255);
        mips_main_state <= L1_grp_whilebody1_S1;
      end
      L1_grp_whilebody1_S1: begin
        iaddr_2 <= (t64 >> 2);
        mips_main_state <= L1_grp_whilebody1_S2;
      end
      L1_grp_whilebody1_S2: begin
        mem_imem_35_req <= 1;
        mem_imem_35_addr <= iaddr_2;
        mem_imem_35_we <= 0;
        mips_main_state <= L1_grp_whilebody1_S3;
      end
      L1_grp_whilebody1_S3: begin
        /*wait for mem read*/
        mips_main_state <= L1_grp_whilebody1_S4;
      end
      L1_grp_whilebody1_S4: begin
        t65 <= mem_imem_35_q;
        mips_main_state <= L1_grp_whilebody1_S5;
      end
      L1_grp_whilebody1_S5: begin
        mem_imem_35_req <= 0;
        ins_2 <= t65;
        mips_main_state <= L1_grp_whilebody1_S6;
      end
      L1_grp_whilebody1_S6: begin
        op_2 <= (ins_2 >> 26);
        mips_main_state <= L1_grp_whilebody1_S11;
      end
      L1_grp_whilebody1_S11: begin
        if (cond66) begin
          mips_main_state <= L1_grp_ifthen2_S12;
        end else if (cond67) begin
          mips_main_state <= L1_grp_ifthen28_S12;
        end else if (cond68) begin
          mips_main_state <= L1_grp_ifthen30_S12;
        end else if (1) begin
          mips_main_state <= L1_grp_ifelse31_S12;
        end
      end
      L1_grp_whilebody1_S23: begin
        n_inst_3 <= (n_inst_2 + 1);
        mips_main_state <= L1_grp_whilebody1_S26;
      end
      L1_grp_whilebody1_S26: begin
        mips_main_state <= L1_grp_whilebody1_S33;
      end
      L1_grp_whilebody1_S33: begin
        mem_reg_1_439_req <= 1;
        mem_reg_1_439_addr <= 0;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= 0;
        mips_main_state <= L1_grp_whilebody1_S34;
      end
      L1_grp_whilebody1_S34: begin
        mem_reg_1_439_req <= 0;
        if (cond88) begin
          mips_main_state <= L1_grp_ifthen62_S35;
        end else begin
          mips_main_state <= L1_grp_bridge64_S2;
        end
      end
      L1_grp_ifelse31_S12: begin
        address_2 <= (ins_2 & 65535);
        t118 <= (ins_2 >> 16);
        t119 <= (ins_2 >> 21);
        mips_main_state <= L1_grp_ifelse31_S13;
      end
      L1_grp_ifelse31_S13: begin
        rs_3 <= (t119 & 31);
        rt_3 <= (t118 & 31);
        mips_main_state <= L1_grp_ifelse31_S15;
      end
      L1_grp_ifelse31_S15: begin
        if (cond120) begin
          mips_main_state <= L1_grp_ifthen32_S16;
        end else if (cond121) begin
          mips_main_state <= L1_grp_ifthen34_S16;
        end else if (cond122) begin
          mips_main_state <= L1_grp_ifthen36_S16;
        end else if (cond123) begin
          mips_main_state <= L1_grp_ifthen38_S16;
        end else if (cond124) begin
          mips_main_state <= L1_grp_ifthen40_S16;
        end else if (cond125) begin
          mips_main_state <= L1_grp_ifthen42_S16;
        end else if (cond126) begin
          mips_main_state <= L1_grp_ifthen44_S16;
        end else if (cond127) begin
          mips_main_state <= L1_grp_ifthen46_S16;
        end else if (cond128) begin
          mips_main_state <= L1_grp_ifthen50_S16;
        end else if (cond129) begin
          mips_main_state <= L1_grp_ifthen54_S16;
        end else if (cond130) begin
          mips_main_state <= L1_grp_ifthen58_S16;
        end else if (cond131) begin
          mips_main_state <= L1_grp_ifthen60_S16;
        end else if (1) begin
          mips_main_state <= L1_grp_ifelse61_S16;
        end
      end
      L1_grp_ifthen2_S12: begin
        funct_2 <= (ins_2 & 63);
        t69 <= (ins_2 >> 6);
        t70 <= (ins_2 >> 11);
        t71 <= (ins_2 >> 16);
        t72 <= (ins_2 >> 21);
        mips_main_state <= L1_grp_ifthen2_S13;
      end
      L1_grp_ifthen2_S13: begin
        rs_2 <= (t72 & 31);
        rt_2 <= (t71 & 31);
        rd_2 <= (t70 & 31);
        shamt_2 <= (t69 & 31);
        mips_main_state <= L1_grp_ifthen2_S15;
      end
      L1_grp_ifthen2_S15: begin
        mips_main_state <= L1_grp_ifthen2_S16;
      end
      L1_grp_ifthen2_S16: begin
        if (cond73) begin
          mips_main_state <= L1_grp_ifthen3_S17;
        end else if (cond74) begin
          mips_main_state <= L1_grp_ifthen5_S17;
        end else if (cond75) begin
          mips_main_state <= L1_grp_ifthen7_S17;
        end else if (cond76) begin
          mips_main_state <= L1_grp_ifthen9_S17;
        end else if (cond77) begin
          mips_main_state <= L1_grp_ifthen11_S17;
        end else if (cond78) begin
          mips_main_state <= L1_grp_ifthen13_S17;
        end else if (cond79) begin
          mips_main_state <= L1_grp_ifthen15_S17;
        end else if (cond80) begin
          mips_main_state <= L1_grp_ifthen17_S17;
        end else if (cond81) begin
          mips_main_state <= L1_grp_ifthen19_S17;
        end else if (cond82) begin
          mips_main_state <= L1_grp_ifthen21_S17;
        end else if (cond83) begin
          mips_main_state <= L1_grp_ifthen23_S17;
        end else if (cond84) begin
          mips_main_state <= L1_grp_ifthen25_S17;
        end else if (1) begin
          mips_main_state <= L1_grp_ifelse26_S17;
        end
      end
      L1_grp_ifthen28_S12: begin
        rt_4 <= rt_1;
        rs_4 <= rs_1;
        rd_3 <= rd_1;
        addr_4 <= addr_1;
        funct_3 <= funct_1;
        address_3 <= address_1;
        daddr_4 <= daddr_1;
        shamt_3 <= shamt_1;
        tgtadr_2 <= (ins_2 & 67108863);
        mips_main_state <= L1_grp_ifthen28_S13;
      end
      L1_grp_ifthen28_S13: begin
        tgtadr_4 <= tgtadr_2;
        pc_4 <= (tgtadr_2 << 2);
        mips_main_state <= L1_grp_ifthen28_S14;
      end
      L1_grp_ifthen28_S14: begin
        pc_12 <= pc_4;
        mips_main_state <= L1_grp_whilebody1_S23;
      end
      L1_grp_ifthen30_S12: begin
        mem_reg_1_439_req <= 1;
        mem_reg_1_439_addr <= 31;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= pc_3;
        rt_4 <= rt_1;
        rs_4 <= rs_1;
        rd_3 <= rd_1;
        addr_4 <= addr_1;
        funct_3 <= funct_1;
        address_3 <= address_1;
        daddr_4 <= daddr_1;
        shamt_3 <= shamt_1;
        tgtadr_3 <= (ins_2 & 67108863);
        mips_main_state <= L1_grp_ifthen30_S13;
      end
      L1_grp_ifthen30_S13: begin
        mem_reg_1_439_req <= 0;
        tgtadr_4 <= tgtadr_3;
        pc_5 <= (tgtadr_3 << 2);
        mips_main_state <= L1_grp_ifthen30_S14;
      end
      L1_grp_ifthen30_S14: begin
        pc_12 <= pc_5;
        mips_main_state <= L1_grp_whilebody1_S23;
      end
      L1_grp_ifelse26_S17: begin
        pc_12 <= 0;
        rt_4 <= rt_2;
        rs_4 <= rs_2;
        rd_3 <= rd_2;
        addr_4 <= addr_1;
        funct_3 <= funct_2;
        address_3 <= address_1;
        daddr_4 <= daddr_1;
        shamt_3 <= shamt_2;
        tgtadr_4 <= tgtadr_1;
        mips_main_state <= L1_grp_whilebody1_S23;
      end
      L1_grp_ifelse61_S16: begin
        pc_12 <= 0;
        rt_4 <= rt_3;
        rs_4 <= rs_3;
        rd_3 <= rd_1;
        addr_4 <= addr_1;
        funct_3 <= funct_1;
        address_3 <= address_2;
        daddr_4 <= daddr_1;
        shamt_3 <= shamt_1;
        tgtadr_4 <= tgtadr_1;
        mips_main_state <= L1_grp_whilebody1_S23;
      end
      L1_grp_ifthen11_S17: begin
        pc_12 <= pc_3;
        rt_4 <= rt_2;
        rs_4 <= rs_2;
        rd_3 <= rd_2;
        addr_4 <= addr_1;
        funct_3 <= funct_2;
        address_3 <= address_1;
        daddr_4 <= daddr_1;
        shamt_3 <= shamt_2;
        tgtadr_4 <= tgtadr_1;
        mem_reg_1_439_req <= 1;
        mem_reg_1_439_addr <= rs_2;
        mem_reg_1_439_we <= 0;
        mips_main_state <= L1_grp_ifthen11_S18;
      end
      L1_grp_ifthen11_S18: begin
        /*wait for mem read*/
        mips_main_state <= L1_grp_ifthen11_S19;
      end
      L1_grp_ifthen11_S19: begin
        t98 <= mem_reg_1_439_q;
        mips_main_state <= L1_grp_ifthen11_S20;
      end
      L1_grp_ifthen11_S20: begin
        mem_reg_1_439_addr <= rt_2;
        mem_reg_1_439_we <= 0;
        mips_main_state <= L1_grp_ifthen11_S21;
      end
      L1_grp_ifthen11_S21: begin
        /*wait for mem read*/
        mips_main_state <= L1_grp_ifthen11_S22;
      end
      L1_grp_ifthen11_S22: begin
        t99 <= mem_reg_1_439_q;
        mips_main_state <= L1_grp_ifthen11_S23;
      end
      L1_grp_ifthen11_S23: begin
        mem_reg_1_439_req <= 0;
        t100 <= (t98 ^ t99);
        mips_main_state <= L1_grp_ifthen11_S24;
      end
      L1_grp_ifthen11_S24: begin
        mem_reg_1_439_req <= 1;
        mem_reg_1_439_addr <= rd_2;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= t100;
        mips_main_state <= L1_grp_ifthen11_S25;
      end
      L1_grp_ifthen11_S25: begin
        mem_reg_1_439_req <= 0;
        mips_main_state <= L1_grp_whilebody1_S23;
      end
      L1_grp_ifthen13_S17: begin
        pc_12 <= pc_3;
        rt_4 <= rt_2;
        rs_4 <= rs_2;
        rd_3 <= rd_2;
        addr_4 <= addr_1;
        funct_3 <= funct_2;
        address_3 <= address_1;
        daddr_4 <= daddr_1;
        shamt_3 <= shamt_2;
        tgtadr_4 <= tgtadr_1;
        mem_reg_1_439_req <= 1;
        mem_reg_1_439_addr <= rt_2;
        mem_reg_1_439_we <= 0;
        mips_main_state <= L1_grp_ifthen13_S18;
      end
      L1_grp_ifthen13_S18: begin
        /*wait for mem read*/
        mips_main_state <= L1_grp_ifthen13_S19;
      end
      L1_grp_ifthen13_S19: begin
        t101 <= mem_reg_1_439_q;
        mips_main_state <= L1_grp_ifthen13_S20;
      end
      L1_grp_ifthen13_S20: begin
        mem_reg_1_439_req <= 0;
        t102 <= (t101 << shamt_2);
        mips_main_state <= L1_grp_ifthen13_S21;
      end
      L1_grp_ifthen13_S21: begin
        mem_reg_1_439_req <= 1;
        mem_reg_1_439_addr <= rd_2;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= t102;
        mips_main_state <= L1_grp_ifthen13_S22;
      end
      L1_grp_ifthen13_S22: begin
        mem_reg_1_439_req <= 0;
        mips_main_state <= L1_grp_whilebody1_S23;
      end
      L1_grp_ifthen15_S17: begin
        pc_12 <= pc_3;
        rt_4 <= rt_2;
        rs_4 <= rs_2;
        rd_3 <= rd_2;
        addr_4 <= addr_1;
        funct_3 <= funct_2;
        address_3 <= address_1;
        daddr_4 <= daddr_1;
        shamt_3 <= shamt_2;
        tgtadr_4 <= tgtadr_1;
        mem_reg_1_439_req <= 1;
        mem_reg_1_439_addr <= rt_2;
        mem_reg_1_439_we <= 0;
        mips_main_state <= L1_grp_ifthen15_S18;
      end
      L1_grp_ifthen15_S18: begin
        /*wait for mem read*/
        mips_main_state <= L1_grp_ifthen15_S19;
      end
      L1_grp_ifthen15_S19: begin
        t103 <= mem_reg_1_439_q;
        mips_main_state <= L1_grp_ifthen15_S20;
      end
      L1_grp_ifthen15_S20: begin
        mem_reg_1_439_req <= 0;
        t104 <= (t103 >> shamt_2);
        mips_main_state <= L1_grp_ifthen15_S21;
      end
      L1_grp_ifthen15_S21: begin
        mem_reg_1_439_req <= 1;
        mem_reg_1_439_addr <= rd_2;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= t104;
        mips_main_state <= L1_grp_ifthen15_S22;
      end
      L1_grp_ifthen15_S22: begin
        mem_reg_1_439_req <= 0;
        mips_main_state <= L1_grp_whilebody1_S23;
      end
      L1_grp_ifthen17_S17: begin
        pc_12 <= pc_3;
        rt_4 <= rt_2;
        rs_4 <= rs_2;
        rd_3 <= rd_2;
        addr_4 <= addr_1;
        funct_3 <= funct_2;
        address_3 <= address_1;
        daddr_4 <= daddr_1;
        shamt_3 <= shamt_2;
        tgtadr_4 <= tgtadr_1;
        mem_reg_1_439_req <= 1;
        mem_reg_1_439_addr <= rt_2;
        mem_reg_1_439_we <= 0;
        mips_main_state <= L1_grp_ifthen17_S18;
      end
      L1_grp_ifthen17_S18: begin
        /*wait for mem read*/
        mips_main_state <= L1_grp_ifthen17_S19;
      end
      L1_grp_ifthen17_S19: begin
        t105 <= mem_reg_1_439_q;
        mips_main_state <= L1_grp_ifthen17_S20;
      end
      L1_grp_ifthen17_S20: begin
        mem_reg_1_439_addr <= rs_2;
        mem_reg_1_439_we <= 0;
        mips_main_state <= L1_grp_ifthen17_S21;
      end
      L1_grp_ifthen17_S21: begin
        /*wait for mem read*/
        mips_main_state <= L1_grp_ifthen17_S22;
      end
      L1_grp_ifthen17_S22: begin
        t106 <= mem_reg_1_439_q;
        mips_main_state <= L1_grp_ifthen17_S23;
      end
      L1_grp_ifthen17_S23: begin
        mem_reg_1_439_req <= 0;
        t107 <= (t105 << t106);
        mips_main_state <= L1_grp_ifthen17_S24;
      end
      L1_grp_ifthen17_S24: begin
        mem_reg_1_439_req <= 1;
        mem_reg_1_439_addr <= rd_2;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= t107;
        mips_main_state <= L1_grp_ifthen17_S25;
      end
      L1_grp_ifthen17_S25: begin
        mem_reg_1_439_req <= 0;
        mips_main_state <= L1_grp_whilebody1_S23;
      end
      L1_grp_ifthen19_S17: begin
        pc_12 <= pc_3;
        rt_4 <= rt_2;
        rs_4 <= rs_2;
        rd_3 <= rd_2;
        addr_4 <= addr_1;
        funct_3 <= funct_2;
        address_3 <= address_1;
        daddr_4 <= daddr_1;
        shamt_3 <= shamt_2;
        tgtadr_4 <= tgtadr_1;
        mem_reg_1_439_req <= 1;
        mem_reg_1_439_addr <= rt_2;
        mem_reg_1_439_we <= 0;
        mips_main_state <= L1_grp_ifthen19_S18;
      end
      L1_grp_ifthen19_S18: begin
        /*wait for mem read*/
        mips_main_state <= L1_grp_ifthen19_S19;
      end
      L1_grp_ifthen19_S19: begin
        t108 <= mem_reg_1_439_q;
        mips_main_state <= L1_grp_ifthen19_S20;
      end
      L1_grp_ifthen19_S20: begin
        mem_reg_1_439_addr <= rs_2;
        mem_reg_1_439_we <= 0;
        mips_main_state <= L1_grp_ifthen19_S21;
      end
      L1_grp_ifthen19_S21: begin
        /*wait for mem read*/
        mips_main_state <= L1_grp_ifthen19_S22;
      end
      L1_grp_ifthen19_S22: begin
        t109 <= mem_reg_1_439_q;
        mips_main_state <= L1_grp_ifthen19_S23;
      end
      L1_grp_ifthen19_S23: begin
        mem_reg_1_439_req <= 0;
        t110 <= (t108 >> t109);
        mips_main_state <= L1_grp_ifthen19_S24;
      end
      L1_grp_ifthen19_S24: begin
        mem_reg_1_439_req <= 1;
        mem_reg_1_439_addr <= rd_2;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= t110;
        mips_main_state <= L1_grp_ifthen19_S25;
      end
      L1_grp_ifthen19_S25: begin
        mem_reg_1_439_req <= 0;
        mips_main_state <= L1_grp_whilebody1_S23;
      end
      L1_grp_ifthen21_S17: begin
        pc_12 <= pc_3;
        rt_4 <= rt_2;
        rs_4 <= rs_2;
        rd_3 <= rd_2;
        addr_4 <= addr_1;
        funct_3 <= funct_2;
        address_3 <= address_1;
        daddr_4 <= daddr_1;
        shamt_3 <= shamt_2;
        tgtadr_4 <= tgtadr_1;
        mem_reg_1_439_req <= 1;
        mem_reg_1_439_addr <= rs_2;
        mem_reg_1_439_we <= 0;
        mips_main_state <= L1_grp_ifthen21_S18;
      end
      L1_grp_ifthen21_S18: begin
        /*wait for mem read*/
        mips_main_state <= L1_grp_ifthen21_S19;
      end
      L1_grp_ifthen21_S19: begin
        t111 <= mem_reg_1_439_q;
        mips_main_state <= L1_grp_ifthen21_S20;
      end
      L1_grp_ifthen21_S20: begin
        mem_reg_1_439_addr <= rt_2;
        mem_reg_1_439_we <= 0;
        mips_main_state <= L1_grp_ifthen21_S21;
      end
      L1_grp_ifthen21_S21: begin
        /*wait for mem read*/
        mips_main_state <= L1_grp_ifthen21_S22;
      end
      L1_grp_ifthen21_S22: begin
        t112 <= mem_reg_1_439_q;
        mips_main_state <= L1_grp_ifthen21_S23;
      end
      L1_grp_ifthen21_S23: begin
        mem_reg_1_439_addr <= rd_2;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= cond113;
        mips_main_state <= L1_grp_ifthen21_S24;
      end
      L1_grp_ifthen21_S24: begin
        mem_reg_1_439_req <= 0;
        mips_main_state <= L1_grp_whilebody1_S23;
      end
      L1_grp_ifthen23_S17: begin
        pc_12 <= pc_3;
        rt_4 <= rt_2;
        rs_4 <= rs_2;
        rd_3 <= rd_2;
        addr_4 <= addr_1;
        funct_3 <= funct_2;
        address_3 <= address_1;
        daddr_4 <= daddr_1;
        shamt_3 <= shamt_2;
        tgtadr_4 <= tgtadr_1;
        mem_reg_1_439_req <= 1;
        mem_reg_1_439_addr <= rs_2;
        mem_reg_1_439_we <= 0;
        mips_main_state <= L1_grp_ifthen23_S18;
      end
      L1_grp_ifthen23_S18: begin
        /*wait for mem read*/
        mips_main_state <= L1_grp_ifthen23_S19;
      end
      L1_grp_ifthen23_S19: begin
        t114 <= mem_reg_1_439_q;
        mips_main_state <= L1_grp_ifthen23_S20;
      end
      L1_grp_ifthen23_S20: begin
        mem_reg_1_439_addr <= rt_2;
        mem_reg_1_439_we <= 0;
        mips_main_state <= L1_grp_ifthen23_S21;
      end
      L1_grp_ifthen23_S21: begin
        /*wait for mem read*/
        mips_main_state <= L1_grp_ifthen23_S22;
      end
      L1_grp_ifthen23_S22: begin
        t115 <= mem_reg_1_439_q;
        mips_main_state <= L1_grp_ifthen23_S23;
      end
      L1_grp_ifthen23_S23: begin
        mem_reg_1_439_addr <= rd_2;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= cond116;
        mips_main_state <= L1_grp_ifthen23_S24;
      end
      L1_grp_ifthen23_S24: begin
        mem_reg_1_439_req <= 0;
        mips_main_state <= L1_grp_whilebody1_S23;
      end
      L1_grp_ifthen25_S17: begin
        rt_4 <= rt_2;
        rs_4 <= rs_2;
        rd_3 <= rd_2;
        addr_4 <= addr_1;
        funct_3 <= funct_2;
        address_3 <= address_1;
        daddr_4 <= daddr_1;
        shamt_3 <= shamt_2;
        tgtadr_4 <= tgtadr_1;
        mem_reg_1_439_req <= 1;
        mem_reg_1_439_addr <= rs_2;
        mem_reg_1_439_we <= 0;
        mips_main_state <= L1_grp_ifthen25_S18;
      end
      L1_grp_ifthen25_S18: begin
        /*wait for mem read*/
        mips_main_state <= L1_grp_ifthen25_S19;
      end
      L1_grp_ifthen25_S19: begin
        t117 <= mem_reg_1_439_q;
        mips_main_state <= L1_grp_ifthen25_S20;
      end
      L1_grp_ifthen25_S20: begin
        mem_reg_1_439_req <= 0;
        pc_7 <= t117;
        mips_main_state <= L1_grp_ifthen25_S21;
      end
      L1_grp_ifthen25_S21: begin
        pc_12 <= pc_7;
        mips_main_state <= L1_grp_whilebody1_S23;
      end
      L1_grp_ifthen3_S17: begin
        pc_12 <= pc_3;
        rt_4 <= rt_2;
        rs_4 <= rs_2;
        rd_3 <= rd_2;
        addr_4 <= addr_1;
        funct_3 <= funct_2;
        address_3 <= address_1;
        daddr_4 <= daddr_1;
        shamt_3 <= shamt_2;
        tgtadr_4 <= tgtadr_1;
        mem_reg_1_439_req <= 1;
        mem_reg_1_439_addr <= rs_2;
        mem_reg_1_439_we <= 0;
        mips_main_state <= L1_grp_ifthen3_S18;
      end
      L1_grp_ifthen3_S18: begin
        /*wait for mem read*/
        mips_main_state <= L1_grp_ifthen3_S19;
      end
      L1_grp_ifthen3_S19: begin
        t85 <= mem_reg_1_439_q;
        mips_main_state <= L1_grp_ifthen3_S20;
      end
      L1_grp_ifthen3_S20: begin
        mem_reg_1_439_addr <= rt_2;
        mem_reg_1_439_we <= 0;
        mips_main_state <= L1_grp_ifthen3_S21;
      end
      L1_grp_ifthen3_S21: begin
        /*wait for mem read*/
        mips_main_state <= L1_grp_ifthen3_S22;
      end
      L1_grp_ifthen3_S22: begin
        t86 <= mem_reg_1_439_q;
        mips_main_state <= L1_grp_ifthen3_S23;
      end
      L1_grp_ifthen3_S23: begin
        mem_reg_1_439_req <= 0;
        t87 <= (t85 + t86);
        mips_main_state <= L1_grp_ifthen3_S24;
      end
      L1_grp_ifthen3_S24: begin
        mem_reg_1_439_req <= 1;
        mem_reg_1_439_addr <= rd_2;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= t87;
        mips_main_state <= L1_grp_ifthen3_S25;
      end
      L1_grp_ifthen3_S25: begin
        mem_reg_1_439_req <= 0;
        mips_main_state <= L1_grp_whilebody1_S23;
      end
      L1_grp_ifthen32_S16: begin
        pc_12 <= pc_3;
        rt_4 <= rt_3;
        rs_4 <= rs_3;
        rd_3 <= rd_1;
        addr_4 <= addr_1;
        funct_3 <= funct_1;
        address_3 <= address_2;
        daddr_4 <= daddr_1;
        shamt_3 <= shamt_1;
        tgtadr_4 <= tgtadr_1;
        mem_reg_1_439_req <= 1;
        mem_reg_1_439_addr <= rs_3;
        mem_reg_1_439_we <= 0;
        mips_main_state <= L1_grp_ifthen32_S17;
      end
      L1_grp_ifthen32_S17: begin
        /*wait for mem read*/
        mips_main_state <= L1_grp_ifthen32_S18;
      end
      L1_grp_ifthen32_S18: begin
        t132 <= mem_reg_1_439_q;
        mips_main_state <= L1_grp_ifthen32_S19;
      end
      L1_grp_ifthen32_S19: begin
        mem_reg_1_439_req <= 0;
        t133 <= (t132 + address_2);
        mips_main_state <= L1_grp_ifthen32_S20;
      end
      L1_grp_ifthen32_S20: begin
        mem_reg_1_439_req <= 1;
        mem_reg_1_439_addr <= rt_3;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= t133;
        mips_main_state <= L1_grp_ifthen32_S21;
      end
      L1_grp_ifthen32_S21: begin
        mem_reg_1_439_req <= 0;
        mips_main_state <= L1_grp_whilebody1_S23;
      end
      L1_grp_ifthen34_S16: begin
        pc_12 <= pc_3;
        rt_4 <= rt_3;
        rs_4 <= rs_3;
        rd_3 <= rd_1;
        addr_4 <= addr_1;
        funct_3 <= funct_1;
        address_3 <= address_2;
        daddr_4 <= daddr_1;
        shamt_3 <= shamt_1;
        tgtadr_4 <= tgtadr_1;
        mem_reg_1_439_req <= 1;
        mem_reg_1_439_addr <= rs_3;
        mem_reg_1_439_we <= 0;
        mips_main_state <= L1_grp_ifthen34_S17;
      end
      L1_grp_ifthen34_S17: begin
        /*wait for mem read*/
        mips_main_state <= L1_grp_ifthen34_S18;
      end
      L1_grp_ifthen34_S18: begin
        t134 <= mem_reg_1_439_q;
        mips_main_state <= L1_grp_ifthen34_S19;
      end
      L1_grp_ifthen34_S19: begin
        mem_reg_1_439_req <= 0;
        t135 <= (t134 & address_2);
        mips_main_state <= L1_grp_ifthen34_S20;
      end
      L1_grp_ifthen34_S20: begin
        mem_reg_1_439_req <= 1;
        mem_reg_1_439_addr <= rt_3;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= t135;
        mips_main_state <= L1_grp_ifthen34_S21;
      end
      L1_grp_ifthen34_S21: begin
        mem_reg_1_439_req <= 0;
        mips_main_state <= L1_grp_whilebody1_S23;
      end
      L1_grp_ifthen36_S16: begin
        pc_12 <= pc_3;
        rt_4 <= rt_3;
        rs_4 <= rs_3;
        rd_3 <= rd_1;
        addr_4 <= addr_1;
        funct_3 <= funct_1;
        address_3 <= address_2;
        daddr_4 <= daddr_1;
        shamt_3 <= shamt_1;
        tgtadr_4 <= tgtadr_1;
        mem_reg_1_439_req <= 1;
        mem_reg_1_439_addr <= rs_3;
        mem_reg_1_439_we <= 0;
        mips_main_state <= L1_grp_ifthen36_S17;
      end
      L1_grp_ifthen36_S17: begin
        /*wait for mem read*/
        mips_main_state <= L1_grp_ifthen36_S18;
      end
      L1_grp_ifthen36_S18: begin
        t136 <= mem_reg_1_439_q;
        mips_main_state <= L1_grp_ifthen36_S19;
      end
      L1_grp_ifthen36_S19: begin
        mem_reg_1_439_req <= 0;
        t137 <= (t136 | address_2);
        mips_main_state <= L1_grp_ifthen36_S20;
      end
      L1_grp_ifthen36_S20: begin
        mem_reg_1_439_req <= 1;
        mem_reg_1_439_addr <= rt_3;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= t137;
        mips_main_state <= L1_grp_ifthen36_S21;
      end
      L1_grp_ifthen36_S21: begin
        mem_reg_1_439_req <= 0;
        mips_main_state <= L1_grp_whilebody1_S23;
      end
      L1_grp_ifthen38_S16: begin
        pc_12 <= pc_3;
        rt_4 <= rt_3;
        rs_4 <= rs_3;
        rd_3 <= rd_1;
        addr_4 <= addr_1;
        funct_3 <= funct_1;
        address_3 <= address_2;
        daddr_4 <= daddr_1;
        shamt_3 <= shamt_1;
        tgtadr_4 <= tgtadr_1;
        mem_reg_1_439_req <= 1;
        mem_reg_1_439_addr <= rs_3;
        mem_reg_1_439_we <= 0;
        mips_main_state <= L1_grp_ifthen38_S17;
      end
      L1_grp_ifthen38_S17: begin
        /*wait for mem read*/
        mips_main_state <= L1_grp_ifthen38_S18;
      end
      L1_grp_ifthen38_S18: begin
        t138 <= mem_reg_1_439_q;
        mips_main_state <= L1_grp_ifthen38_S19;
      end
      L1_grp_ifthen38_S19: begin
        mem_reg_1_439_req <= 0;
        t139 <= (t138 ^ address_2);
        mips_main_state <= L1_grp_ifthen38_S20;
      end
      L1_grp_ifthen38_S20: begin
        mem_reg_1_439_req <= 1;
        mem_reg_1_439_addr <= rt_3;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= t139;
        mips_main_state <= L1_grp_ifthen38_S21;
      end
      L1_grp_ifthen38_S21: begin
        mem_reg_1_439_req <= 0;
        mips_main_state <= L1_grp_whilebody1_S23;
      end
      L1_grp_ifthen40_S16: begin
        pc_12 <= pc_3;
        rt_4 <= rt_3;
        rs_4 <= rs_3;
        rd_3 <= rd_1;
        funct_3 <= funct_1;
        address_3 <= address_2;
        shamt_3 <= shamt_1;
        tgtadr_4 <= tgtadr_1;
        mem_reg_1_439_req <= 1;
        mem_reg_1_439_addr <= rs_3;
        mem_reg_1_439_we <= 0;
        mips_main_state <= L1_grp_ifthen40_S17;
      end
      L1_grp_ifthen40_S17: begin
        /*wait for mem read*/
        mips_main_state <= L1_grp_ifthen40_S18;
      end
      L1_grp_ifthen40_S18: begin
        t140 <= mem_reg_1_439_q;
        mips_main_state <= L1_grp_ifthen40_S19;
      end
      L1_grp_ifthen40_S19: begin
        mem_reg_1_439_req <= 0;
        addr_2 <= (t140 + address_2);
        mips_main_state <= L1_grp_ifthen40_S20;
      end
      L1_grp_ifthen40_S20: begin
        addr_4 <= addr_2;
        t141 <= (addr_2 & 255);
        mips_main_state <= L1_grp_ifthen40_S21;
      end
      L1_grp_ifthen40_S21: begin
        daddr_2 <= (t141 >> 2);
        mips_main_state <= L1_grp_ifthen40_S22;
      end
      L1_grp_ifthen40_S22: begin
        daddr_4 <= daddr_2;
        mips_main_state <= L1_grp_ifthen40_S29;
      end
      L1_grp_ifthen40_S29: begin
        mem_dmem_36_req <= 1;
        mem_dmem_36_addr <= daddr_2;
        mem_dmem_36_we <= 0;
        mips_main_state <= L1_grp_ifthen40_S30;
      end
      L1_grp_ifthen40_S30: begin
        /*wait for mem read*/
        mips_main_state <= L1_grp_ifthen40_S31;
      end
      L1_grp_ifthen40_S31: begin
        t142 <= mem_dmem_36_q;
        mips_main_state <= L1_grp_ifthen40_S32;
      end
      L1_grp_ifthen40_S32: begin
        mem_dmem_36_req <= 0;
        mem_reg_1_439_req <= 1;
        mem_reg_1_439_addr <= rt_3;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= t142;
        mips_main_state <= L1_grp_ifthen40_S33;
      end
      L1_grp_ifthen40_S33: begin
        mem_reg_1_439_req <= 0;
        mips_main_state <= L1_grp_whilebody1_S23;
      end
      L1_grp_ifthen42_S16: begin
        pc_12 <= pc_3;
        rt_4 <= rt_3;
        rs_4 <= rs_3;
        rd_3 <= rd_1;
        funct_3 <= funct_1;
        address_3 <= address_2;
        shamt_3 <= shamt_1;
        tgtadr_4 <= tgtadr_1;
        mem_reg_1_439_req <= 1;
        mem_reg_1_439_addr <= rs_3;
        mem_reg_1_439_we <= 0;
        mips_main_state <= L1_grp_ifthen42_S17;
      end
      L1_grp_ifthen42_S17: begin
        /*wait for mem read*/
        mips_main_state <= L1_grp_ifthen42_S18;
      end
      L1_grp_ifthen42_S18: begin
        t143 <= mem_reg_1_439_q;
        mips_main_state <= L1_grp_ifthen42_S19;
      end
      L1_grp_ifthen42_S19: begin
        mem_reg_1_439_req <= 0;
        addr_3 <= (t143 + address_2);
        mips_main_state <= L1_grp_ifthen42_S20;
      end
      L1_grp_ifthen42_S20: begin
        addr_4 <= addr_3;
        t144 <= (addr_3 & 255);
        mips_main_state <= L1_grp_ifthen42_S21;
      end
      L1_grp_ifthen42_S21: begin
        daddr_3 <= (t144 >> 2);
        mips_main_state <= L1_grp_ifthen42_S22;
      end
      L1_grp_ifthen42_S22: begin
        daddr_4 <= daddr_3;
        mips_main_state <= L1_grp_ifthen42_S25;
      end
      L1_grp_ifthen42_S25: begin
        mem_reg_1_439_req <= 1;
        mem_reg_1_439_addr <= rt_3;
        mem_reg_1_439_we <= 0;
        mips_main_state <= L1_grp_ifthen42_S26;
      end
      L1_grp_ifthen42_S26: begin
        /*wait for mem read*/
        mips_main_state <= L1_grp_ifthen42_S27;
      end
      L1_grp_ifthen42_S27: begin
        t145 <= mem_reg_1_439_q;
        mips_main_state <= L1_grp_ifthen42_S28;
      end
      L1_grp_ifthen42_S28: begin
        mem_reg_1_439_req <= 0;
        mem_dmem_36_req <= 1;
        mem_dmem_36_addr <= daddr_3;
        mem_dmem_36_we <= 1;
        mem_dmem_36_d <= t145;
        mips_main_state <= L1_grp_ifthen42_S29;
      end
      L1_grp_ifthen42_S29: begin
        mem_dmem_36_req <= 0;
        mips_main_state <= L1_grp_whilebody1_S23;
      end
      L1_grp_ifthen44_S16: begin
        pc_12 <= pc_3;
        rt_4 <= rt_3;
        rs_4 <= rs_3;
        rd_3 <= rd_1;
        addr_4 <= addr_1;
        funct_3 <= funct_1;
        address_3 <= address_2;
        daddr_4 <= daddr_1;
        shamt_3 <= shamt_1;
        tgtadr_4 <= tgtadr_1;
        t146 <= (address_2 << 16);
        mips_main_state <= L1_grp_ifthen44_S17;
      end
      L1_grp_ifthen44_S17: begin
        mem_reg_1_439_req <= 1;
        mem_reg_1_439_addr <= rt_3;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= t146;
        mips_main_state <= L1_grp_ifthen44_S18;
      end
      L1_grp_ifthen44_S18: begin
        mem_reg_1_439_req <= 0;
        mips_main_state <= L1_grp_whilebody1_S23;
      end
      L1_grp_ifthen46_S16: begin
        pc_12 <= pc_3;
        rt_4 <= rt_3;
        rs_4 <= rs_3;
        rd_3 <= rd_1;
        addr_4 <= addr_1;
        funct_3 <= funct_1;
        address_3 <= address_2;
        daddr_4 <= daddr_1;
        shamt_3 <= shamt_1;
        tgtadr_4 <= tgtadr_1;
        mem_reg_1_439_req <= 1;
        mem_reg_1_439_addr <= rs_3;
        mem_reg_1_439_we <= 0;
        mips_main_state <= L1_grp_ifthen46_S17;
      end
      L1_grp_ifthen46_S17: begin
        /*wait for mem read*/
        mips_main_state <= L1_grp_ifthen46_S18;
      end
      L1_grp_ifthen46_S18: begin
        t147 <= mem_reg_1_439_q;
        mips_main_state <= L1_grp_ifthen46_S19;
      end
      L1_grp_ifthen46_S19: begin
        mem_reg_1_439_addr <= rt_3;
        mem_reg_1_439_we <= 0;
        mips_main_state <= L1_grp_ifthen46_S20;
      end
      L1_grp_ifthen46_S20: begin
        /*wait for mem read*/
        mips_main_state <= L1_grp_ifthen46_S21;
      end
      L1_grp_ifthen46_S21: begin
        t148 <= mem_reg_1_439_q;
        mips_main_state <= L1_grp_ifthen46_S22;
      end
      L1_grp_ifthen46_S22: begin
        mem_reg_1_439_req <= 0;
        if (cond149) begin
          mips_main_state <= L1_grp_ifthen47_S23;
        end else begin
          mips_main_state <= L1_grp_whilebody1_S23;
        end
      end
      L1_grp_ifthen5_S17: begin
        pc_12 <= pc_3;
        rt_4 <= rt_2;
        rs_4 <= rs_2;
        rd_3 <= rd_2;
        addr_4 <= addr_1;
        funct_3 <= funct_2;
        address_3 <= address_1;
        daddr_4 <= daddr_1;
        shamt_3 <= shamt_2;
        tgtadr_4 <= tgtadr_1;
        mem_reg_1_439_req <= 1;
        mem_reg_1_439_addr <= rs_2;
        mem_reg_1_439_we <= 0;
        mips_main_state <= L1_grp_ifthen5_S18;
      end
      L1_grp_ifthen5_S18: begin
        /*wait for mem read*/
        mips_main_state <= L1_grp_ifthen5_S19;
      end
      L1_grp_ifthen5_S19: begin
        t89 <= mem_reg_1_439_q;
        mips_main_state <= L1_grp_ifthen5_S20;
      end
      L1_grp_ifthen5_S20: begin
        mem_reg_1_439_addr <= rt_2;
        mem_reg_1_439_we <= 0;
        mips_main_state <= L1_grp_ifthen5_S21;
      end
      L1_grp_ifthen5_S21: begin
        /*wait for mem read*/
        mips_main_state <= L1_grp_ifthen5_S22;
      end
      L1_grp_ifthen5_S22: begin
        t90 <= mem_reg_1_439_q;
        mips_main_state <= L1_grp_ifthen5_S23;
      end
      L1_grp_ifthen5_S23: begin
        mem_reg_1_439_req <= 0;
        t91 <= (t89 - t90);
        mips_main_state <= L1_grp_ifthen5_S24;
      end
      L1_grp_ifthen5_S24: begin
        mem_reg_1_439_req <= 1;
        mem_reg_1_439_addr <= rd_2;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= t91;
        mips_main_state <= L1_grp_ifthen5_S25;
      end
      L1_grp_ifthen5_S25: begin
        mem_reg_1_439_req <= 0;
        mips_main_state <= L1_grp_whilebody1_S23;
      end
      L1_grp_ifthen50_S16: begin
        pc_12 <= pc_3;
        rt_4 <= rt_3;
        rs_4 <= rs_3;
        rd_3 <= rd_1;
        addr_4 <= addr_1;
        funct_3 <= funct_1;
        address_3 <= address_2;
        daddr_4 <= daddr_1;
        shamt_3 <= shamt_1;
        tgtadr_4 <= tgtadr_1;
        mem_reg_1_439_req <= 1;
        mem_reg_1_439_addr <= rs_3;
        mem_reg_1_439_we <= 0;
        mips_main_state <= L1_grp_ifthen50_S17;
      end
      L1_grp_ifthen50_S17: begin
        /*wait for mem read*/
        mips_main_state <= L1_grp_ifthen50_S18;
      end
      L1_grp_ifthen50_S18: begin
        t152 <= mem_reg_1_439_q;
        mips_main_state <= L1_grp_ifthen50_S19;
      end
      L1_grp_ifthen50_S19: begin
        mem_reg_1_439_addr <= rt_3;
        mem_reg_1_439_we <= 0;
        mips_main_state <= L1_grp_ifthen50_S20;
      end
      L1_grp_ifthen50_S20: begin
        /*wait for mem read*/
        mips_main_state <= L1_grp_ifthen50_S21;
      end
      L1_grp_ifthen50_S21: begin
        t153 <= mem_reg_1_439_q;
        mips_main_state <= L1_grp_ifthen50_S22;
      end
      L1_grp_ifthen50_S22: begin
        mem_reg_1_439_req <= 0;
        if (cond154) begin
          mips_main_state <= L1_grp_ifthen51_S23;
        end else begin
          mips_main_state <= L1_grp_whilebody1_S23;
        end
      end
      L1_grp_ifthen54_S16: begin
        pc_12 <= pc_3;
        rt_4 <= rt_3;
        rs_4 <= rs_3;
        rd_3 <= rd_1;
        addr_4 <= addr_1;
        funct_3 <= funct_1;
        address_3 <= address_2;
        daddr_4 <= daddr_1;
        shamt_3 <= shamt_1;
        tgtadr_4 <= tgtadr_1;
        mem_reg_1_439_req <= 1;
        mem_reg_1_439_addr <= rs_3;
        mem_reg_1_439_we <= 0;
        mips_main_state <= L1_grp_ifthen54_S17;
      end
      L1_grp_ifthen54_S17: begin
        /*wait for mem read*/
        mips_main_state <= L1_grp_ifthen54_S18;
      end
      L1_grp_ifthen54_S18: begin
        t157 <= mem_reg_1_439_q;
        mips_main_state <= L1_grp_ifthen54_S19;
      end
      L1_grp_ifthen54_S19: begin
        mem_reg_1_439_req <= 0;
        if (cond158) begin
          mips_main_state <= L1_grp_ifthen55_S20;
        end else begin
          mips_main_state <= L1_grp_whilebody1_S23;
        end
      end
      L1_grp_ifthen58_S16: begin
        pc_12 <= pc_3;
        rt_4 <= rt_3;
        rs_4 <= rs_3;
        rd_3 <= rd_1;
        addr_4 <= addr_1;
        funct_3 <= funct_1;
        address_3 <= address_2;
        daddr_4 <= daddr_1;
        shamt_3 <= shamt_1;
        tgtadr_4 <= tgtadr_1;
        mem_reg_1_439_req <= 1;
        mem_reg_1_439_addr <= rs_3;
        mem_reg_1_439_we <= 0;
        mips_main_state <= L1_grp_ifthen58_S17;
      end
      L1_grp_ifthen58_S17: begin
        /*wait for mem read*/
        mips_main_state <= L1_grp_ifthen58_S18;
      end
      L1_grp_ifthen58_S18: begin
        t161 <= mem_reg_1_439_q;
        mips_main_state <= L1_grp_ifthen58_S19;
      end
      L1_grp_ifthen58_S19: begin
        mem_reg_1_439_addr <= rt_3;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= cond162;
        mips_main_state <= L1_grp_ifthen58_S20;
      end
      L1_grp_ifthen58_S20: begin
        mem_reg_1_439_req <= 0;
        mips_main_state <= L1_grp_whilebody1_S23;
      end
      L1_grp_ifthen60_S16: begin
        pc_12 <= pc_3;
        rt_4 <= rt_3;
        rs_4 <= rs_3;
        rd_3 <= rd_1;
        addr_4 <= addr_1;
        funct_3 <= funct_1;
        address_3 <= address_2;
        daddr_4 <= daddr_1;
        shamt_3 <= shamt_1;
        tgtadr_4 <= tgtadr_1;
        mem_reg_1_439_req <= 1;
        mem_reg_1_439_addr <= rs_3;
        mem_reg_1_439_we <= 0;
        mips_main_state <= L1_grp_ifthen60_S17;
      end
      L1_grp_ifthen60_S17: begin
        /*wait for mem read*/
        mips_main_state <= L1_grp_ifthen60_S18;
      end
      L1_grp_ifthen60_S18: begin
        t163 <= mem_reg_1_439_q;
        mips_main_state <= L1_grp_ifthen60_S19;
      end
      L1_grp_ifthen60_S19: begin
        mem_reg_1_439_addr <= rt_3;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= cond164;
        mips_main_state <= L1_grp_ifthen60_S20;
      end
      L1_grp_ifthen60_S20: begin
        mem_reg_1_439_req <= 0;
        mips_main_state <= L1_grp_whilebody1_S23;
      end
      L1_grp_ifthen7_S17: begin
        pc_12 <= pc_3;
        rt_4 <= rt_2;
        rs_4 <= rs_2;
        rd_3 <= rd_2;
        addr_4 <= addr_1;
        funct_3 <= funct_2;
        address_3 <= address_1;
        daddr_4 <= daddr_1;
        shamt_3 <= shamt_2;
        tgtadr_4 <= tgtadr_1;
        mem_reg_1_439_req <= 1;
        mem_reg_1_439_addr <= rs_2;
        mem_reg_1_439_we <= 0;
        mips_main_state <= L1_grp_ifthen7_S18;
      end
      L1_grp_ifthen7_S18: begin
        /*wait for mem read*/
        mips_main_state <= L1_grp_ifthen7_S19;
      end
      L1_grp_ifthen7_S19: begin
        t92 <= mem_reg_1_439_q;
        mips_main_state <= L1_grp_ifthen7_S20;
      end
      L1_grp_ifthen7_S20: begin
        mem_reg_1_439_addr <= rt_2;
        mem_reg_1_439_we <= 0;
        mips_main_state <= L1_grp_ifthen7_S21;
      end
      L1_grp_ifthen7_S21: begin
        /*wait for mem read*/
        mips_main_state <= L1_grp_ifthen7_S22;
      end
      L1_grp_ifthen7_S22: begin
        t93 <= mem_reg_1_439_q;
        mips_main_state <= L1_grp_ifthen7_S23;
      end
      L1_grp_ifthen7_S23: begin
        mem_reg_1_439_req <= 0;
        t94 <= (t92 & t93);
        mips_main_state <= L1_grp_ifthen7_S24;
      end
      L1_grp_ifthen7_S24: begin
        mem_reg_1_439_req <= 1;
        mem_reg_1_439_addr <= rd_2;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= t94;
        mips_main_state <= L1_grp_ifthen7_S25;
      end
      L1_grp_ifthen7_S25: begin
        mem_reg_1_439_req <= 0;
        mips_main_state <= L1_grp_whilebody1_S23;
      end
      L1_grp_ifthen9_S17: begin
        pc_12 <= pc_3;
        rt_4 <= rt_2;
        rs_4 <= rs_2;
        rd_3 <= rd_2;
        addr_4 <= addr_1;
        funct_3 <= funct_2;
        address_3 <= address_1;
        daddr_4 <= daddr_1;
        shamt_3 <= shamt_2;
        tgtadr_4 <= tgtadr_1;
        mem_reg_1_439_req <= 1;
        mem_reg_1_439_addr <= rs_2;
        mem_reg_1_439_we <= 0;
        mips_main_state <= L1_grp_ifthen9_S18;
      end
      L1_grp_ifthen9_S18: begin
        /*wait for mem read*/
        mips_main_state <= L1_grp_ifthen9_S19;
      end
      L1_grp_ifthen9_S19: begin
        t95 <= mem_reg_1_439_q;
        mips_main_state <= L1_grp_ifthen9_S20;
      end
      L1_grp_ifthen9_S20: begin
        mem_reg_1_439_addr <= rt_2;
        mem_reg_1_439_we <= 0;
        mips_main_state <= L1_grp_ifthen9_S21;
      end
      L1_grp_ifthen9_S21: begin
        /*wait for mem read*/
        mips_main_state <= L1_grp_ifthen9_S22;
      end
      L1_grp_ifthen9_S22: begin
        t96 <= mem_reg_1_439_q;
        mips_main_state <= L1_grp_ifthen9_S23;
      end
      L1_grp_ifthen9_S23: begin
        mem_reg_1_439_req <= 0;
        t97 <= (t95 | t96);
        mips_main_state <= L1_grp_ifthen9_S24;
      end
      L1_grp_ifthen9_S24: begin
        mem_reg_1_439_req <= 1;
        mem_reg_1_439_addr <= rd_2;
        mem_reg_1_439_we <= 1;
        mem_reg_1_439_d <= t97;
        mips_main_state <= L1_grp_ifthen9_S25;
      end
      L1_grp_ifthen9_S25: begin
        mem_reg_1_439_req <= 0;
        mips_main_state <= L1_grp_whilebody1_S23;
      end
      L1_grp_ifthen47_S23: begin
        rt_4 <= rt_3;
        rs_4 <= rs_3;
        rd_3 <= rd_1;
        addr_4 <= addr_1;
        funct_3 <= funct_1;
        address_3 <= address_2;
        daddr_4 <= daddr_1;
        shamt_3 <= shamt_1;
        tgtadr_4 <= tgtadr_1;
        t150 <= (pc_3 - 4);
        t151 <= (address_2 << 2);
        mips_main_state <= L1_grp_ifthen47_S24;
      end
      L1_grp_ifthen47_S24: begin
        pc_11 <= (t150 + t151);
        mips_main_state <= L1_grp_ifthen47_S25;
      end
      L1_grp_ifthen47_S25: begin
        pc_12 <= pc_11;
        mips_main_state <= L1_grp_whilebody1_S23;
      end
      L1_grp_ifthen51_S23: begin
        rt_4 <= rt_3;
        rs_4 <= rs_3;
        rd_3 <= rd_1;
        addr_4 <= addr_1;
        funct_3 <= funct_1;
        address_3 <= address_2;
        daddr_4 <= daddr_1;
        shamt_3 <= shamt_1;
        tgtadr_4 <= tgtadr_1;
        t155 <= (pc_3 - 4);
        t156 <= (address_2 << 2);
        mips_main_state <= L1_grp_ifthen51_S24;
      end
      L1_grp_ifthen51_S24: begin
        pc_8 <= (t155 + t156);
        mips_main_state <= L1_grp_ifthen51_S25;
      end
      L1_grp_ifthen51_S25: begin
        pc_12 <= pc_8;
        mips_main_state <= L1_grp_whilebody1_S23;
      end
      L1_grp_ifthen55_S20: begin
        rt_4 <= rt_3;
        rs_4 <= rs_3;
        rd_3 <= rd_1;
        addr_4 <= addr_1;
        funct_3 <= funct_1;
        address_3 <= address_2;
        daddr_4 <= daddr_1;
        shamt_3 <= shamt_1;
        tgtadr_4 <= tgtadr_1;
        t159 <= (pc_3 - 4);
        t160 <= (address_2 << 2);
        mips_main_state <= L1_grp_ifthen55_S21;
      end
      L1_grp_ifthen55_S21: begin
        pc_10 <= (t159 + t160);
        mips_main_state <= L1_grp_ifthen55_S22;
      end
      L1_grp_ifthen55_S22: begin
        pc_12 <= pc_10;
        mips_main_state <= L1_grp_whilebody1_S23;
      end
      L1_grp_ifthen62_S35: begin
        addr_5 <= addr_4;
        daddr_5 <= daddr_4;
        ins_3 <= ins_2;
        iaddr_3 <= iaddr_2;
        rs_5 <= rs_4;
        op_3 <= op_2;
        rt_5 <= rt_4;
        tgtadr_5 <= tgtadr_4;
        rd_4 <= rd_3;
        pc_13 <= pc_12;
        shamt_4 <= shamt_3;
        address_4 <= address_3;
        funct_4 <= funct_3;
        n_inst_4 <= n_inst_3;
        mips_main_state <= mips_main_grp_top0_S70;
      end
      L1_grp_bridge64_S2: begin
        iaddr_1 <= iaddr_2;
        mips_main_state <= L1_grp_bridge64_S6;
      end
      L1_grp_bridge64_S6: begin
        ins_1 <= ins_2;
        mips_main_state <= L1_grp_bridge64_S7;
      end
      L1_grp_bridge64_S7: begin
        op_1 <= op_2;
        mips_main_state <= L1_grp_bridge64_S24;
      end
      L1_grp_bridge64_S24: begin
        addr_1 <= addr_4;
        daddr_1 <= daddr_4;
        rs_1 <= rs_4;
        rt_1 <= rt_4;
        tgtadr_1 <= tgtadr_4;
        rd_1 <= rd_3;
        shamt_1 <= shamt_3;
        address_1 <= address_3;
        funct_1 <= funct_3;
        n_inst_2 <= n_inst_3;
        mips_main_state <= L1_grp_bridge64_S26;
      end
      L1_grp_bridge64_S26: begin
        pc_2 <= pc_12;
        mips_main_state <= L1_grp_top0_S0;
      end
      endcase
    end
  end
  
endmodule

