module practica1(
input [3:0]iA,
input [3:0]iB,
input [3:0]iOpcode,
input iClk,
output [4:0]oFlag,      //   [0]oFlag=Zero	[1]oFlag=Carry	 [2]oFlag=Sign	 [3]oFlag=Overflow 	[4]oFlag=Parity
output [3:0]oSalida
);
reg [4:0]rFlag_q;
reg [4:0]rSalida_q;

reg [4:0]rFlag_d;
reg [4:0]rSalida_d;

assign oFlag=rFlag_q;
assign oSalida[3:0]=rSalida_q[3:0];

always@(posedge iClk)
begin
	rFlag_q<=rFlag_d;
	rSalida_q[3:0]<=rSalida_d[3:0];
end

always@*
begin
	case(iOpcode)
		4'b1100: rSalida_d = iA+iB; //suma
		4'b0000: rSalida_d = iA-iB; //resta  ---- oOpcode=0
		4'b0001: rSalida_d = iA&iB; //And
		4'b0010: rSalida_d = iA|iB; //or
		4'b0011: rSalida_d[3:0] = ~iA; //not 
		4'b0100: rSalida_d = iA^iB; //Xor
		4'b0101: rSalida_d[3:0] = ~iA; //complmento a 1 
		4'b0110: rSalida_d = iA<<<1; //Corrimiento aritmético a la izquierda
		4'b0111: rSalida_d = iA>>>1; //Corrimiento aritmético a la derecha
		4'b1000: rSalida_d = iA<<1; //corrimiento lógico a la izquierda
		4'b1001: rSalida_d = iA>>1; //corrimiento lógico a la derecha
		4'b1010: rSalida_d = {iA[2:0],iA[3]}; //rotación a la izquierda
		4'b1011: rSalida_d = {iA[0],iA[3:1]}; //rotación a la derecha
		default: rSalida_d = 4'b0000;
	endcase

rFlag_d[0] = (rSalida_d==4'b0000) ? 1 : 0;   // Bandera Zero
rFlag_d[1] = (rSalida_d[4]==1) ? 1 : 0;	    // Bandera Carry
if(iA<iB)
begin
	rFlag_d[2] = (rSalida_d[3]==1) ? 1 : 0; // Bandera Sign
end
	else
	begin
		rFlag_d[2] = 0;
	end
if ((iA[2]+iB[2]==2'b10 && rSalida_d[3]==1) || (iA[3]+iB[3]==2'b10 && rSalida_d[4]==1))	  // Bandera OverFlow 
begin
	rFlag_d[3]=1;
end 
	else
	begin 
		rFlag_d[3]=0;
	end
rFlag_d[4] = (rSalida_d[0]^rSalida_d[1]^rSalida_d[2]^rSalida_d[3]==0) ? 1 : 0; // Bandera Parity
if (rSalida_d==0)
begin
	rFlag_d[4]=0;
end

end

endmodule







