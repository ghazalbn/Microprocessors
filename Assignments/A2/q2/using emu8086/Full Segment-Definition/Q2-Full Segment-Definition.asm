
;Q2 using FULL SEGMENT DEFINITION

STSEG   SEGMENT
DB 64   DUP (?)
STSEG   ENDS
;--------------------------------------------------
DTSEG   SEGMENT
MYDATA  DB 10,20,95,22,25,70,88,61,44,93 ;my array of 10 numbers
SUM     DW 0
AVG     DB ?
MAX     DB ?
MIN     DB ?
DTSEG   ENDS
;--------------------------------------------------
CDSEG   SEGMENT
MAIN    PROC FAR        ;program entry point
        ASSUME CS:CDSEG,DS:DTSEG,SS:STSEG
        MOV AX,DTSEG    ;load the data segment address 
        MOV DS, AX
        
        MOV CX, 10   
        MOV SI, 0             
        MOV AH, 0    
        
LOP:    MOV AL, MYDATA[SI] 
        CMP SI, 0  
        JNE MAX_NUM
        MOV MAX, AL 
        MOV MIN, AL
 
MAX_NUM:CMP MAX, AL     ;update max
        JAE MIN_NUM  
        MOV MAX, AL 
        
MIN_NUM:CMP MIN, AL     ;update min
        JBE ADD_NUM
        MOV MIN, AL
        
ADD_NUM:ADD SUM, AX     
        INC SI
        LOOP LOP        ;dec CX and JNZ 
         
AVG_ARR:MOV AX, SUM 
        DIV SI          ;div SUM by 10 to calculate avg of array
        MOV AVG, AL 
        
        MOV AH,4CH      ;set up to
        INT 21H         ;return to the DOS
MAIN    ENDP
CDSEG   ENDS
        END MAIN        ;program exit point
