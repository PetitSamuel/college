	AREA	AsmTemplate, CODE, READONLY
	IMPORT	main

; sample program makes the 4 LEDs P1.16, P1.17, P1.18, P1.19 go on and off in sequence
; (c) Mike Brady, 2011 -- 2019.

	EXPORT	start
start

IO1DIR	EQU	0xE0028018
IO1SET	EQU	0xE0028014
IO1CLR	EQU	0xE002801C
IO1PIN	EQU	0xE0028010
	ldr r3,=IO1PIN
	LDR R7,=0;
	LDR R8,=0
	LDR R0,=0
	LDR R9,=0 ; last button was + on startup
	
; r1 points to the SET register
; r2 points to the CLEAR register
while
	LDR R4, [R3] 
	MOV R4, R4, LSR #4;
	LDR R5,=0x000f0000;
	EOR R4, R5, R4
	AND R4, R5, R4
	;STR R4, [R2];
	CMP R4, #0;
	BEQ while
	MOV R6, R4, LSR #16
		
	CMP R6, #1
	BNE notOne
	B LeftButton
notOne
	CMP R6, #2
	BNE notTwo
	B MiddleLeftButton
notTwo
	CMP R6, #4
	BNE notFour
	B MiddleRightButton
notFour
	CMP R6, #8
	BNE handled
	B RightButton
handled	
	BL waitASecond
	B while
	
;R0 = number
LeftButton
	ADD R0, R0, #1
	LDR R10,= storeNumbers
	STRB R0, [R10]
	BL displayCurrentValue
	B handled
;R0 = number
MiddleLeftButton
	SUB R0, R0, #1
	LDR R10,= storeNumbers
	STRB R0, [R10]
	BL displayCurrentValue
	B handled
;
MiddleRightButton
	BL waitASecond
	LDR R4, [R3] 
	MOV R4, R4, LSR #4;
	LDR R5,=0x000f0000;
	EOR R4, R5, R4
	AND R4, R5, R4
	MOV R4, R4, LSR #16
	CMP R4, R6
	BEQ longMiddleRight
	CMP R9, #0
	BEQ performAdd
	SUB R8, R8, R0
	B subtracted
performAdd
	ADD R8, R8, R0
subtracted
	MOV R9, #0
	LDR R10,= storeNumbers
	STRB R8, [R10]
	MOV R0, #0
	BL displayCurrentValue
	B handled

RightButton
	BL waitASecond
	LDR R4, [R3] 
	MOV R4, R4, LSR #4;
	LDR R5,=0x000f0000;
	EOR R4, R5, R4
	AND R4, R5, R4
	MOV R4, R4, LSR #16
	CMP R4, R6
	BEQ longRight
	CMP R9, #0
	BEQ performAdd2
	SUB R8, R8, R0
	B subtracted2
performAdd2
	ADD R8, R8, R0
subtracted2
	MOV R9, #1
	LDR R10,= storeNumbers
	STRB R8, [R10]
	MOV R0, #0
	BL displayCurrentValue
	B handled

	
displayCurrentValue
	STMFD sp!, {LR, R1 - R12}
	
	ldr	r1,=IO1DIR
	ldr	r2,=0x000f0000	;select P1.19--P1.16
	str	r2,[r1]		;make them outputs
	ldr	r1,=IO1SET
	str	r2,[r1]		;set them to turn the LEDs off
	ldr	r2,=IO1CLR
	;LDR R12,= sign;
	;LDRB R12, [R12];

	LDR R6,= storeNumbers
	LDRB R9, [R6]
display
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
	MOV R3, R9
	CMP R3, #0
	BNE notZero
	LDR R3,=0x000f0000
notZero
	str	r3,[r2]		;clear the bit -> turn on the LED
	LDMFD SP!, {PC, R1-R12}
	
;subroutine which pauses the program for about one second
waitASecond
	STMFD SP!, {LR, R3}
	LDR	r3,=4000000
wait
	CMP R3, #0
	BEQ stopWaiting
	SUB R3, R3, #1;
	B wait
	
stopWaiting
	LDMFD SP!, {PC, R3}
	
	
stoplongWaiting
	LDMFD SP!, {PC, R3}
	
	
longRight
	B start


longMiddleRight
	LDR R9,= 0
	LDR R0,= 0
	LDR R10,= storeNumbers
	STRB R0, [R10]
	BL displayCurrentValue
	B while

stop	B	stop
	AREA	Grids, DATA, READWRITE
storeNumbers
		DCB	0
sign
		DCB	0
	END
		
		
		
		
		
		
		
		
		
		
		
