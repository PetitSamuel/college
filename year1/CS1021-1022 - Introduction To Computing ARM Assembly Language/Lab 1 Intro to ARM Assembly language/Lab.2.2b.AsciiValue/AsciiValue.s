	AREA	AsciiValue, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R4, ='2'	; Load '2','0','3','4' into R4...R1
	LDR	R3, ='0'	;
	LDR	R2, ='3'	;
	LDR	R1, ='4'	;

	SUB R4, R4, R3; Converting to decimal values
	SUB R2, R2, R3;
	SUB R1, R1, R3;
	SUB R3, R3, R3;
	
	LDR R5, = 1000; Multiplying by 10^4
	MUL R0, R4, R5; Adding to final result in R0
	
	LDR R5, = 10; Multiplying by 10^2
	MUL R6, R2, R5; Adding to final result in R0
	ADD R0, R0, R6;
	
	ADD R0, R0, R1; Adding to final result in R0
	
stop	B	stop

	END	