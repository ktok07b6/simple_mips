module simple_mips_v1_0
(
	// Ports of Axi Slave Bus Interface S
	input wire  S_ACLK,
	input wire  S_ARESETN,
	input wire [4 : 0] S_AWADDR,
	input wire [2 : 0] S_AWPROT,
	input wire  S_AWVALID,
	output wire  S_AWREADY,
	input wire [31 : 0] S_WDATA,
	input wire [3 : 0] S_WSTRB,
	input wire  S_WVALID,
	output wire  S_WREADY,
	output wire [1 : 0] S_BRESP,
	output wire  S_BVALID,
	input wire  S_BREADY,
	input wire [4 : 0] S_ARADDR,
	input wire [2 : 0] S_ARPROT,
	input wire  S_ARVALID,
	output wire  S_ARREADY,
	output wire [31 : 0] S_RDATA,
	output wire [1 : 0] S_RRESP,
	output wire  S_RVALID,
	input wire  S_RREADY,

	// Ports of Axi Master Bus Interface M
	input wire  M_ACLK,
	input wire  M_ARESETN,
	output wire M_AWID,
	output wire [31 : 0] M_AWADDR,
	output wire [7 : 0] M_AWLEN,
	output wire [2 : 0] M_AWSIZE,
	output wire [1 : 0] M_AWBURST,
	output wire M_AWLOCK,
	output wire [3 : 0] M_AWCACHE,
	output wire [2 : 0] M_AWPROT,
	output wire [3 : 0] M_AWQOS,
	output wire M_AWUSER,
	output wire M_AWVALID,
	input wire  M_AWREADY,
	output wire [31 : 0] M_WDATA,
	output wire [3 : 0] M_WSTRB,
	output wire M_WLAST,
	output wire M_WUSER,
	output wire M_WVALID,
	input wire  M_WREADY,
	input wire M_BID,
	input wire [1 : 0] M_BRESP,
	input wire M_BUSER,
	input wire M_BVALID,
	output wire M_BREADY,
	output wire M_ARID,
	output wire [31 : 0] M_ARADDR,
	output wire [7 : 0] M_ARLEN,
	output wire [2 : 0] M_ARSIZE,
	output wire [1 : 0] M_ARBURST,
	output wire M_ARLOCK,
	output wire [3 : 0] M_ARCACHE,
	output wire [2 : 0] M_ARPROT,
	output wire [3 : 0] M_ARQOS,
	output wire M_ARUSER,
	output wire M_ARVALID,
	input wire  M_ARREADY,
	input wire M_RID,
	input wire [31 : 0] M_RDATA,
	input wire [1 : 0] M_RRESP,
	input wire M_RLAST,
	input wire M_RUSER,
	input wire M_RVALID,
	output wire M_RREADY,

	output PROC_DONE
);

	wire [31 : 0] reg_mode;
	wire [31 : 0] reg_address;
	wire [31 : 0] reg_length;
	wire [31 : 0] reg_run;
	wire [31 : 0] reg_status;
    wire [31 : 0] reg_status2;
    
	AXI_Slave_Lite# (.C_DATA_WIDTH(32),
					 .C_ADDR_WIDTH(5))
	axi_slave_lite(.MODE(reg_mode),
				   .ADDRESS(reg_address),
				   .LENGTH(reg_length),
				   .RUN(reg_run),
				   .STATUS(reg_status),
				   .STATUS2(reg_status2),

				   .S_ACLK(S_ACLK),
				   .S_ARESETN(S_ARESETN),
				   /*write address*/
				   .S_AWADDR(S_AWADDR),
				   .S_AWPROT(S_AWPROT),
				   .S_AWVALID(S_AWVALID),
				   .S_AWREADY(S_AWREADY),
				   /*write data*/
				   .S_WDATA(S_WDATA),
				   .S_WSTRB(S_WSTRB),
				   .S_WVALID(S_WVALID),
				   .S_WREADY(S_WREADY),
				   /*write response*/
				   .S_BRESP(S_BRESP),
				   .S_BVALID(S_BVALID),
				   .S_BREADY(S_BREADY),
				   /*read address*/
				   .S_ARADDR(S_ARADDR),
				   .S_ARPROT(S_ARPROT),
				   .S_ARVALID(S_ARVALID),
				   .S_ARREADY(S_ARREADY),
				   /*read data*/
				   .S_RDATA(S_RDATA),
				   .S_RRESP(S_RRESP),
				   .S_RVALID(S_RVALID),
				   .S_RREADY(S_RREADY));

	reg trans_start;
	wire trans_done;
	wire error;
	reg input_done;
	reg output_done;
	wire kernel_done;

	wire [6:0] mem_dmem_1_442_addr;
	wire signed [31:0] mem_dmem_1_442_d;
	wire mem_dmem_1_442_req;
	wire mem_dmem_1_442_we;
	wire signed [31:0] mem_dmem_1_442_q;

	wire [5:0] mem_imem_1_440_addr;
	wire signed [31:0] mem_imem_1_440_d;
	wire mem_imem_1_440_req;
	wire mem_imem_1_440_we;
	wire signed [31:0] mem_imem_1_440_q;

	//sub module wires
	reg mips_main_0_ACCEPT;
	reg mips_main_0_READY;
	wire signed [31:0] mips_main_0_OUT0;
	wire mips_main_0_VALID;

	wire signed [31:0] mips_main_0_mem_dmem_1_442_q;
	wire signed [31:0] mips_main_0_mem_dmem_1_442_d;
	wire [6:0] mips_main_0_mem_dmem_1_442_addr;
	wire mips_main_0_mem_dmem_1_442_we;
	wire mips_main_0_mem_dmem_1_442_req;

	wire signed [31:0] mips_main_0_mem_imem_1_440_q;
	wire signed [31:0] mips_main_0_mem_imem_1_440_d;
	wire [5:0] mips_main_0_mem_imem_1_440_addr;
	wire mips_main_0_mem_imem_1_440_we;
	wire mips_main_0_mem_imem_1_440_req;

	wire signed [31:0] mem_dmem_1_442_mux_q;
	wire signed [31:0] mem_dmem_1_442_mux_d;
	wire [6:0] mem_dmem_1_442_mux_addr;
	wire mem_dmem_1_442_mux_we;
	wire [1:0] mem_dmem_1_442_mux_select_sig;

	wire signed [31:0] mem_imem_1_440_mux_q;
	wire signed [31:0] mem_imem_1_440_mux_d;
	wire [5:0] mem_imem_1_440_mux_addr;
	wire mem_imem_1_440_mux_we;

	wire [1:0] mem_imem_1_440_mux_select_sig;

	assign kernel_done = mips_main_0_VALID;
	assign PROC_DONE= kernel_done;

    reg [31:0] write_addr;
	reg [15:0] write_len;
	reg [31:0] read_addr;
	reg [15:0] read_len;

    wire [2:0] master_state;
    
	AXI_Master_Mips#(.C_ADDR_WIDTH(32),
				.C_DATA_WIDTH(32))
	axi_master(.INIT_TXN(trans_start),
			   .TXN_DONE(trans_done),
			   .ERROR(error),
   			   .WRITE_ADDR(write_addr),
			   .WRITE_LEN(write_len),
			   .READ_ADDR(read_addr),
			   .READ_LEN(read_len),

			   .M_ACLK(M_ACLK),
			   .M_ARESETN(M_ARESETN),
			   .TRANSACTION_MODE(reg_mode[1:0]),

			   .M_AWVALID(M_AWVALID),
			   .M_AWREADY(M_AWREADY),
			   .M_AWADDR(M_AWADDR),
			   .M_AWLEN(M_AWLEN),
			   .M_AWSIZE(M_AWSIZE),
			   .M_AWBURST(M_AWBURST),
			   .M_AWCACHE(M_AWCACHE),
			   .M_AWID(M_AWID),
			   .M_AWLOCK(M_AWLOCK),
			   .M_AWPROT(M_AWPROT),
			   .M_AWQOS(M_AWQOS),
			   .M_AWUSER(M_AWUSER),

			   .M_WVALID(M_WVALID),
			   .M_WREADY(M_WREADY),
			   .M_WDATA(M_WDATA),
			   .M_WSTRB(M_WSTRB),
			   .M_WLAST(M_WLAST),
			   .M_WUSER(M_WUSER),

			   .M_BVALID(M_BVALID),
			   .M_BREADY(M_BREADY),
			   .M_BRESP(M_BRESP),
			   .M_BID(M_BID),
			   .M_BUSER(M_BUSER),

			   .M_ARVALID(M_ARVALID),
			   .M_ARREADY(M_ARREADY),
			   .M_ARADDR(M_ARADDR),
			   .M_ARLEN(M_ARLEN),
			   .M_ARSIZE(M_ARSIZE),
			   .M_ARBURST(M_ARBURST),
			   .M_ARCACHE(M_ARCACHE),
			   .M_ARID(M_ARID),
			   .M_ARLOCK(M_ARLOCK),
			   .M_ARPROT(M_ARPROT),
			   .M_ARQOS(M_ARQOS),
			   .M_ARUSER(M_ARUSER),

			   .M_RVALID(M_RVALID),
			   .M_RREADY(M_RREADY),
			   .M_RDATA(M_RDATA),
			   .M_RRESP(M_RRESP),
			   .M_RLAST(M_RLAST),
			   .M_RID(M_RID),
			   .M_RUSER(M_RUSER),

			   //param0
			   .mem_imem_addr(mem_imem_1_440_addr),
			   .mem_imem_d(mem_imem_1_440_d),
			   .mem_imem_req(mem_imem_1_440_req),
			   .mem_imem_we(mem_imem_1_440_we),
			   .mem_imem_q(mem_imem_1_440_q),
			   //param1
			   .mem_dmem_addr(mem_dmem_1_442_addr),
			   .mem_dmem_d(mem_dmem_1_442_d),
			   .mem_dmem_req(mem_dmem_1_442_req),
			   .mem_dmem_we(mem_dmem_1_442_we),
			   .mem_dmem_q(mem_dmem_1_442_q),
			   //return0
			   .out0(mips_main_0_OUT0),
			   //for debug
			   .exec_state(master_state)
			   );


	//muxes
	function [6:0] mem_dmem_1_442_mux_addr_selector
	  (input [1:0] mem_dmem_1_442_mux_select_sig,
	   input [6:0] mem_dmem_1_442_addr,
	   input [6:0] mips_main_0_mem_dmem_1_442_addr
	   );
		begin
			case (1'b1)
				mem_dmem_1_442_mux_select_sig[0]: mem_dmem_1_442_mux_addr_selector = mem_dmem_1_442_addr;
				mem_dmem_1_442_mux_select_sig[1]: mem_dmem_1_442_mux_addr_selector = mips_main_0_mem_dmem_1_442_addr;
			endcase
		end
	endfunction // case

	assign mem_dmem_1_442_mux_addr = mem_dmem_1_442_mux_addr_selector(mem_dmem_1_442_mux_select_sig, mem_dmem_1_442_addr, mips_main_0_mem_dmem_1_442_addr);

	function [31:0] mem_dmem_1_442_mux_d_selector
	  (input [1:0] mem_dmem_1_442_mux_select_sig,
       input [31:0] mem_dmem_1_442_d,
       input [31:0] mips_main_0_mem_dmem_1_442_d
	   );
		begin
			case (1'b1)
				mem_dmem_1_442_mux_select_sig[0]: mem_dmem_1_442_mux_d_selector = mem_dmem_1_442_d;
				mem_dmem_1_442_mux_select_sig[1]: mem_dmem_1_442_mux_d_selector = mips_main_0_mem_dmem_1_442_d;
			endcase
		end
	endfunction // case

	assign mem_dmem_1_442_mux_d = mem_dmem_1_442_mux_d_selector(mem_dmem_1_442_mux_select_sig, mem_dmem_1_442_d, mips_main_0_mem_dmem_1_442_d);

	function [0:0] mem_dmem_1_442_mux_we_selector
	  (input [1:0] mem_dmem_1_442_mux_select_sig,
       input [0:0] mem_dmem_1_442_we,
       input [0:0] mips_main_0_mem_dmem_1_442_we
	   );
		begin
			case (1'b1)
				mem_dmem_1_442_mux_select_sig[0]: mem_dmem_1_442_mux_we_selector = mem_dmem_1_442_we;
				mem_dmem_1_442_mux_select_sig[1]: mem_dmem_1_442_mux_we_selector = mips_main_0_mem_dmem_1_442_we;
			endcase
		end
	endfunction // case

	assign mem_dmem_1_442_mux_we = mem_dmem_1_442_mux_we_selector(mem_dmem_1_442_mux_select_sig, mem_dmem_1_442_we, mips_main_0_mem_dmem_1_442_we);

	function [5:0] mem_imem_1_440_mux_addr_selector
	  (input [1:0] mem_imem_1_440_mux_select_sig,
       input [5:0] mem_imem_1_440_addr,
       input [5:0] mips_main_0_mem_imem_1_440_addr
	   );
		begin
			case (1'b1)
				mem_imem_1_440_mux_select_sig[0]: mem_imem_1_440_mux_addr_selector = mem_imem_1_440_addr;
				mem_imem_1_440_mux_select_sig[1]: mem_imem_1_440_mux_addr_selector = mips_main_0_mem_imem_1_440_addr;
			endcase
		end
	endfunction // case

	assign mem_imem_1_440_mux_addr = mem_imem_1_440_mux_addr_selector(mem_imem_1_440_mux_select_sig, mem_imem_1_440_addr, mips_main_0_mem_imem_1_440_addr);

	function [31:0] mem_imem_1_440_mux_d_selector
	  (input [1:0] mem_imem_1_440_mux_select_sig,
       input [31:0] mem_imem_1_440_d,
       input [31:0] mips_main_0_mem_imem_1_440_d
	   );
		begin
			case (1'b1)
				mem_imem_1_440_mux_select_sig[0]: mem_imem_1_440_mux_d_selector = mem_imem_1_440_d;
				mem_imem_1_440_mux_select_sig[1]: mem_imem_1_440_mux_d_selector = mips_main_0_mem_imem_1_440_d;
			endcase
		end
	endfunction // case

	assign mem_imem_1_440_mux_d = mem_imem_1_440_mux_d_selector(mem_imem_1_440_mux_select_sig, mem_imem_1_440_d, mips_main_0_mem_imem_1_440_d);
	function [0:0] mem_imem_1_440_mux_we_selector
	  (input [1:0] mem_imem_1_440_mux_select_sig,
       input [0:0] mem_imem_1_440_we,
       input [0:0] mips_main_0_mem_imem_1_440_we
	   );
		begin
			case (1'b1)
				mem_imem_1_440_mux_select_sig[0]: mem_imem_1_440_mux_we_selector = mem_imem_1_440_we;
				mem_imem_1_440_mux_select_sig[1]: mem_imem_1_440_mux_we_selector = mips_main_0_mem_imem_1_440_we;
			endcase
		end
	endfunction // case

	assign mem_imem_1_440_mux_we = mem_imem_1_440_mux_we_selector(mem_imem_1_440_mux_select_sig, mem_imem_1_440_we, mips_main_0_mem_imem_1_440_we);

	//demuxes
	assign mem_dmem_1_442_q =             1'b1 == mem_dmem_1_442_mux_select_sig[0] ? mem_dmem_1_442_mux_q:32'bz;
	assign mips_main_0_mem_dmem_1_442_q = 1'b1 == mem_dmem_1_442_mux_select_sig[1] ? mem_dmem_1_442_mux_q:32'bz;

	assign mem_imem_1_440_q =             1'b1 == mem_imem_1_440_mux_select_sig[0] ? mem_imem_1_440_mux_q:32'bz;
	assign mips_main_0_mem_imem_1_440_q = 1'b1 == mem_imem_1_440_mux_select_sig[1] ? mem_imem_1_440_mux_q:32'bz;

	wire reset = ~M_ARESETN;
	//sub module instances
	mips_main mips_main_0(.CLK(M_ACLK), .RST(reset),
						  .mips_main_OUT0(mips_main_0_OUT0),
						  .mips_main_READY(mips_main_0_READY),
						  .mips_main_ACCEPT(mips_main_0_ACCEPT),
						  .mips_main_VALID(mips_main_0_VALID),
						  .mem_dmem_36_q(mips_main_0_mem_dmem_1_442_q),
						  .mem_dmem_36_d(mips_main_0_mem_dmem_1_442_d),
						  .mem_dmem_36_addr(mips_main_0_mem_dmem_1_442_addr),
						  .mem_dmem_36_we(mips_main_0_mem_dmem_1_442_we),
						  .mem_dmem_36_req(mips_main_0_mem_dmem_1_442_req),
						  .mem_imem_35_q(mips_main_0_mem_imem_1_440_q),
						  .mem_imem_35_d(mips_main_0_mem_imem_1_440_d),
						  .mem_imem_35_addr(mips_main_0_mem_imem_1_440_addr),
						  .mem_imem_35_we(mips_main_0_mem_imem_1_440_we),
						  .mem_imem_35_req(mips_main_0_mem_imem_1_440_req));

	SinglePortRam#(.DATA_WIDTH(32), .ADDR_WIDTH(7))
	mem_dmem_1_442(.CLK(M_ACLK), .RST(reset),
				   .D(mem_dmem_1_442_mux_d),
				   .Q(mem_dmem_1_442_mux_q),
				   .ADDR(mem_dmem_1_442_mux_addr),
				   .WE(mem_dmem_1_442_mux_we));
	SinglePortRam#(.DATA_WIDTH(32), .ADDR_WIDTH(6))
	mem_imem_1_440(.CLK(M_ACLK), .RST(reset),
				   .D(mem_imem_1_440_mux_d),
				   .Q(mem_imem_1_440_mux_q),
				   .ADDR(mem_imem_1_440_mux_addr),
				   .WE(mem_imem_1_440_mux_we));

	//assigns
	assign mem_dmem_1_442_mux_select_sig = {mips_main_0_mem_dmem_1_442_req, mem_dmem_1_442_req};
	assign mem_imem_1_440_mux_select_sig = {mips_main_0_mem_imem_1_440_req, mem_imem_1_440_req};

	parameter [2:0] STATE_IDLE = 3'b000,
	  STATE_READ_PARAMS   = 3'b001,
	  STATE_PROCESS_START = 3'b010,
	  STATE_PROCESS_WAIT = 3'b011,
	  STATE_PROCESS_DONE = 3'b100,
	  STATE_RETURN_VALUE = 3'b101;

	always @(state) begin
		$display("top.state %d", state);
	end
	always @(reg_mode, reg_address, reg_length, reg_run) begin
		$display("reg_mode %d", reg_mode);
		$display("reg_address %x", reg_address);
		$display("reg_length %d", reg_length);
		$display("reg_run %d", reg_run);
	end
	always @(reg_status) begin
		$display("reg_status[3:0] %b", reg_status[3:0]);
	end

	
    reg reg_run_delay;
    wire run_pulse;
    assign run_pulse = (reg_run_delay == 1'b0 && reg_run[0] == 1'b1);
    always @(posedge M_ACLK) begin
        if (M_ARESETN == 1'b0) begin
            reg_run_delay <= 1'b0;
        end else begin
        	reg_run_delay <= reg_run[0];
		end
	end

	reg [3:0] state;
	always @(posedge M_ACLK) begin
		if (M_ARESETN == 1'b0) begin
			trans_start <= 1'b0;
			write_addr <= 0;
			write_len <= 0;
			read_addr <= 0;
			read_len <= 0;
			mips_main_0_READY <= 1'b0;
			mips_main_0_ACCEPT <= 1'b0;
			state <= STATE_IDLE;
		end else begin
			case (state)
				STATE_IDLE: begin
					mips_main_0_ACCEPT <= 1'b0;
					if (run_pulse == 1'b1) begin
						trans_start <= 1'b1;
						input_done <= 1'b0;
						output_done <= 1'b0;
						if (reg_mode[0] == 1'b0) begin
							state <= STATE_RETURN_VALUE;
						end else begin
							state <= STATE_READ_PARAMS;
						end
					end
				end
				STATE_READ_PARAMS: begin
					trans_start <= 1'b0;
					read_addr <= reg_address;
					read_len <= reg_length;
					if (trans_done == 1'b1) begin
						input_done <= 1'b1;
						state <= STATE_PROCESS_START;
					end
				end
				STATE_PROCESS_START: begin
					mips_main_0_READY <= 1'b1;
					state <= STATE_PROCESS_WAIT;
				end
				STATE_PROCESS_WAIT: begin
					mips_main_0_READY <= 1'b0;
					if (mips_main_0_VALID) begin
						state <= STATE_PROCESS_DONE;
					end
				end
				STATE_PROCESS_DONE: begin
					mips_main_0_ACCEPT <= 1'b0;
					state <= STATE_IDLE;
				end
				STATE_RETURN_VALUE: begin
					trans_start <= 1'b0;
					write_addr <= reg_address;
					write_len <= reg_length;
					if (trans_done == 1'b1) begin
						output_done <= 1'b1;
						mips_main_0_ACCEPT <= 1'b1;
						state <= STATE_IDLE;
					end
				end
			endcase
		end
	end

	assign reg_status = {21'b0,  master_state, 1'b0, state, kernel_done, output_done, input_done};
    
endmodule
