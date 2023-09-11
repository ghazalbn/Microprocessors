#include <mega32.h>
#include <delay.h>
#include <stdint.h>
#include <alcd.h>

#define DHT11_PIN 1
uint8_t c=0, H,;


unsigned char int_to_char(int x)
{
    return x + '0';
}

void put_on_lcd(int value, int c)
{
    unsigned int r = 0;
    unsigned char tens = int_to_char(value / 10);
    unsigned char ones = int_to_char(value % 10);
    lcd_gotoxy(c, r);
    lcd_putchar(tens);
    lcd_gotoxy(c + 1, r);
    lcd_putchar(ones);
}


uint8_t read_h()            
{
    unsigned char q;    
    for (q=0; q<8; q++)
    {
        while(!(PINA & (1<<DHT11_PIN)));  
        delay_us(30);
        if(PINA & (1<<DHT11_PIN))
        	c = (c<<1)|(0x01);  
        else c = (c<<1);
        while(PINA & (1<<DHT11_PIN));
    }
    return c;
}

void main(void)
{   
    DDRB = 0xFF;
     
    lcd_init(16);    
    lcd_gotoxy(0, 0);
    lcd_puts("Humadity: ");
    
    while(1)
    {    
		DDRA |= (1<<DHT11_PIN);
	    PORTA &= ~(1<<DHT11_PIN);    
	    delay_ms(20);            
	    PORTA |= (1<<DHT11_PIN);        
		DDRA &= ~(1<<DHT11_PIN);
	    while(PINA & (1<<DHT11_PIN));
	    while(!(PINA & (1<<DHT11_PIN)));
	    while(PINA & (1<<DHT11_PIN)); 
     
        H = read_h();    
        
    	put_on_lcd(H, 10);        
        lcd_gotoxy(12, 0);
        lcd_puts("%");
        
        if(H < 40 || H > 60)
           PORTB = 0x01;          
        else PORTB = 0x00;
                
    	delay_ms(100);
    }    
}
