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
    ldx     #$36
    stx     delay
loop
    ldaa    $02
    cmpa    $0
    beq     start
    ldaa    sound
    eora    #$80
    staa    sound
    staa    $BFFF
    ldx     delay
delay_loop
    dex
    cpx     $0
    bne     delay_loop
    ldaa    $FF
    staa    P1DATA
    ldaa    $BFFF
    cmpa    #$FF
    bne     loop
    rts

sound   ds 1
delay   ds 2
