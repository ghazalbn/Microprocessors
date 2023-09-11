;Q1

ORG 100H

JMP MAIN

oldX DW -1
oldY DW 0
curX DW 0
curY DW 0 
COLOR DB 0AH
    

print macro x, y, attrib, sdat
LOCAL   s_dcl, skip_dcl, s_dcl_end
    pusha
    mov dx, cs
    mov es, dx
    mov ah, 13h
    mov al, 1
    mov bh, 0
    mov bl, attrib
    mov cx, offset s_dcl_end - offset s_dcl
    mov dl, x
    mov dh, y
    mov bp, offset s_dcl
    int 10h
    popa
    jmp skip_dcl
    s_dcl DB sdat
    s_dcl_end DB 0
    skip_dcl:    
endm

print_space macro num
    pusha
    mov ah, 9
    mov al, ' '
    mov bl, 0000_1111b
    mov cx, num
    int 10h
    popa
endm   

print_ax proc
cmp ax, 0
jne print_ax_r
    push ax
    mov al, '0'
    mov ah, 0eh
    int 10h
    pop ax
    ret 
print_ax_r:
    pusha
    mov dx, 0
    cmp ax, 0
    je pn_done
    mov bx, 10
    div bx    
    call print_ax_r
    mov ax, dx
    add al, 30h
    mov ah, 0eh
    int 10h    
    jmp pn_done
pn_done:
    popa  
    ret  
endp



MAIN:   mov ah, 00
        mov al, 13h        ;GRAPHIC MODE 
        int 10h
        
        MOV AX, 0
        INT 33H
        CMP AX, 0
        JE EXT 
        


CHECK:  mov ax, 3
        int 33h 
        
        cmp cx, curX
        jne PRINTP
        cmp dx, curY
        jne PRINTP

CON:    shr cx, 1
        cmp bx, 1
        jne CHANGE: 
        JE SET_CLR
CO:     mov al, COLOR        ;color
        jmp DRAW


PRINTP: print 0,0,0000_1111b,"x="
        mov ax, cx
        call print_ax
        print_space 4
        print 0,1,0000_1111b,"y="
        mov ax, dx
        call print_ax
        print_space 4
        mov curX, cx
        mov curY, dx
        jmp CON  


SET_CLR:CMP COLOR, 0CH
        JNE NOTRED
        MOV COLOR, 09H  
        JMP CO
        
NOTRED: CMP COLOR, 09H
        JNE NOTBLUE
        MOV COLOR, 0AH  
        JMP CO
        
NOTBLUE:MOV COLOR, 0CH
        JMP CO


CHANGE: cmp oldX, -1
        je SET
        push cx
        push dx
        mov cx, oldX
        mov dx, oldY
        mov ah, 0dh     ; get pixel.
        int 10h
        xor al, 1111b   ; pixel color
        mov ah, 0ch     ; set pixel
        int 10h
        pop dx
        pop cx  
        
SET:    mov ah, 0DH     ; get pixel.
        int 10h
        xor al, 1111B   ; pixel color
        mov oldX, cx
        mov oldY, dx  
        
DRAW:   mov ah, 0CH
        int 10H  
        
ESC:    mov dl, 255
        mov ah, 6
        int 21h
        cmp al, 27 
        jne CHECK

EXT: RET



