.text
.global codigo4
.type codigo4 function

codigo4:
MOV R2, #0 // Para ver si bNumber1 es mayor, menor o igual a bNumber2
MOV R3, #0 // ubCounter

SUB R2, R0, R1
BMI SUMA
BHI RESTA
B IGUAL
BX LR

SUMA:
ADD R3, R3, #1
BX LR
RESTA:
SUB R3, R3, #1
BX LR
IGUAL:
ADD R3, R0, R1
BX LR
