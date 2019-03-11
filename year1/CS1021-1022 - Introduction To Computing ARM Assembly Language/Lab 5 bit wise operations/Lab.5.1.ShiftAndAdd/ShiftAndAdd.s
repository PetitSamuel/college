	AREA	ShiftAndAdd, CODE, READONLY
	IMPORT	main
	EXPORT	start

start

	LDR	R1, =9; value = 9
	LDR	R2, =11; mult = 11
	
	LDR R0, =0; result = 0
	LDR R4,=0; count = 0
whl
	CMP R2, #0; while(mult != 0)
	BEQ enwh; {
	
	MOVS R2, R2, LSR #1; mult = mult >> 1
	LDR R10,=0;
	ADC R10, R2; carry = mult + flag
	
	CMP R10, R2; if(carry != mult)
	BEQ skipif; {
	ADD R0, R0, R1, LSL R4; result +=  value <<count
skipif
	ADD R4, R4, #1; count++ }
	B whl;}
enwh
	
stop	B	stop


	END	
		
		
	