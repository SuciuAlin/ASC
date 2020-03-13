;Cel mai mare divizor comun al unui sir de octeti
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
    sir db 20,40,50,60
    ls equ $-sir
    x db 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
    ;in dl va fi cmmdc
    mov dl, [sir]
    mov esi,1
    mov ecx, ls-1
    ;se fac ls parcurgeri
    Repeta:
        mov al,[sir+esi]
        din_nou:
        cmp al,dl
        je Urmatoru
        
        cmp al,dl
        jb dlMaiMare
        ;daca al e mai mare
        sub al,dl
        jmp din_nou
        dlMaiMare:
        sub dl,al
        jmp din_nou
        
        
        Urmatoru:
        inc esi
    loop Repeta  
    
    mov [x], dl    
        
    
    
        ;pe fiecare pargurgere se fac scaderi repetate din cel mai mare pe cel mai mic pana cand elementele ajung egale
           ; lucrez pe registrii al si dl
    
    
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
