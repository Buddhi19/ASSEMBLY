;
; AssemblerApplication1.asm
;
; Created: 30/10/2023 11:26:35 PM
; Author : msi
;

;turn on and off led

; Replace with your application code
;<label>	<opcode>	<operand>
			

			.include "m328pdef.inc"

			.cseg
			.org	0x00

			ldi		r16, (1<<PB0)	; load 00000001 into register 16
			out		DDRB, r26		; write the value in r16 to DDRB
			out		PORTB, r16		; write the value in r16 to PortB
			
loop:		rjmp	loop

			 
