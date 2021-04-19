module DivDeFrec(
	input iclk,
	output reg oClk
);
reg [27:0] counter;	// espacio necesario para almacenar los 50Mhz
initial begin			// esto es para haer simulaciones
	counter = 0;
	oClk = 0;
end
always @(posedge iclk)
	begin 
		if (counter ==0)
		begin
			counter <= 49999999;
			oClk <= ~oClk;
		end
		else
		begin
			counter <= counter -1;
		end
	end
endmodule
