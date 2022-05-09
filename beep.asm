;
;
; ..\dasm-2.20.14.1-win-x64\dasm.exe beep.asm -f3 -v5 -obeep.bin
;
;

    processor   6803

P1DATA  equ $02
P2DATA  equ $03

    org     $8E00

start
    ldx     delay
    cpx     #$0
    bne     loop
    ldx     #$3C
    stx     delay
loop
    ldaa    sound
    eora    #$80
    staa    sound
    staa    $BFFF
    ldx     delay
delay_loop
    dex
    cpx     #$0
    bne     delay_loop
    ldaa    #$0
    staa    P1DATA
    ldaa    $BFFF
    cmpa    #$FF
    bne     loop
    rts

sound   ds 1
delay   ds 2
