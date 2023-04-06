// Create a program to generate random numbers, use a seed with a timer and a push
// The timer will run permanently generating seeds, the number must be from 0 to 999
// Each time you generate a number turn the buzzer at 400 Hz for 0.2 seconds.

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

unsigned char num;                            
char Cadena[17];
unsigned char i;
void main(void)
{
    CLKPR=0x80;
    CLKPR=0x04;
    SetupLCD();
    StringLCD(" Random Numbers"); 
    PORTC.0=1;  // Pull Up for Push in PB0
    DDRC.1=1;  // Output for Buzzer
    TCCR0B=0x01; // Start timer in CK (1)

    while (1)
    {     
         
        if (PINC.0==0)
        {     
            srand(TCNT0);                                   
            num=rand()%1000;
            sprintf(Cadena,"%003i",num);
            MoveCursor(6,1);
            StringLCDVar(Cadena);
            //Sound at 0.2 seg at 400 Hz
            for (i=0; i<80; i++) 
            {
                PORTC.1=1;
                delay_us(1250);
                PORTC.1=0;
                delay_us(1250);
            }
            //while(PINB.0==0);
            while(PINC.0==0);
        }

    }
}