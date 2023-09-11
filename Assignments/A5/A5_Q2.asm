
;Q3
      
.MODEL  SMALL
.STACK  128
;--------------------------------------------------
.DATA  

    from DB "mov from "
    F    DB ?
    to   DB " to "
    T    DB ?
    line DB 0AH, 0DH, '$'
    c    DB 0
;-------------------------------------------------- 

.CODE

Tower MACRO num
        MOV AX, 1
        PUSH AX
        MOV AX, 3
        PUSH AX
        MOV AX, 2
        PUSH AX
        MOV AX, num
        PUSH AX
        CALL hanoi 
      ENDM
    
    
MAIN PROC         ;program entry point
     MOV AX,@DATA ;load the data segment address
     MOV DS,AX    ;assign value to DS 

     Tower 10D    ;macro
    
EXIT: MOV AH,4CH   ;set up to
      INT 21H      ;return to the OS 
MAIN  ENDP

hanoi proc
       push bp
       mov bp, sp
       cmp word ptr ss:[bp+4], 0
       je down
       
       push word ptr ss:[bp+0AH]
       push word ptr ss:[bp+6]
       push word ptr ss:[bp+8]
       mov ax, word ptr ss:[bp+4]
       dec ax
       push ax
       call hanoi
    
       push word ptr ss:[bp+0AH]
       push word ptr ss:[bp+08]
       call print
    
       push word ptr ss:[bp+06H]
       push word ptr ss:[bp+8]
       push word ptr ss:[bp+0AH]
       mov ax, word ptr ss:[bp+4]
       dec ax
       push ax
       call hanoi
    
       pop bp
       ret 8
    down:
       pop bp
       ret 8

hanoi endp 

    
print proc
       push bp
       mov bp, sp
       mov F, '0'
       mov al, byte ptr ss:[bp+06]
       add F, al
       mov T, '0'
       mov al, byte ptr ss:[bp+4]
       add T, al
       lea dx, from
       mov ah, 09
       int 21h
       pop bp
       ret 4
    
print endp
end