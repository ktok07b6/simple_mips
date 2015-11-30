module AXI_Slave_Lite #
(
 parameter integer C_DATA_WIDTH= 32,
 parameter integer C_ADDR_WIDTH= 5
)
(
 output wire [C_DATA_WIDTH-1 : 0] MODE,
 output wire [C_DATA_WIDTH-1 : 0] ADDRESS,
 output wire [C_DATA_WIDTH-1 : 0] LENGTH,
 output wire [C_DATA_WIDTH-1 : 0] RUN,
 input wire [C_DATA_WIDTH-1 : 0] STATUS,
 input wire [C_DATA_WIDTH-1 : 0] STATUS2,

 input wire  S_ACLK,
 input wire  S_ARESETN,

 input wire [C_ADDR_WIDTH-1 : 0] S_AWADDR,
 input wire [2 : 0] S_AWPROT,
 input wire  S_AWVALID,
 output wire  S_AWREADY,

 input wire [C_DATA_WIDTH-1 : 0] S_WDATA,
 input wire [(C_DATA_WIDTH/8)-1 : 0] S_WSTRB,
 input wire  S_WVALID,
 output wire  S_WREADY,
 
 output wire [1 : 0] S_BRESP,
 output wire  S_BVALID,
 input wire  S_BREADY,
 
 input wire [C_ADDR_WIDTH-1 : 0] S_ARADDR,
 input wire [2 : 0] S_ARPROT,
 input wire  S_ARVALID,
 output wire  S_ARREADY,

 output wire [C_DATA_WIDTH-1 : 0] S_RDATA,
 output wire [1 : 0] S_RRESP,
 output wire  S_RVALID,
 input wire  S_RREADY
);

// AXI4LITE signals
reg [C_ADDR_WIDTH-1 : 0] axi_awaddr;
reg axi_awready;
reg axi_wready;
reg [1 : 0] axi_bresp;
reg axi_bvalid;
reg [C_ADDR_WIDTH-1 : 0] axi_araddr;
reg axi_arready;
reg [C_DATA_WIDTH-1 : 0] axi_rdata;
reg [1 : 0] axi_rresp;
reg axi_rvalid;

localparam integer ADDR_LSB = (C_DATA_WIDTH/32) + 1;
localparam integer REG_ADDR_BITS = 2;

reg [C_DATA_WIDTH-1:0] reg_mode;
reg [C_DATA_WIDTH-1:0] reg_address;
reg [C_DATA_WIDTH-1:0] reg_length;
reg [C_DATA_WIDTH-1:0] reg_run;
wire [C_DATA_WIDTH-1:0] reg_status;
wire [C_DATA_WIDTH-1:0] reg_status2;
wire reg_rden;
wire reg_wren;
reg [C_DATA_WIDTH-1:0] reg_data_out;

assign MODE = reg_mode;
assign ADDRESS = reg_address;
assign LENGTH = reg_length;
assign RUN = reg_run;
assign reg_status = STATUS;
assign reg_status2 = STATUS2;

assign S_AWREADY= axi_awready;
assign S_WREADY= axi_wready;
assign S_BRESP= axi_bresp;
assign S_BVALID= axi_bvalid;
assign S_ARREADY= axi_arready;
assign S_RDATA= axi_rdata;
assign S_RRESP= axi_rresp;
assign S_RVALID= axi_rvalid;

always @(posedge S_ACLK) begin
	if (S_ARESETN == 1'b0) begin
		axi_awready <= 1'b0;
	end else begin
		if (~axi_awready && S_AWVALID && S_WVALID) begin
			axi_awready <= 1'b1;
		end else begin
			axi_awready <= 1'b0;
		end
	end
end

always @(posedge S_ACLK) begin
	if (S_ARESETN == 1'b0) begin
		axi_awaddr <= 0;
	end else begin
		if (~axi_awready && S_AWVALID && S_WVALID) begin
			axi_awaddr <= S_AWADDR;
		end
	end
end

always @(posedge S_ACLK) begin
	if (S_ARESETN == 1'b0) begin
		axi_wready <= 1'b0;
	end else begin
		if (~axi_wready && S_WVALID && S_AWVALID) begin
			axi_wready <= 1'b1;
		end else begin
			axi_wready <= 1'b0;
		end
	end
end

assign reg_wren = axi_wready && S_WVALID && axi_awready && S_AWVALID;

always @(posedge S_ACLK) begin
	if (S_ARESETN == 1'b0) begin
		reg_mode <= 0;
		reg_address <= 0;
		reg_length <= 0;
		reg_run <= 0;
	end else begin
		if (reg_wren) begin
			case (axi_awaddr[ADDR_LSB+REG_ADDR_BITS:ADDR_LSB])
				3'b000: reg_mode <= S_WDATA;
				3'b001: reg_address <= S_WDATA;
				3'b010: reg_length <= S_WDATA;
				3'b011: reg_run <= S_WDATA;
				default : begin
					reg_mode <= reg_mode;
					reg_address <= reg_address;
					reg_length <= reg_length;
					reg_run <= reg_run;
				end
			endcase
		end
	end
end

always @(posedge S_ACLK) begin
	if (S_ARESETN == 1'b0) begin
		axi_bvalid <= 0;
		axi_bresp  <= 2'b0;
	end else begin
		if (axi_awready && S_AWVALID && ~axi_bvalid && axi_wready && S_WVALID) begin
			axi_bvalid <= 1'b1;
			axi_bresp  <= 2'b0;
		end else begin
			if (S_BREADY && axi_bvalid) begin
				axi_bvalid <= 1'b0;
			end
		end
	end
end

always @(posedge S_ACLK) begin
	if (S_ARESETN == 1'b0) begin
		axi_arready <= 1'b0;
		axi_araddr  <= 32'b0;
	end else begin
		if (~axi_arready && S_ARVALID) begin
			axi_arready <= 1'b1;
			axi_araddr  <= S_ARADDR;
		end else begin
			axi_arready <= 1'b0;
		end
	end
end

always @(posedge S_ACLK) begin
	if (S_ARESETN == 1'b0) begin
		axi_rvalid <= 0;
		axi_rresp  <= 0;
	end else begin
		if (axi_arready && S_ARVALID && ~axi_rvalid) begin
			axi_rvalid <= 1'b1;
			axi_rresp  <= 2'b0;
		end else if (axi_rvalid && S_RREADY) begin
			axi_rvalid <= 1'b0;
		end
	end
end


assign reg_rden = axi_arready & S_ARVALID & ~axi_rvalid;
always @(*) begin
	case (axi_araddr[ADDR_LSB+REG_ADDR_BITS:ADDR_LSB])
		3'b000: reg_data_out <= 0;
		3'b001: reg_data_out <= 11;
		3'b010: reg_data_out <= 22;
		3'b011: reg_data_out <= 33;
		3'b100: reg_data_out <= reg_status;
		3'b101: reg_data_out <= reg_status2;
		default: reg_data_out <= 0;
	endcase
end

always @(posedge S_ACLK) begin
	if (S_ARESETN == 1'b0) begin
		axi_rdata <= 0;
	end else begin
		if (reg_rden) begin
			axi_rdata <= reg_data_out;
		end
	end
end

endmodule // lite_slave_v1_0_S00_AXI
