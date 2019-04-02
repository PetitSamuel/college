	AREA	Flags2, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
;(i) N = 0; Z = 0; C = 0; V = 0
	LDR R0, = 0x20000000 ;
	LDR R1, = 0x10000000;
	ADDS R2, R1, R0;

;(ii) N = 1; Z = 0; C = 0; V = 0
	LDR R0, = 0x80000000 ;
	LDR R1, = 0x10000000;
	ADDS R2, R1, R0;

;(iii) N = 0; Z = 0; C = 1; V = 0
	LDR R0, = 0xC0000000 ;
	LDR R1, = 0x50000000 ;
	ADDS R2, R1, R0;

;(iv) N = 1; Z = 0; C = 1; V = 0
	LDR R0, = 0xD0000000 ;
	LDR R1, = 0xC0000000;
	ADDS R2, R1, R0;

;(v) N = 0; Z = 1; C = 1; V = 0
	LDR R0, = 0x50000000 ;
	LDR R1, = 0xB0000000;
	ADDS R2, R1, R0;

;(vi) N = 0; Z = 1; C = 0; V = 0
	LDR R0, = 0x00000000 ;
	LDR R1, = 0x00000000 ;
	ADDS R2, R1, R0;

;(vii) N = 1; Z = 0; C = 0; V = 1
	LDR R0, = 0x50000000 ;
	LDR R1, = 0x50000000;
	ADDS R2, R1, R0;

;(viii) N = 0; Z = 0; C = 1; V = 1
	LDR R0, =  0xB0000000;
	LDR R1, =  0xC0000000;
	ADDS R2, R1, R0;

;(ix) N = 0; Z = 1; C = 1; V = 1

	LDR R0, = 0x80000000 ;
	LDR R1, = 0x80000000;
	ADDS R2, R1, R0;


stop	B	stop

	END	