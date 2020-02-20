	AREA	BubbleSort, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R0, =testarr			; load address of first number
	LDR	R1, =N					; load length of array
	BL sort						; call subroutine sort
	B stop						; end the program


sort
	;
	; sort subroutine
	;sorts an array of numbers in ascending order (from lowest to highest)
	; Parameters
	;		[R0] : address of the first number
	;		[R1] : size of the array(amount of numbers to sort)
	
	STMFD sp!, {R5-R7, lr}		; save registers and lr
wh								;do{
	ldr R3, =0					;swapped = false
	LDR R4, =1					; i = 1

forLoop
	CMP R4, R1				;for(i<length(array); i++){
	BHS endFor
	
	LDR R5, [R0, R4, LSL #2]	; loading array[i]
	SUB R6, R4, #1				; tmp = i - 1
	LDR R6, [R0, R6, LSL #2]	; loading array[tmp]
	
	CMP R6, R5					;if(array[i-1] > array[i]){
	BLS endif
	
;	LDR R2, [R0, R4, LSL #2]	;
	MOV R2, R4					;
	LDR R7,= 4					;
	MUL R2, R7, R2				;addressToPass = (i * 4) + firstAddress
	ADD R2, R2, R0				;
	BL swap						;swap(array[i])
	LDR R3, =1					;swapped = true	
endif							;}
	ADD R4, R4, #1;
	B forLoop					;}
endFor	
	CMP R3, #1					;
	BNE eWh						; } while(swapped)
	B wh

eWh
	LDMFD sp!, {R5-R7, pc}		; restore registers
	
swap
	;
	;swap subroutine
	;swap 2 elements in a 1 dimensional array of word siwe integers
	;		[R2 - 4] : address of the first element to be swapped
	;		[R2] : address of the second element to swap

	STMFD sp!, {R5-R6, lr}		; save registers and lr
	
	LDR R5, [R2, #-4]; load word size value at address R4
	LDR R6, [R2]	; load word size value at address R3
	STR R6, [R2, #-4]	; load value at address R3
	STR R5, [R2]	; load value at address R4
	
	LDMFD sp!, {R5-R6, pc}; restore registers

stop	B	stop


	AREA	TestData, DATA, READWRITE
N	EQU	10
testarr	DCD	3,9,2,1,8,0,7,4,9,6
	END