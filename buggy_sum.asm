# File: buggy_sum.s
.section .data
msg:    .asciz "Sum is: "

.section .text
.globl _start

_start:
    movl $5, %eax           # First number = 5
    addl %ebx, %eax         # Add uninitialized EBX to EAX (BUG!)

    # Convert EAX to ASCII and print
    movl %eax, %edi
    movl $buf, %esi
    call int_to_ascii

    # Print "Sum is: "
    movl $4, %eax
    movl $1, %ebx
    movl $msg, %ecx
    movl $8, %edx
    int $0x80

    # Print number
    movl $4, %eax
    movl $1, %ebx
    movl $buf, %ecx
    subl $buf, %esi
    movl %esi, %edx
    int $0x80

    # Print newline
    movl $4, %eax
    movl $1, %ebx
    movl $nl, %ecx
    movl $1, %edx
    int $0x80

    # Exit
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80

# Converts EDI (int) to ASCII string in ESI buffer
int_to_ascii:
    movl $10, %ebx
    movl %esi, %ecx

.convert:
    xorl %edx, %edx
    divl %ebx
    addb $'0', %dl
    movb %dl, (%esi)
    incl %esi
    test %eax, %eax
    jnz .convert

    # Reverse string
    leal -1(%esi), %edx
    movl %ecx, %eax

.reverse:
    cmpl %eax, %edx
    jge .done
    movb (%eax), %bl
    movb (%edx), %bh
    movb %bh, (%eax)
    movb %bl, (%edx)
    incl %eax
    decl %edx
    jmp .reverse

.done:
    ret

.section .bss
buf:    .skip 12
.section .data
nl:     .asciz "\n"
