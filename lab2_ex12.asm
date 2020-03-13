bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; a b c d byte
    ; e f g h word
    ; 21
    a db 1
    b db 1
    c db 1
    d db 1
    
    e dw 1
    f dw 1
    g dw 1
    h dw 1
; our code starts here
segment code use32 class=code
    start:
    xor eax,eax
    mov ax,[f]
    mov bx,[g]
    mul bx
    mov ebx,eax
    
    xor eax,eax
    mov al,[a]
    mov cl,[b]
    mul cl
    mov cx,[e]
    mul cx
    sub eax,ecx
    mov ebx,eax
    
    ; c*d
    mov al,[c]
    mov cl,[d]
    mul cl
    mov dx,[h]
    mul dx
    
    mov edx,eax
    mov eax,ebx
    div edx
    
    
    
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
