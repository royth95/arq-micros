void vfPines (char puerto, int pin, int in_out) //in_out=1->Salida  in_out=0->Entrada
{
	int x=0; // auxiliar de ciclos
	int *pReloj;
	int *PDDR_A,*PDDR_B,*PDDR_C,*PDDR_D,*PDDR_E;
	int *PCR_A,*PCR_B,*PCR_C,*PCR_D,*PCR_E;
	int bit; // para hacer un corrimiento de bits dependiendo del pin que quiero habilitar con un 1 o 0
	int regA=0,regB=0,regC=0,regD=0,regE=0; // registros para guardar los valores de los PDDR de cada puerto

	pReloj=0x40048038;
	*pReloj=0x3E00; 	// Habilito el reloj de todos los puertos

	switch(puerto)
	{
		case 'A':  PDDR_A=(int *)0x400FF014;
						if (in_out==1)
						{
							regA=*PDDR_A;
							bit=1;
							bit=bit<<pin;
							regA=regA | bit;
							*PDDR_A=regA;
						}
							else if (in_out==0)
							{
								regA=*PDDR_A;
								bit=1;
								bit=bit<<pin;
								regA=(regA | bit) ^ (bit);
								*PDDR_A=regA;
							}
						PCR_A=(int *)0x40049000; // habilitar el PCR
						if (pin<1)
						{
							*PCR_A=0x100;
						}
						else if(pin>0)
						{
							for(x=0;x<pin;x++)
							{
								PCR_A=PCR_A+0x1;
							}
							*PCR_A=0x100;
						}
					break;
		case 'B':  PDDR_B=(int *)0x400FF054;
						if (in_out==1)
						{
							regB=*PDDR_B;
							bit=1;
							bit=bit<<pin;
							regB=regB | bit;
							*PDDR_B=regB;
						}
							else if (in_out==0)
							{
								regB=*PDDR_B;
								bit=1;
								bit=bit<<pin;
								regB=(regB | bit) ^ (bit);
								*PDDR_B=regB;
							}
						PCR_B=(int *)0x4004A000;
						if(pin>0)
						{
							for(x=0;x<pin;x++)
							{
								PCR_B=PCR_B+0x1;
							}
							*PCR_B=0x100;
						}
							else{
								*PCR_B=0x100;
							}
					break;
		case 'C':  PDDR_C=(int *)0x400FF094;
							if (in_out==1)
							{
								regC=*PDDR_C;
								bit=1;
								bit=bit<<pin;
								regC=regC | bit;
								*PDDR_C=regC;
							}
								else if (in_out==0)
								{
									regC=*PDDR_C;
									bit=1;
									bit=bit<<pin;
									regC=(regC | bit) ^ (bit);
									*PDDR_C=regC;
								}
							PCR_C=(int *)0x4004B000;
							if(pin>0)
							{
								for(x=0;x<pin;x++)
								{
									PCR_C=PCR_C+0x1;
								}
								*PCR_C=0x100;
							}
								else{
									*PCR_C=0x100;
								}
						break;
		case 'D':  PDDR_D=(int *)0x400FF0D4;
							if (in_out==1)
							{
								regD=*PDDR_D;
								bit=1;
								bit=bit<<pin;
								regD=regD | bit;
								*PDDR_D=regD;
							}
								else if (in_out==0)
								{
									regD=*PDDR_D;
									bit=1;
									bit=bit<<pin;
									regD=(regD | bit) ^ (bit);
									*PDDR_D=regD;
								}
							PCR_D=(int *)0x4004C000;
								if(pin>0)
								{
									for(x=0;x<pin;x++)
									{
										PCR_D=PCR_D+0x1;
									}
									*PCR_D=0x100;
								}
									else{
										*PCR_D=0x100;
									}
						break;
		case 'E':  PDDR_E=(int *)0x400FF114;
							if (in_out==1)
							{
								regE=*PDDR_E;
								bit=1;
								bit=bit<<pin;
								regE=regE | bit;
								*PDDR_E=regE;
							}
								else if (in_out==0)
								{
									regE=*PDDR_E;
									bit=0;
									bit=bit<<pin;
									regE=(regE | bit) ^ (bit);
									*PDDR_E=regE;
								}
							PCR_E=(int *)0x4004D000;
								if(pin>0)
								{
									for(x=0;x<pin;x++)
									{
										PCR_E=PCR_E+0x1;
									}
									*PCR_E=0x100;
								}
									else{
										*PCR_E=0x100;
									}
						break;
		default: break;
	}
}

void vfDigWrite(char port, int pines, int valor)
{
	int *PDOR_A,*PDOR_B,*PDOR_C,*PDOR_D,*PDOR_E;
	int bit;  // para hacer un corrimiento de bits dependiendo del pin que quiero habilitar con un 1 o 0
	int reg_A=0,reg_B=0,reg_C=0,reg_D=0,reg_E=0; // registros para guardar los valores de los PDDR de cada puerto

	switch(port)
	{
		case 'A': PDOR_A=0x400FF000;
				if (valor==1)
				{
					reg_A=*PDOR_A;
					bit=1;
					bit=bit<<pines;
					reg_A=reg_A | bit;
					*PDOR_A=reg_A;
				}
					else if (valor==0)
					{
						reg_A=*PDOR_A;
						bit=1;
						bit=bit<<pines;
						reg_A=(reg_A | bit) ^ (bit);
						*PDOR_A=reg_A;
					}
				break;
		case 'B': PDOR_B=0x400FF040;
				if (valor==1)
				{
					reg_B=*PDOR_B;
					bit=1;
					bit=bit<<pines;
					reg_B=reg_B | bit;
					*PDOR_B=reg_B;
				}
					else if (valor==0)
					{
						reg_B=*PDOR_B;
						bit=1;
						bit=bit<<pines;
						reg_B=(reg_B | bit) ^ (bit);
						*PDOR_B=reg_B;
					}
				break;
		case 'C': PDOR_C=0x400FF080;
				if (valor==1)
				{
					reg_C=*PDOR_C;
					bit=1;
					bit=bit<<pines;
					reg_C=reg_C | bit;
					*PDOR_C=reg_C;
				}
					else if (valor==0)
					{
						reg_C=*PDOR_C;
						bit=1;
						bit=bit<<pines;
						reg_C=(reg_C | bit) ^ (bit);
						*PDOR_C=reg_C;
					}
				break;
		case 'D': PDOR_D=0x400FF0C0;
				if (valor==1)
				{
					reg_D=*PDOR_D;
					bit=1;
					bit=bit<<pines;
					reg_D=reg_D | bit;
					*PDOR_D=reg_D;
				}
					else if (valor==0)
					{
						reg_D=*PDOR_D;
						bit=1;
						bit=bit<<pines;
						reg_D=(reg_D | bit) ^ (bit);
						*PDOR_D=reg_D;
					}
				break;
		case 'E': PDOR_E=0x400FF100;
				if (valor==1)
				{
					reg_E=*PDOR_E;
					bit=1;
					bit=bit<<pines;
					reg_E=reg_E | bit;
					*PDOR_E=reg_E;
				}
					else if (valor==0)
					{
						reg_E=*PDOR_E;
						bit=1;
						bit=bit<<pines;
						reg_E=(reg_E | bit) ^ (bit);
						*PDOR_E=reg_E;
					}
				break;
	}

}

void vfDelay(void)
{
	int x=400000;

	while(x>=0)
	{
		x--;
	}
}
