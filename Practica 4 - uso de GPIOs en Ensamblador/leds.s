.data
//               reloj B, D y A   PDDR B      PDDR D     PCR B18     PCR B19     PCR D1      PDOR B      PDOR D     PDDR A      PCR A1     PDOR A
direcciones: .word 0x40048038, 0x400FF054, 0x400FF0D4, 0x4004A048, 0x4004A04C, 0x4004C004, 0x400FF040, 0x400FF0C0, 0x400FF014, 0x40049004, 0x400FF000
//             reloj/  PDDR B/ D y A/ PCR/ LED Verde/ LED Rojo/ LED Azul y A
valores: .word 0x1600, 0xC0000, 0x2, 0x100, 0x40000, 0x80000, 0x0
// Delay antes de pasar al siguiente estado
delay: .long 0x989680 // 10,000,000 decimal

.text
.global leds
.type leds function

leds:
LDR r3, =direcciones
LDR r3, [r3,#0]
LDR r4, =valores
LDR r4, [r4,#0]
STR r4, [r3]	// Habilitar el reloj para los puertos B, D y A

LDR r3, =direcciones
LDR r3, [r3,#4]
LDR r4, =valores
LDR r4, [r4,#4]
STR r4, [r3]   // Habilitar el PDDR B

LDR r3, =direcciones
LDR r3, [r3,#8]
LDR r4, =valores
LDR r4, [r4,#8]
STR r4, [r3]   // Habilitar el PDDR D

LDR r3, =direcciones
LDR r3, [r3,#32]
LDR r4, =valores
LDR r4, [r4,#8]
STR r4, [r3]   // Habilitar el PDDR A

LDR r3, =direcciones
LDR r3, [r3,#12]
LDR r4, =valores
LDR r4, [r4,#12]
STR r4, [r3]   // Habilitar el PCR B18 como Alternativa 1

LDR r3, =direcciones
LDR r3, [r3,#16]
LDR r4, =valores
LDR r4, [r4,#12]
STR r4, [r3]   // Habilitar el PCR B19 como Alternativa 1

LDR r3, =direcciones
LDR r3, [r3,#20]
LDR r4, =valores
LDR r4, [r4,#12]
STR r4, [r3]   // Habilitar el PCR D1 como Alternativa 1

LDR r3, =direcciones
LDR r3, [r3,#36]
LDR r4, =valores
LDR r4, [r4,#12]
STR r4, [r3]   // Habilitar el PCR A1 como Alternativa 1

LDR r3, =direcciones
LDR r3, [r3,#24]
LDR r4, =valores
LDR r4, [r4,#4]
STR r4, [r3]   // Habilitar el PDOR B (apagar leds B18 y B19)

LDR r3, =direcciones
LDR r3, [r3,#28]
LDR r4, =valores
LDR r4, [r4,#8]
STR r4, [r3]   // Habilitar el PDOR D (apagar led D1)

LDR r3, =direcciones
LDR r3, [r3,#40]
LDR r4, =valores
LDR r4, [r4,#8]
STR r4, [r3]   // Habilitar el PDOR A1

/*.text
.global practica4
.type practica4 function*/
practica4:
B onehot
onehot:
MOV r6, #0  //                                       registro que cambia entre secuencias
MOV r0, #1 // en R0 se muestra la secuencia one hot
LDR r3, =direcciones
LDR r3, [r3,#24]
LDR r4, =valores
LDR r4, [r4,#20]
STR r4, [r3]   // prender el Led rojo (B18)
B retardo
secuencia1:
LSL r0, r0, #1
CMP r0, #2
BEQ verde
CMP r0, #4
BEQ azul
CMP r0, #8
BEQ amarillo
verde:
LDR r3, =direcciones
LDR r3, [r3,#24]
LDR r4, =valores
LDR r4, [r4,#16]
STR r4, [r3]   // prender el Led verde (B19)
B retardo
azul:
LDR r3, =direcciones
LDR r3, [r3,#28]
LDR r4, =valores
LDR r4, [r4,#24]
STR r4, [r3]   // prender el Led azul (D1)
B retardo
amarillo: // no es amarillo pero ya no le cambié el nombre para evitar alguna falla
LDR r3, =direcciones
LDR r3, [r3,#40]
LDR r4, =valores
LDR r4, [r4,#8]
STR r4, [r3]   // Habilitar el PDOR A
B retardo
retardo:
LDR r5, =delay
LDR r5, [r5]
B restar_1
restar_1:
SUB r5, #1
CMP r5, #1
BHI restar_1
BEQ comparar
comparar:
LDR r3, =direcciones
LDR r3, [r3,#24]
LDR r4, =valores
LDR r4, [r4,#4]
STR r4, [r3]   // apagar los dos leds del puerto B
LDR r3, =direcciones
LDR r3, [r3,#28]
LDR r4, =valores
LDR r4, [r4,#8]
STR r4, [r3]   // apagar el Led del puerto D
CMP r6, #1
BEQ johnson  //                              si es 1, cambia a la siguiente secuencia
CMP r0, #8
BLO secuencia1
BHS onehot
//-------------------------------------------------------------------------------------
johnson:
MOV r6, #0  //                                       registro que cambia entre secuencias
MOV r1, #0 // en R1 se muestra la secuencia Johnson
// no prende ningún led
MOV r1, #1//-------------------------------------
LDR r3, =direcciones
LDR r3, [r3,#24]
LDR r4, =valores
LDR r4, [r4,#4]
STR r4, [r3]   // apagar los dos leds del puerto B
LDR r3, =direcciones
LDR r3, [r3,#28]
LDR r4, =valores
LDR r4, [r4,#8]
STR r4, [r3]   // apagar el Led del puerto D
LDR r3, =direcciones
LDR r3, [r3,#24]
LDR r4, =valores
LDR r4, [r4,#20]
STR r4, [r3]   // prender el Led rojo (B18)
//retardo
LDR r5, =delay
LDR r5, [r5]
B restar1
restar1:
SUB r5, #1
CMP r5, #1
BHI restar1
MOV r1, #3//-----------------------------------
/*LDR r3, =direcciones
LDR r3, [r3,#24]
LDR r4, =valores
LDR r4, [r4,#20]
STR r4, [r3]   // prender el Led rojo (B18)*/
LDR r3, =direcciones
LDR r3, [r3,#24]
LDR r4, =valores
LDR r4, [r4,#16]
STR r4, [r3]   // prender el Led verde (B19)
//retardo
LDR r5, =delay
LDR r5, [r5]
B restar2
restar2:
SUB r5, #1
CMP r5, #1
BHI restar2
MOV r1, #7//-----------------------------------
/*LDR r3, [r3,#24]
LDR r4, =valores
LDR r4, [r4,#20]
STR r4, [r3]   // prender el Led rojo (B18)
LDR r3, =direcciones
LDR r3, [r3,#24]
LDR r4, =valores
LDR r4, [r4,#16]
STR r4, [r3]   // prender el Led verde (B19)*/
LDR r3, =direcciones
LDR r3, [r3,#28]
LDR r4, =valores
LDR r4, [r4,#24]
STR r4, [r3]   // prender el Led azul (D1)
//retardo
LDR r5, =delay
LDR r5, [r5]
B restar3
restar3:
SUB r5, #1
CMP r5, #1
BHI restar3
MOV r1, #15//-----------------------------------
/*LDR r3, [r3,#24]
LDR r4, =valores
LDR r4, [r4,#20]
STR r4, [r3]   // prender el Led rojo (B18)
LDR r3, =direcciones
LDR r3, [r3,#24]
LDR r4, =valores
LDR r4, [r4,#16]
STR r4, [r3]   // prender el Led verde (B19)
LDR r3, =direcciones
LDR r3, [r3,#28]
LDR r4, =valores
LDR r4, [r4,#24]
STR r4, [r3]   // prender el Led azul (D1)*/
LDR r3, =direcciones
LDR r3, [r3,#40]
LDR r4, =valores
LDR r4, [r4,#8]
STR r4, [r3]   // Habilitar el PDOR A
//retardo
LDR r5, =delay
LDR r5, [r5]
B restar4
restar4:
SUB r5, #1
CMP r5, #1
BHI restar4
MOV r1, #14//-----------------------------------
LDR r3, =direcciones
LDR r3, [r3,#24]
LDR r4, =valores
LDR r4, [r4,#4]
STR r4, [r3]   // apagar los dos leds del puerto B
LDR r3, =direcciones
LDR r3, [r3,#28]
LDR r4, =valores
LDR r4, [r4,#8]
STR r4, [r3]   // apagar el Led del puerto D
LDR r3, =direcciones
LDR r3, [r3,#24]
LDR r4, =valores
LDR r4, [r4,#16]
STR r4, [r3]   // prender el Led verde (B19)
LDR r3, =direcciones
LDR r3, [r3,#28]
LDR r4, =valores
LDR r4, [r4,#24]
STR r4, [r3]   // prender el Led azul (D1)
LDR r3, =direcciones
LDR r3, [r3,#40]
LDR r4, =valores
LDR r4, [r4,#8]
STR r4, [r3]   // Habilitar el PDOR A
//retardo
LDR r5, =delay
LDR r5, [r5]
B restar5
restar5:
SUB r5, #1
CMP r5, #1
BHI restar5
BEQ seguir
johnson1:
B johnson
seguir:
MOV r1, #12//----------------------------------
LDR r3, =direcciones
LDR r3, [r3,#24]
LDR r4, =valores
LDR r4, [r4,#4]
STR r4, [r3]   // apagar los dos leds del puerto B
LDR r3, =direcciones
LDR r3, [r3,#28]
LDR r4, =valores
LDR r4, [r4,#8]
STR r4, [r3]   // apagar el Led del puerto D
LDR r3, =direcciones
LDR r3, [r3,#28]
LDR r4, =valores
LDR r4, [r4,#24]
STR r4, [r3]   // prender el Led azul (D1)
LDR r3, =direcciones
LDR r3, [r3,#40]
LDR r4, =valores
LDR r4, [r4,#8]
STR r4, [r3]   // Habilitar el PDOR A
//retardo
LDR r5, =delay
LDR r5, [r5]
B restar6
//B continuar
onehot1:                               // para dar el salto desde abajo hasta el inicio
B onehot
//continuar:
restar6:
SUB r5, #1
CMP r5, #1
BHI restar6
MOV r1, #8//-------------------------------------
LDR r3, =direcciones
LDR r3, [r3,#24]
LDR r4, =valores
LDR r4, [r4,#4]
STR r4, [r3]   // apagar los dos leds del puerto B
LDR r3, =direcciones
LDR r3, [r3,#28]
LDR r4, =valores
LDR r4, [r4,#8]
STR r4, [r3]   // apagar el Led del puerto D
LDR r3, =direcciones
LDR r3, [r3,#40]
LDR r4, =valores
LDR r4, [r4,#8]
STR r4, [r3]   // Habilitar el PDOR A
//retardo
LDR r5, =delay
LDR r5, [r5]
B restar7
restar7:
SUB r5, #1
CMP r5, #1
BHI restar7
CMP r6, #1
BEQ bounce  //                              si es 1, cambia a la siguiente secuencia
CMP r1, #8
BHS johnson1
//-------------------------------------------------------------------------------------
bounce:
MOV r6, #0  //                                       registro que cambia entre secuencias
MOV r2, #8 //              en R3 se muestra la secuencia Bounce
LDR r3, =direcciones
LDR r3, [r3,#24]
LDR r4, =valores
LDR r4, [r4,#4]
STR r4, [r3]   // apagar los dos leds del puerto B
LDR r3, =direcciones
LDR r3, [r3,#28]
LDR r4, =valores
LDR r4, [r4,#8]
STR r4, [r3]   // apagar el Led del puerto D
LDR r3, =direcciones
LDR r3, [r3,#40]
LDR r4, =valores
LDR r4, [r4,#8]
STR r4, [r3]   // Habilitar el PDOR A
//retardo
LDR r5, =delay
LDR r5, [r5]
B restar8
restar8:
SUB r5, #1
CMP r5, #1
BHI restar8
BEQ derecha
derecha:
LSR r2, r2, #1
CMP r2, #4
BEQ azul1
CMP r2, #2
BEQ verde1
CMP r2, #1
BEQ rojo1
azul1:
/*LDR r3, =direcciones
LDR r3, [r3,#24]
LDR r4, =valores
LDR r4, [r4,#4]
STR r4, [r3]   // apagar los dos leds del puerto B
LDR r3, =direcciones
LDR r3, [r3,#28]
LDR r4, =valores
LDR r4, [r4,#8]
STR r4, [r3]   // apagar el Led del puerto D    */
LDR r3, =direcciones
LDR r3, [r3,#28]
LDR r4, =valores
LDR r4, [r4,#24]
STR r4, [r3]   // prender el Led azul (D1)
//retardo:
LDR r5, =delay
LDR r5, [r5]
B restar9
restar9:
SUB r5, #1
CMP r5, #1
BHI restar9
CMP r2, #1
BEQ izquierda
B derecha
verde1:
/*LDR r3, =direcciones
LDR r3, [r3,#24]
LDR r4, =valores
LDR r4, [r4,#4]
STR r4, [r3]   // apagar los dos leds del puerto B */
LDR r3, =direcciones
LDR r3, [r3,#28]
LDR r4, =valores
LDR r4, [r4,#8]
STR r4, [r3]   // apagar el Led del puerto D
LDR r3, =direcciones
LDR r3, [r3,#24]
LDR r4, =valores
LDR r4, [r4,#16]
STR r4, [r3]   // prender el Led verde (B19)
//retardo:
LDR r5, =delay
LDR r5, [r5]
B restar10
restar10:
SUB r5, #1
CMP r5, #1
BHI restar10
CMP r2, #1
BEQ izquierda
B derecha
rojo1:
/*LDR r3, =direcciones
LDR r3, [r3,#24]
LDR r4, =valores
LDR r4, [r4,#4]
STR r4, [r3]   // apagar los dos leds del puerto B
LDR r3, =direcciones
LDR r3, [r3,#28]
LDR r4, =valores
LDR r4, [r4,#8]
STR r4, [r3]   // apagar el Led del puerto D */
LDR r3, =direcciones
LDR r3, [r3,#24]
LDR r4, =valores
LDR r4, [r4,#20]
STR r4, [r3]   // prender el Led rojo (B18)
CMP r6, #1
BEQ onehot1  //                              si es 1, cambia a la siguiente secuencia
//retardo:
LDR r5, =delay
LDR r5, [r5]
B restar10
restar11:
SUB r5, #1
CMP r5, #1
BHI restar11
CMP r2, #1
BEQ izquierda
B derecha

izquierda:
LSL r2, r2, #1
CMP r2, #4
BEQ azul2
CMP r2, #2
BEQ verde2
CMP r2, #1
BEQ rojo2
CMP r2, #8
BEQ amarillo2
azul2:
LDR r3, =direcciones
LDR r3, [r3,#24]
LDR r4, =valores
LDR r4, [r4,#4]
STR r4, [r3]   // apagar los dos leds del puerto B
/*LDR r3, =direcciones
LDR r3, [r3,#28]
LDR r4, =valores
LDR r4, [r4,#8]
STR r4, [r3]   // apagar el Led del puerto D  */
LDR r3, =direcciones
LDR r3, [r3,#28]
LDR r4, =valores
LDR r4, [r4,#24]
STR r4, [r3]   // prender el Led azul (D1)
//retardo:
LDR r5, =delay
LDR r5, [r5]
B restar12
restar12:
SUB r5, #1
CMP r5, #1
BHI restar12
CMP r2, #8
BHS derecha
B izquierda
verde2:
/*LDR r3, =direcciones
LDR r3, [r3,#24]
LDR r4, =valores
LDR r4, [r4,#4]
STR r4, [r3]   // apagar los dos leds del puerto B */
LDR r3, =direcciones
LDR r3, [r3,#28]
LDR r4, =valores
LDR r4, [r4,#8]
STR r4, [r3]   // apagar el Led del puerto D
LDR r3, =direcciones
LDR r3, [r3,#24]
LDR r4, =valores
LDR r4, [r4,#16]
STR r4, [r3]   // prender el Led verde (B19)
//retardo:
LDR r5, =delay
LDR r5, [r5]
B restar13
restar13:
SUB r5, #1
CMP r5, #1
BHI restar13
CMP r2, #8
BHS derecha
B izquierda
rojo2:
LDR r3, =direcciones
LDR r3, [r3,#24]
LDR r4, =valores
LDR r4, [r4,#4]
STR r4, [r3]   // apagar los dos leds del puerto B
/*LDR r3, =direcciones
LDR r3, [r3,#28]
LDR r4, =valores
LDR r4, [r4,#8]
STR r4, [r3]   // apagar el Led del puerto D */
LDR r3, =direcciones
LDR r3, [r3,#24]
LDR r4, =valores
LDR r4, [r4,#20]
STR r4, [r3]   // prender el Led rojo (B18)
//retardo:
LDR r5, =delay
LDR r5, [r5]
B restar14
restar14:
SUB r5, #1
CMP r5, #1
BHI restar14
CMP r2, #8
BHS derecha
B izquierda
amarillo2:
B bounce
