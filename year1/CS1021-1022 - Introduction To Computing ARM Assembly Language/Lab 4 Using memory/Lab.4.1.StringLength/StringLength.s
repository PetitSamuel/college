	AREA	StringLength, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R1, =str1	; address = adress of first value
	MOV R0, #0		; count = 0

whl	
	LDRB R2, [R1]	; while(value != 0){
	CMP R2, #0		; value = Memory.byte[address]
	BEQ endwhl		;
	ADD R0, R0, #1	; count += 1
	ADD R1, R1, #1	; address += 1
	B whl			;}
endwhl
	
stop	B	stop



	AREA	TestData, DATA, READWRITE

str1	DCB	"Friday",0

	END	
