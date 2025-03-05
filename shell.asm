section .text
global _start
extern read_line
extern line
extern size
_start:
  call read_line
  mov ecx, line
  mov edx, [size]
  call check_exit
  call write
  jmp _start

write: ; rsi message pointer rdx message length
  mov eax, 4       ; sys_write
  mov ebx, 1       ; stdout
  int 0x80
  ret

check_exit:
  cmp edx, 5
  jne .return
  cmp byte [ecx], 'e'
  jne .return
  cmp byte [ecx + 1], 'x'
  jne .return
  cmp byte [ecx + 2], 'i'
  jne .return
  cmp byte [ecx + 3], 't'
  jne .return
  je exit
.return:
  ret

exit:
  mov eax, 1      ; sys_exit
  xor ebx, ebx    ; status = 0
  int 0x80