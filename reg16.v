module reg16 (
  output reg [15:0] q,
  input [15:0] d,
  input load,
  input CLK,
  input RSTN,
  input Bjudge // Indicator: if NOP is needed
  );
  always @(posedge CLK or negedge RSTN)
  begin
    if (!RSTN) begin
      q <= 0;
    end
	 
    else if(Bjudge) begin // If write_pc is on
		q <= 16'b0000000000011111; //NOP
	 end
	 
	 else if (load) begin
      q <= d; 
    end		
  end
endmodule
