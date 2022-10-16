ldi r16, HIGH(RAMEND)		;initialise stack pointer
out SPH, r16
ldi r16, LOW(RAMEND)
out SPL, r16

ldi r17, 0b00000111
out DDRB, r17				;set PortB pins 0,1,2 as output
ldi r18, 0b10000000
out DDRD, r18				;set PortD pin 7 as input


begin:						;program start
ldi r19, 0b00000000	
out PORTB, r19				;set portB to zero



rcall DelayT1
cbi PORTB, 0
rcall DelayT1
rjmp begin

DelayT1:
ldi r16, 0xfd
sts TCNT1H, r16
ldi r16, 0x8f
sts TCNT1L, r16
ldi r20, 0
sts TCCR1A, r20				;timer counter 1 normal mode
ldi r20, 0x04				;prescaling of /256
sts TCCR1B, r20				;start timer one

loop:
sbis TIFR1, TOV1
rjmp loop
ldi r20, 0
sts TCCR1A, r20				;stop timer
ldi r20, 1					;clear flag
out TIFR1, r20				;reset flag
ret