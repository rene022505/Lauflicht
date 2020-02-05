;
; Schiebelicht.asm
;
; Created: 05.02.2020 10:09:55
; Author : rene
;

.def aus = r16
.def an = r17
.def aussen = r18
.def innen = r19
.def lichtR = r20
.def acht = r22
.def input = r21

; PORTA als ausgabe
init:
	ldi aus, 0
	ldi an, 0xFF

	out DDRA, an
	
	out DDRB, aus
	out PORTB, an

	ldi lichtR, 0b00001111

loop:
	;Eingabe einlesen
	in input, PINB
	;Maskieren
	andi input, 0x01
	;Wenn input null ist licht rechts
	brbc SREG_Z, rechts
	;Wenn input !null ist licht links
	jmp links

links:
	ldi acht, 0x08
	acht2:
		;Wait 200ms
		ldi aussen, 0x8F
		aussen2:
			ldi innen, 0xFF
			innen2:
				dec innen
				brbc SREG_Z, innen2
				dec aussen
				brbc SREG_Z, aussen2

		ROL lichtR

		out PORTA, lichtR

		dec acht
		brbc SREG_Z, acht2
	jmp loop

rechts:
	ldi acht, 0x08
	acht1:
		;Wait 200ms
		ldi aussen, 0x8F
		aussen1:
			ldi innen, 0xFF
			innen1:
				dec innen
				brbc SREG_Z, innen1
				dec aussen
				brbc SREG_Z, aussen1

		ROR lichtR

		out PORTA, lichtR

		dec acht
		brbc SREG_Z, acht1
	jmp loop