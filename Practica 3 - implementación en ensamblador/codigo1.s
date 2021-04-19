.text
.global codigo1
.type codigo1 function

codigo1:
MOV r0, #5 // sum
MOV r1, #4  // i

for1:
BAL compare1

forN:
ADD r1, r1, #1
BAL compare1

compare1:
CMP r0,r1
BLS salir
BHI suma

compareN:
CMP r0,r1
BLS salir
BHI forN

suma:
ADD r1, r1, #1
BAL compareN

salir:
BX LR
