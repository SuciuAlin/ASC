bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    sir dw 3123h,321h,22h,6566h,99h
    ls equ $-sir
    changed db 1
; our code starts here
segment code use32 class=code
    start:
        ; ...
    
    mov esi,0
    
    Repeta_1:
    mov esi,0
    mov byte[changed],0
    
    mov ecx, [ls-1]
        Repeta_for:
        mov ax, word[sir+esi]
        cmp ax, word[sir+esi+1]
        jle urmator_for
        xchg ax, word[sir+esi+1]
        mov byte[changed], 1        
        urmator_for:
        inc esi
    loop Repeta_for
    cmp byte[changed],1
    je Repeta_1
    
    
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
