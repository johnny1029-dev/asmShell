section .text
global strcmp

strcmp:
    cld               ; Clear direction flag
.loop:
    lodsb             ; Load byte from [esi] into AL
    scasb             ; Compare with byte at [edi], increase edi
    jne .not_equal    ; If not equal, exit
    test al, al       ; Check for null terminator
    jnz .loop         ; Keep looping if not null
    xor eax, eax      ; Return 0 (equal)
    ret
.not_equal:
    mov eax, 1        ; Return 1 (not equal)
    ret
