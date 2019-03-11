	AREA	GCD, CODE, READONLY
	IMPORT	main
	EXPORT	start

start

	MOV R2,#100		; (a = 12)
	MOV R3,#18		; (b = 18)
	
whiledifferent
	CMP R2, R3; 
	BEQ endwhile	;while (a != b) {	
	
	CMP R2, R3; 	if(a > b)
	BLO else		; {
	SUB R2, R2, R3; a = a - b
	B endif			; }
		
else      		 	; else {
	SUB R3, R3, R2	; b = b - a
endif    			;}
	
	B whiledifferent ; }
endwhile

	MOV R0, R2		; result = a


stop	B	stop

	END	