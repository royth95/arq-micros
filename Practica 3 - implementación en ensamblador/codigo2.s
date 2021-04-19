.text
.global codigo2
.type codigo2 function

codigo2:
MOV r1, #0 // para comparar en el while

comparar:
CMP r0, r1
BNE restar
SUB r0, r0, #1
BX LR

restar:
SUB r0, r0, #1
CMP r0, r1
BNE restar
SUB r0, r0, #1
BX LR
