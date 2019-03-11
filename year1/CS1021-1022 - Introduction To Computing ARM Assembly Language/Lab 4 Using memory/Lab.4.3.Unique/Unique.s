	AREA	Unique, CODE, READONLY
	IMPORT	main
	EXPORT	start

start

	LDR	R1, =VALUES	;Values = address.VALUES 
	LDR R2, =COUNT	;Count = address.COUNT
	LDR R2, [R2]	;Count = Memory.word[Count]
	MOV R0, #1		;unique = 1
	MOV R3, #0		;a = 0
	MOV R4, #4		; tmp = 4
	MUL R2, R4, R2	; countEnd = tmp * count 		(or 4 * count)
whlCMP	
	CMP R3, R2		; while (a != coundEnd){
	BEQ stopCheck	;
	
	ADD R4, R3, R1	; newAddress = values + a
	LDR R4, [R4]	; newValue = memory.word[newAddress]
	ADD R3, R3, #4	; a += 4
	
	MOV R5, R3		; b = a
whlCMPT	
	CMP R5, R2		; while(b != countEnd){
	BEQ stopwhilTwo
	
	ADD R6, R5, R1	; newAddress2 = b + values
	LDR R6, [R6]	; newValue2 = memory.word[newAddress2]
	ADD R5, R5, #4	; b += 4
	
	CMP R4, R6		; if( newValue2 == newValue){
	BNE notEQU
	MOV R0, #0		; unique = 0
	MOV R5, R2		; b = countEnd
	MOV R3, R2		; a = countEnd }	}	}
notEQU
	B whlCMPT
	
	
stopwhilTwo
	B whlCMP
stopCheck

stop	B	stop


	AREA	TestData, DATA, READWRITE
	
COUNT	DCD	10
VALUES	DCD	2, 5, 4, 4, 13, 50, 18, 8, 9, 12


	END	