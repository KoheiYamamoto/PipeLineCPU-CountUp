module alu (
  output reg [15:0] q,
  input [15:0] sr1,
  input [15:0] sr2,
  input [15:0] pc,
  input [15:0] ir,
  input CLK,
  input RSTN
  );

  wire [15:0] imm = {{8{ir[7]}},ir[7:0]};

  always @(posedge CLK or negedge RSTN)
  begin
    if (!RSTN) begin
      q <= 0;
    end
    else begin
      casex (ir)
		16'b11_xxx_xxx_xxxxxxxx: //ADDi
		  q <= sr1 + imm; 
		16'b00_xxx_xxx_xxx_00100: // CMP
		  q <= (sr1>sr2) ? 16'b1111111111111111 : 16'b0000000000000000;
		16'b00_xxx_xxx_xxx_00101: // MLT
		  q <= sr1 * sr2;
		16'b10_010_xxx_xxxxxxxx: // BZ
		  q <= (sr1) ? pc : imm + pc;
		16'b00_xxx_xxx_xxx_00010: // ADD
		  q <= sr1 + sr2;
		16'b01_xxx_000_xxxxxxxx:  // LI
        q <= imm;
      16'b10_000_000_xxxxxxxx:   // B
        q <= pc + imm;
		16'b10_001_xxx_xxxxxxxx:
		  q <= (!sr1) ? pc : imm + pc; // BNZ
      endcase
    end
  end
endmodule
