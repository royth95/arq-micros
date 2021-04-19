module practica1(
input [3:0]iA,
input [3:0]iB,
input [3:0]iOpcode,
input iClk,
output [4:0]oFlag,      //   [0]oFlag=Zero	[1]oFlag=Carry	 [2]oFlag=Sign	 [3]oFlag=Overflow 	[4]oFlag=Parity
output [3:0]oSalida
);
reg [4:0]rFlag;
reg [4:0]rSalida;
assign oFlag=rFlag;
assign oSalida[3:0]=rSalida[3:0];

always@(posedge iClk)
begin
rSalida[4]=0;
	case(iOpcode)
		4'b1011: rSalida = iA+iB; //suma
		4'b1100: rSalida = iA-iB; //resta  
		4'b1101: rSalida = iA&iB; //And
		
		4'b0000: rSalida = iA|iB; //or     -OpCode = 0
		4'b0001: rSalida[3:0] = ~iA; //not 
		4'b0010: rSalida = iA^iB; //Xor
		4'b0011: rSalida[3:0] = ~iA; //complmento a 1 
		4'b0100: rSalida[3:0] = ~iA + 1'b1; //complmento a 2 
		4'b0101: rSalida = iA<<<1; //Corrimiento aritmético a la izquierda
		4'b0110: rSalida = iA>>>1; //Corrimiento aritmético a la derecha
		4'b0111: rSalida = iA<<1; //corrimiento lógico a la izquierda
		4'b1000: rSalida = iA>>1; //corrimiento lógico a la derecha
		4'b1001: rSalida = {iA[2:0],iA[3]}; //rotación a la izquierda
		4'b1010: rSalida = {iA[0],iA[3:1]}; //rotación a la derecha
		default: rSalida = 4'b0000;
	endcase

rFlag[0] = (rSalida==4'b0000) ? 1 : 0;   // Bandera Zero
rFlag[1] = (rSalida[4]==1) ? 1 : 0;	    // Bandera Carry
rFlag[2] = (rSalida[3]==1) ? 1 : 0;    // Bandera Sign
rFlag[3] = (rSalida >= 4'b1000) || ((rFlag[1]==1) && (rSalida>4'b1000)) ? 1 : 0;  // Bandera OverFlow 
rFlag[4] = (rSalida[0]^rSalida[1]^rSalida[2]^rSalida[3]==0) ? 0 : 1; // Bandera Parity



end
endmodule
