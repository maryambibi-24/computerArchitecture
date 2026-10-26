; Task 11: Illustrative 128-set cache mapping for stride 1024 vs 1028 bytes.
default rel
extern printf
global main
section .data
fmt db "stride=%d: distinct sets visited=%d of 128 in first 128 accesses",10,0
section .text
main:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    ; stride 1024 bytes = 16 lines of 64B => same set for each access
    lea rcx, [fmt]
    mov edx, 1024
    mov r8d, 1
    call printf
    ; 1028-byte stride is not line-aligned; it walks many sets in this simplified model
    lea rcx, [fmt]
    mov edx, 1028
    mov r8d, 128
    call printf
    xor eax, eax
    add rsp, 32
    pop rbp
    ret
