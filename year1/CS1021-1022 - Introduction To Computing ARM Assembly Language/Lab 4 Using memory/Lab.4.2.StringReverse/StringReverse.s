	AREA	StringReverse, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R1, =strSrc	; address1 = address of first value
	LDR	R2, =strDst	;address2 = address of first value
	MOV R0, #0		; count = 0

whl	
	LDRB R3, [R1]	; while(value != 0){
	CMP R3, #0		;value = Memory.byte[address1]
	BEQ endwhl		;
	ADD R0, R0, #1	; count += 1
	ADD R1, R1, #1	; address1 += 1	}
	B whl			;
endwhl

whlReversing
	CMP R0, #0		; while(count != 0){
	BEQ endReverse	;
	
	SUB R0, R0, #1	;count -= 1
	SUB R1, R1, #1	;address1 -= 1
	
	LDRB R3, [R1]	; value = Memory.byte[address1]
	STRB R3, [R2]	; Memory.byte[address2] = value
	
	ADD R2, R2, #1	; address2 += 1 }
	B whlReversing
endReverse

stop	B	stop
	AREA	TestData, DATA, READWRITE


strSrc	DCB	"hello",0
strDst	SPACE	128

	END	