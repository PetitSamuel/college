	AREA	Sudoku, CODE, READONLY
	IMPORT	main
	IMPORT	sendchar
	EXPORT	start
	PRESERVE8

start

	;
	; write tests for getSquare subroutine
	;
;	LDR	R0, =loadGrid
;	MOV	R1, #0
;	MOV	R2, #1		; value = getSquare(Row : 0, Column : 0, address)
;	BL	getSquare ; (compare value in R0 with value at position selected in grid)

	;
	; write tests for setSquare subroutine
	;
;	LDR R3,= testGridOne
;	STR	R3, [sp, #-4]!;
;	LDR	R0, =5
;	MOV	R1, #0
;	MOV	R2, #0;	setSquare(Row: 0, Column: 2, Value (byte): 5)
;	BL setSquare;
;	ADD sp, sp, #4;
;to test : execute and copy address in R3 into memory window. Check for the value at the position (Row, Column) set.

	;
	; write tests for isValid subroutine
	;
;	MOV	R1, #0
;	MOV R2, #0;
;	LDR R0,= testGridThree
;	BL checkSquare; Returns true or false in R0 
	; checks for validity at position (Row : R1, Column : R2). Will check for : the row, the column and the sub-square's validity
	
	;
	;testing displayText subroutine
	;gets an address parameter (of an array of characters : a string) and displays it on the console
	;LDR R0,=displayTextSolved ;	load the address of some null terminated text string
	;BL displayText			
	; run the program and look inside the console to test
	
	
	;testing the 2 print grids subroutine
	;printGrid goes through all of the rows and calls printRow, then jumps to next line
	;printRow goes through all of the value contained in a specific row and returns the value (converted to ascii) in the console
	
	;to print a specific row into the console 
	;LDR R1,=1;
	;LDR R2,= loadGrid
	;BL printRow; printing row 1 (rows start at index 0)
	
	;to print the entire grid 
	;LDR R1, =loadGrid
	;BL printGrid
	
	
	; test sudoku subroutine / mainline
	;shows inside the console the original grid and after executing the sudoku subroutine the (solved) grid is displayed again (including text messages to explain more clearly what's happening)

	;DELETE COMMAS TO TEST FULL PROGRAM (with display and uniqueness checking)
;	LDR R1,= displayTextNonSolved; displayText(nonSolved)
;	BL displayText;
;	LDR R1,= multiSolutionGrid
;	BL printGrid				; printGrid(gridAddress)
;	MOV	R1, #0
;	MOV	R2, #0
;	LDR R0,= multiSolutionGrid;
;	LDR R10,= 0;
;	LDR R11,= 0;
;	STMFD	sp!, {R10, R11}
;	BL sudoku					;sudoku(address, row, column, Boolean : unique, boolean : isNotUnique) //solve current grid
;	ADD SP, SP, #8;
;	MOV R3, R0					;save (boolean result)
;	MOV R4, R1					; save boolean(unique)
;	LDR R1,= displayTextFinal	; displayText(finalGrid)
;	BL displayText;	
;	LDR R1,= finalGrid 
;	BL printGrid				;displayFinalGrid
;	LDR R0,=10;			print(new line)
;	BL sendchar
;
;	CMP R4, #1;			if(unique) display(uniqueSolutionString)
;	BNE notUniqueText
;	LDR R1,= uniqueSolution
;	B uniqueIsFalse
;notUniqueText			;	else display(multipleSolutionsString);
;	LDR R1,= multipleSolutions
;uniqueIsFalse

;	BL displayText;	

	;PROVIDED TESTING METHOD
	LDR	R3, =1
testStageOne
 	CMP	R3, #9
	BGT	testStageTwo
	LDR	R0, =testGridOne	
	STRB	R3, [R0]
	LDR	R1, =0
	LDR	R2, =0	
	BL	isValid
	MOV R4, R0;
	ADD	R3, R3, #1	; put a break point here - only 1 should be valid
	B	testStageOne

; my sudoku subroutine will search for 2 solutions. Or try all of the different solutions (which makes solving 
; unique solution grids innefficient). It will return a boolean value if 2 solutions have been found or not.
testStageTwo
	LDR	R0, =testGridTwo
	LDR	R1, =0
	LDR	R2, =0
	LDR R10,= 0;
	LDR R11,= 0;
	STMFD	sp!, {R10, R11}
	BL sudoku					;sudoku(address, row, column, Boolean : unique, boolean : isNotUnique) //solve current grid
	ADD SP, SP, #8;
	
;	Loaded 	finalGrid instead of testGrid two because the result grid is stored in finalGrid when it is found
;	the program then continues looking for solutions (checking the 'uniqueness' of the grid)
	LDR	R0, =finalGrid
	LDR	R1, =testSolutionTwo
	BL	compareGrids
	
	MOV R3, R0;
	
testStageThree
	LDR	R0, =testGridThree
	LDR	R1, =0
	LDR	R2, =0
	LDR R10,= 0;
	LDR R11,= 0;
	STMFD	sp!, {R10, R11}
; my sudoku subroutine will search for 2 solutions. Or try all of the different solutions (which makes solving 
; unique solution grids innefficient). It will return a boolean value if 2 solutions have been found or not.
; this grid does take a lot of time to compute due to the above reason
	BL sudoku					;sudoku(address, row, column, Boolean : unique, boolean : isNotUnique) //solve current grid
	ADD SP, SP, #8;
;	Loaded 	finalGrid instead of testGrid three because the result grid is stored in finalGrid when it is found
;	the program then continues looking for solutions (checking the 'uniqueness' of the grid)	
	LDR	R0, =finalGrid
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


; getSquare subroutine
;gets the value of a digit with a given row and column
;	Parameters : 
;	R0 : address
;	R1 : row index
;	R2 column index
;	R0 digit return value
getSquare
	STMFD sp!, {R3-R6, lr}; save registers 
	MOV	R3, R0	; load address of first value (base Address)
	MOV R4, R1			; save row
	MOV R5, R2			; save col
	; accessing value of a 2D array
	LDR R6,=9			; tmp = 9 
	MUL R6, R4, R6		;  tmp address of value = tmp * row ( = 9 * row)
	ADD R6, R6, R5		; address of value = tmpAddress + col + baseAddress
	ADD R6, R6, R3;
	LDRB R0, [R6]		; Load Byte value at address
	LDMFD sp!,{R3-R6, pc}; restore registers

; setSquare subroutine
; sets a number value at a column and row index
;	Parameters:
;	R0 : byte value to store
;	R1 : row index
;	R2 : column index
;	[sp + 4 * nbSaveRegisters] : address
setSquare
	STMFD sp!, {R3-R7, lr}; save registers
	LDR R6, [sp, #24]		; load base address	
	MOV	R3,R0			; value
	MOV R4, R1			;row
	MOV R5, R2			;column
	LDR R7,=9			; 
	MUL R7, R4, R7		; address = 9 * row + column + base address
	ADD R7, R7, R5		;  
	ADD R7, R7, R6;
	STRB R3, [R7]		; store value at [address]
	LDMFD sp!,{R3-R7, pc}; restore registers	


; isValid subroutine
; checks if a grid is (partially) valid or not 
;	Parameters
;	R0 : address
;	R1 : row index
;	R2 : column index
;	R0 return value (TRUE or FALSE : 1 or 0)
isValid
	STMFD sp!, {R3-R6, lr}; save registers
	LDR R5,=0;			trueCount = 0
	MOV R6, R0;			address
	MOV R3, R1			; row
	MOV R4, R2			; column
	; check if row, column and square is valid
	MOV R1, R3;
	MOV R2, R6			;	trueCount += checkRow(address, row)
	BL checkRow			
	ADD R5, R5, R0;		if(trueCount != 1) return false
	CMP R5, #1;
	BNE returnFalse
	MOV R1, R6			;trueCount += checkRow(address, column)
	MOV R2, R4			
	BL checkCol

	ADD R5, R5, R0;		if(trueCount != 2) return false
	CMP R5, #2;
	BNE returnFalse
	MOV R1, R3			
	MOV R2, R4				
	MOV R0, R6;
	BL checkSquare;		trueCount += checkSubGrid(address, row, column)
	ADD R5, R5, R0;
	
	CMP R5, #3;			if(trueCount != 3) return false
	BNE returnFalse	
						;	else {	return true;}
	LDR R0,= 1;
	MOV R1, R3			;restore row
	MOV R2, R4			; restore column		
	LDMFD sp!,{R3-R6, pc}; restore registers
returnFalse
	MOV R1, R3			;restore row
	MOV R2, R4			; restore column	
	LDR R0,= 0;
	LDMFD sp!,{R3-R6, pc}; restore registers


; checkRow subroutine
;gets a row index and checks if that row is valid or not
;	Parameters :
;	R1 : Row index
;	R2 : address
;	R0 : boolean output value (1 or 0)
checkRow
	STMFD sp!, {R3-R8, lr}; save registers
	MOV R8, R2;				address
	MOV R3, R1			  ; row
	LDR R4,= 0			  ; for(int i = 0; i < length - 1; i++){
for1	
	MOV R1, R3			  ; value1 = getSquare(Row : row, Column : i, address) 
	MOV R2, R4;
	MOV R0, R8;
	BL getSquare
	MOV R5, R0;
	MOV R6, R4			
for2					;   for (int j = i +1; j < length; j++){
	ADD R6, R6, #1;
	MOV R1, R3			; value2 = getSquare(Row : row, Column : j, address)				
	MOV R2, R6;
	MOV R0, R8;	
	BL getSquare
	MOV R7, R0;
	
	CMP R5, R7			; if(value 1 == value 2 && value 1 != 0) return false
	BNE notEqual
	CMP R5, #0;
	BEQ notEqual
	LDR R0,=0;
	LDMFD sp!,{R3-R8, pc};	restore registers
notEqual

	CMP R6, #8; }
	BHS endFor2
	B for2
endFor2
	

	ADD R4, R4, #1;
; compares with 8 and not 9 because count is incremented after loading the value at that index
	CMP R4, #8;
	BHS endFor1
	B for1
endFor1					; }
	LDR R0,=1		; returnValue = true
	LDMFD sp!,{R3-R8, pc};	restore registers


; checkCol subroutine
;gets a Column index and checks if that column is valid or not
;	Parameters :
;	R1 : address
;	R2 : Column index
;	R0 : boolean output value (1 or 0)
checkCol
	STMFD sp!, {R3-R8, lr}; save registers
	MOV R8, R1;			address
	MOV R3, R2			 ; column
	LDR R4,= 0			 ; for(int i = 0; i < length - 1; i++){
forCol1	
	MOV R1, R4;
	MOV R2, R3;
	MOV R0, R8;		
	BL getSquare		; value1 = getSquare(Row : i, Column : column, address)
	MOV R5, R0;
	MOV R6, R4;
forCol2
						; for (int j = i +1; j < length; j++){
	ADD R6, R6, #1;

	MOV R1, R6;
	MOV R2, R3;
	MOV R0, R8;		
	BL getSquare		 ;value2 = getSquare(Row : j, Column : column, address)
	MOV R7, R0;
	
	CMP R5, R7			; if(value 1 == value 2 && value 1 != 0) return false
	BNE notEq2
	CMP R5, #0;
	BEQ notEq2
	LDR R0,=0;
	B endForCol1		; }
notEq2
	CMP R6, #8;
	BHS endForCol2
	B forCol2
endForCol2

	ADD R4, R4, #1;	
	LDR R0,=1			; returnValue = true (was changed by subroutine getSquare)
; compares with 8 and not 9 because count is incremented after loading the value at that index
	CMP R4, #8;
	BHS endForCol1
	B forCol1			; }
					;	return true
endForCol1
	LDMFD sp!,{R3-R8, pc};	restore registers


; checkSquare subroutine
;gets a row and a column index and checks if the square it is positionned in is valid or not
;	Parameters :
; 	R0 : address
;	R1 : Row index
;	R2 : Column index
;	R0 : boolean output value (1 or 0)
checkSquare
	STMFD sp!, {R3-R11, lr}; save registers
	MOV R11, R0				;address
	MOV R3, R1				; row 
	MOV R4, R2				; column
; getting the indexes to point at the top left of each sub-square	
	CMP R3, #0				; if(row == 0 || row == 3 || row == 6) row = row
	BEQ endRowCheck
	CMP R3, #3;
	BEQ endRowCheck
	CMP R3, #6;
	BEQ endRowCheck
	
	CMP R3, #1				; else if(row ==1 || row == 4 || row ==7) row = row -1
	BEQ rowInPos2
	CMP R3, #4;
	BEQ rowInPos2
	CMP R3, #7;
	BEQ rowInPos2

	CMP R3, #2				; else if( row == 2 || row ==5 || row == 8) row = row - 2
	BEQ rowInPos3
	CMP R3, #5;
	BEQ rowInPos3
	CMP R3, #8;
	BEQ rowInPos3

rowInPos2
	SUB R3, R3, #1;
	B endRowCheck

rowInPos3
	SUB R3, R3, #2;
	B endRowCheck

endRowCheck
	CMP R4, #0				;if(column == 0 || column == 3 || column == 6) column = column
	BEQ endColCheck
	CMP R4, #3;
	BEQ endColCheck
	CMP R4, #6;
	BEQ endColCheck
	
	CMP R4, #1				;if(column == 1 || column == 4 || column == 7) column = column - 1
	BEQ colInPos2
	CMP R4, #4;
	BEQ colInPos2
	CMP R4, #7;
	BEQ colInPos2

	CMP R4, #2				;if(column == 2 || column == 5 || column == 8) column = column - 8
	BEQ colInPos3
	CMP R4, #5;
	BEQ colInPos3
	CMP R4, #8;
	BEQ colInPos3

colInPos2
	SUB R4, R4, #1;
	B endColCheck

colInPos3
	SUB R4, R4, #2;
	B endColCheck

endColCheck
; storing all of the 9 values of the sub-square on the system stack for ease of comparison
	LDR R5,= 0;
forLoopPushValuesOnStack
	CMP R5, #3				; for(int i = 0; i < 3; i++){
	BHS endPushValues
	
	MOV R1, R3				; value1 = getSquare(Row : row, Column : i, address)
	MOV R2, R4
	ADD R2, R2, R5
	MOV R0, R11;		
	BL getSquare
	MOV R7, R0;
	ADD R1, R1, #1			;value2 = getSquare(Row : row+1, Column : i, address)
	MOV R0, R11;		
	BL getSquare
	MOV R8, R0;
	ADD R1, R1, #1;
	MOV R0, R11;			
	BL getSquare			; value3 = getSquare(Row : row+2, Column : i, address)
	MOV R9, R0;
	STMFD sp!, {R7-R9}		; push value1,value2 and value3 on system stack
	ADD R5, R5, #1;
	B forLoopPushValuesOnStack
endPushValues				;  }
	LDR R0,= 1				; tmpReturnValue = true
	LDR R3,= 0;
forFirstForLoop
	CMP	R3, #8				; for(int i = 0; i < 8; i++){
	BHS endFirstForLoop
	
	LDR R6, [sp, R3, LSL #2]; value1 = sp + i * 4
	MOV R4, R3;
	
	CMP R6, #0				; for(int j = i+1; j < 9; i++){
	BEQ endSecondForLoop
	
forSecondForLoop
	ADD R4, R4, #1;
	CMP R4, #9;
	BHS endSecondForLoop

	LDR R7, [sp, R4, LSL #2]; value2 = sp + j * 4
	
	CMP R6, R7				; if(value 1 == value2 && value1 != 0) return false
	BNE notEqualForLoops
	CMP R6, #0;
	BEQ notEqualForLoops
	LDR R0,=0;
	B endFirstForLoop
notEqualForLoops

	B forSecondForLoop		; }
endSecondForLoop
	ADD R3, R3, #1;
	B forFirstForLoop
endFirstForLoop				;  }
	ADD sp, sp, #36			; pop 9 pushed values (9 * 4)
	LDMFD sp!,{R3-R11, pc};	 restore registers

; sudoku subroutine
;automatically fills the sudoku grid using 'brute force', 
;returns if the grid has compeletely been filled or if the grid is not solvable
; Paramteres : 
; 	R0 : address
;	R1 : Row
;	R2 : Column
;	[sp + (number of saved registers + 1 * 4)] : unique (boolean) (also returned (but saved in R1) as it is necessary to determine which text String to display)
;	[sp + (number of saved registers + 1 * 4) + 4] : isNotUnique (boolean)
;	R0 : return boolean value(result)
;	R1 : return (unique)
;	note : here the number of registers saved is 10 (11 with LR) so 11*4 = 44
; we then have [sp + 44] and [sp + 48]
sudoku
	STMFD sp!, {R3-R12, lr}; save registers
	MOV R12, R0;	address
	LDR R11, [sp, #44];	unique
	LDR R10, [sp, #48]; isNotUnique
	
	LDR R0,= 0; result = false;
	MOV R3, R1;row
	MOV R4, R2;column

	MOV R5, R3; nxtrow = row
	MOV R6, R4; nxtcol = col + 1
	ADD R6, R6, #1;
	
	CMP R6, #8; if (nxtcol > 8 ) {
	BLS endIfResetnxtCol
	LDR R6,= 0; nxtcol = 0
	ADD R5, R5, #1; nxtrow++ }
endIfResetnxtCol

	MOV R1, R3;
	MOV R2, R4;
	MOV R0, R12;			
	BL getSquare
	MOV R7, R0; value = getSquare(Row : row, Column : col, address)
	LDR R0,= 0; result = false; (as overwritten by getSquare subroutine)
	CMP R7, #0	; if(value != 0){
	BEQ skipNonZero
	
	CMP R3, #8	; if(row == 8 && col == 8) return true;
	BNE notLastSquare
	CMP R4, #8;
	BNE notLastSquare
	LDR R0,= 1;
	B returnSudokuSubroutine
notLastSquare	
	MOV R1, R5;	else {
	MOV R2, R6; 
	STMFD sp!, {R10, R11}; push parameters unique and isNotUnique on sp
	MOV R0, R12;				
	BL sudoku			;result = sudoku(Row : nxtRow, Column = nxtcol, address, unique, isNotUnique)
	LDMFD sp!,{R10, R11};	 restores the two (updated) parameter registers
	CMP R0, #1;	if(result && unique){
	BNE dontreturn
	CMP R10, #1
	BNE	dontreturn;		
	LDR R10,= 0;	unique = false	
	B returnSudokuSubroutine;	return true	 }
dontreturn	
	
	B returnSudokuSubroutine ; }
skipNonZero		; } else {
	LDR R8,= 1; for(byte i = 1; i <= 9 && !result; i++){
forLoopTry	
	CMP R8, #9
	BHI endForLoopTry
	CMP R0, #1;
	BEQ endForLoopTry
	MOV R0, R8;

	MOV R1, R3;
	MOV R2, R4;
	STR	R12, [sp, #-4]!;	pushing address on system stack (passing as parameter)
	BL setSquare; setSquare(Row : row, Column : col, Value : i, address)
	ADD SP, SP, #4;	pop value off stack
	MOV R1, R3;
	MOV R2, R4;
	MOV R0, R12;					
	BL isValid;	
	MOV R9, R0; isValidResult = isValid(Row : row, Column : col, address)
	LDR R0,= 0; result = false (overwritten by subroutine)
	CMP R9, #1;	if(isValidResult){
	BNE squareNotValid

	CMP R3, #8	; if(row == 8 && col == 8) return true;
	BNE notLastSquare2
	CMP R4, #8;
	BNE notLastSquare2
	LDR R0,= 1;
	B returnSudokuSubroutine
notLastSquare2
	MOV R1, R5;	else {
	MOV R0, R12;					
	MOV R2, R6; result = sudoku(Row : nxtRow, Column = nxtcol, address)
	STMFD sp!, {R10, R11}; push parameters unique and uniqueHasBeenChangedTwice on sp
	BL sudoku			;result = sudoku(Row : nxtRow, Column = nxtcol, address, unique, isNotUnique)
	LDMFD sp!,{R10, R11}	;restores the two (updated) parameter registers
	CMP R11, #0;	if(!uniqueHasBeenChangedTwice){
	BNE squareNotValid

	CMP R0, #1		;if(result){
	BNE squareNotValid	
	CMP R10, #0;		if(!isNotUnique){
	BNE alreadyUnique;	isNotUnique = true;
	LDR R10,= 1;		result = false
	LDR R0,= 0;			
	MOV R1, R12;	copy_grid_to_final_display_grid(currentGrid)
	BL copy_grid_into_grid_to_display; copy current grid into grid to display for result
	B squareNotValid	; }
alreadyUnique	
	CMP R10, #1		; else if(unique){
	BNE squareNotValid
	LDR R0,= 1;		unique = false;
	LDR R10,= 0;	uniqueHasBeenChangedTwice = true
	LDR R11,= 1;	return true;
	B returnSudokuSubroutine
notUniqueAnymore		; }
						;}
squareNotValid;		}
	ADD R8, R8, #1;
	B forLoopTry
endForLoopTry	; }

	CMP R0, #0; if(!result){
	BNE returnSudokuSubroutine
	
	MOV R1, R3;
	MOV R2, R4;
	LDR R0,= 0;	 
	STR	R12, [sp, #-4]!; push address on stack (parameter)

	BL setSquare; setSquare(Row : row, Column : col, Value : i, address)
	ADD SP, SP, #4;	pop value off stack					;  }
returnSudokuSubroutine
	CMP R11, #0;	if(!isNotUnique && unique){
	BNE hasBeenSet;	
	CMP R10, #0;
	BNE hasBeenSet
	MOV R4, R0;		tmpResult = result
	MOV R1, R12;	copy_grid_to_final_display_grid(currentGrid)
	BL copy_grid_into_grid_to_display; copy current grid into grid to display for result
	MOV R0, R4;		result = tmpResult
hasBeenSet			; }
	MOV R1, R10; return : R0 (result) R1 (uniqueSolution)
	STR R11, [sp, #44];	update unique and isNotUnique values in the system stack
	STR R10, [sp, #48];	
	LDMFD sp!,{R3-R12, pc};	 restore registers


; printGrid subroutine
;prints the current sudoku grid
; Parameters : 
;	R1 : address
printGrid
	STMFD sp!, {R3-R4, lr}; save registers
	MOV R4, R1; address
	LDR R3,= 0; row = 0;
forLoopPrint
	CMP R3, #9; for(int row = 0; row < 9; row++){
	BHS stopForPrint
	MOV R1, R3;
	MOV R2, R4;
	BL printRow;	printRow(row, address)
	MOV R0, #10;	print(next line)
	BL sendchar
	ADD R3, R3, #1;
	B forLoopPrint
stopForPrint	;}
	LDR R0,= 10	;   print(next line)
	BL sendchar
	LDMFD sp!,{R3-R4, pc};	 restore registers

; printRow subroutine
;prints the current row in the console
; Parameters :
;	R1 : row index
;	R2 : Address
printRow
	STMFD sp!, {R3-R6, lr}; save registers
	MOV R3, R1; row
	MOV R5, R2;	base Address
	LDR R6,= 9;
	MUL R6, R3, R6;
	ADD R5, R5, R6		;firstAddressOfRow = baseAddress + 9 * rowIndex
	LDR R4,= 0; row = 0;
forColPrint
	CMP R4, #9; for(int i = 0; i < 9; i++){
	BHS stopRowPrint
	LDRB R6, [R5, R4];	value = memory.byte[firstAddressOfRow + i]
	ADD R0, R6, #'0'; value += '0' //converting to ascii value
	BL sendchar;;		print(value)
	LDR R0,= 32;		print(' ')
	BL sendchar
	ADD R4, R4, #1;	}
	B forColPrint
stopRowPrint	
	LDMFD sp!,{R3-R6, pc};	 restore registers


;displayText subroutine 
; displays a null terminated string of characters into the console
; Parameters : 
;	R1 : address of first char to display
displayText
	STMFD sp!, {R3-R5, lr}; save registers
	MOV R3, R1;	address
	LDR R4,= 0; i = 0
displayCharacters;		char = 1 (to get into while loop at the start)	
	LDRB R5, [R3, R4]; while(char != 0)
	CMP R5, #0;			char = memory.byte[address+i]
	BEQ stopReading;	print(char)
	MOV R0, R5;			}
	BL sendchar;}
	ADD R4, R4, #1;
	B displayCharacters
stopReading
	LDR R0,=10;			print(new line)
	BL sendchar
	LDMFD sp!,{R3-R5,pc};	 restore registers
	
;copy_grid_into_grid_to_display subroutine 
; copies a given grid into the grid used to print the final (solved) grid
; Parameters : 
;	R1 : address of grid to copy
copy_grid_into_grid_to_display
	STMFD sp!, {R3-R6, lr}; save registers	
	MOV R3, R1;	address of grid to copy
	LDR R6,= finalGrid;	 address of grid to fill
	LDR R4,= 0;
copyNextValueForLoop	
	CMP R4, #81		;for(int i =0; i < 9*9; i++){
	BHS endCopy
	LDRB R5, [R3, R4]; value = memory.byte[originalgrid base address + i]
	STRB R5, [R6, R4]; memory.byte[gridToFill base address + i] = value
	ADD R4, R4, #1;		}
	B copyNextValueForLoop
endCopy	
	LDMFD sp!,{R3-R6,pc};	 restore registers
	AREA	Grids, DATA, READWRITE
		
;to use a grid change its name to "loadGrid" (or change the addresses loaded in the mainline)

;final grid is used to keep track of the final grid to display as the program finds wheter
;the grid has a unique solution or not
finalGrid
		DCB	0,0,0,0,0,0,0,0,0
		DCB	0,0,0,0,0,0,0,0,0
		DCB	0,0,0,0,0,0,0,0,0
		DCB	0,0,0,0,0,0,0,0,0
		DCB	0,0,0,0,0,0,0,0,0
		DCB	0,0,0,0,0,0,0,0,0
		DCB	0,0,0,0,0,0,0,0,0
		DCB	0,0,0,0,0,0,0,0,0
		DCB	0,0,0,0,0,0,0,0,0

;this grid has multiple solutions
multiSolutionGrid
		DCB	0,0,0,0,0,1,4,0,0
    	DCB	3,0,0,0,0,7,8,0,5
    	DCB	7,9,0,6,0,0,0,1,0
    	DCB	8,0,0,0,0,0,2,5,0
    	DCB	0,0,0,0,0,0,0,0,0
    	DCB	0,0,3,7,0,0,0,0,6
    	DCB	0,2,0,0,0,6,0,3,8
    	DCB	5,0,8,9,0,0,0,0,1
    	DCB	0,0,9,3,0,0,0,0,0

;this grid has a unique solution
uniqueSolutionGrid
		DCB 0,1,9,8,0,0,0,0,6
    	DCB	8,0,0,0,6,0,0,0,0
    	DCB	0,0,6,3,0,0,0,8,2
    	DCB	0,0,1,9,0,0,0,6,5
    	DCB	0,0,4,6,5,0,1,0,0
    	DCB	5,6,0,0,0,8,3,0,0
    	DCB	6,4,0,0,0,7,0,0,0
    	DCB	0,0,0,0,3,0,6,0,4
    	DCB	0,0,0,0,0,6,9,7,0

;provided grids
;to use a grid change its name to "loadGrid" (& remember to change the previous grid's name)

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
		
displayTextNonSolved
		DCB	"Here is the original grid :",0

displayTextFinal
		DCB	"Here is the final grid :",0

uniqueSolution
		DCB	"The solution is unique",0

multipleSolutions
		DCB	"The solution is not unique",0
	END
