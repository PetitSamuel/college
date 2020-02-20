	AREA	Lotto, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R1, =TICKETS; adrT = memory.address(TICKETS)
	LDR R2, =COUNT;  nTix = memory.address(COUNT)
	LDR R3, =DRAW; adrDraw = memory.address(DRAW)
	
	LDR R2, [R2]; nTix = memory.word[COUNT]
	MOV R0, #6; tmp = 6
	MUL R2, R0, R2; nTotal = nTix * 6
	LDR R10,=0; cTix = 0
	MOV R9, #0;
wh1
	CMP R10, R2; while(cTix < nTix){
	BHS endwh1;
	LDRB R4, [R1]; eTix=[adrT]
	ADD R1, R1, #1; adrT++
	ADD R10, R10, #1; cTix++
	
	LDR R3, =DRAW; adrDraw = memory.address(DRAW)
	LDR R11,=0; cD = 0
wh2	
	CMP R11, #6; while(cD < 6)
	BHS endwh2;{
	LDRB R5, [R3]; eD = [adrD]
	ADD R11, R11, #1; cD++
	ADD R3, R3, #1; adrD++
	
	CMP R5, R4; if(eD == eT)
	BNE endif1; {
	ADD R9, R9, #1; Total++ }
endif1	
	B wh2; }
endwh2
	
	MOV R7, R10; remainder = cTix
	MOV R8, #6; b = 6
	
whRemainder
	CMP R7, R8; 
	BLT ewhRemain ; while (remainder >= b) {
	SUB R7, R7, R8; remainder = remainder - b
	B whRemainder ; }
ewhRemain

	CMP R7, #0; if(cTix % 6 == 0)
	BNE skipif;{
	
	CMP R9, #4; if(total == 4)
	BNE skip4; {
	LDR R0, =MATCH4; [MATCH4] = [MATCH4] +1
	LDR R12, [R0];
	ADD R12, R12, #1; }
	STR R12, [R0];
skip4
	CMP R9, #5; if(total == 5)
	BNE skip5; {
	LDR R0, =MATCH5; [MATCH5] = [MATCH5] +1
	LDR R12, [R0]; }
	ADD R12, R12, #1;
	STR R12, [R0];
skip5
	CMP R9, #6;if(total == 6)
	BNE skip6; {
	LDR R0, =MATCH6;[MATCH6] = [MATCH6] +1
	LDR R12, [R0];
	ADD R12, R12, #1; }
	STR R12, [R0];	
skip6
	MOV R9, #0; Total = 0
skipif; }
	B wh1; }
endwh1

	LDR R0, =MATCH6
	LDR R0, [R0]; winners6 = [MATCH6]
	
	LDR R1, =MATCH5;
	LDR R1, [R1]; winners5 = [MATCH5]

	LDR R2, =MATCH4;
	LDR R2, [R2]; winners4 = [MATCH4]


stop	B	stop 



	AREA	TestData, DATA, READWRITE
	
COUNT	DCD	3			; Number of Tickets
TICKETS	DCB	10, 1, 12, 2, 26, 30	; Tickets
	DCB	10, 11, 12, 27, 26, 7
	DCB	10, 11, 12, 22, 26, 30
	

DRAW	DCB	10, 11, 12, 22, 26, 30	; Lottery Draw

MATCH4	DCD	0
MATCH5	DCD	0
MATCH6	DCD	0

	END	
