format PE console
include "win32ax.inc"

  start:
        mov ecx, 999            ; load the start number to counter
        
  .loop:
        xor edx, edx            ; reset edx. we want 32 bit result, so we are doing 64 bit division
        mov eax, ecx            ; prepare division
        mov ebx, 3              ; load first divisor (3)
        div ebx                 ; divide
        cmp edx, 0              ; check if there is remainder
        jz start.success        ; if not, skip next division

        xor edx, edx            ; again, reset edx
        mov eax, ecx            ; prepare division
        mov ebx, 5              ; load second divisor (5)
        div ebx                 ; divide: edx = eax / ebx
        cmp edx, 0              ; check if there is remainder
        jnz start.skip          ; if so, skip this number
        
  .success:
        add [sum], ecx          ; add number to variable

  .skip:
        dec ecx                 ; decrement counter
        jnz start.loop          ; go to start

        ; print sum using printf function of c
        cinvoke printf, formatstring, [sum]
        invoke  ExitProcess, 0

        formatstring db "%d", 13, 10, 0
        sum dd 0

section '.idata' import data readable

        library msvcrt, 'msvcrt.dll',\
                kernel32, 'kernel32.dll'

        import msvcrt, printf, 'printf'
        import kernel32, ExitProcess, 'ExitProcess'