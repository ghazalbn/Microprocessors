;A3 Q2 Bakhshande

.MODEL SMALL
 
.STACK 100H 
          
.DATA  
      LEN DW -20D
      NAMES DB 'Ghazal$','Mahdie$','Maedeh$','Ghazal$','Behrad$','Ghazal$','Mahdie$','Mahtab$','Narges$','Mahtab$','Mahtab$','Narges$','Mahtab$','Narges$','Narges$','Narges$','Narges$','Narges$','Narges$','Narges$'
      STR_LEN DB 7H
      COUNTS DB 20 DUP(0)
      COUNT DB 0
     
.CODE
      MAIN PROC
      MOV AX, @DATA
      MOV DS, AX
      
        MOV SI, OFFSET NAMES   
        MOV DI, OFFSET NAMES 
        MOV CX, LEN 
        DEC CL
        MOV DL, 00 
        MOV BP, LEN 
        DEC BP
        JMP LOP  
 
  LOP3: MOV AL, [SI] 
        CMP AL,'$'
        JZ EQ
        CMP AL,[DI]
        JNZ NOTEQ
        INC SI
        INC DI
        JMP LOP3

  EQ:   INC COUNT 
        MOV SI, OFFSET NAMES 
        MOV AX, DX
        MUL STR_LEN
        ADD SI, AX
        INC DI
        JMP LOP2
        
  NOTEQ:MOV SI, OFFSET NAMES  
        MOV AX, DX
        MUL STR_LEN
        ADD SI, AX
        JMP NEXT
        
  NEXT: MOV AL, [DI] 
        CMP AL,'$'
        JZ SET_DI
        INC DI
        JMP NEXT 
        
 SET_DI:INC DI
        JZ LOP2 
        
  LOP2: INC BP 
        JNZ LOP3
        
        MOV DI, DX
        MOV AL, COUNT
        MOV COUNTS[DI], AL 
        MOV COUNT, 00 
        INC DX     
        MOV SI, OFFSET NAMES 
        MOV AX, DX
        MUL STR_LEN
        ADD SI, AX 
        MOV DI, OFFSET NAMES
        MOV BP, LEN
        DEC BP 
        
  LOP:  INC CL
        JNZ LOP2 
        
        
        MOV AH, 4CH
        INT 21H
MAIN ENDP
END