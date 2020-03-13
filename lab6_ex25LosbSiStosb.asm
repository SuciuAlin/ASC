;Se da un sir de octeti. Sa se obtina sirul oglindit al reprezentarii binare a acestui sir de octesi
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
    s DB 01011100b, 10001001b, 11100101b 
    ;sa => d DB 10100111b, 10010001b, 00111010b.
    ls equ $-s
    d times ($-s) db 0
    
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
    mov ecx, ls
    mov esi,s
    mov edi,d+ls-1
    ;parcurg sirul s de la stang ala dreapta
    ;iar sirul d va fi punerea elementelor parcurse din s dar incepand din dreapta si emrgand in stanga
    
    Repeta:
        cld
        lodsb
        std
        stosb
    
    loop Repeta
    
 
    ;oglinditul e practic restul impartirii numarului(in baza 10) la 2, shiftat de fiecare data la stanga
    ;de 8 ori fiind vorba de un octet
    
    mov edi, d
    mov ecx, ls
    
    Repeta_mare:
        mov esi, ecx
        mov ecx, 8
        mov dl,0
        mov al,[edi]
        Repeta_shiftare:
            mov ah,0
            mov bl, 2
            div bl ; incercat fara
            
            
            shl dl, 1
            or dl, ah
        
        loop Repeta_shiftare
        mov [edi], dl
        mov ecx, esi
        inc edi
    loop Repeta_mare
        
    
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
