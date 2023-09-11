
;Q2
      
.MODEL  SMALL
.STACK  64
;--------------------------------------------------
.DATA  

    ASK1   DB 'Enter numbers1: ','$'
    ASK2   DB 'Enter numbers2: ','$'
    MENU   DB 'Enter one of the following numbers:','$'
    OP0    DB '0: Add','$'
    OP1    DB '1: Sub(absolute value)','$'  
    OP2    DB '2: Multiply','$'
    OP3    DB '3: Divide(larger number by the smaller number)','$'
    OP4    DB '4: Exit','$' 
    CHOICE DB ?
    NUM1   DW ?       ;number 1
    NUM2   DW ?       ;number 2 
    TMP    DW ?
;-------------------------------------------------- 

.CODE  
      
MAIN    PROC FAR     ;program entry point
        MOV AX,@DATA ;load the data segment address
        MOV DS,AX    ;assign value to DS    
        
        ;input number 1 and store it in NUM1
        
INPUT1: MOV AH,09
        MOV DX, OFFSET ASK1
        INT 21H 
        
STORE1: MOV AH,1    ;input function
        INT 21H  
        SUB AX,130H
        CMP AL,9
        JA YES1
        JMP NO1
  YES1: SUB AX,7
  NO1:  SHL AL,4 
        MOV AH,0
        MOV NUM1,AX 
        MOV AH,1
        INT 21H  
        SUB AX,130H
        CMP AL,9
        JA YES2
        JMP NO2
  YES2: SUB AX,7
   NO2: ADD NUM1,AX 
        
NEWL1:  MOV AH,02
        MOV DX, 13
        INT 21H
        MOV DX, 10
        INT 21H
        
        ;input number 2 and store it in NUM2

INPUT2: MOV AH,09
        MOV DX, OFFSET ASK2
        INT 21H 
        
STORE2: MOV AH,1    ;input function
        INT 21H  
        SUB AX,130H
        CMP AL,9
        JA YES3
        JMP NO3
  YES3: SUB AX,7
  NO3:  SHL AL,4 
        MOV AH,0
        MOV NUM2,AX 
        MOV AH,1
        INT 21H  
        SUB AX,130H
        CMP AL,9
        JA YES4
        JMP NO4
  YES4: SUB AX,7
   NO4: ADD NUM2,AX 
        
NEWL2:  MOV AH,02
        MOV DX, 13
        INT 21H
        MOV DX, 10
        INT 21H
        MOV AH,02
        MOV DX, 13
        INT 21H
        MOV DX, 10
        INT 21H 
        
        ;display menu
        
MYMENU: MOV AH,09
        MOV DX, OFFSET MENU
        INT 21H  
        
NEWL3:  MOV AH,02
        MOV DX, 13
        INT 21H
        MOV DX, 10
        INT 21H
        
        MOV AH,09
        MOV DX, OFFSET OP0
        INT 21H    
        
NEWL4:  MOV AH,02
        MOV DX, 13
        INT 21H
        MOV DX, 10
        INT 21H
        
        MOV AH,09
        MOV DX, OFFSET OP1
        INT 21H 
        
NEWL5:  MOV AH,02
        MOV DX, 13
        INT 21H
        MOV DX, 10
        INT 21H
         
        MOV AH,09
        MOV DX, OFFSET OP2
        INT 21H 
       
NEWL6:  MOV AH,02
        MOV DX, 13
        INT 21H
        MOV DX, 10
        INT 21H
         
        MOV AH,09
        MOV DX, OFFSET OP3
        INT 21H 
        
NEWL7:  MOV AH,02
        MOV DX, 13
        INT 21H
        MOV DX, 10
        INT 21H
        
        MOV AH,09
        MOV DX, OFFSET OP4
        INT 21H
        
NEWL8:  MOV AH,02
        MOV DX, 13
        INT 21H
        MOV DX, 10
        INT 21H
        
INPUT3: MOV AH,1    ;input function
        INT 21H 
        MOV CHOICE,AL  
        
NEWL9:  MOV AH,02
        MOV DX, 13
        INT 21H
        MOV DX, 10
        INT 21H
        MOV AH,02
        MOV DX, 13
        INT 21H
        MOV DX, 10
        INT 21H
        
CHOOSE: MOV AL,CHOICE
        CMP AL,30H
        JZ MYADD
        CMP AL,31H
        JZ MYSUB 
        CMP AL,32H
        JZ MYMUL
        CMP AL,33H
        JZ MYDIV
        JMP EXIT

MYADD:  MOV AX,NUM1
        ADD AX,NUM2  
        MOV BX,AX 
        MOV CX,100H
        JMP PRINT1  
            
            
MYSUB:  MOV AX,NUM1
        CMP AX,NUM2 
        JB SWAP
        SUB AX,NUM2
        JMP CONT 
        
SWAP:   MOV AX,NUM2
        SUB AX,NUM1 
        
CONT:   MOV BX,AX 
        MOV CX,10H
        JMP PRINT1
             
             
MYMUL:  MOV AX,NUM1
        MUL NUM2 
        MOV BX,AX 
        MOV CX,1000H
        JMP PRINT1
        
PRINT1: MOV AX, BX  
        MOV DX,0
        DIV CX 
        MOV BX,DX    ;remainder 
        CMP AX,9
        JA ABOV
        ADD AX,48 
        JMP BEL 
 ABOV:  ADD AX,55
  BEL:  MOV DX,AX
        MOV AH,02
        INT 21H  
        SHR CX,4
        JNZ PRINT1 
        JMP EXIT 
        
MYDIV:  MOV DX,0
        MOV AX,NUM1
        CMP AX,NUM2 
        JB SWAP2
        DIV NUM2
        JMP CONT2 
        
SWAP2:  MOV AX,NUM2
        DIV NUM1 
        
CONT2:  MOV BX,AX 
        MOV TMP,DX
        MOV CX,10H
        JMP PRINTD
        
PRINTD: MOV AX, BX  
        MOV DX,0
        DIV CX 
        MOV BX,DX    ;remainder 
        CMP AX,9
        JA ABOV2
        ADD AX,48 
        JMP BEL2
 ABOV2: ADD AX,55
  BEL2: MOV DX,AX
        MOV AH,02
        INT 21H  
        SHR CX,4
        JNZ PRINTD  
        
NEWL10:  MOV AH,02
        MOV DX, 13
        INT 21H
        MOV DX, 10
        INT 21H
        
        MOV BX,TMP
        MOV CX,10H
PRINTR: MOV AX, BX  
        MOV DX,0
        DIV CX 
        MOV BX,DX    ;remainder 
        CMP AX,9
        JA ABOV3
        ADD AX,48 
        JMP BEL3 
 ABOV3: ADD AX,55
  BEL3: MOV DX,AX
        MOV AH,02
        INT 21H  
        SHR CX,4
        JNZ PRINTR 
        JMP EXIT  

        
        
 EXIT:  MOV AH,4CH   ;set up to
        INT 21H      ;return to the OS 
MAIN    ENDP
        END MAIN     ;program exit point
