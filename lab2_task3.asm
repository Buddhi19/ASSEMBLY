; Task3.asm
;
; Created: 27/11/2023 9:27:46 PM
; Author : Buddhi Wijenayake
;
.include "m328pdef.inc"
	.cseg
	.org		0x00
		rjmp	setup
	.org		0x02
		rjmp	INT0_ISR

setup:
	ldi			r16, 0xff
	out			DDRD, r16				; set all the pins as output in PORTD
	sbi			DDRC, 0					; set analog pin PC0 as input 
	ldi			r16, 0x00		
	sts			ADMUX, r16				; configure admux with external capacitor at AREF pin 
	ldi			r16, (1<<7)		
	sts			ADCSRA, r16				; enable ADCSRA

loop:
	ldi			r16, (1<<7)|(1<<6)				
	sts			ADCSRA, r16				; start conversion

wait_key:
	lds			r16, ADCSRA
	sbrs		r16, 4					; skip is conversion is complete << ADC INTERRUPT FLAG >>
	rjmp		wait_key
	ldi			r16, (1 << 4)|(1 << 7)
	sts			ADCSRA, r16				; set ADC interrupt flag
	lds			r21, ADCL
	lds			r18, ADCH
	out			PORTD, r21
	rjmp		loop

INT0_ISR:
	reti
