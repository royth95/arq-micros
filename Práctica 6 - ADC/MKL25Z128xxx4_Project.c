 /**
 * @file    MKL25Z128xxx4_Project.c
 * @brief   Application entry point.
 */
#include <stdio.h>
#include "board.h"
#include "peripherals.h"
#include "pin_mux.h"
#include "clock_config.h"
#include "MKL25Z4.h"
#include "fsl_debug_console.h"

/* TODO: insert other include files here. */
#include "ADC.h"
#include "pines.h"
/* TODO: insert other definitions and declarations here. */

int main(void) {
	int result_ADC; //y=20;
	int *pBoton; //--------------------revisar-------------------------
	int count=600000; // 2000000

	app_ADC_Init();
	vfPines('A',1,0); //  pin A1 como entrada (0) a la tarjeta del push button
	vfPines('B',18,1); // LED tarjeta
	vfPines('C',11,1); // LED 1
	vfPines('C',10,1); // LED 2
	vfPines('C',6,1); // LED 3
	vfPines('C',5,1); // LED 4

	vfDigWrite('B',18,1);  // Apagar todos los LED's
	vfDigWrite('C',11,0);
	vfDigWrite('C',10,0);
	vfDigWrite('C',6,0);
	vfDigWrite('C',5,0);

	pBoton=(int *)0x400FF010; // Puerto A para leer el valor del push button


    while(1)
    {
    	result_ADC=app_ADC_Task();
    	if (result_ADC>=2500) // ADC = 500
    	{
    		vfDigWrite('B',18,0);
    		count=count-1;			// Contador a 30 segundos si el sensor se mantiene a 40°C
    		if (count<=0)
    		{
    			while(1)//(*pBoton!=0x100012 || *pBoton!=0x100013) // Secuencia bounce
    			{
    				if (*pBoton==0x100012 || *pBoton==0x100013)
					{
						count=600000;
						break;
					}
    				vfDigWrite('C',11,1); //LED 1
    				vfDelay();
    				vfDigWrite('C',11,0);
    				vfDigWrite('C',10,1);// LED 2
    				vfDelay();
    				vfDigWrite('C',10,0);
    				vfDigWrite('C',6,1);// LED 3
    				vfDelay();
    				vfDigWrite('C',6,0);
    				vfDigWrite('C',5,1);// LED 4
    				vfDelay();
    				vfDigWrite('C',5,0);
    				vfDigWrite('C',6,1);// LED 3
    				vfDelay();
    				vfDigWrite('C',6,0);
    				vfDigWrite('C',10,1);// LED 2
    				vfDelay();
    				vfDigWrite('C',10,0);
    				vfDelay();
    			}
    		}
    	}
			else
			{
				vfDigWrite('B',18,1); // Si no se mantiene por 30 segundos, se apagan todos los LED's
				vfDigWrite('C',11,0);
				vfDigWrite('C',10,0);
				vfDigWrite('C',6,0);
				vfDigWrite('C',5,0);
				count=600000; // le vuelvo asignar el valor al contador
			}
    }
return 0 ;
}
















