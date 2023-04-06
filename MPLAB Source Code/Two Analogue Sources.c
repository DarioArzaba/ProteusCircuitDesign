/*
 * Examen2Parcial.c
 *
 */

#include <mega328P.h>   
#include <display.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#asm
    .equ __lcd_port=0x8
    .equ __lcd_EN=1
    .equ __lcd_RS=0
    .equ __lcd_D4=2
    .equ __lcd_D5=3
    .equ __lcd_D6=4
    .equ __lcd_D7=5
#endasm

char num;
int D0, D1, D2, D3;

void main(void)
{
    CLKPR=0x80;
    CLKPR=0;
    SetupLCD();
    StringLCD("A01367752 DarioA"); 
    MoveCursor(0,1);
    StringLCD("Numero: ");
    
    // Timer 1
    DDRB.1=1; // Output PB1 for Timer 1
    TCCR1A = 0x40;
    TCCR1B = 0x09;
    OCR1AH = 7999/256;
    OCR1AL = 7999%256;
    
    // Timer 0
    DDRD.6=1; // Output PD6 for Timer 0
    TCCR0A = 0x42;
    TCCR0B = 0X03; 
    OCR0A = 177;
    
    // Timer 2
    DDRB.3=1; // Output PD6 for Timer 0
    TCCR2A = 0x42;
    TCCR2B = 0X04; 
    OCR2A = 247;
    
    PORTD.0 = 1;
    PORTD.1 = 1;
    PORTD.2 = 1;
    PORTD.3 = 1;
    
    while (1)
    {  
        D0 = PIND.0;
        D1 = PIND.1;
        D2 = PIND.2;
        D3 = PIND.3;
        
        if (D3==0&&D2==0&&D1==0&&D0==0) num = 48;
        if (D3==0&&D2==0&&D1==0&&D0==1) num = 49;
        if (D3==0&&D2==0&&D1==1&&D0==0) num = 50;
        if (D3==0&&D2==0&&D1==1&&D0==1) num = 51;
        if (D3==0&&D2==1&&D1==0&&D0==0) num = 52;
        if (D3==0&&D2==1&&D1==0&&D0==1) num = 53;
        if (D3==0&&D2==1&&D1==1&&D0==0) num = 54;
        if (D3==0&&D2==1&&D1==1&&D0==1) num = 55;
        if (D3==1&&D2==0&&D1==0&&D0==0) num = 56;
        if (D3==1&&D2==0&&D1==0&&D0==1) num = 57;
        if (D3==1&&D2==0&&D1==1&&D0==0) num = 65;
        if (D3==1&&D2==0&&D1==1&&D0==1) num = 66;
        if (D3==1&&D2==1&&D1==0&&D0==0) num = 67;
        if (D3==1&&D2==1&&D1==0&&D0==1) num = 68;
        if (D3==1&&D2==1&&D1==1&&D0==0) num = 69;
        if (D3==1&&D2==1&&D1==1&&D0==1) num = 70;
        
        MoveCursor(9,1);
         
        CharLCD(num);

    }
}
