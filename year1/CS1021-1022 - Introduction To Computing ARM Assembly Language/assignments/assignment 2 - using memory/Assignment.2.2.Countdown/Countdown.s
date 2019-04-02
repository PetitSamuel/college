	AREA	Countdown, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R1, =cdWord	; adrW = load address of letters cdWord
	LDR	R2, =cdLetters	; adrL = load address of letters cdLetters
	
	LDR R0,= 1; wordIsPossible = true
	LDR R3, =1; eW = 1 //to make sure it is not equal to 0 for going through while loop the first time

wh1
	CMP R3, #0; while(eW != 0){
	BEQ endwh1
	LDRB R3, [R1]; eW = Memory.byte[adrW]
	ADD R1, R1, #1; adrW++
	
	LDR R4,= 1; eL = 1  //to make sure it is not equal to 0 for going through while loop the first time
	LDR	R2, =cdLetters	; adrL = reset to first adress

wh2
	CMP R4, #0; while (eL != 0)
	BEQ endwh2 ;{
	CMP R3, #0;
	BNE eWnotZero;
	B endwh2;
eWnotZero
	LDRB R4, [R2]; eL = [adrL]
	
	CMP R3, R4; if(eW == eL){
	BNE skipif
	MOV R10, #'$'; [adrL] = '$' 
	STRB R10, [R2]; and end while loop for letters values}
	B endwh2; }
skipif
	ADD R2, R2, #1;  adrL++ }
	B wh2
endwh2

	CMP R4, #0; if(eL == 0){
	BNE skipEnd
	MOV R0, #0;  wordIsPossible = false
	B endwh1;	end program}
skipEnd;
	B wh1
endwh1	
stop	B	stop



	AREA	TestData, DATA, READWRITE
	
cdWord
	DCB	"hello",0

cdLetters
	DCB	"abcde",0
	
	END	
