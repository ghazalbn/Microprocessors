#include <mega32.h>
#include <alcd.h>
#include <delay.h>      
#include <stdlib.h>
#include <stdio.h>

#define KEYPAD_R1 PORTD.0
#define KEYPAD_R2 PORTD.1
#define KEYPAD_R3 PORTD.2
#define KEYPAD_R4 PORTD.3
#define KEYPAD_C1 PIND.4
#define KEYPAD_C2 PIND.5
#define KEYPAD_C3 PIND.6
#define KEYPAD_C4 PIND.7

#define KEYPAD_NUM0 0
#define KEYPAD_NUM1 1
#define KEYPAD_NUM2 2
#define KEYPAD_NUM3 3
#define KEYPAD_NUM4 4
#define KEYPAD_NUM5 5
#define KEYPAD_NUM6 6
#define KEYPAD_NUM7 7
#define KEYPAD_NUM8 8
#define KEYPAD_NUM9 9

#define EQUAL       '='
#define PLUS        '+'
#define MINUS       '-'
#define DIV         '/'
#define MULT        '*'

#define CLEAR       'c'


#include <mega32.h>
#include <alcd.h>
#include <delay.h>      
#include <stdlib.h>
#include <stdio.h>

#define KEYPAD_R1 PORTD.0
#define KEYPAD_R2 PORTD.1
#define KEYPAD_R3 PORTD.2
#define KEYPAD_R4 PORTD.3
#define KEYPAD_C1 PIND.4
#define KEYPAD_C2 PIND.5
#define KEYPAD_C3 PIND.6
#define KEYPAD_C4 PIND.7

#define KEYPAD_NUM0 0
#define KEYPAD_NUM1 1
#define KEYPAD_NUM2 2
#define KEYPAD_NUM3 3
#define KEYPAD_NUM4 4
#define KEYPAD_NUM5 5
#define KEYPAD_NUM6 6
#define KEYPAD_NUM7 7
#define KEYPAD_NUM8 8
#define KEYPAD_NUM9 9

#define EQUAL       '='
#define PLUS        '+'
#define MINUS       '-'
#define DIV         '/'
#define MULT        '*'

#define CLEAR       'c'

float number[5];
unsigned char operator[4];
int count = 0;
unsigned char OP = 1;

void calculate()
{                           
    char i,j,k;
    char operators[4]={'/','*','-','+'}; 
    unsigned char buffer[16];
    int temp;
    for(k=0;k<4;k++)
    {
        for(i=0;i<count;i++)
        {
            if(operator[i] == operators[k])
            {
                if(k==0) 
                    number[i] = number[i] / number [i+1];
                else if(k==1) 
                    number[i] = number[i] * number [i+1];
                else if(k==2)  
                    number[i] = number[i] - number [i+1];
                else if(k==3) 
                    number[i] = number[i] + number [i+1];
                for(j=i;j<count - 1;j++)
                {
                    number[j+1] = number[j+2];
                    operator[j] = operator[j+1];
                }    
                count --;
            }
        }
        
        
    }   
    temp = number[0];
    sprintf(buffer,"%d", temp);
    lcd_puts(buffer);   
}

unsigned char keypad() {
    unsigned char res = 255;

    KEYPAD_R1 = 1;
    KEYPAD_R2 = 0; 
    KEYPAD_R3 = 0; 
    KEYPAD_R4 = 0;
    
    delay_ms(5);
    if (KEYPAD_C1)
        res = KEYPAD_NUM7;
    else if (KEYPAD_C2)
        res = KEYPAD_NUM8;
    else if (KEYPAD_C3)
        res = KEYPAD_NUM9; 
    else if (KEYPAD_C4)
        res = DIV;     
        
    KEYPAD_R1 = 0;
    KEYPAD_R2 = 1; 
    KEYPAD_R3 = 0;
    KEYPAD_R4 = 0;
    
    delay_ms(5);
    if (KEYPAD_C1)
        res = KEYPAD_NUM4;
    else if (KEYPAD_C2)
        res = KEYPAD_NUM5;
    else if (KEYPAD_C3)
        res = KEYPAD_NUM6;
    else if (KEYPAD_C4)
        res = MULT;

    KEYPAD_R1 = 0;
    KEYPAD_R2 = 0;
    KEYPAD_R3 = 1;
    KEYPAD_R4 = 0;
    
    delay_ms(5);
    if (KEYPAD_C1)
        res = KEYPAD_NUM1;
    else if (KEYPAD_C2)
        res = KEYPAD_NUM2;
    else if (KEYPAD_C3)
        res = KEYPAD_NUM3;  
    else if (KEYPAD_C4)
        res = MINUS;

    KEYPAD_R1 = 0;
    KEYPAD_R2 = 0;
    KEYPAD_R3 = 0;
    KEYPAD_R4 = 1;
    
    delay_ms(5);
    if (KEYPAD_C2)
        res = KEYPAD_NUM0; 
    else if (KEYPAD_C1)
        res = CLEAR;
    else if (KEYPAD_C3)
        res = EQUAL; 
    else if (KEYPAD_C4)
        res = PLUS;

    return res;
}


void main(void) {
    unsigned char key,i;
    DDRC = 0xFF;
    DDRD = 0x0F;
    PORTC = 0x00;

    lcd_init(16);
    lcd_clear();

    while (1) {
        key = keypad();
        
        if (key != 255) {
            while (keypad() != 255);
            delay_ms(20);
            if(key >=0 && key <=9)
            {
            lcd_putchar(key + 48);
            number[count] *= 10;
            number[count] += key;
            OP = 0; 
            }  
            else if(key == 'c')
            {  
                lcd_clear();
                for(i=0;i<5;i++)
                    number[i]=0;
                count = 0;
                OP = 1;
            } 
            else if(key == '=')
            {
                lcd_clear();
                calculate(); 
                for(i=0;i<5;i++)
                    number[i]=0;
                count = 0; 
                OP = 1;
            }  
            else if(!OP)
            {
                OP = 1;
                operator[count] = key;  
                lcd_putchar(key);
                count ++;   
            }
        }
    }
}
