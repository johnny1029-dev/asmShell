section .text
global _start
extern read_line
extern line
extern size
extern strcmp
_start:
  call read_line
  mov ecx, line
  mov edx, [size]
  call check_commands
  jmp _start

write: ; rsi message pointer rdx message length
  mov eax, 4       ; sys_write
  mov ebx, 1       ; stdout
  int 0x80
  ret

check_echo:
  cmp byte [ecx], 'e'
  jne .return
  cmp byte [ecx + 1], 'c'
  jne .return
  cmp byte [ecx + 2], 'h'
  jne .return
  cmp byte [ecx + 3], 'o'
  jne .return
  cmp byte [ecx + 4], ' '
  jne .return
  je echo
.return:
  ret

echo:
  add ecx, 5
  sub edx, 5
  call write
  mov eax, 0
  ret

exit:
  mov eax, 1      ; sys_exit
  xor ebx, ebx    ; status = 0
  int 0x80

check_commands:
  mov eax, 1
  mov esi, ecx
  mov edi, exit_command
  call strcmp
  cmp eax, 0
  je exit
  call check_echo
  cmp eax, 0
  jne print_wrong_command
  ret

print_wrong_command:
  mov ecx, wrong_command
  mov edx, wrong_command_length
  call write
  ret


section .data
  exit_command db "exit", 0xA, 0
  wrong_command db "Wrong command", 0xA, 0
  wrong_command_length equ $ - wrong_command

