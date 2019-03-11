	AREA	Sets, CODE, READONLY
	IMPORT	main
	IMPORT	sendchar
	EXPORT	start
	PRESERVE8

start

	LDR R10,= AElems; adrA = address(AElems)
	LDR R12,= CElems; adrC = address(CElems)
	
	LDR R5,= ASize; nA = address(ASize)
	LDR R5, [R5]; nA = memory.word[ASize]
	LDR R6,= BSize; nB = address(BSize)
	LDR R6, [R6]; nB = memory.word[BSize}

	LDR R3,= 0; cA = 0

wh1	
	CMP R3, R5; while(cA < nA){
	BHS endwh1;
	LDR R1, [R10]; eA = memory.word[adrA]
	ADD R10, R10, #4; adrA += 4
	ADD R3, R3, #1; cA ++
	
	CMP R1, #'$'; if(eA == '$')
	BNE eifdol; { skip to next number }
	B wh1
eifdol
	
	MOV R4, #0; cB = 0
	LDR R11,= BElems; adrB = address(BElems)
	LDR R8,=1; addNumber = TRUE

wh2	
	CMP R4, R6; while(cB < nB)
	BHS endwh2;	{
	LDR R2, [R11]; eB = memory.word[adrB]
	
	CMP R2, R1; if(eA == eB)
	BNE endif1; {
	MOV R0, #'$'; tmp = '$'
	STR R0, [R11]; memory.word[adrB] = tmp
	LDR R8,=0;	addNumber = FALSE
endif1			;}
	
	ADD R11, R11, #4; adrB += 4
	ADD R4, R4, #1; cB++
	B wh2			;}
endwh2
	
	CMP R8, #0; if(addNumber == TRUE)
	BEQ endif2; {
	LDR R7,= CSize; nC = address(CSize)
	LDR R7, [R7]; nC = memory.word[CSize]
	ADD R7, R7, #1; nC++
	LDR R0,= CSize; tmp = address(CSize)
	STR R7, [R0]; CSize = tmp
	
	STR R1, [R12]; memory.word[adrC] = nA
	ADD R12, R12, #4; adrC += 4 }
	B wh1
	
endif2;			else{
	MOV R4, R10; adrTMP = adrA
	MOV R8, R3;	cTMP = cA
whCheckListA
	CMP R8, R5; while(cTMP < nA){
	BHS ewhCheckA; 
	LDR R11, [R4]; tmp = memory.word[adrTMP]
	
	CMP R11, R1; if(tmp == eA)  {
	BNE eIfEq
	MOV R0, #'$'; tmp2 = '$'
	STR R0, [R4]; memory.word[adrTMP] = tmp2
eIfEq	
	ADD R4, R4, #4; adrTMP += 4
	ADD R8, R8, #1; cTMP ++
	B whCheckListA
ewhCheckA
	B wh1

endwh1				; }
	
	LDR R11,= BElems; adrB = address(BElems)
	MOV R4, #0; cB = 0

wh3	
	CMP R4, R6; while(cB < nB)
	BHS endwh3;	{
	LDR R2, [R11]; eB = memory.word[adrB]	
	ADD R4, R4, #1; cB ++
	ADD R11, R11, #4; adrB += 4
	
	CMP R2, #'$'; if(eB == '$')
	BNE endifDol; { skip to next number }
	B wh3
endifDol
	
	LDR R7,= CSize; nC = address(CSize)
	LDR R7, [R7]; nC = memory.word[CSize]
	ADD R7, R7, #1; nC++
	LDR R0,= CSize; tmp = address(CSize)
	STR R7, [R0]; [CSize] = tmp
	
	STR R2, [R12]; memory.word[adrC] = nB
	ADD R12, R12, #4; adrC += 4 }
	B wh3
endwh3

stop	B	stop


	AREA	TestData, DATA, READWRITE
	
ASize	DCD	6			; Number of elements in A
AElems	DCD	1,2,3,4,5,2	; Elements of A

BSize	DCD	6			; Number of elements in B
BElems	DCD	5,5,1,7,9,8	; Elements of B

CSize	DCD	0			; Number of elements in C
CElems	SPACE	56			; Elements of C

	END	
	END	
