	AREA	ConsoleInput, CODE, READONLY
	IMPORT	main
	IMPORT	getkey
	IMPORT	sendchar
	EXPORT	start
	PRESERVE8

start

	MOV R4, #0		; total = 0
	LDR R5, = 10	; 
	
read
	BL	getkey		; read key from console
	
	CMP R0, #'9'	; if ( ch == 0x0D ){
	BHI nextgetchar	; skip next if statement 	
	CMP R0, #0x0D	;}
	BEQ isEnter		; if( ch > '9' || ch < '*' ){
	CMP R0, #'*'	;	skip to next input }
	BLO nextgetchar	;
isEnter	
	
	CMP	R0, #0x0D  	; while (key != CR)
	BEQ	endRead		; {
	BL	sendchar	; send key to console

	MUL R4, R5, R4	; total = total * 10
	SUB R4, R4, #'0';
	ADD R4, R4, R0	; total = tmp + key entered
nextgetchar
	B	read		; }
	
endRead

stop	B	stop

	END	