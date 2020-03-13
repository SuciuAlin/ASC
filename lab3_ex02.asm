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
    a dw 3
    b db 5
    c dw 2
    d dd 10
    x dq 15
; our code starts here
segment code use32 class=code
    start:
        ; ...
    mov al,[b]
    cbw 
    imul word[a]
    mov bx,ax
    mov cx,dx
    mov al,[b]
    cbw
    cwd
    div word[c]
    cwde
    push cx
    push bx
    pop ebx
    add ebx,eax
    sub ebx,1
    mov al,[b]
    cbw 
    add ax,[c]
    mov cx,ax
    push ebx
    pop ax
    pop dx
    idiv cx
    cwde
    add eax,[d]
    cdq
    mov ebx, dword[x+0]
    mov ecx, dword[x+4]
    
    sub eax,ebx
    sbb edx,ecx
    
    
    
    
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
