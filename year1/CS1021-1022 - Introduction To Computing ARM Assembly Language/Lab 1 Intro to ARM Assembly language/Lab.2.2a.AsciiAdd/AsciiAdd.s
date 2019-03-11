	AREA	AsciiAdd, CODE, READONLY
	IMPORT	main
	EXPORT	start

start

; part a

	LDR	R1, ='2'	; R1 = 0x32 (ASCII symbol '2')
	LDR	R2, ='4'	; R2 = 0x34 (ASCII symbol '4')	
	LDR R3, ='0'	; R3 = 0x30 (ASCII symbol '0')
	SUB R0, R1, R3	; R0 = 0x32 - 0x30
	ADD R0, R0, R2	; R0 = 0x36

stop	B	stop

	END	