
;Q3
      
.MODEL  SMALL
.STACK  64
;--------------------------------------------------
.DATA  

    a      DW 5678h, 1234h, 5465h, 5 dup(0)  ;a = 5465 1234 5678
    b      DW 1111h, 1111h, 1111h, 5 dup(0)  ;b = 1111 1111 1111
    c      DW 6 dup(?) 
    count  DB 6  
    offset DB 10
;-------------------------------------------------- 

.CODE

MAIN    PROC FAR     ;program entry point
        MOV AX,@DATA ;load the data segment ADDress
        MOV DS,AX    ;asSIgn value to DS   


        LEA SI,a
        LEA BX,b
        LEA DI,c                   
        
        MOV AX,WORD PTR [SI]            
        MUL WORD PTR [BX+0]            
        MOV [DI],AX                   
        MOV CX,DX                       

        MOV AX,WORD PTR [SI+2]          
        MUL WORD PTR [BX+0]             
        ADD CX,AX                      
        MOV [DI+2],CX 
                         
        MOV CX,DX                      
                
 
        MOV AX,WORD PTR [SI+4]         
        MUL WORD PTR [BX+0]             
        ADD CX,AX                      
        MOV [DI+4],CX                   
        
        MOV [DI+6],DX        
        MOV CX,0       
               

        MOV AX,WORD PTR [SI]           
        MUL WORD PTR [BX+2]             
        ADD WORD PTR [DI+2],AX          
        adc CX,DX 
                             
        ADD [DI+4],CX  
        
        MOV CX,0                 

        MOV AX,WORD PTR [SI+2]         
        MUL WORD PTR [BX+2]             
        ADD WORD PTR [DI+4],AX
        adc CX,DX                       
        ADD WORD PTR [DI+6],CX          
        
        MOV CX,0
        
        
        MOV AX,WORD PTR [SI+4]         
        MUL WORD PTR [BX+2]            
        ;ADD CX,AX                   
        ADD WORD PTR [DI+6],AX         
        adc CX,DX  
        
        
        MOV WORD PTR [DI+8],CX
        
        MOV CX,0 
        
        
        MOV AX,WORD PTR [SI]          
        MUL WORD PTR [BX+4]             
        ADD WORD PTR [DI+4],AX         
        adc CX,DX   
        
                         
        ADD [DI+6],CX  
        
        MOV CX,0              

        MOV AX,WORD PTR [SI+2]      
        MUL WORD PTR [BX+4]           
        ADD WORD PTR [DI+6],AX
        adc CX,DX 
                          
        ADD WORD PTR [DI+8],CX        
               
               
               
        MOV CX,0
               
               
               
        
        MOV AX,WORD PTR [SI+4]        
        MUL WORD PTR [BX+4]            
        ADD WORD PTR [DI+8],AX       
        adc DX,0000
        MOV WORD PTR [DI+10],DX   
                  
                  
                  
        MOV SI,10
        ADD SI, DI
LOP:    MOV CX,1000H  
        
        MOV BX,[SI]
PRINT:  MOV AX, BX  
        MOV DX,0
        DIV CX 
        MOV BX,DX    
        CMP AX,9
        JA ABOV
        ADD AX,48 
        JMP BEL 
 ABOV:  ADD AX,55
  BEL:  MOV DX,AX
        MOV AH,02
        INT 21H  
        
        SHR CX,4
        JNZ PRINT 
        DEC SI
        DEC SI
        DEC count
        JNZ LOP
           
           
        MOV AH,02
        MOV DX, 13
        INT 21H
        MOV DX, 10
        INT 21H 
        MOV AH,02
        MOV DX, 13
        INT 21H
        MOV DX, 10
        INT 21H
        
        MOV count,3  
        LEA SI,b
        ADD SI,4 
        
        
        
LOP1:   MOV CX,1000H  
        
        MOV BX,[SI]
DIVP1:  MOV AX, BX  
        MOV DX,0
        DIV CX 
        MOV BX,DX    ;remainder 
        CMP AX,9
        JA CHKA
        ADD AX,48 
        JMP CHKB 
        
        
 CHKA:  ADD AX,55   
 
 
 
 CHKB:  MOV DX,AX
        MOV AH,02
        INT 21H  
        
        SHR CX,4
        JNZ DIVP1 
        DEC SI
        DEC SI
        DEC count
        JNZ LOP1
        
        
        MOV AH,02
        MOV DX, 13
        INT 21H
        MOV DX, 10
        INT 21H 
        MOV AH,02
        MOV DX, 13
        INT 21H
        MOV DX, 10
        INT 21H
        
        MOV count,3  
        LEA SI,a
        ADD SI,4
        
        
LOP2:   MOV CX,1000H  
        
        MOV BX,[SI]
DIVP2:  MOV AX, BX  
        MOV DX,0
        DIV CX 
        MOV BX,DX    ;remainder 
        CMP AX,9
        JA AB  
        
        
        ADD AX,48 
        JMP BELL 
        
        
  AB:   ADD AX,55
  
  
  
  BELL: MOV DX,AX
        MOV AH,02
        INT 21H  
        
        SHR CX,4
        JNZ DIVP2 
        
        DEC SI
        DEC SI
        
        DEC count
        JNZ LOP2 

 EXIT:  MOV AH,4CH   ;set up to
        INT 21H      ;return to the OS 
MAIN    ENDP
        END MAIN     ;program exit point