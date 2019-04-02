	AREA	Sudoku, CODE, READONLY
	EXPORT	start

start
	LDR	R0, =testGridOne
	LDR	R1, =0
 	LDR	R2, =0
 	LDR	R3, =1

testStageOne
 	CMP	R3, #9
 	BGT	testStageTwo
	STRB	R3, [R0]
	BL	isValid
	ADD	R3, R3, #1	; put a break point here - only 1 should be valid
	B	testStageOne

testStageTwo
	LDR	R0, =testGridTwo
	LDR	R1, =0
	LDR	R2, =0
	BL	sudoku
	LDR	R0, =testGridTwo
	LDR	R1, =testSolutionTwo
	BL	compareGrids

testStageThree
	LDR	R0, =testGridThree
	LDR	R1, =0
	LDR	R2, =0
	BL	sudoku
	LDR	R0, =testGridThree
	LDR	R1, =testSolutionThree
	BL	compareGrids

stop	B	stop


compareGrids
	STMFD	sp!, {R4-R6, LR}
	LDR	R4, =0
forCompareGrids
	CMP	R4, #(9*9)
	BGE	endForCompareGrids
	LDRB	R5, [R0, R4]
	LDRB	R6, [R1, R4]
	CMP	R5, R6
	BNE	endForCompareGrids
	ADD	R4, R4, #1
	B	forCompareGrids
endForCompareGrids

	CMP	R4,#(9*9)
	BNE	elseCompareGridsFalse
	MOV	R0, #1
	B	endIfCompareGridsTrue
elseCompareGridsFalse
	MOV	R0, #0
endIfCompareGridsTrue
	LDMFD	sp!, {R4-R6, PC}


;
;
; YOUR SUBROUTINES HERE
;
;   isValid subroutine
;   sudoku subroutine
;   any other subroutines
;
;


	AREA	Grids, DATA, READWRITE

testGridOne
	DCB	0,0,0,0,0,5,6,7,0
	DCB	0,2,3,0,0,0,0,0,0
	DCB	0,4,0,0,0,0,0,0,0
	DCB	0,0,0,0,0,0,0,0,0
	DCB	0,0,0,0,0,0,0,0,0
	DCB	0,0,0,0,0,0,0,0,0
	DCB	0,0,0,0,0,0,0,0,0
	DCB	8,0,0,0,0,0,0,0,0
	DCB	9,0,0,0,0,0,0,0,0

testGridTwo
	DCB	0,2,7,6,0,0,0,0,3
	DCB	3,0,0,0,0,9,0,0,0
	DCB	8,0,0,0,4,0,5,0,0
	DCB	6,0,0,0,0,2,0,4,0
	DCB	0,0,2,0,0,0,8,0,0
	DCB	0,4,0,7,0,0,0,0,1
	DCB	0,0,3,0,1,0,0,0,7
	DCB	0,0,0,8,0,0,0,0,9
	DCB	9,0,0,0,0,6,2,8,0

testSolutionTwo
	DCB	1,2,7,6,5,8,4,9,3
	DCB	3,5,4,2,7,9,1,6,8
	DCB	8,9,6,3,4,1,5,7,2
	DCB	6,3,9,1,8,2,7,4,5
	DCB	7,1,2,4,9,5,8,3,6
	DCB	5,4,8,7,6,3,9,2,1
	DCB	2,8,3,9,1,4,6,5,7
	DCB	4,6,5,8,2,7,3,1,9
	DCB	9,7,1,5,3,6,2,8,4

testGridThree
	DCB	0,0,0,9,0,0,0,5,0
	DCB	0,0,3,0,4,0,1,0,6
	DCB	0,4,0,2,0,0,0,8,0
	DCB	7,0,8,0,0,0,0,0,0
	DCB	0,3,0,0,0,0,0,6,0
	DCB	0,0,0,0,0,0,5,0,4
	DCB	0,6,0,0,0,1,0,7,0
	DCB	4,0,2,0,5,0,3,0,0
	DCB	0,9,0,0,0,8,0,0,0

testSolutionThree
	DCB	1,2,7,9,8,6,4,5,3
	DCB	9,8,3,5,4,7,1,2,6
	DCB	5,4,6,2,1,3,7,8,9
	DCB	7,5,8,3,6,4,2,9,1
	DCB	2,3,4,1,9,5,8,6,7
	DCB	6,1,9,8,7,2,5,3,4
	DCB	8,6,5,4,3,1,9,7,2
	DCB	4,7,2,6,5,9,3,1,8
	DCB	3,9,1,7,2,8,6,4,5

	END
