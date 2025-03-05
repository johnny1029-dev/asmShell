section .bss 
  input_buffer resb 1
  size resd 1
  line resb 256

section .text
  global read_line
  global input_buffer
  global size
  global line

read_line:
  mov dword [size], 0  ; Reset size counter
.read_loop:
  call read
  cmp eax, 0           ; Check if read() returned 0 (EOF)
  je .end_read

  mov al, [input_buffer]  ; Get character read
  mov ebx, [size]         
  mov [line + ebx], al    ; Store character in line buffer
  inc ebx                 
  mov [size], ebx         ; Update size counter

  cmp al, 0xA             ; Check for newline
  je .end_read
  jmp .read_loop

.end_read:
  mov ebx, [size]
  mov byte [line + ebx], 0  ; Null-terminate string
  ret

read: 
  mov eax, 3      ; sys_read
  mov ebx, 0      ; stdin
  mov ecx, input_buffer
  mov edx, 1      ; Max 1 character
  int 0x80
  ret