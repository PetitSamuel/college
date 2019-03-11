	AREA	Shift64, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R0, =0xFFFFFFFF;
	LDR	R1, =0xFFFFFFFF;
	LDR	R2, =4; sign = 4 (test value)

	LDR R3, =0; count = 0
	
	CMP R2, #0; if(sign < 0)
	BLT whNeg; { go to negative loop}
	CMP R2, #0; else if{ sign < 0)
	BHI whPos;{ go to negative loop}
	CMP R2, #0;else if(sign == 0){
	BGT end; go to end of program}
	
whNeg	
	CMP R3, R2; while(count > sign ) { 
	BLE eWhNeg
	SUB R3, R3, #1; Count--
	MOV R1, R1, LSL#1; R1 << 1
	MOVS R0, R0, LSL#1; R0 << 1
	ADC R4, R0; tmp = R0+carry
	CMP R4, R0; if (tmp != R0)
	BEQ eif; {
	ADD R1, R1, #1; R1++ }	
eif	
	B whNeg;}	
eWhNeg
	B end;

whPos
	CMP R3, R2; while(count < sign){
	BGE ewhPos
	ADD R3, R3, #1; count++
	MOV R0, R0, LSR #1; R0 >>1
	MOVS R1, R1, LSR #1; R1 >> 1 (Flags!)
	
	ADC R4, R1; tmp = R1+ carry
	
	CMP R4, R1; if(tmp != R1){
	BEQ eif2
	ADD R0, R0, #0x80000000; R1 += 0x80000000
eif2;					}
	B whPos
ewhPos
end
stop	B	stop


	END
		