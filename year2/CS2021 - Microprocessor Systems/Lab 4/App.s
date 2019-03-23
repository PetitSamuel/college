; Definitions  -- references to 'UM' are to the User Manual.
; Timer Stuff -- UM, Table 173
IO0DIR	EQU	0xE0028008 ; pins needed are P0.17, P0.18 and P0.21
IO0SET	EQU	0xE0028004
IO0CLR	EQU	0xE002800C
T0	equ	0xE0004000		; Timer 0 Base Address
T1	equ	0xE0008000

IR	equ	0			; Add this to a timer's base address to get actual register address
TCR	equ	4
MCR	equ	0x14
MR0	equ	0x18

TimerCommandReset	equ	2
TimerCommandRun	equ	1
TimerModeResetAndInterrupt	equ	3
TimerResetTimer0Interrupt	equ	1
TimerResetAllInterrupts	equ	0xFF

; VIC Stuff -- UM, Table 41
VIC	equ	0xFFFFF000		; VIC Base Address
IntEnable	equ	0x10
VectAddr	equ	0x30
VectAddr0	equ	0x100
VectCtrl0	equ	0x200

Timer0ChannelNumber	equ	4	; UM, Table 63
Timer0Mask	equ	1<<Timer0ChannelNumber	; UM, Table 63
IRQslot_en	equ	5		; UM, Table 58

	AREA	InitialisationAndMain, CODE, READONLY
	IMPORT	main

; (c) Mike Brady, 2014 -- 2019.

	EXPORT	start
start
; initialisation code

; Initialise the VIC
	ldr	r0,=VIC			; looking at you, VIC!

	ldr	r1,=irqhan
	str	r1,[r0,#VectAddr0] 	; associate our interrupt handler with Vectored Interrupt 0

	mov	r1,#Timer0ChannelNumber+(1<<IRQslot_en)
	str	r1,[r0,#VectCtrl0] 	; make Timer 0 interrupts the source of Vectored Interrupt 0

	mov	r1,#Timer0Mask
	str	r1,[r0,#IntEnable]	; enable Timer 0 interrupts to be recognised by the VIC

	mov	r1,#0
	str	r1,[r0,#VectAddr]   	; remove any pending interrupt (may not be needed)

; Initialise Timer 0
	ldr	r0,=T0			; looking at you, Timer 0!

	mov	r1,#TimerCommandReset
	str	r1,[r0,#TCR]

	mov	r1,#TimerResetAllInterrupts
	str	r1,[r0,#IR]

	ldr	r1,=(14745600/200)-1	 ; 5 ms = 1/200 second
	str	r1,[r0,#MR0]

	mov	r1,#TimerModeResetAndInterrupt
	str	r1,[r0,#MCR]

	mov	r1,#TimerCommandRun
	str	r1,[r0,#TCR]
	ldr	r1,=IO0DIR
	ldr	r2,=0x00260000	;select select 17, 18, 21
	str	r2,[r1]		;make them outputs
	ldr	r1,=IO0SET
	str	r2,[r1]		;set them to turn the LEDs off
	ldr	r2,=IO0CLR
	MOV R5, #0		;boolean has R4 reached 200
	MOV R4, #0		;count to 200

;from here, initialisation is finished, so it should be the main body of the main program
	ldr	r3,=0x00020000	; start with P0.17
	str	r3,[r2]	   	; clear the bit -> turn on the LED
wloop	
	CMP R5, #1
	BNE loopWait
	CMP R3, #0x00020000
	BNE change2
	str	r3,[r1]		;set the bit -> turn off the LED
	mov	r3,r3,lsl #1	;shift up to next bit.
	str	r3,[r2]	   	; clear the bit -> turn on the LED
	MOV R5, #0
	MOV R4, #0
	B loopWait
change2
	CMP R3, #0x00040000
	BNE change3
	str	r3,[r1]		;set the bit -> turn off the LED
	mov	r3,r3,lsl #3	;shift up to next bit.
	str	r3,[r2]	   	; clear the bit -> turn on the LED
	MOV R5, #0
	MOV R4, #0
	B loopWait
change3
	str	r3,[r1]		;set the bit -> turn off the LED
	mov	r3,r3,lsr #4	;shift up to next bit.
	str	r3,[r2]	   	; clear the bit -> turn on the LED
	MOV R5, #0
	MOV R4, #0
loopWait

	B wloop  		; branch always
;main program execution will never drop below the statement above.

	AREA	InterruptStuff, CODE, READONLY
irqhan	sub	lr,lr,#4
	stmfd	sp!,{r0-r1,lr}	; the lr will be restored to the pc
;this is the body of the interrupt handler
	ADD R4, R4, #1
	CMP R4, #200
	BNE return
	MOV R5, #1
return
;here you'd put the unique part of your interrupt handler
;all the other stuff is "housekeeping" to save registers and acknowledge interrupts


;this is where we stop the timer from making the interrupt request to the VIC
;i.e. we 'acknowledge' the interrupt
	ldr	r0,=T0
	mov	r1,#TimerResetTimer0Interrupt
	str	r1,[r0,#IR]	   	; remove MR0 interrupt request from timer

;here we stop the VIC from making the interrupt request to the CPU:
	ldr	r0,=VIC
	mov	r1,#0
	str	r1,[r0,#VectAddr]	; reset VIC

	ldmfd	sp!,{r0-r1,pc}^	; return from interrupt, restoring pc from lr
				; and also restoring the CPSR

	END