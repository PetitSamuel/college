	AREA	AsmTemplate, CODE, READONLY
	IMPORT	main

; sample program makes the 4 LEDs P1.16, P1.17, P1.18, P1.19 go on and off in sequence
; (c) Mike Brady, 2011 -- 2019.

	EXPORT	start
start

; R0 = Number to display
	LDR R0,= -419
	MOV R12, #0		; assume number is positive
	LDR R1,= 0x80000000
	AND R2, R0, R1
	CMP R2, #0
	BEQ positive
	MOV R12, #1		; record fact that number is negative
	LDR R1,= 0xFFFFFFFF ;number is negative so we record this fact in R12 and get the two's complement of the number
	EOR R0, R0, R1		;gets ones complement
	ADD R0, R0, #1		;add one to get two's complement
positive	;number was positive or is now positive as two's complement has been gotten
	LDR R6,= storeNumbers
	LDR R5,= 0x3B9ACA00	;Load one billion
	MOV R1, R5
	BL div			;divide our number by R5
	STRB R1, [R6]	;store number of divisions into address of R6
	ADD R6, R6, #1	;increment R6
	MOV R7, R0
	LDR R5,= 0x5F5E100
keepDividing
	CMP R5, #1
	BLS finishedDividing
	MOV R1, R5
	BL div			;divide our number by R5
	STRB R1, [R6]	;store number of divisions into address of R6
	ADD R6, R6, #1	;increment R6
	MOV R7, R0
	MOV R0, R5
	MOV R1, #0x0000000A		;divide our divisor by 10 to get next digit
	BL div
	MOV R5, R1
	MOV R0, R7		;move our number back in
	B keepDividing
finishedDividing	;only single digit remains
	STRB R0, [R6]
	LDR R8,=sign;
	STRB R12, [R8];
	B flashResults


div	;R0 = numerator, R1 = divisor; R0 = return remaining number after division, R1 = return number of divisions
	STMFD SP!, {LR, R4-R12}
	MOV R4, #0	; 0 successful divisions
while
	CMP R0, R1
	BLT	completeDiv
	SUB R0, R0, R1
	ADD R4, R4, #1
	B while
completeDiv
	MOV R1, R4	;return number of divisions
	LDMFD SP!, {PC, R4-R12}
	
flashResults
	
IO1DIR	EQU	0xE0028018
IO1SET	EQU	0xE0028014
IO1CLR	EQU	0xE002801C
	LDR R12,= sign;
	LDRB R12, [R12];
	ldr	r1,=IO1DIR
	ldr	r2,=0x000f0000	;select P1.19--P1.16
	str	r2,[r1]		;make them outputs
	ldr	r1,=IO1SET
	str	r2,[r1]		;set them to turn the LEDs off
	ldr	r2,=IO1CLR
; r1 points to the SET register
; r2 points to the CLEAR register
	BL waitASecond
	CMP R12, #0
	BEQ positiveSign
	ldr	r3,=0x000D0000
	B endsign
positiveSign
	ldr r3,= 0x00050000
endsign
	str	r3,[r2]		;clear the bit -> turn on the LED
	BL waitASecond
	LDR R6,= storeNumbers
	MOV R7, #0		;counter
	MOV R8, #0		;have started boolean
loop
	CMP R7, #10
	BEQ flashResults
	LDRB R9, [R6, R7]
	CMP R9, #0
	BNE display
	CMP R8, #0
	BEQ increment

display
	MOV R8, #1
	STMFD SP!, {R12}
	MOV R9, R9, LSL #16
	LDR R10,= 0x00010000
	LDR R11,= 0x00020000
	LDR R12,= 0x00040000
    LDR R5,= 0x00080000
	AND R10, R9, R10 
	AND R11, R9, R11 
	AND R12, R9, R12
	AND R5, R9, R5
	MOV R10, R10, LSL #3
	MOV R11, R11, LSL #1
	MOV R12, R12, LSR #1
	MOV R5, R5, LSR #3
	MOV R9, #0
	ORR R9, R9,R10 
	ORR R9, R9,R11 
	ORR R9, R9,R12 
	ORR R9, R9,R5 
	str	r3,[r1]		
	MOV R3, R9
	CMP R3, #0
	BNE notZero
	LDR R3,=0x000f0000
notZero
	str	r3,[r2]		;clear the bit -> turn on the LED
	BL waitASecond
increment
	ADD R7, R7, #1

	CMP R7, #10
	BNE skipExtraCheck
	CMP R8, #0
	BNE skipExtraCheck
	; numer is 0, display it
	LDR R3,=0x000f0000
	str	r3,[r2]		;clear the bit -> turn on the LED
	BL wait
skipExtraCheck
	LDMFD SP!, {R12}
	B loop
;subroutine which pauses the program for about one second
waitASecond

	STMFD SP!, {LR, R3}
	LDR	r3,=10000000
wait
	CMP R3, #0
	BEQ stopWaiting
	SUB R3, R3, #1;
	B wait
stopWaiting

	LDMFD SP!, {PC, R3}

stop	B	stop
	AREA	Grids, DATA, READWRITE

storeNumbers
		DCB	0,0,0,0,0,0,0,0,0,0
sign
		DCB	0
	END
		
		