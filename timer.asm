;
;
; ..\dasm-2.20.14.1-win-x64\dasm.exe timer.asm -f3 -v5 -otimer.bin
;
;

    processor   6803

TCSR    equ $08
TIMER   equ $09
TOCR    equ $0B
TICR    equ $0D   
; set bit 2 of TCSR to enable OCF

    org     $4E00

start
    ldd     #$0800
    std     delay
    ldaa    #126
    staa    16902
    ldx     #timer_ocf
    stx     16903
    cli
    ldaa    #0
    staa    TCSR
    rts

timer_ocf
    ldaa    sound
    eora    #$80
    staa    sound
    staa    49151
    ldd     delay
    addd    TIMER
    bita    TCSR
    std     TOCR
    rti

sound   ds 1
delay   ds 2
