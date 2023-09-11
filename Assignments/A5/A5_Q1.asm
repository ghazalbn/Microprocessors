
;Q1
      
.MODEL  SMALL
.STACK  2048
;--------------------------------------------------
.DATA  

        X    DW -1
        Y    DW 0  
        curX DW 0
        curY DW 0 
        COLOR DB 0AH
;-------------------------------------------------- 

.CODE 

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


MAIN    PROC FAR     ;program entry point
        MOV AX,@DATA ;load the data segment address
        MOV DS,AX    ;assign value to DS



        MOV AH, 00
        MOV AL, 13H    ; set graphic mode 
        INT 10H
            
        ; reset mouse and get its status:
        MOV AX, 0
        INT 33H
        CMP AX, 0 
        JE EXT              

CHECK:  MOV AX, 3H
        INT 33H 
        
        cmp cx, curX
        jne PRINTP
        cmp dx, curY
        jne PRINTP
        
CONT:   SHR CX, 1 
        CMP BX, 1
        JNE CHANGE 
        JE SET_CLR
CON:    MOV AL, COLOR   ;color
        JMP DRAW
        
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
        
        jmp CONT
          
          
        
SET_CLR:CMP COLOR, 0CH
        JNE NOTRED
        MOV COLOR, 09H  
        JMP CON
        
NOTRED: CMP COLOR, 09H
        JNE NOTBLUE
        MOV COLOR, 0AH  
        JMP CON
        
NOTBLUE:MOV COLOR, 0CH
        JMP CON


CHANGE: cmp X, -1
        je SET
        mov cx, X
        mov dx, Y
        mov ah, 0dh     ; get pixel.
        int 10h
        xor al, 1111b   ; pixel color
        
        mov ah, 0ch     ; set pixel
        int 10h
                  

SET:    mov ah, 0dh     ; get pixel.
        int 10h
        xor al, 1111b   ; pixel color               
        mov X, cx
        mov Y, dx  

 DRAW:  MOV AH, 0CH     ; set pixel
        INT 10H 
                  
      
                
  ESC:  mov dl, 255
        mov ah, 6
        int 21h
        cmp al, 27      
        jne CHECK  
        
        
        ;mov ax, 3 ; back to text mode: 80x25
        ;int 10h  
                
  EXT:  MOV AH,4CH   ;set up to
        INT 21H      ;return to the OS 
MAIN    ENDP
        END MAIN     ;program exit point
