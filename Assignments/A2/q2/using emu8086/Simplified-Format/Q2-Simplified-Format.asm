
;Q2 using SIMPLIFIED SEGMENT DEFINITION  
      
.MODEL  SMALL
.STACK  64
;--------------------------------------------------
.DATA  
MYDATA  DB 10,20,95,22,25,70,88,61,44,93 ;my array of 10 numbers
;MYDATA  DB 10 DUP(0FFH) another array
SUM     DW 0
AVG     DB ?
MAX     DB ?
MIN     DB ?
;--------------------------------------------------
      .CODE
MAIN    PROC FAR     ;program entry point
        MOV AX,@DATA ;load the data segment address
        MOV DS,AX    ;assign value to DS    
        
        MOV CX, 10   
        MOV SI, 0             
        MOV AH, 0    
        
LOP:    MOV AL, MYDATA[SI] 
        CMP SI, 0  
        JNE MAX_NUM
        MOV MAX, AL 
        MOV MIN, AL
 
MAX_NUM:CMP MAX, AL  ;update max
        JAE MIN_NUM  
        MOV MAX, AL 
        
MIN_NUM:CMP MIN, AL  ;update min
        JBE ADD_NUM
        MOV MIN, AL
        
ADD_NUM:ADD SUM, AX   
        INC SI
        LOOP LOP     ;dec CX and JNZ 
         
AVG_ARR:MOV AX, SUM 
        DIV SI       ;div SUM by 10 to calculate avg of array
        MOV AVG, AL
            
        MOV AH,4CH   ;set up to
        INT 21H      ;return to the OS 
MAIN    ENDP
        END MAIN     ;program exit point
