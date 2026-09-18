global _main
extern _printf

section .data
format db "Value in AL = %d", 10, 0

section .text
_main:

    ; Put decimal 10 into AL.
    ; AL is an 8-bit register.
    mov al, 10

    ; Convert AL to a 32-bit value.
    movzx eax, al

    ; Push value for printf.
    push eax

    ; Push address of format string.
    push format

    ; Call printf.
    call _printf

    ; Remove 8 bytes from stack.
    add esp, 8

    ; Return 0.
    xor eax, eax
    ret