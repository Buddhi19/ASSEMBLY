; Task1.asm
;
; Created: 22/11/2023 8:44:34 PM
; Author : Buddhi Wijenayake
;

.include "m328pdef.inc"

	.cseg
	.org	0x00 
	; set PD0 as output
	; set PB0 as input

	ldi r16, 0x01					; set 0000,0001
	out DDRD, r16					; set PORTD/0 as output

	ldi r17, 0xFE					; set 1111,1110
	out	DDRB, r17					; set PORTB/0 as input


loop:
	in	r16, PINB					; take inputs port B
	sbrc r16, 0						; continue if r16's 0th bit is set
	rjmp on
	rjmp off
on:
	ldi r17,(1<<PD0)
	out PORTD, r17
	rjmp loop

off:
	ldi r17,0x00
	out PORTD, r17
	rjmp loop


