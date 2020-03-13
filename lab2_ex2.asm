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
    doi equ 2
    trei equ 3
    cinci equ 5
    zece equ 10
    douazeci equ 20
    zero equ 0
    
    a db 7
    b db 9
    c db 3    
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
    xor eax,eax
    mov eax,zero
    mov ebx,zero
    mov ecx,zero
    mov edx,zero
    
    ;bl = b-a+2
    mov bl,[b]
    sub bl,[a]
    add bl,doi
    
    ;20* bl
    mov al,bl
    mov bl, douazeci
    mov ah, zero
    imul bl; al e implicit 
    mov bx,ax;retinem inmultirea in bx
    
    ;10*c
    mov cl,zece
    mov al,[c]
    mul cl
    mov cx, ax;retinem inmultirea in cx
    
    ;scaderea bx-cx
    sub bx,cx
    
    ;inmultire 3 * bx si apoi impartire
    mov ax,trei
    mul bx
    mov bl,cinci
    div bl
    
    ; rezultat final in ax
    
    
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
