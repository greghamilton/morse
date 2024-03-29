# morse

Morse code for the MC-10.

Two implementations are provided. 

## Timer

 * morse.txt
 * timer.asm

Sound is generated by the timer OCF interrupt ISR. The tone will play continuously while the interrupt is enabled.

This approach yields an unpleasantly choppy sound at higher frequencies. It is of technical interest but is not recommeneded.

Start the tone.
```
POKE 8,8
```

Stop the tone.
```
POKE 8,0
```

The OCF interrupt occurs when the free running timer value matches the value stored in OCR ($0B). With each interrupt OCR is updated to the current timer value + a configurable delay.

This delay can be modified from BASIC.

```
EN=8:DH=36397:DL=36398
POKE DH,8:REM DELAY HIGH BYTE
POKE DL,0:REM DELAY LOW BYTE
POKE EN,8:REM START TONE
POKE EN,0:REM STOP TONE
```
Use lower values to increase the pitch. Anything less than $0800 sounds a bit harsh to me. Your mileage may vary.

For a pitch approximately equivalent to ```SOUND 200,1``` try ...

```
POKE DH,2
POKE DL,128
```

## Keyboard polling

 * beep.txt
 * beep.asm

Sound is generated for as long as a key is pressed. The assembly code sound function returns control to BASIC when the key is released.

A configurable delay controls the pitch. The quality of the sound is comparable to the output of the BASIC SOUND command.

```
10 DH=36399:DL=36400
15 POKEDL,60:REM SET THE PITCH
20 A$=INKEY$:IFA$=""THEN10
25 EXEC:REM SOUND A TONE FOR AS LONG AS A KEY IS PRESSED
30 GOTO20
```
