.global _start

.equ UART_BASE, 0x10000000
.equ UART_THR,  0x00  # Transmit Holding Register
.equ UART_LSR,  0x05  # Line Status Register
.equ UART_LSR_THRE, 0x20  # THR Empty bit

.section .text
_start:
    
    la a0, hello_string  
    jal ra, uart_puts    

    
    j .


uart_puts:
    li t0, UART_BASE  
1:
    lb t1, (a0)       
    beqz t1, 3f      
2:
    
    lb t2, UART_LSR(t0)
    andi t2, t2, UART_LSR_THRE
    beqz t2, 2b
    
    sb t1, UART_THR(t0)
    addi a0, a0, 1    
    j 1b
3:
    ret

.section .rodata
hello_string:
    .asciz "Hello, from hart 0!\n"
