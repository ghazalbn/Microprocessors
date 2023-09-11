
;Q3
      
.MODEL  SMALL
.STACK  64
;--------------------------------------------------
.DATA  

    ASK1   DB 'Enter row: ','$'
    ASK2   DB 'Enter column: ','$'
    ASK3   DB 'Enter the length of the side: ','$'
    X      DW ?       ;X
    Y      DW ?       ;Y
    LEN    DW ?       ;side length
;-------------------------------------------------- 

.CODE  
      
MAIN    PROC FAR     ;program entry point
        MOV AX,@DATA ;load the data segment address
        MOV DS,AX    ;assign value to DS    
        
        
        
INPUT1: MOV AH,09
        MOV DX, OFFSET ASK1
        INT 21H 
        
STORE1: MOV AH,1    ;input function
        INT 21H  
        ;SUB AX,130H
        ;SHL AX,12 
        ;MOV X,AX 
        ;MOV AH,1
        ;INT 21H  
        SUB AX,130H  
        CMP AL,9
        JA YES1
        JMP NO1
  YES1: SUB AX,7
  NO1:  SHL AX,8
        MOV X,AX
        MOV AH,1
        INT 21H 
        SUB AX,130H 
        CMP AL,9
        JA YES2
        JMP NO2
  YES2: SUB AX,7
  NO2:  SHL AX,4 
        ADD X,AX 
        MOV AH,1
        INT 21H  
        SUB AX,130H 
        CMP AL,9
        JA YES3
        JMP NO3
  YES3: SUB AX,7
  NO3:  ADD X,AX 
        
NEWL1:  MOV AH,02
        MOV DX, 13
        INT 21H
        MOV DX, 10
        INT 21H  
        
INPUT2: MOV AH,09
        MOV DX, OFFSET ASK2
        INT 21H 
        
STORE2: MOV AH,1    ;input function
        INT 21H    
        SUB AX,130H  
        CMP AL,9
        JA YES4
        JMP NO4
  YES4: SUB AX,7
  NO4:  SHL AX,8
        MOV Y,AX
        MOV AH,1
        INT 21H 
        SUB AX,130H 
        CMP AL,9
        JA YES5
        JMP NO5
  YES5: SUB AX,7
  NO5:  SHL AX,4 
        ADD Y,AX 
        MOV AH,1
        INT 21H  
        SUB AX,130H 
        CMP AL,9
        JA YES6
        JMP NO6
  YES6: SUB AX,7
  NO6:  ADD Y,AX  
        
NEWL2:  MOV AH,02
        MOV DX, 13
        INT 21H
        MOV DX, 10
        INT 21H          
          
INPUT3: MOV AH,09
        MOV DX, OFFSET ASK3
        INT 21H 
        
STORE3: MOV AH,1
        INT 21H  
        SUB AX,130H  
        CMP AL,9
        JA YES7
        JMP NO7
  YES7: SUB AX,7
  NO7:  SHL AX,8
        MOV LEN,AX
        MOV AH,1
        INT 21H 
        SUB AX,130H 
        CMP AL,9
        JA YES8
        JMP NO8
  YES8: SUB AX,7
  NO8:  SHL AX,4 
        ADD LEN,AX 
        MOV AH,1
        INT 21H  
        SUB AX,130H 
        CMP AL,9
        JA YES9
        JMP NO9
  YES9: SUB AX,7
  NO9:  ADD LEN,AX 
        
NEWL3:  MOV AH,02
        MOV DX, 13
        INT 21H
        MOV DX, 10
        INT 21H
               
CLEAR:  MOV AX,0600H   ;SCROLL THE SCREEN 
        MOV BH,07      ;NORMALATIRIBUTE 
        MOV CX,0000    ;FROM ROW=OO,COLUMN=OO
        MOV DX,184FH   ;TO ROW=18H,COLUMN=4FH
        INT 10H        ;INVOKE INTERRUPT TO CLEAR SCREEN
        MOV AH,00      ;SET MODE 
        MOV AL,13H     ;MODE = 13
        INT 10H        ;INVOKE INTERRUPT TO CHANGE MODE 
        
        MOV CX,Y       ;START LINE AT COLUMN = Y AND 
        MOV DX,X       ;ROW= X
         
 LINE1: MOV AH,0CH     ;AH=OCH TO DRAW A LINE
        MOV AL,01      ;PIXELS = WHITE 
        INT 10H        ;INVOKE INTERRUPT TO DRAW LINE
        INC DX         ;INCREMENT VERTICAL POSITION 
        MOV BX,X
        ADD BX,LEN
        CMP DX,BX      ;DRAW LINE UNTIL ROW = X + LEN 
        JNZ LINE1
 
 LINE2: INT 10H        ;INVOKE INTERRUPT TO DRAW LINE
        INC CX         ;INCREMENT HORIZONTAL POSITION 
        DEC DX         ;DECREMENT VERTICAL POSITION
        CMP DX,X       ;DRAW LINE UNTIL ROW = X 
        JNZ LINE2 
        
 LINE3: INT 10H        ;INVOKE INTERRUPT TO DRAW LINE
        DEC CX         ;INCREMENT VERTICAL POSITION 
        CMP CX,Y       ;DRAW LINE UNTIL COLUMN = Y 
        JNZ LINE3      
          
        
 EXIT:  MOV AH,4CH   ;set up to
        INT 21H      ;return to the OS 
MAIN    ENDP
        END MAIN     ;program exit point
