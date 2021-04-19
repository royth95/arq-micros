module UnidadDeControl // #(parameter Credencial=4'b0010)
(
input iClk,
input [3:0]iID,				//Entrada InputData de los switches
input [3:0]iRegCount,		// Le llega la salida de la respuesta de la ALU
input [4:0]iRegFlags,		// Le llegan las banderas de la ALU
output [3:0]oCredencial,	// Es el valor de credencial en un estado y toma el valor de 1 en otro estado
output [3:0]oOpcode,			// salida hacia el opcode de la ALU
output oLed,					// Led cuando ambas entradas son iguales
output [3:0]oID,				// salida de la entrada del InputData en un estado y el valor del contador en otro estado
output [3:0]oCount			// Salida del contador a los leds de la tarjeta
);
reg [2:0]state=3'b000;
reg[2:0]nextstate=3'b000;
reg [4:0]rFlags=5'b00000;				// Registro para las banderas para el estado 2
reg [3:0]rSalida=4'b0000;				// Registro de la salida de la ALU, donde se asigna en el estado 4 al contador (donde se suma o resta 1)

reg [3:0]rOpcode_q;
reg [3:0]rOpcode_d=4'b0000;

reg [3:0]rCredencial_q;
reg [3:0]rCredencial_d=4'b0000;

reg [3:0]rCount_q;
reg [3:0]rCount_d=4'b0000;

reg [3:0]rID_q;
reg [3:0]rID_d=4'b0000;

reg rLed_q;
reg rLed_d=1'b0;

assign oCount=rCount_q;
assign oID=rID_q;
assign oLed=rLed_q;
assign oCredencial=rCredencial_q;
assign oOpcode=rOpcode_q;
							 
always@(posedge iClk)
begin
	rID_q<=rID_d;
	rLed_q<=rLed_d;
	rCount_q<=rCount_d;
	rCredencial_q<=rCredencial_d;
	rOpcode_q=rOpcode_d;
	state=nextstate;
end

always@*
begin
	case(state)
		3'b000: 
		begin				
			rID_d=iID;						// El valor de la entrada inputdata (iA de la ALU) se controla con los switches
			rCredencial_d=4'b0010;		// Se fija el valor de credencial (iB de la ALU) para este estado
			rOpcode_d=4'b0000;			// Manda la operación de la resta para ver si iA es menor, mayor o igual a iB
			nextstate=3'b001;				// Te manda al siguiente estado
		end
		3'b001:
		begin
			rFlags=iRegFlags;			// El registro almacena el valor de las banderas del estado anterior
			nextstate=3'b010;			// Te manda al siguiente estado
		end
		3'b010:
		begin
			if (rFlags[2]==1 && rFlags[0]==0) // InputData es menor que Credencial
			begin
				rID_d=rCount_d;			// El registro del imputdata (iA de la ALU) toma el valor de contador
				rCredencial_d=4'b0001;	// El registro de credencial (iB de la ALU) toma el valor de 1
				rOpcode_d=4'b0000;		// Se le manda la combinación para resta al opcode de la ALU
				//rSalida[3:0]=iRegCount[3:0]; // El resultado de la operación se guarda en el registro del contador
				rLed_d=1'b0; 				// El led está apagado
				nextstate=3'b011;			// Te regresa al primer estado
			end
				else if(rFlags[2]==0 && rFlags[0]==0) // InputData es mayor que Credencial
				begin
					rID_d=rCount_d;		  //El registro del imputdata (iA de la ALU) toma el valor de contador
					rCredencial_d=4'b0001;	//El registro de credencial (iB de la ALU) toma el valor de 1
					rOpcode_d=4'b1100;		// Se le manda la combinación para resta al opcode de la ALU
					//rSalida[3:0]=iRegCount[3:0]; // El resultado de la operación se guarda en el registro del contador
					rLed_d=1'b0; 				// El led está apagado
					nextstate=3'b011;					// Te regresa al primer estado
				end
					else if(rFlags[2]==0 && rFlags[0]==1) // inputData y Credencial valen igual
					begin
						rLed_d=1'b1;						// Prende el led para indicar que ambas entradas son iguales
						rSalida=rSalida; 					// El valor del contador se mantiene igual
						nextstate=3'b000;					// Te regresa al primer estado
					end
						else
						begin
							rSalida=rSalida;
							rLed_d=1'b0;
							nextstate=3'b011;
						end
		end
		3'b011:
		begin
			rSalida[3:0]=iRegCount[3:0];
			nextstate=3'b100;
		end
		3'b100:
		begin
			rCount_d[3:0]=rSalida[3:0]; // El resultado de la operación se guarda en el registro del contador
			nextstate=3'b000;//---------
		end
		default:
		begin
			nextstate=3'b000;
		end
		
	endcase
	
	if (rCount_d==4'b1111)	// Si el contador llega a su valor maximo, se reinicia
	begin
		rCount_d=4'b0000;
	end
	
end				 
							 
endmodule
