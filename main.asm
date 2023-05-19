ldi r16, HIGH(RAMEND)     ; Load immediate "high byte" of RAMEND into r16 - this initializes the stack pointer high byte
out SPH, r16              ; Output the contents of r16 to Stack Pointer High (SPH)
ldi r16, LOW(RAMEND)      ; Load immediate "low byte" of RAMEND into r16 - this initializes the stack pointer low byte
out SPL, r16              ; Output the contents of r16 to Stack Pointer Low (SPL)

ldi r17, 0b00000111       ; Load immediate value '00000111' into r17
out DDRB, r17             ; Set the first three pins of port B as output (Data Direction Register B)

ldi r18, 0b10000000       ; Load immediate value '10000000' into r18
out DDRD, r18             ; Set the eighth pin of port D as input (Data Direction Register D)

begin:                     ; Label for the beginning of the program
ldi r19, 0b00000000
out PORTB, r19            ; Set all pins of port B to zero

rcall DelayT1             ; Call subroutine DelayT1
cbi PORTB, 0              ; Clear the bit 0 of Port B
rcall DelayT1             ; Call subroutine DelayT1 again
rjmp begin                ; Unconditional jump back to the 'begin' label

DelayT1:                  ; Label for the DelayT1 subroutine
ldi r16, 0xfd             ; Load immediate value '0xfd' into r16
sts TCNT1H, r16           ; Store direct from data space (sets Timer/Counter 1 – High Byte to r16 value)
ldi r16, 0x8f             ; Load immediate value '0x8f' into r16
sts TCNT1L, r16           ; Store direct from data space (sets Timer/Counter 1 – Low Byte to r16 value)
ldi r20, 0                ; Load immediate value '0' into r20
sts TCCR1A, r20           ; Set Timer/Counter1 Control Register A to normal mode

ldi r20, 0x04             ; Load immediate value '0x04' into r20 for prescaling of /256
sts TCCR1B, r20           ; Set Timer/Counter1 Control Register B to start timer

loop:                      ; Label for a loop
sbis TIFR1, TOV1          ; Skip if bit in I/O register is set (skip next instruction if TOV1 bit in TIFR1 is set)
rjmp loop                  ; Unconditional jump back to the 'loop' label

ldi r20, 0                ; Load immediate value '0' into r20
sts TCCR1A, r20           ; Stop timer by resetting Timer/Counter1 Control Register A
ldi r20, 1                ; Load immediate value '1' into r20 to clear flag
out TIFR1, r20            ; Output the content of r20 to Timer/Counter 1 Flag Register (TIFR1), effectively resetting the flag
ret                        ; Return from subroutine
