.text
.global codigo3
.type codigo3 function

codigo3:
MOV r0, #0 // n
MOV r1, #0 // valor del while

codigo:
ADD R0, R0, #1
CMP r0,r1
BLO codigo
BX LR

