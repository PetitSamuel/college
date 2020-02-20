	AREA	FpAdd, CODE, READONLY
	IMPORT	main
	EXPORT	start

start

	;
	; Part 1 - decode
	;

	LDR	r0, =0xbf09999a		; fpval1 = -0.5375
	LDR	r1, =0xbd19999a		; fpval2 = -0.0375

	BL	fpadd

stop	B	stop

; fpadd subroutine
; Adds two IEEE754 single precision floating point values
; Parameters:
;   R0: first floating point value
;   R1: second floating point value
; Return value:
;   R0: floating point result
;
fpadd
	STMFD sp!, {R3-R9 ,lr}

	LDR R3, =0x007FFFFF		; Loading 0 0000 0000 1111 1111 1111 1111 1111 111 in R3
	LDR R4, =0x7F800000		; Loading 0 1111 1111 0000 0000 0000 0000 0000 000 in R4
	
	;check if they are negative 
	LDR R11,= 0				; signvalue1 = false;
	LDR R12,= 0				;signvalue2 = false
	LDR R9, =0x7FFFFFFF
	BIC R10, R0, R9			;keep only sign bit of value1
	
	CMP R10, #0x80000000	; if(sign bit value1 == 1)	
	BNE notnegative
	ADD R11, R11, #1		;signvalue1 = true;
notnegative

	BIC R10, R1, R9			;
	CMP R10, #0x80000000;	if(sign bit value2 == 1) signvalue2 = true;
	BNE notnegative2
	ADD R12, R12, #1;
notnegative2


	;Getting the exponent values from the floating point values
	AND R5, R4, R0	; exponent1 = value1 AND 0x7F800000
	AND R7, R4, R1	; exponent2 = value2 AND 0x7F800000
	
	;Getting the fraction values from the floating point values
	AND R6, R3, R0	; fraction1 = value1 AND 0x007FFFFF	
	AND R8, R3, R1	; fraction2 = value2 AND 0x007FFFFF	

	MOV R5, R5, LSR #23; shift exponent to be in first 8 bits(8 less significant bit) 
	MOV R7, R7, LSR #23	;	same as above : exponent = exponent >> 23
	LDR R9, =127
	SUBS R5, R5, R9		; exponent1 -= 127 					converting exponent back to original exponent value (bc of : 2^(e-b))
	SUBS R7, R7, R9		; exponent2 -= 127
	
	CMP R5, R7
	BLO othersub		; if(exponent1 > exponent2){
	SUBS R9, R5, R7;	tmp = exponent1 - exponent2	
	B skipothersub
othersub				; } else {
	SUBS R9, R7, R5;	tmp = exponent2 - exponent1		}
skipothersub
	CMP R9, #0			; if(tmp < 0) tmp * -1
	BHS notneg
	LDR R0,= -1;
	MUL R9, R0, R9;
notneg
	CMP R5, R7			;if(exponent1 = exponent2){
	BEQ ignore			;	
	CMP R5, R7			;	} else if(exponent1>exponent2){
	BLO exp2IsGreater
	;shift fraction2 by R9
	MOV R0, R9			;
	MOV R1, R8			;
	BL shitft			;fraction2 = shitf(tmp, fraction2)
	MOV R8, R1			;exponent2 = exponent1
	MOV R7, R5			; } else{
	B ignore
exp2IsGreater
	;shift fraction1 by R9
	MOV R0, R9			; 
	MOV R1, R6;
	BL shitft			;fraction1 = shitf(tmp, fraction1)
	MOV R6, R1			;exponent1 = exponent2
	MOV R5, R7	
ignore				; }

	CMP R11, #0		; if(signvalue1 == false && sign value2 == false){
	BNE firstnumbernegative; 
	CMP R12, #0
	BNE second
	ADD R6, R6, R8; add = fraction1 + fraction2	
	B finishedadd	; } else if (signvalue1 == false && signvalue2 == true){
second
	SUB R6, R6, R8;		add = fraction1 - fraction2;
	B finishedadd	; } else if(signvalue1 == true && signvalue2 == false)
firstnumbernegative
	CMP R12, #0
	BNE bothnegatives
	SUB R6, R8, R6	; add = fraction1 - fraction2 } else {	
	B finishedadd	
bothnegatives
	ADD R6, R6, R8; add = fraction1 + fraction2		
	ADD R6,R6, #0x80000000; add sign bit to result}
finishedadd

	CMP R6, #0		;  if(add < 0){
	BHS dontaddsignbit
	LDR R10,=-1;  add = add * -1
	MUL R6,R10,R6;add sign bit to add
	ADD R6,R6, #0x80000000; }
dontaddsignbit

	ADD R7, R7, #127; exponent = exponent + 127 (converting back to 2^e-b)	
	MOV R7, R7, LSL #23	; exponent << 23 		(shift back exponent to original position)	
	ADD R0, R6, R7		; result = add ++ exponent
	

	LDMFD sp!, {R3-R9 ,pc}
	
; shitft subroutine
; shifts the given fraction by a set value of bits
; Parameters:
;   R0: quantity to shift
;   R1: fraction to shift
; Return value:
;   R1: shifted fraction
shitft	
	STMFD sp!, {R3-R4 ,lr}	; save registers
	MOV R4, R0				; quantity
	ADD R1, R1, #0x00800000 ; adding the 1.XXX that isn't contained in the fraction :    fraction = fraction + 0x00800000
	MOV R1, R1, LSR R4		; fraction >> quantity
	LDMFD sp!, {R3-R4 ,pc}	; restore registers
	END