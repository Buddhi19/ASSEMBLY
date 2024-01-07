;assembly part1

.include "m328pdef.inc"
	.def mask 	 = r16						;define mask register
	.def ledR    = r17						;define led register
	.def oLoopR  = r18						;define outerloop register
	.def iLoopRl = r24						;define inner loop register low
	.def iLoopRh = r25						;define inner loop register high
	.equ oVal    = 71						;define outer loop value
	.equ iVal    = 28168					;define inner loop value
	.equ ledpin  = 0						;define led pin number

	.cseg

	.org		0x00						;set instruction command to 0x00
	clr			ledR						;clear led register zero
	ldi			mask,(1<<PB5)				;load the mask register 00100000
	out			DDRB, mask					;turn on PB5 on PORTB as output

start:
	eor			ledR, mask					;XOR (toggle) value in led register
	out			PORTB, ledR
	;sbi			PORTB, ledpin				;set bit immediate 
	ldi			oLoopR, oVal				;initialize outer loop count
	
oLoop:
	ldi			iLoopRl, LOW(iVal)			;initialize inner loop count LOW
	ldi			iLoopRh, HIGH(iVal)			;initialize inner loop count HIGH	

iLoop:
	sbiw		iLoopRl, 1					;decrement inner loop register
	brne		iLoop						;branch to iLoop if iLoop register!=0
	dec			oLoopR						;decrement outer loop register
	brne		oLoop						;branch to oLoop if oLoopR !=0
	rjmp		start						;call back main
