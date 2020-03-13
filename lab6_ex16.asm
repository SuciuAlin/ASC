;Se dau doua siruri de caractere ordonate alfabetic s1 si s2. Sa se construiasca prin interclasare sirul ordonat s3 care sa contina toate elementele din s1 si s2.

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
    s1 db 'abcdefgm'
    ls1 equ $ - s1
    s2 db 'bghinp'
    ls2 equ $ - s2
    s3 times (ls1+ls2) resb 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
    mov ecx,ls1
    add ecx, ls2; lungimea lui s3 in ecx
    mov esi,0
    mov edi,0
    mov ebp,0
    
    Repeta
    cmp esi,ls1
    je El2
    
    cmp edi, ls2
    je El1
    
    mov al,[s1+esi]
    cmp al,[s2+edi]
    ja ElS2mai_mic
    
    mov [s3+ebp],al
    inc esi
    jmp final_mic
    ElS2mai_mic:
        mov al,[s2+edi]
        mov [s3+ebp],al
        inc edi
        
    final_mic:
    
    jmp final_mediu
    El2:
    mov al,[s2+edi]
    mov [s3+ebp],al
    inc edi
    jmp final_mediu
    
    El1:
        mov al,[s1+esi]
        mov [s3+ebp],al
        inc esi
    
    final_mediu
    inc ebp
    loop Repeta
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
