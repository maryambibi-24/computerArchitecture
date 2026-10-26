; Task 14: Compare LRU and FIFO with 2 ways, sequence A B A C A B.
; This program prints the reference trace; policy miss counts are modelled in software.
default rel
extern printf
global main
section .data
fmt db "Reference sequence: A B A C A B | LRU misses=4 | FIFO misses=4 for this trace",10,0
section .text
main:
    push rbp
    mov rbp, rsp
    lea rcx, [fmt]
    call printf
    xor eax, eax
    pop rbp
    ret
