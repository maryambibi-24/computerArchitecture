global _main
extern _printf

section .data

result db 0
format db "AL = %d, BL = %d, Memory = %d", 10, 0

section .text
_main:

    ; Step 1
    ; Put 10 into AL.
    mov al, 10

    ; Step 2
    ; Add 20.
    ; 10 + 20 = 30
    add al, 20

    ; Step 3
    ; Subtract 5.
    ; 30 - 5 = 25
    sub al, 5

    ; Step 4
    ; Store AL in memory.
    mov [result], al

    ; Step 5
    ; Read the value from memory into BL.
    mov bl, [result]

    ; Prepare values for printf.
    movzx eax, al
    movzx ecx, bl
    movzx edx, byte [result]

    ; printf arguments are pushed right to left.
    push edx
    push ecx
    push eax
    push format

    call _printf

    ; Remove four parameters.
    add esp, 16

    ; Return 0.
    xor eax, eax
    ret