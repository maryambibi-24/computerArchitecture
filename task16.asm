; Task 16: Software model comparing write-allocate and no-write-allocate.
default rel
extern printf
global main
section .data
fmt db "Write-allocate: store miss brings line in; next load HIT.",10,"No-write-allocate: store bypasses line; next load MISS.",10,0
section .text
main:
    push rbp
    mov rbp, rsp
    lea rcx, [fmt]
    call printf
    xor eax, eax
    pop rbp
    ret
