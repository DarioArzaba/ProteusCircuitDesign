#asm
    .equ __lcd_port=0x0B
    .equ __lcd_EN=3
    .equ __lcd_RS=2
    .equ __lcd_D4=4
    .equ __lcd_D5=5
    .equ __lcd_D6=6
    .equ __lcd_D7=7
#endasm

#include <mega328p.h>
#include <delay.h>
#include <display.h>   
#include <stdio.h>
#include <stdlib.h>

unsigned int num = 995;                            
char Cadena[17];
void main(void)
{
    CLKPR=0x80;
    CLKPR=0x04;
    SetupLCD();
    StringLCD(" People Counter"); 
    PORTC.0=1;
    PORTC.1=1;
    PORTC.2=1;
    sprintf(Cadena,"%003i",num);
    MoveCursor(6,1);
    StringLCDVar(Cadena);

    while (1)
    {     
         
        if (PINC.0==0)
        {
            //Clear Counter
            num = 0;
            sprintf(Cadena,"%003i",num);
            MoveCursor(6,1);
            StringLCDVar(Cadena);
            delay_ms(30); // Delay for bounce when PRESSING
            while (PINC.0==0); //Ignore everything until first RELEASE
            delay_ms(10); // Delay for bounce at RELEASE
        }
           
        if (PINC.1==0)
        {
            //If not at 0 minus one
            if (num > 0)
            {
                num--;
                sprintf(Cadena,"%003i",num);
                MoveCursor(6,1);
                StringLCDVar(Cadena);
            }
            delay_ms(30); // Delay for bounce when PRESSING
            while (PINC.1==0); //Ignore everything until first RELEASE
            delay_ms(10); // Delay for bounce at RELEASE
        }
        
             
        if (PINC.2==0)
        {
            //If not at 999 add one
            if (num < 999)
            {
                num++;
                sprintf(Cadena,"%003i",num);
                MoveCursor(6,1);
                StringLCDVar(Cadena);
            }
            delay_ms(30); // Delay for bounce when PRESSING
            while (PINC.2==0); //Ignore everything until first RELEASE
            delay_ms(10); // Delay for bounce at RELEASE
        }  
     

    }
}