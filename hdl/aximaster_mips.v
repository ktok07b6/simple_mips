
module fifo_buffer #
(
 parameter integer DATA_WIDTH = 32,
 parameter integer ADDR_WIDTH = 4,
 parameter integer READY_THRESHOLD = 2,
 parameter integer LOW_THRESHOLD = 2
)
(
 input ACLK,
 input ARESETN,
 input [DATA_WIDTH-1:0]  data_in,
 input enq,
 output full,
 output ready,
 output will_empty,
 output [DATA_WIDTH-1:0] data_out,
 input deq,
 output empty
);

reg [ADDR_WIDTH-1:0] head;
reg [ADDR_WIDTH-1:0] tail;
reg [ADDR_WIDTH  :0] count;
wire we;
assign we = enq && !full;
  
localparam LENGTH = 2 ** ADDR_WIDTH;
reg [DATA_WIDTH-1:0] mem [0:LENGTH-1];

always @(posedge ACLK) begin
	if(we) mem[head] <= data_in;
end
assign data_out = mem[tail];

assign ready = count >= READY_THRESHOLD;
assign full = count >= LENGTH;
assign will_empty = count <= LOW_THRESHOLD;
assign empty = count == 0;

always @(posedge ACLK) begin
	if (ARESETN == 0) begin
		head  <= 0;
		tail  <= 0;
		count <= 0;
	end else begin
		if (enq && deq) begin
			if (count == LENGTH) begin
				count <= count - 1;
				tail <= (tail == LENGTH-1)? 0 : tail + 1;
			end else if (count == 0) begin
				count <= count + 1;
				head <= (head == LENGTH-1)? 0 : head + 1;
			end else begin
				count <= count;
				head <= (head == LENGTH-1)? 0 : head + 1;
				tail <= (tail == LENGTH-1)? 0 : tail + 1;
			end
		end else if (enq) begin
			if (count < LENGTH) begin
				count <= count + 1;
				head <= (head == LENGTH-1)? 0 : head + 1;
			end
		end else if (deq) begin
			if (count > 0) begin
				count <= count - 1;
				tail <= (tail == LENGTH-1)? 0 : tail + 1;
			end
		end
	end
end

endmodule


module AXI_Master_Mips #
(
 parameter integer C_ADDR_WIDTH= 32,
 parameter integer C_DATA_WIDTH= 32
)
(
 input [1:0] TRANSACTION_MODE,
 input wire INIT_TXN,
 output wire TXN_DONE,
 output reg  ERROR,
 input wire [C_ADDR_WIDTH-1: 0] WRITE_ADDR,
 input wire [15:0] WRITE_LEN,
 input wire [C_ADDR_WIDTH-1: 0] READ_ADDR,
 input wire [15:0] READ_LEN,

 input wire  M_ACLK,
 input wire  M_ARESETN,
 /* write address */
 output wire M_AWVALID,
 input wire M_AWREADY,
 output wire [C_ADDR_WIDTH-1 : 0] M_AWADDR,
 output wire [7 : 0] M_AWLEN,
 output wire [2 : 0] M_AWSIZE,
 output wire [1 : 0] M_AWBURST, /*b01*/
 output wire [3 : 0] M_AWCACHE, /*b0010*/
 output wire M_AWID, /*unused*/
 output wire M_AWLOCK, /*unused*/
 output wire [2 : 0] M_AWPROT, /*unused*/
 output wire [3 : 0] M_AWQOS, /*unused*/
 output wire M_AWUSER, /*unused*/
 /* write data */
 output wire M_WVALID,
 input wire M_WREADY,
 output wire [C_DATA_WIDTH-1 : 0] M_WDATA,
 output wire [C_DATA_WIDTH/8-1 : 0] M_WSTRB,
 output wire M_WLAST,
 output wire M_WUSER, /*unused*/
 /* write response */
 input wire M_BVALID,
 output wire M_BREADY,
 input wire [1 : 0] M_BRESP,
 input wire M_BID, /*unused*/
 input wire M_BUSER, /*unused*/

 /* read address */
 output wire M_ARVALID,
 input wire M_ARREADY,
 output wire [C_ADDR_WIDTH-1 : 0] M_ARADDR,
 output wire [7 : 0] M_ARLEN,
 output wire [2 : 0] M_ARSIZE,
 output wire [1 : 0] M_ARBURST, /*b01*/
 output wire [3 : 0] M_ARCACHE, /*b0010*/
 output wire M_ARID, /*unused*/
 output wire M_ARLOCK, /*unused*/
 output wire [2 : 0] M_ARPROT, /*unused*/
 output wire [3 : 0] M_ARQOS, /*unused*/
 output wire M_ARUSER, /*unused*/

 /* read data */
 input wire M_RVALID,
 output wire M_RREADY,
 input wire [C_DATA_WIDTH-1 : 0] M_RDATA,
 input wire [1 : 0] M_RRESP,
 input wire M_RLAST,
 input wire M_RID, /*unused*/
 input wire M_RUSER, /*unused*/


 //param0
 output reg [5:0] mem_imem_addr,
 output reg [31:0] mem_imem_d,
 output reg mem_imem_req,
 output reg mem_imem_we,
 input wire [31:0] mem_imem_q,
 //param1
 output reg [6:0] mem_dmem_addr,
 output reg [31:0] mem_dmem_d,
 output reg mem_dmem_req,
 output reg mem_dmem_we,
 input wire [31:0] mem_dmem_q,
 //return0
 input wire [31:0] out0,
 output wire [2:0] exec_state
);

function integer clogb2 (input integer bit_depth);
	begin
		for(clogb2=0; bit_depth>0; clogb2=clogb2+1)
		  bit_depth = bit_depth >> 1;
	end
endfunction // clogb2

localparam BURST_LEN = 256;
// AXI4LITE signals
//AXI4 internal temp signals
reg [C_ADDR_WIDTH-1 : 0] axi_awaddr;
reg axi_awvalid;
reg axi_wlast;
reg axi_wvalid;
reg [C_ADDR_WIDTH-1 : 0] axi_araddr;
reg  axi_arvalid;
reg  axi_rready;

reg [15:0] write_index;
reg [15:0] read_index;
wire [9:0] write_burst_size_bytes;
wire [9:0] read_burst_size_bytes;
reg  start_single_burst_write;
reg  start_single_burst_read;
reg  writes_done;
reg  reads_done;
reg  error_reg;
reg  trans_done;
reg  burst_write_active;
reg  burst_read_active;

//Interface response error flags
wire  write_resp_error;
wire  read_resp_error;
wire  wnext;
wire  rnext;
reg  init_txn_ff;
reg  init_txn_ff2;
wire  init_txn_pulse;
localparam MODE_WRITE = 2'b00;
localparam MODE_READ  = 2'b01;

// I/O Connections assignments
assign M_AWID= 'b0;
assign M_AWADDR= WRITE_ADDR + axi_awaddr;

assign M_AWLEN= WRITE_LEN > BURST_LEN ? BURST_LEN-1 : WRITE_LEN-1;
assign M_AWSIZE= clogb2((C_DATA_WIDTH/8)-1);
assign M_AWBURST= 2'b01;
assign M_AWLOCK= 1'b0;

assign M_AWCACHE= 4'b0011;
assign M_AWPROT= 3'h0;
assign M_AWQOS= 4'h0;
assign M_AWUSER= 'b1;
assign M_AWVALID= axi_awvalid;

assign M_WSTRB= {(C_DATA_WIDTH/8){1'b1}};
assign M_WLAST= axi_wlast;
assign M_WUSER= 'b0;
assign M_WVALID= axi_wvalid;

assign M_BREADY= 1'b1;

assign M_ARID= 'b0;
assign M_ARADDR= READ_ADDR + axi_araddr;
assign M_ARLEN= READ_LEN > BURST_LEN ? BURST_LEN-1 : READ_LEN-1;
assign M_ARSIZE= clogb2((C_DATA_WIDTH/8)-1);
assign M_ARBURST= 2'b01;
assign M_ARLOCK= 1'b0;
assign M_ARCACHE= 4'b0011;
assign M_ARPROT= 3'h0;
assign M_ARQOS= 4'h0;
assign M_ARUSER= 'b1;
assign M_ARVALID= axi_arvalid;
assign M_RREADY= axi_rready;

assign TXN_DONE= trans_done;

assign write_burst_size_bytes= WRITE_LEN > BURST_LEN ? BURST_LEN * C_DATA_WIDTH/8: WRITE_LEN * C_DATA_WIDTH/8;
assign read_burst_size_bytes= READ_LEN > BURST_LEN ? BURST_LEN * C_DATA_WIDTH/8: READ_LEN * C_DATA_WIDTH/8;

assign init_txn_pulse= (!init_txn_ff2) && init_txn_ff;
always @(posedge M_ACLK) begin
	if (M_ARESETN == 0) begin
		init_txn_ff <= 1'b0;
		init_txn_ff2 <= 1'b0;
	end	else begin
		init_txn_ff <= INIT_TXN;
		init_txn_ff2 <= init_txn_ff;
	end
end


//awvalid & awaddr
reg aw_accept;
always @(posedge M_ACLK) begin
	if (M_ARESETN == 0 || init_txn_pulse == 1'b1 ) begin
		axi_awvalid <= 1'b0;
		axi_awaddr <= 'b0;
		aw_accept <= 'b0;
	end else if (~axi_awvalid && start_single_burst_write) begin
		axi_awvalid <= 1'b1;
		axi_awaddr <= axi_awaddr;
		aw_accept <= 'b1;
	end else if (M_AWREADY && axi_awvalid) begin
		axi_awvalid <= 1'b0;
		axi_awaddr <= axi_awaddr + write_burst_size_bytes;
	end else begin
		axi_awvalid <= axi_awvalid;
		axi_awaddr <= axi_awaddr;
		aw_accept <= aw_accept;
	end
end


reg [7:0] param;

localparam PARAM0_LEN = 44;
localparam PARAM1_LEN = 64;
localparam RETURN0_LEN = 4;
wire [15:0] param0_write_index;
wire [15:0] param1_write_index;
wire [15:0] param0_read_index;
wire [15:0] param1_read_index;
assign param0_write_index = write_index;
assign param1_write_index = write_index - PARAM0_LEN;
assign param0_read_index = read_index;
assign param1_read_index = read_index - PARAM0_LEN;

//param
always @(posedge M_ACLK) begin
	if (M_ARESETN == 0 || init_txn_pulse == 1'b1) begin
		param <= 0;
	end else if (burst_write_active) begin
		if (write_index == 0) begin
			param <= 0;
		end	else if (write_index == PARAM0_LEN+1) begin
			param <= 1;
		end	else if (write_index == (PARAM0_LEN+PARAM1_LEN+1)) begin
			param <= 2;
		end else begin
			param <= param;
		end
	end else if (burst_read_active) begin
		if (read_index == 0) begin
			param <= 0;
		end	else if (read_index == PARAM0_LEN-1) begin
			param <= 1;
		end else begin
			param <= param;
		end
	end
end


//imem address & we & req control
always @(posedge M_ACLK) begin
	if (M_ARESETN == 0 || init_txn_pulse == 1'b1) begin
		mem_imem_addr <= 'b0;
		mem_imem_we <= 1'b0;
	end else if (start_single_burst_write
			|| (burst_write_active && param0_write_index < PARAM0_LEN)) begin
			mem_imem_addr <= param0_write_index;
			mem_imem_we <= 1'b0;
	end else if (start_single_burst_read
					 || (burst_read_active && param0_read_index < PARAM0_LEN)) begin
			mem_imem_addr <= param0_read_index;
			mem_imem_we <= 1'b1;
	end else begin
		mem_imem_addr <= 'b0;
		mem_imem_we <= 1'b0;
	end
end

always @(posedge M_ACLK) begin
	if (M_ARESETN == 0 || init_txn_pulse == 1'b1) begin
		mem_imem_req <= 1'b0;
	end else if (start_single_burst_write
			|| (burst_write_active && param0_write_index < PARAM0_LEN+1)) begin
			mem_imem_req <= 1'b1;
	end else if (start_single_burst_read
					 || (burst_read_active && param0_read_index < PARAM0_LEN+1)) begin
			mem_imem_req <= 1'b1;
	end else begin
		mem_imem_req <= 1'b0;
	end
end


//dmem address control
always @(posedge M_ACLK) begin
	if (M_ARESETN == 0 || init_txn_pulse == 1'b1) begin
		mem_dmem_addr <= 'b0;
		mem_dmem_we <= 1'b0;
	end else if (start_single_burst_write
			|| (burst_write_active && param1_write_index < PARAM1_LEN)) begin
			mem_dmem_addr <= param1_write_index;
			mem_dmem_we <= 1'b0;
	end else if (start_single_burst_read
			 || (burst_read_active && param1_read_index < PARAM1_LEN)) begin
			mem_dmem_addr <= param1_read_index;
			mem_dmem_we <= 1'b1;
	end else begin
		mem_dmem_addr <= 'b0;
		mem_dmem_we <= 1'b0;
	end
end

always @(posedge M_ACLK) begin
	if (M_ARESETN == 0 || init_txn_pulse == 1'b1) begin
		mem_dmem_req <= 1'b0;
	end else if (start_single_burst_write
			|| (burst_write_active && param1_write_index < PARAM1_LEN+1)) begin
			mem_dmem_req <= 1'b1;
	end else if (start_single_burst_read
			 || (burst_read_active && param1_read_index < PARAM1_LEN+1)) begin
			mem_dmem_req <= 1'b1;
	end else begin
		mem_dmem_req <= 1'b0;
	end
end


reg fifo_enq;
wire fifo_deq;
reg [31:0] fifo_in;
wire [31:0] fifo_out;
wire fifo_full;
wire fifo_ready;
wire fifo_empty;
wire fifo_will_empty;

fifo_buffer #(
    .DATA_WIDTH(32), 
    .ADDR_WIDTH(4),
    .READY_THRESHOLD(2),
    .LOW_THRESHOLD(2)
    )
 fifo_buffer_inst(
	.ACLK(M_ACLK),
	.ARESETN(M_ARESETN),
	.enq(fifo_enq),
	.deq(fifo_deq),
	.data_in(fifo_in),
	.data_out(fifo_out),
	.full(fifo_full),
	.ready(fifo_ready),
	.empty(fifo_empty),
	.will_empty(fifo_will_empty));

assign wnext = M_WREADY & axi_wvalid;
assign M_WDATA = fifo_out;
assign fifo_deq = M_WREADY & axi_wvalid;

//wvalid
always @(posedge M_ACLK) begin
	if (M_ARESETN == 0 || init_txn_pulse == 1'b1) begin
		axi_wvalid <= 1'b0;
	end else if (~axi_wvalid && burst_write_active && fifo_ready) begin
		axi_wvalid <= 1'b1;
	end else if (axi_wlast) begin
		axi_wvalid <= 1'b0;
	end else begin
		axi_wvalid <= axi_wvalid;
	end
end

//wlast
always @(posedge M_ACLK) begin
	if (M_ARESETN == 0 || init_txn_pulse == 1'b1 ) begin
		axi_wlast <= 1'b0;
	end else if (~axi_wlast && wnext && WRITE_LEN != 1 && fifo_will_empty) begin
		axi_wlast <= 1'b1;
	end else begin
		axi_wlast <= 1'b0;
	end
end

//write_index
always @(posedge M_ACLK) begin
	if (M_ARESETN == 0
		|| init_txn_pulse == 1'b1
		) begin
		write_index <= 0;
	//count up after mem_req has been asserted
	end else if (burst_write_active && ~axi_wlast && ~fifo_full && write_index != WRITE_LEN+2) begin
        write_index <= write_index + 1;
	end else begin
		write_index <= write_index;
	end
end

//write to fifo
always @(posedge M_ACLK) begin
    if (M_ARESETN == 0
		|| init_txn_pulse == 1'b1
		) begin
		fifo_enq <= 0;
	end else if (~axi_wlast && ~fifo_full && write_index >= 2 && write_index != WRITE_LEN+2) begin
		fifo_enq <= 1;
		case (param)
            2'b00: fifo_in <= mem_imem_q;
            2'b01: fifo_in <= mem_dmem_q;
            2'b10: fifo_in <= out0;
            default: fifo_in <= 'bz;
        endcase
	end else begin
		fifo_enq <= 0;
	end
end


//write active
always @(posedge M_ACLK) begin
	if (M_ARESETN == 0) begin
		burst_write_active <= 1'b0;
	end else if (start_single_burst_write == 1'b1) begin
		burst_write_active <= 1'b1;
	end else if (M_BVALID) begin
		burst_write_active <= 0;
	end
end

//writes done
always @(posedge M_ACLK) begin
	if (M_ARESETN == 0 || init_txn_pulse == 1'b1) begin
		writes_done <= 1'b0;
	end else if (M_BVALID) begin
		writes_done <= 1'b1;
	end else if (writes_done == 1'b1) begin
		writes_done <= 1'b0;
	end else begin
		writes_done <= writes_done;
	end
end

//arvalid & araddr
always @(posedge M_ACLK) begin
	if (M_ARESETN == 0 || init_txn_pulse == 1'b1 ) begin
		axi_arvalid <= 1'b0;
		axi_araddr <= 'b0;
	end else if (~axi_arvalid && start_single_burst_read) begin
		axi_arvalid <= 1'b1;
		axi_araddr <= axi_araddr;
	end else if (M_ARREADY && axi_arvalid) begin
		axi_arvalid <= 1'b0;
		axi_araddr <= axi_araddr + read_burst_size_bytes;
	end else begin
		axi_arvalid <= axi_arvalid;
		axi_araddr <= axi_araddr;
	end
end



assign rnext = M_RVALID && axi_rready;

//rready
always @(posedge M_ACLK) begin
	if (M_ARESETN == 0 || init_txn_pulse == 1'b1 ) begin
		axi_rready <= 1'b0;
	end else if (M_RLAST && axi_rready) begin
		axi_rready <= 1'b0;
	end else if (M_ARREADY && axi_arvalid
				 || M_RVALID) begin
		axi_rready <= 1'b1;
	end	else begin
		axi_rready <= axi_rready;
	end
end

//rdata
always @(posedge M_ACLK) begin
	if (M_ARESETN == 0 || init_txn_pulse == 1'b1) begin
		mem_imem_d <= 'bz;
        mem_dmem_d <= 'bz;
	end else if (M_RVALID && axi_rready) begin
		case (param)
			2'b00: begin
				mem_imem_d <= M_RDATA;
				mem_dmem_d <= 'bz;
			end
			2'b01: begin
				mem_imem_d <= 'bz;
				mem_dmem_d <= M_RDATA;
			end
		endcase
	end else begin
		//
	end
end

//read index
always @(posedge M_ACLK) begin
	if (M_ARESETN == 0
		|| init_txn_pulse == 1'b1
		|| start_single_burst_read) begin
		read_index <= 0;
	end else if (~M_RLAST && rnext && (read_index <= READ_LEN-1)) begin
		read_index <= read_index + 1;
	end else begin
		read_index <= read_index;
	end
end

//read active
always @(posedge M_ACLK) begin
	if (M_ARESETN == 0) begin
		burst_read_active <= 1'b0;
	end else if (start_single_burst_read) begin
		burst_read_active <= 1'b1;
	end else if (M_RVALID && axi_rready && M_RLAST) begin
		burst_read_active <= 0;
	end
end

//reads done
always @(posedge M_ACLK) begin
	if (M_ARESETN == 0 || init_txn_pulse == 1'b1) begin
		reads_done <= 1'b0;
	end else if (M_RVALID && axi_rready && M_RLAST) begin
		reads_done <= 1'b1;
	end else if (reads_done == 1'b1) begin
		reads_done <= 1'b0;
	end else begin
		reads_done <= reads_done;
	end
end


assign write_resp_error = M_BVALID & M_BRESP[1];
assign read_resp_error = axi_rready & M_RVALID & M_RRESP[1];

always @(posedge M_ACLK) begin
	if (M_ARESETN == 0 || init_txn_pulse == 1'b1) begin
		error_reg <= 1'b0;
	end else if (write_resp_error || read_resp_error) begin
		error_reg <= 1'b1;
	end else begin
		error_reg <= error_reg;
	end
end

parameter [2:0] STATE_IDLE = 3'b000,
  STATE_WRITE_INIT         = 3'b001,
  STATE_WRITE_CONTINUE     = 3'b010,
  STATE_READ_INIT          = 3'b011,
  STATE_READ_CONTINUE      = 3'b100;

reg [2:0] mst_exec_state;
always @ ( posedge M_ACLK) begin
	if (M_ARESETN == 1'b0 ) begin
		mst_exec_state <= STATE_IDLE;
		start_single_burst_write <= 1'b0;
		start_single_burst_read  <= 1'b0;
		trans_done <= 1'b0;
		ERROR <= 1'b0;
	end else begin
		case (mst_exec_state)
			STATE_IDLE: begin
				trans_done <= 1'b0;
				if (init_txn_pulse == 1'b1) begin

					ERROR <= 1'b0;
					if (TRANSACTION_MODE == MODE_WRITE) begin
						mst_exec_state <= STATE_WRITE_INIT;
					end else begin
						mst_exec_state <= STATE_READ_INIT;
					end
				end else begin
					mst_exec_state <= STATE_IDLE;
				end
			end
			STATE_WRITE_INIT: begin
				if (~axi_awvalid && ~start_single_burst_write && ~burst_write_active) begin
					start_single_burst_write <= 1'b1;
					mst_exec_state <= STATE_WRITE_CONTINUE;
				end
			end
			STATE_WRITE_CONTINUE: begin
				if (writes_done) begin
					ERROR <= error_reg;
					mst_exec_state <= STATE_IDLE;
					trans_done <= 1'b1;
				end else begin
					start_single_burst_write <= 1'b0;
				end
			end

			STATE_READ_INIT: begin
				if (~axi_arvalid && ~burst_read_active && ~start_single_burst_read) begin
					start_single_burst_read <= 1'b1;
					mst_exec_state <= STATE_READ_CONTINUE;
				end
			end
			STATE_READ_CONTINUE: begin
				if (reads_done) begin
					ERROR <= error_reg;
					mst_exec_state <= STATE_IDLE;
					trans_done <= 1'b1;
				end else begin
					start_single_burst_read <= 1'b0;
				end
			end
			default: begin
				mst_exec_state  <= STATE_IDLE;
			end
		endcase
	end
end

always @ (M_ARREADY, M_ARVALID, M_ARLEN, M_ARADDR, M_RREADY, M_RVALID, M_RDATA, M_RLAST) begin
	$display("%5t:ARREADY=%b ARVALID=%b ARLEN %1d ARADDR=%x RREADY %b RVALID %b RDATA %x RLAST %b",
			 $time,
			 M_ARREADY, M_ARVALID, M_ARLEN, M_ARADDR, M_RREADY, M_RVALID, M_RDATA, M_RLAST);
end

always @ (M_AWREADY, M_AWVALID, M_AWLEN, M_AWADDR, M_WREADY, M_WVALID, M_WDATA, M_WLAST) begin
	$display("%5t:AWREADY=%b AWVALID=%b AWLEN %1d AWADDR=%x WREADY %b WVALID %b WDATA %x WLAST %b",
			 $time,
			 M_AWREADY, M_AWVALID, M_AWLEN, M_AWADDR, M_WREADY, M_WVALID, M_WDATA, M_WLAST);
end
always @ (M_BREADY, M_BVALID, M_BRESP) begin
	$display("%5t:BREADY=%b BVALID=%b BRESP %b",
			 $time,
			 M_BREADY, M_BVALID, M_BRESP);
end

always @ (mst_exec_state) begin
	$display("mst_exec_state %d", mst_exec_state);
end
always @ (read_index) begin
	$display("read_index %d", read_index);
end
always @ (write_index) begin
	$display("write_index %d", write_index);
end
always @ (start_single_burst_read) begin
	$display("start_single_burst_read %b", start_single_burst_read);
end
always @ (start_single_burst_write) begin
	$display("start_single_burst_write %b", start_single_burst_write);
end
always @ (burst_read_active) begin
	$display("burst_read_active %b", burst_read_active);
end
always @ (burst_write_active) begin
	$display("burst_write_active %b", burst_write_active);
end

always @ (param) begin
	$display("param %d", param);
end

always @(mem_dmem_addr, mem_dmem_d, mem_dmem_req, mem_dmem_we, mem_dmem_q) begin
	$display("dmem_addr %d", mem_dmem_addr);
	$display("dmem_d %d", mem_dmem_d);
	$display("dmem_req %b", mem_dmem_req);
	$display("dmem_we %b", mem_dmem_we);
	$display("dmem_q %d", mem_dmem_q);
end

always @(mem_imem_addr, mem_imem_d, mem_imem_req, mem_imem_we, mem_imem_q) begin
	$display("imem_addr %d", mem_imem_addr);
	$display("imem_d %x", mem_imem_d);
	$display("imem_req %b", mem_imem_req);
	$display("imem_we %b", mem_imem_we);
	$display("imem_q %x", mem_imem_q);
end

assign exec_state= mst_exec_state;

endmodule


