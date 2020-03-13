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
    ; dx:ax 12345678h
    a dd 12345678h
    ; ecx:ebx 1122334455667788h
    b dq 1122334455667788h
    
    
; our code starts here
segment code use32 class=code
    start:
    ; ...
    
    
    xor eax,eax
    xor ebx,ebx
    xor ecx,ecx
    xor edx,edx
        
    mov dx,word [a+2]
    mov ax,word [a+0]
    
    mov ecx, dword [b + 4]
    mov ebx, dword [b + 0]
    
    
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
