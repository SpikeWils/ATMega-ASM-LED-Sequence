# AVR Assembly Blinking LEDs Program

This repository contains an AVR Assembly program which controls LEDs connected to the Port B of the microcontroller.

## Description

The program is intended to run on an AVR-based microcontroller. The application initializes the Stack Pointer, sets up specific pins on Port B and Port D as output and input respectively. 

It uses a timer-based delay for controlling the state of LEDs connected to the microcontroller.

## Program Structure

The program contains two main parts:

1. **Initialization**: Stack pointer is initialized, ports are set up correctly.
2. **Main loop (labelled as `begin`)**: This part of the program controls the blinking of LEDs. It sets Port B to zero initially and then enters a loop where it calls a delay subroutine `DelayT1`, toggles the state of the LED, calls the delay again, and repeats the process indefinitely.
3. **DelayT1 subroutine**: This subroutine sets up and starts a timer, then enters a busy loop waiting for the overflow flag `TOV1` to be set, which means the timer has overflowed. Once the overflow occurs, the subroutine stops the timer, clears the overflow flag, and returns to the caller.

## Setup

Make sure to connect your LEDs to the appropriate pins on Port B of your AVR microcontroller.

## Usage

You can assemble and load this program onto your AVR microcontroller using your preferred AVR toolchain and programmer.

For more information on AVR assembly language programming and specific details of the instructions used, please refer to the [AVR Instruction Set Manual](http://ww1.microchip.com/downloads/en/devicedoc/atmel-0856-avr-instruction-set-manual.pdf).
