	AREA	Divide, CODE, READONLY
	IMPORT	main
	EXPORT	start

start

	MOV R2, #14 ; a = 15
	MOV R3, #7 ; b = 7
	MOV R0, #0; quotient = 0
	MOV R1, R2; remainder = a

	CMP r3, #0;  if( b  >= 0 )
	BLE endifzero; {
	
whOne
	CMP R1, R3;
	BLT endwhOne ; while (remainder >= b) {
	
	ADD R0, R0, #1; quotient = quotient + 1
	SUB R1, R1, R3; remainder = remainder - b
	
	B whOne ; }
	
endwhOne

endifzero   ; }

stop	B	stop

	END	