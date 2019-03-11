	AREA	Expressions, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
;First expression	
	LDR R1, =2; x = 2
	LDR R3, =3; tmp = 3
	
	MUL R0, R1, R1; result = x * x
	MUL R0, R3, R0;	result = 3x * x
	
	LDR R3, =5; tmp = 5
	
	MUL R3, R1, R3; tmp = 5x
	ADD R0, R0, R3; result = 3x * x = 5x	




		;second expression
	LDR R1, =1; x = 1
	LDR R2, =2; y = 2
	LDR R3, =6; tmp = 6
	
	MUL R0, R1, R2; result = x * y
	MUL R0, R3, R0; result = 6 * x * y
	LDR R3, =2; tmp = 2
	MUL R4, R1, R1; tmp2 = x * x
	MUL R3, R4, R3; tmp = 2 * x * x
	ADD R0, R0, R3; result = 6xy + 2 x * x
	
	LDR R3, =3; tmp = 3
	MUL R4, R2, R2; tmp2 = y * y
	MUL R3, R4, R3; tmp = 3 * y * y
	
	ADD R0, R0, R3; result = 2 * x * x + 6xy + 3 * y * y



		; third expression
	LDR R1, = 1; x = 1
	
	MUL R0, R1, R1; result = x * x
	MUL R0, R1, R0; result = x *x * x
	MUL R3, R1, R1; result = x * x
	
	LDR R4, =4; tmp = 4
	
	MUL R3, R4, R3; result = 4 * x * x
	SUB R0, R0, R3; result = x * x * x - 4 * x * x
	
	LDR R3, =3; tmp = 3
	
	MUL R3, R1, R3; tmp = 3 * x
	ADD R0, R0, R3; result = x * x * x - 4 * x * x + 3 * x
	
	LDR R3, = 8; tmp = 8
	ADD R0, R0, R3; result = x * x * x - 4 * x * x + 3 * x + 8


		
stop	B	stop

END