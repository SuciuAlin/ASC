;Se dau doua siruri de caractere ordonate alfabetic s1 si s2. Sa se construiasca prin interclasare sirul ordonat s3 care sa contina toate elementele din s1 si s2.
bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

                       
;lodsb al <- ds:esi

;stosb es:edi <-al
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
    add ecx,ls2; lungimea lui s3 in ecx
    mov esi,s1
    mov ebp,s2
    mov edi,s3 ; adresa de plecare din s3 (necesar pt stosb)
    
    cld
    Repeta:
        cmp esi, s2  ; a ajuns la adresa la care se termina s1
        je El2
        
        cmp ebp, s3  ; a ajuns la adresa la care se termina s 2
        je El1
        
        mov al,[esi]
        cmp al,[ebp]
        ja ElS2mai_mic
        lodsb
        stosb
        jmp final
        ElS2mai_mic:
         xchg esi, ebp
         lodsb
         stosb
         xchg esi, ebp
        
        jmp final
        El2:
         xchg esi,ebp
         lodsb
         stosb
         xchg esi, ebp
         jmp final
        
        
        El1:
        lodsb
        stosb
        final:
    loop Repeta
    
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
