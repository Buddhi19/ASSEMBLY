; Task2.asm
;
; Created: 23/11/2023 11:19:11 AM
; Author : Buddhi Wijenyake
;

.include	"m328pdef.inc"
	.cseg
	.org	0x00	
		jmp		start
	.org	INT0addr 
		jmp	isr_into

start:
	ldi		r20, 0x00
	ldi		r16, 0x01
	sts		EICRA, r16
	ldi		r16, 0x01
	out		EIMSK, r16
	sei

	ldi		r17, 0x01
	out		DDRD, r17

loop:
	
	rjmp	loop

isr_into:
	in		r16, PIND
	sbrs	r16,2
	rjmp	off
	rjmp	on
	reti
	

on:
	ldi		r16, 0x01
	out		PORTD, r16
	reti

off:
	ldi		r16, 0x00
	out		PORTD, r16
	reti
