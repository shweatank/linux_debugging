section .data
    newline db 10, 0             ; newline character
    buffer db '0', 0             ; buffer to hold ASCII digit and null terminator

section .text
    global _start

_start:
    mov ecx, 1                   ; loop counter (start from 1)

.loop:
    cmp ecx, 11                  ; loop until 10 (stop at 11)
    jge .exit

    ; Convert number in ECX to ASCII (only works for 1-9 here)
    mov eax, ecx
    add eax, '0'
    mov [buffer], al

    ; Write digit to stdout
    mov eax, 4                   ; sys_write
    mov ebx, 1                   ; stdout
    mov ecx, buffer              ; buffer to print
    mov edx, 1                   ; print 1 byte
    int 0x80

    ; Print newline
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    inc ecx                      ; increment loop counter
    jmp .loop

.exit:
    ; Exit program
    mov eax, 1                   ; sys_exit
    xor ebx, ebx
    int 0x80
