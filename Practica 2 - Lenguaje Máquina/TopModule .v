module TopModule(
input Clk, 
input [3:0]iInputData,
output Led,
output [3:0]Count
					 );
wire WClk;
wire [3:0]wB;
wire [3:0]wID;
wire [3:0]wCont;
wire [4:0]wFlag;
wire [3:0]wOpcode;

	DivDeFrec divisor(
	.iclk (Clk),
	.oClk (wClk)
	);
	
	UnidadDeControl UDC(
	.iClk (wClk),
	.oCredencial (wB),
	.iID (iInputData),
	.oID (wID),
	.oLed (Led),
	.oOpcode (wOpcode),
	.iRegFlags (wFlag),
	.oCount (Count),
	.iRegCount (wCont)
	);
	
	practica1 ALU(
	.iClk (wClk),
	.iB (wB),
	.iA (wID),
	.oFlag (wFlag),
	.iOpcode (wOpcode),
	.oSalida (wCont)
	);
	
endmodule
