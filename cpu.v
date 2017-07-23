module cpu (
  output [7:0]  led,
  output [15:0] seg0,
  output [15:0] seg1,
  output [15:0] seg2,
  output [15:0] seg3,
  output [15:0] seg4,
  output [15:0] seg5,
  output [15:0] seg6,
  output [15:0] seg7,
  output [15:0] seg8,
  output [15:0] seg9,
  output [15:0] sega,
  output [15:0] segb,
  output [15:0] segc,
  output [15:0] segd,
  output [15:0] sege,
  output [15:0] segf,
  input  start,
  input  stop,
  input  CLK,
  input  RSTN
  );

  wire [3:0] ph;
  wire [15:0] w_imem, w_dmem;
  wire [15:0] w_pc, w_ir, w_sr1, w_sr2, w_alu, w_dr;
  wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7;
  wire write_dr, write_dmem, write_pc, write_reg;
  wire [15:0] w_d;
  
  // Edited from here
  wire [15:0] w_ir1, w_ir2;
  wire [15:0] w_pc1;
 
  wire [15:0] whichr0;
  wire [15:0] whichr1;
  wire [15:0] whichr2;
  wire [15:0] whichr3;
  wire [15:0] whichr4;
  wire [15:0] whichr5;
  wire [15:0] whichr6;
  wire [15:0] whichr7; 
  assign whichr0 = (w_ir2[13:11] == w_ir[10:8]) ? w_d : r0;
  assign whichr1 = (w_ir2[13:11] == w_ir[10:8]) ? w_d : r1;
  assign whichr2 = (w_ir2[13:11] == w_ir[10:8]) ? w_d : r2;
  assign whichr3 = (w_ir2[13:11] == w_ir[10:8]) ? w_d : r3;
  assign whichr4 = (w_ir2[13:11] == w_ir[10:8]) ? w_d : r4;
  assign whichr5 = (w_ir2[13:11] == w_ir[10:8]) ? w_d : r5;
  assign whichr6 = (w_ir2[13:11] == w_ir[10:8]) ? w_d : r6;
  assign whichr7 = (w_ir2[13:11] == w_ir[10:8]) ? w_d : r7;
  wire [15:0] whichf1r;
  assign whichf1r = ((w_ir2[13:11] == w_ir1[10:8]))
                    ? w_d : w_sr1;
  
  assign led = {4'b0000, ph[3:0]};
  assign seg0 = r0;
  assign seg1 = r1;
  assign seg2 = r2;
  assign seg3 = r3;
  assign seg4 = r4;
  assign seg5 = r5;
  assign seg6 = r6;
  assign seg7 = r7;
  assign seg8 = w_pc;
  assign seg9 = w_ir;
  assign sega = w_sr1;
  assign segb = w_sr2;
  assign segc = w_alu;
  assign segd = w_dr;
  assign sege = 16'h0000;
  assign segf = 16'h0000;

  assign write_dr = ph[2] && 
           (w_ir1[15:14]==2'b00) && (w_ir1[7:0]==8'b00000001); 
			  //LD:load
			  
  assign write_dmem = ph[2] && 
           (w_ir1[15:11]==5'b00000) && (w_ir1[4:0]==5'b00000); 
			  //ST:wren
			  
  assign write_pc = ph[3] &&
           ((w_ir2[15:8]==8'b10000000)
           || (w_ir2[15:11]==5'b10010)
           || (w_ir2[15:11]==5'b10001)); 
			  //B,BNZ,BZ:load
			  
  assign write_reg = ph[3] && (
           ((w_ir2[15:14]==2'b00) && (w_ir2[7:0]==8'b00000001))
           || ((w_ir2[15:14]==2'b00) && (w_ir2[4:0]==5'b00010))
			  || ((w_ir2[15:14]==2'b00) && (w_ir2[4:0]==5'b00100)) 
			  || ((w_ir2[15:14]==2'b00) && (w_ir2[4:0]==5'b00101))
			  || (w_ir2[15:14]==2'b11)
			  || ((w_ir2[15:14]==2'b01) && (w_ir2[10:8]==3'b000)));
			  //LD,LI,ADD,ADDi,CMP,MLT:load
			  
  assign w_d = ((w_ir2[15:14]==2'b00) && (w_ir2[7:0]==8'b00000001)) 
           ? w_dr : w_alu;
			  //MUX					  
  
  sm sm (
    .q(ph), 
    .start(start), 
    .stop(stop), 
    .CLK(CLK), 
    .RSTN(RSTN)
  );

  count16rle pc (
    .q(w_pc),
    .load(write_pc),
    .inc(ph[0]),
    .d(w_alu), 
    .CLK(CLK),
    .RSTN(RSTN)
  );
  
  count16rle pc1 ( // Data for ALU calculation 
    .q(w_pc1),     // output of pc1
    .load(ph[1]),  // ph[1]: Activated
    .inc(1'b0), 	 // Preventing ir fetching
    .d(w_pc),      // Taking over the signal from pc
    .CLK(CLK),
    .RSTN(RSTN)
  );

  imem imem (
    .address(w_pc),
    .clock(~CLK), 
    .q(w_imem) 
  );

  reg16 ir ( 
    .q(w_ir),  
    .load(ph[0]), 
    .d(w_imem), 
    .CLK(CLK),
    .RSTN(RSTN),
	 .Bjudge(write_pc) // Indicator: if NOP is needed
  );
  
  reg16 ir1 ( 
    .q(w_ir1),        // output of ir1
    .load(ph[1]),     // ph[1]: Activated
    .d(w_ir),         // Taking over the signal from ir
    .CLK(CLK),
    .RSTN(RSTN),
	 .Bjudge(write_pc) // Indicator: if NOP is needed
  );

  reg16 ir2 ( 
    .q(w_ir2),        // output of ir2
    .load(ph[2]), 	 // ph[2]: Activated
    .d(w_ir1), 		 // Taking over the signal from ir1
    .CLK(CLK),
    .RSTN(RSTN),
	 .Bjudge(write_pc) // Indicator: if NOP is needed
  );
  
  regfile regfile (
    .q0(r0),
    .q1(r1),
    .q2(r2),
    .q3(r3),
    .q4(r4),
    .q5(r5),
    .q6(r6),
    .q7(r7),
    .load(write_reg), 
    .wsel(w_ir2[13:11]), // Getting signal from ir2
    .d(w_d), 
    .CLK(CLK),
    .RSTN(RSTN)
  );

  muxreg16 sr1 (
    .q(w_sr1),
    .load(ph[1]),
    .d0(whichr0),  // r0: 2-cycle-Forwarding
    .d1(whichr1),  // r1: 2-cycle-Forwarding
    .d2(whichr2),  // r2: 2-cycle-Forwarding
    .d3(whichr3),  // r3: 2-cycle-Forwarding
    .d4(whichr4),  // r4: 2-cycle-Forwarding
    .d5(whichr5),  // r5: 2-cycle-Forwarding
    .d6(whichr6),  // r6: 2-cycle-Forwarding
    .d7(whichr7),  // r7: 2-cycle-Forwarding
    .sel(w_ir[10:8]),
    .CLK(CLK),
    .RSTN(RSTN)
  );

  muxreg16 sr2 (
    .q(w_sr2),
    .load(ph[1]),
    .d0(r0),
    .d1(r1),
    .d2(r2),
    .d3(r3),
    .d4(r4),
    .d5(r5),
    .d6(r6),
    .d7(r7),
    .sel(w_ir[7:5]),
    .CLK(CLK),
    .RSTN(RSTN)
  );

  alu alu (
    .q(w_alu),
    .sr1(whichf1r), // 1-cycle-Forwarding
    .sr2(w_sr2),
    .pc(w_pc1),     // Getting signal from pc1
    .ir(w_ir1),     // Getting signal from ir1
    .CLK(CLK),
    .RSTN(RSTN)
  );

  dmem dmem (
    .address(whichf1r), // if 1-cycle-Forwarding
    .clock(~CLK),
    .data(w_sr2), 
    .wren(write_dmem), 
    .q(w_dmem) 
  );

  reg16 dr ( 
    .q(w_dr),
    .load(write_dr),
    .d(w_dmem),
    .CLK(CLK),
    .RSTN(RSTN)
  );
	
endmodule
