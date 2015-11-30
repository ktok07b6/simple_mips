`timescale 1ns / 1ps

module simple_mips_v1_0_tb();
	//localparams
	localparam C_S_ADDR_WIDTH = 5;
	localparam C_M_ADDR_WIDTH = 32;
	localparam C_DATA_WIDTH = 32;
	localparam C_WRITE_BURST_LEN = 4;
	localparam C_READ_BURST_LEN = 4;

	localparam CLK_PERIOD = 10;
	localparam CLK_HALF_PERIOD = 5;
	localparam INITIAL_RESET_SPAN = 100;
	//internal regs
	reg CLK;
	reg RSTn;

	/* write address */
	reg [C_S_ADDR_WIDTH-1 : 0] S_AWADDR;
	reg [2 : 0] S_AWPROT;
	reg S_AWVALID;
	wire S_AWREADY;

	/* write data */
	reg [C_DATA_WIDTH-1 : 0] S_WDATA;
	reg [C_DATA_WIDTH/8-1 : 0] S_WSTRB;
	reg S_WVALID;
	wire S_WREADY;

	/* write response */
	wire [1 : 0] S_BRESP;
	wire S_BVALID;
	reg S_BREADY;

	/* read address */
	reg [C_S_ADDR_WIDTH-1 : 0] S_ARADDR;
	reg [2 : 0] S_ARPROT; /*unused*/
	reg S_ARVALID;
	wire S_ARREADY;

	/* read data */
	wire [C_DATA_WIDTH-1 : 0] S_RDATA;
	wire [1 : 0] S_RRESP;
	wire S_RVALID;
	reg S_RREADY;

	/* write address */
	wire M_AWVALID;
	reg M_AWREADY;
	wire [C_M_ADDR_WIDTH-1 : 0] M_AWADDR;
	wire [7:0] M_AWLEN;
	wire [2:0] M_AWSIZE;
	wire [1:0] M_AWBURST;
	wire [3:0] M_AWCACHE;
	wire M_AWID;
	wire M_AWLOCK;
	wire [2 : 0] M_AWPROT;
	wire [3 : 0] M_AWQOS;
	wire M_AWUSER;

	/* write data */
	wire M_WVALID;
	reg M_WREADY;
	wire [C_DATA_WIDTH-1 : 0] M_WDATA;
	wire [C_DATA_WIDTH/8-1 : 0] M_WSTRB;
	wire M_WLAST;
	wire M_WUSER; /*unused*/
	/* write response */
	reg M_BVALID;
	wire M_BREADY;
	reg [1 : 0] M_BRESP;
	reg M_BID; /*unused*/
	reg M_BUSER; /*unused*/

	/* read address */
	wire M_ARVALID;
	reg M_ARREADY;
	wire [C_M_ADDR_WIDTH-1 : 0] M_ARADDR;
	wire [7 : 0] M_ARLEN;
	wire [2 : 0] M_ARSIZE;
	wire [1 : 0] M_ARBURST; /*b01*/
	wire [3 : 0] M_ARCACHE; /*b0010*/
	wire M_ARID; /*unused*/
	wire M_ARLOCK; /*unused*/
	wire [2 : 0] M_ARPROT; /*unused*/
	wire [3 : 0] M_ARQOS; /*unused*/
	wire M_ARUSER; /*unused*/

	/* read data */
	reg M_RVALID;
	wire M_RREADY;
	reg [C_DATA_WIDTH-1 : 0] M_RDATA;
	reg [1 : 0] M_RRESP;
	reg M_RLAST;
	reg M_RID; /*unused*/
	reg M_RUSER; /*unused*/

    wire proc_done;

	simple_mips_v1_0 simple_mips_v1_0_inst(.S_ACLK(CLK),
			.S_ARESETN(RSTn),

			/* write address */
			.S_AWVALID(S_AWVALID),
			.S_AWREADY(S_AWREADY),
			.S_AWADDR(S_AWADDR),
			.S_AWPROT(S_AWPROT), /*unused*/
			/* write data */
			.S_WVALID(S_WVALID),
			.S_WREADY(S_WREADY),
			.S_WDATA(S_WDATA),
			.S_WSTRB(S_WSTRB), /*unused*/
			/* write response */
			.S_BVALID(S_BVALID),
			.S_BREADY(S_BREADY),
			.S_BRESP(S_BRESP), /*unused*/
			/* read address */
			.S_ARVALID(S_ARVALID),
			.S_ARREADY(S_ARREADY),
			.S_ARADDR(S_ARADDR),
			.S_ARPROT(S_ARPROT), /*unused*/
			/* read data */
			.S_RVALID(S_RVALID),
			.S_RREADY(S_RREADY),
			.S_RDATA(S_RDATA),
			.S_RRESP(S_RRESP), /*unused*/

            .M_ACLK(CLK),
			.M_ARESETN(RSTn),
			/* write address */
			.M_AWVALID(M_AWVALID),
			.M_AWREADY(M_AWREADY),
			.M_AWADDR(M_AWADDR),
			.M_AWLEN(M_AWLEN),
			.M_AWSIZE(M_AWSIZE),
			.M_AWBURST(M_AWBURST), /*b01*/
			.M_AWCACHE(M_AWCACHE), /*b0010*/
			.M_AWID(M_AWID), /*unused*/
			.M_AWLOCK(M_AWLOCK), /*unused*/
			.M_AWPROT(M_AWPROT), /*unused*/
			.M_AWQOS(M_AWQOS), /*unused*/
			.M_AWUSER(M_AWUSER), /*unused*/
			/* write data */
			.M_WVALID(M_WVALID),
			.M_WREADY(M_WREADY),
			.M_WDATA(M_WDATA),
			.M_WSTRB(M_WSTRB),
			.M_WLAST(M_WLAST),
			.M_WUSER(M_WUSER), /*unused*/
			/* write response */
			.M_BVALID(M_BVALID),
			.M_BREADY(M_BREADY),
			.M_BRESP(M_BRESP),
			.M_BID(M_BID), /*unused*/
			.M_BUSER(M_BUSER), /*unused*/
			/* read address */
			.M_ARVALID(M_ARVALID),
			.M_ARREADY(M_ARREADY),
			.M_ARADDR(M_ARADDR),
			.M_ARLEN(M_ARLEN),
			.M_ARSIZE(M_ARSIZE),
			.M_ARBURST(M_ARBURST), /*b01*/
			.M_ARCACHE(M_ARCACHE), /*b0010*/
			.M_ARID(M_ARID), /*unused*/
			.M_ARLOCK(M_ARLOCK), /*unused*/
			.M_ARPROT(M_ARPROT), /*unused*/
			.M_ARQOS(M_ARQOS), /*unused*/
			.M_ARUSER(M_ARUSER), /*unused*/

			/* read data */
			.M_RVALID(M_RVALID),
			.M_RREADY(M_RREADY),
			.M_RDATA(M_RDATA),
			.M_RRESP(M_RRESP),
			.M_RLAST(M_RLAST),
			.M_RID(M_RID), /*unused*/
			.M_RUSER(M_RUSER), /*unused*/

			.PROC_DONE(proc_done)
			);


	initial begin
		CLK = 0;
		#CLK_HALF_PERIOD
		forever #CLK_HALF_PERIOD CLK = ~CLK;
	end

	integer i;

	initial begin
		RSTn <= 0;
		S_AWVALID <= 0;
		S_AWADDR <= 0;
		#INITIAL_RESET_SPAN
		RSTn <= 1;

		//setup regsters
		//mode is read
		#CLK_PERIOD
		S_AWVALID <= 1'b1;
		S_AWADDR <= 5'b00000;
		S_WVALID <= 1'b1;
		S_WDATA <= 1'b1;
		#CLK_PERIOD
		#CLK_PERIOD
		S_AWVALID <= 1'b0;
		S_WVALID <= 1'b0;
		//read address
		#CLK_PERIOD
		S_AWVALID <= 1'b1;
		S_AWADDR <= 5'b00100;
		S_WVALID <= 1'b1;
		S_WDATA <= 32'h12340000;
		#CLK_PERIOD
		#CLK_PERIOD
		S_AWVALID <= 1'b0;
		S_WVALID <= 1'b0;
		#CLK_PERIOD
        //read size
		S_AWVALID <= 1'b1;
		S_AWADDR <= 5'b01000;
		S_WVALID <= 1'b1;
		S_WDATA <= 64+44;
		#CLK_PERIOD
		#CLK_PERIOD
		S_AWVALID <= 1'b0;
		S_WVALID <= 1'b0;
		#CLK_PERIOD
		//run
		S_AWVALID <= 1'b1;
		S_AWADDR <= 5'b01100;
		S_WVALID <= 1'b1;
		S_WDATA <= 1;
		#CLK_PERIOD
		#CLK_PERIOD
		S_AWVALID <= 1'b0;
		S_WVALID <= 1'b0;
		#CLK_PERIOD
		//reset run
		S_AWVALID <= 1'b1;
		S_AWADDR <= 5'b01100;
		S_WVALID <= 1'b1;
		S_WDATA <= 0;
		#CLK_PERIOD
		#CLK_PERIOD
		S_AWVALID <= 1'b0;
		S_WVALID <= 1'b0;
		#CLK_PERIOD

		//read

		if (M_ARVALID != 1) begin
			@(posedge M_ARVALID);
		end
		#CLK_PERIOD
		M_ARREADY <= 1'b1;
		M_RDATA <= 2409889792;
        M_RVALID <= 1'b1;

		#CLK_PERIOD
		M_ARREADY <= 1'b0;
		M_RRESP <= 0;
		M_RLAST <= 0;
		/*
		#CLK_PERIOD
		#CLK_PERIOD
		#CLK_PERIOD
		//read imem data

		  M_RDATA <= 2409889792;
		M_RVALID <= 1'b1;
		*/
		if (M_RREADY != 1) begin
			@(posedge M_RREADY);
		end

		#CLK_PERIOD
		  M_RDATA <= 665124868;
		#CLK_PERIOD
		  M_RDATA <= 614858756;

		#CLK_PERIOD
		  M_RDATA <= 266368;

		#CLK_PERIOD
		  M_RDATA <= 12726305;

		#CLK_PERIOD
		  M_RDATA <= 202375190;

		#CLK_PERIOD
		  M_RDATA <= 0;

		#CLK_PERIOD
		  M_RDATA <= 872546314;

		#CLK_PERIOD
		  M_RDATA <= 12;

		#CLK_PERIOD
		  M_RDATA <= 1006702593;

		#CLK_PERIOD
		  M_RDATA <= 875036672;

		#CLK_PERIOD
		  M_RDATA <= 280704;

		#CLK_PERIOD
		  M_RDATA <= 17385505;

		#CLK_PERIOD
		  M_RDATA <= 2368339968;

		#CLK_PERIOD
		  M_RDATA <= 350336;

		#CLK_PERIOD
		  M_RDATA <= 17520673;

		#CLK_PERIOD
		  M_RDATA <= 2372665344;

		#CLK_PERIOD
		  M_RDATA <= 25847850;

		#CLK_PERIOD
		  M_RDATA <= 295698435;

		#CLK_PERIOD
		  M_RDATA <= 2905341952;

		#CLK_PERIOD
		  M_RDATA <= 2909405184;

		#CLK_PERIOD
		  M_RDATA <= 65011720;

		#CLK_PERIOD
		  M_RDATA <= 666763252;

		#CLK_PERIOD
		  M_RDATA <= 2948530184;

		#CLK_PERIOD
		  M_RDATA <= 2947612676;

		#CLK_PERIOD
		  M_RDATA <= 2947547136;

		#CLK_PERIOD
		  M_RDATA <= 605028352;

		#CLK_PERIOD
		  M_RDATA <= 705167368;

		#CLK_PERIOD
		  M_RDATA <= 285212683;

		#CLK_PERIOD
		  M_RDATA <= 638648321;

		#CLK_PERIOD
		  M_RDATA <= 707264520;

		#CLK_PERIOD
		  M_RDATA <= 285212678;

		#CLK_PERIOD
		  M_RDATA <= 637796352;

		#CLK_PERIOD
		  M_RDATA <= 639959040;

		#CLK_PERIOD
		  M_RDATA <= 202375177;

		#CLK_PERIOD
		  M_RDATA <= 640745473;

		#CLK_PERIOD
		  M_RDATA <= 135266334;

		#CLK_PERIOD
		  M_RDATA <= 638582785;

		#CLK_PERIOD
		  M_RDATA <= 135266331;

		#CLK_PERIOD
		  M_RDATA <= 2411659272;

		#CLK_PERIOD
		  M_RDATA <= 2410741764;

		#CLK_PERIOD
		  M_RDATA <= 2410676224;

		#CLK_PERIOD
		  M_RDATA <= 666697740;

    /*
    //read status
            S_ARVALID <= 1'b1;
            S_ARADDR <= 5'b10000;
            S_RREADY <= 1'b1;
            #CLK_PERIOD
            #CLK_PERIOD
            S_AWVALID <= 1'b0;
            S_WVALID <= 1'b0;
            #CLK_PERIOD
            $finish();
    */
		#CLK_PERIOD
		  M_RDATA <= 65011720;//imem last data
		#CLK_PERIOD
		  M_RDATA <= 22;// dmem
		#CLK_PERIOD
		  M_RDATA <= 5;
		#CLK_PERIOD
		  M_RDATA <= -9;
		#CLK_PERIOD
		  M_RDATA <= 3;
		#CLK_PERIOD
		  M_RDATA <= -17;
		#CLK_PERIOD
		  M_RDATA <= 38;
		#CLK_PERIOD
		  M_RDATA <= 0;
		#CLK_PERIOD
		  M_RDATA <= 11;
		for (i = 8; i < 63; i = i+1) begin
			#CLK_PERIOD
			M_RDATA <= 0;
		end

		#CLK_PERIOD
		M_RDATA <= 0;//dmem last data
		M_RLAST <= 1'b1;

		#CLK_PERIOD
		M_RVALID <= 0;
		M_RLAST <= 1'b0;
		M_RDATA <= 32'hxxxxxxxx;

		#CLK_PERIOD
		#CLK_PERIOD
		#CLK_PERIOD
		#CLK_PERIOD
		#CLK_PERIOD
		//$finish();
		if (proc_done != 1'b1) begin
            @(posedge proc_done);
        end


        M_AWREADY <= 1'b0;
        M_WREADY <= 1'b0;
		//setup regsters
		//mode is write
		#CLK_PERIOD
		S_AWVALID <= 1'b1;
		S_AWADDR <= 5'b00000;
		S_WVALID <= 1'b1;
		S_WDATA <= 1'b0;
		#CLK_PERIOD
		#CLK_PERIOD
		S_AWVALID <= 1'b0;
		S_WVALID <= 1'b0;
		//read address
		#CLK_PERIOD
		S_AWVALID <= 1'b1;
		S_AWADDR <= 5'b00100;
		S_WVALID <= 1'b1;
		S_WDATA <= 32'h56780000;
		#CLK_PERIOD
		#CLK_PERIOD
		S_AWVALID <= 1'b0;
		S_WVALID <= 1'b0;
		#CLK_PERIOD
        //read size
		S_AWVALID <= 1'b1;
		S_AWADDR <= 5'b01000;
		S_WVALID <= 1'b1;
		S_WDATA <= 64+44+1;
		#CLK_PERIOD
		#CLK_PERIOD
		S_AWVALID <= 1'b0;
		S_WVALID <= 1'b0;
		#CLK_PERIOD
		//run
		S_AWVALID <= 1'b1;
		S_AWADDR <= 5'b01100;
		S_WVALID <= 1'b1;
		S_WDATA <= 1;
		#CLK_PERIOD
		#CLK_PERIOD
		S_AWVALID <= 1'b0;
		S_WVALID <= 1'b0;
		#CLK_PERIOD
		#CLK_PERIOD
		#CLK_PERIOD
		#CLK_PERIOD
		#CLK_PERIOD
		#CLK_PERIOD
		#CLK_PERIOD
		#CLK_PERIOD
		#CLK_PERIOD
		//resetrun
		
        S_AWVALID <= 1'b1;
        S_AWADDR <= 5'b01100;
        S_WVALID <= 1'b1;
        S_WDATA <= 0;
        #CLK_PERIOD
        #CLK_PERIOD
        S_AWVALID <= 1'b0;
        S_WVALID <= 1'b0;
        #CLK_PERIOD

		#CLK_PERIOD
		#CLK_PERIOD
        #CLK_PERIOD
        #CLK_PERIOD
        #CLK_PERIOD
        
		//write
		if (M_AWVALID != 1) begin
			@(posedge M_AWVALID);
		end
		M_AWREADY <= 1'b1;
		M_BVALID <= 1'b0;
		#CLK_PERIOD
		#CLK_PERIOD
		M_AWREADY <= 1'b0;
		;
        if (M_WVALID != 1) begin
            @(posedge M_WVALID);
        end
		#CLK_PERIOD
     	M_WREADY <= 1'b1;
		@(posedge M_WLAST);
		#CLK_PERIOD
		M_WREADY <= 1'b0;
		M_BVALID <= 1'b1;
		#CLK_PERIOD
		M_BVALID <= 1'b0;
		#CLK_PERIOD
		#CLK_PERIOD
		#CLK_PERIOD
		#(CLK_PERIOD*100)
		$finish();
	end
endmodule
