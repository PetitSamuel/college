	AREA	DisplayResult, CODE, READONLY
	IMPORT	main
	IMPORT	getkey
	IMPORT	sendchar
	EXPORT	start
	PRESERVE8

start

	MOV R4, #0		;inputNumber = 0
	LDR R5, = 10	;multiplicator = 10
	MOV R10, #0		;sign = 0
	
read
	BL	getkey		; read key from console
	 
	CMP R0, #'9'	; if ( ch == 0x0D ){
	BHI nextgetchar	; skip next if statement 	
	CMP R0, #0x0D	;}
	BEQ isEnter		; if( ch > '9' || ch < '*' ){
	CMP R0, #'*'	;	skip to next input }
	BLO nextgetchar	;
isEnter				;

	CMP R0, #'+'	;if( key == +)	
	BNE notPlus		;{ 
	BL sendchar		;send key to console
	MOV R10, #'+'	;sign = '+'
	MOV R6, R4		;number1 = inputNumber
	MOV R4, #0		;number2 = 0
	B nextNumber	;skip computations for this character and continue while loop to get second number
notPlus				; }

	CMP R0, #'-'	;if(key == '-' )
	BNE notMinus	;{
	BL sendchar		;	send key to console
	MOV R10, #'-'	;	sign = '-'
	MOV R6, R4		;	number1 = inputNumber
	MOV R4, #0		;	number2 = 0
	B nextNumber	;	skip computations for this character and continue while loop to get second number
notMinus			;}
	
	CMP R0, #'*'	;if(key == '*')
	BNE notMul		;{
	BL sendchar		;	send key to console
	MOV R10, #'*'	;	sign = '*'
	MOV R6, R4		;	number1 = inputNumber
	MOV R4, #0		;	number2 = 0
	B nextNumber	;	skip computations for this character and continue while loop to get second number
notMul				;}

	CMP R0, #'/'	;if(key == '/')
	BNE notDiv		;{
	BL sendchar		;	send key to console
	MOV R10, #'/'	;	sign = '/'
	MOV R6, R4		;	number1 = inputNumber
	MOV R4, #0		;	number2 = 0
	B nextNumber	;	skip computations for this character and continue while loop to get second number
notDiv				;}
	
	CMP	R0, #0x0D  	; while (key != CR)
	BEQ	endRead		; {
	BL	sendchar	; send key to console
	
	MUL R4, R5, R4	; inputNumber = inputNumber * 10
	SUB R0, R0, #'0'; converting number from ASCII to decimal ( tmp = tmp - '0')
	ADD R4, R4, R0	; total = tmp + key entered
nextNumber
nextgetchar
	B	read		; }
endRead

	CMP R10, #'+'	; if(sign == '+')
	BNE dontAdd		;{
	ADD R5, R4, R6	;result = number1 + number2
dontAdd				;}

	CMP R10, #'-'	;if(sign == '-')
	BNE dontSub		;{
	SUBS R5, R6, R4	; result = number1 - number2
dontSub				;}

	CMP R10, #'*'	;if(sign == '*')
	BNE dontMul		;{
	MUL R5, R4, R6	;result = number2 * number1
dontMul				;}

	CMP R10, #'/'	;if(sign == '/'){
	BNE dontDiv		;
	CMP R4, #0		;	if(number2 == 0){
	BEQ divZero		;	skip to the end of the program }
	MOV R5, #0		;	quotient = 0
	MOV R8, R6		;	remainder = number2
whilDiv	
	CMP R8, R4		;while(remainder => number2]{
	BLT endDiv		;		
	ADD R5, R5, #1	;quotient = quotient +1
	SUB R8, R8, R4	;remainder = remainder - number2 }
	B whilDiv		;}

endDiv	
dontDiv	

	MOV R0, #'='	;
	BL sendchar		; send '=' to console

	CMP R5, #0		;if (result ==0)
	BNE notZero		;{
	MOV R0, #'0'	;send 0 to console
	BL sendchar		; }
notZero

	CMP R5, #0		; if( result < 0)
	BGE negativeNumber;{
	MOVS R9, #-1	; tmp = -1
	MULS R5, R9, R5	; result = result * tmp
	MOV R0, #'-'	; sent '-' to console
	BL sendchar		;
negativeNumber		;}	
	
	MOV R9, #10		; x = 10
	MOV R7, #0		; y = 0
	MOV R8, #1		; value x^y

whilePwrOfTen	
	CMP R8, R5		; 
	BHI endPwrOfTen	; while ( x^y =< result){
	MUL R8, R9, R8	; x^y = x^(y+1)
	ADD R7,R7, #1	; y = y + 1 }
	B whilePwrOfTen
endPwrOfTen
	
whileRemainder
	CMP R7, #0		; while(y != 0)
	BEQ endDisplay	;{
	SUB R7, R7, #1	; y = y -1
	MOV R4, #0		; tmpPwr = 0
	MOV R6, #1		; divisor = 10^0
	
whlFindingDivisor
	CMP R4, R7		;while(tmpPwr != y){
	BEQ endwhDivisor;
	ADD R4, R4, #1	; tmpPwr = tmpPwr + 1
	MUL R6, R9, R6	; divisor = divisor * 10 }
	B whlFindingDivisor
endwhDivisor

	MOV R4, R5		;remainder = result
	MOV R8, #0		;quotient = 0
whDividding
	CMP R4, R6		;while (remainder >= divisor) {
	BLT endDivision	;
	ADD R8,R8, #1	;quotient = quotient + 1 
	SUB R4, R4, R6	;remainder = remainder - divisor }
	B whDividding
endDivision			

	ADD R0, R8, #'0'; loads in R0 the ascii value for the number stored in quotient
	BL sendchar		; and sends it to the console 
	MOV R5, R4		; result = remainder
	B whileRemainder; } (end of displaying the result stored in R5 to the console)
endDisplay
divZero
stop	B	stop

	END