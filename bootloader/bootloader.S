.equ br_rtos,   0x80001000
.equ br_linux,  0x80200000

.global _start
        .section .text.kernel

_start:
        csrr t0, mhartid
        li t1, 0
        beq t0, t1, hart_0

        li t1, 1
        beq t0, t1, hart_1

        j .


hart_0:   
        li t0, br_rtos
        jr t0

hart_1: 
        li t0, br_linux
        jr t0
