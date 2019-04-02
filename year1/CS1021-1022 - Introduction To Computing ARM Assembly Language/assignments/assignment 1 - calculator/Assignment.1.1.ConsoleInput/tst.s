	AREA	ConsoleInput, CODE, READONLY
	IMPORT	main
	IMPORT	getkey
	IMPORT	sendchar
	EXPORT	start
	PRESERVE8

start
	MOV R4, #0;
	LDR R5, = 10;
read
	BL	getkey		; read key from console
	CMP	R0, #0x0D  	; while (key != CR)
	BEQ	endRead		; {
	BL	sendchar	

	
	MUL R4, R5, R4; total = total * 10
	SUB R4, R4, #'0';
	ADD R4, R4, R0; total = tmp + key entered
	B	read		; }
	
endRead

stop	B	stop

	END	