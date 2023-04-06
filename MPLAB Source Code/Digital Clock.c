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

signed char H = 0, M = 0, S = 0;
char Cadena[17];
unsigned int i;
void main(void)
{
    CLKPR=0x80;
    CLKPR=0x04;
    SetupLCD();
    TCCR1A=0x00;
    TCCR1B=0x0A; //Timer 1 CTC CK x 8
    OCR1AH = 31249/256;
    OCR1AL = 31249%256;
    PORTC.0=1;
    PORTC.1=1;
    PORTC.2=1;
    PORTC.3=1;
    PORTC.4=1;
    
    // Cicle every 0.25 seconds
    // Counts Needed = (250000/8)=31250-1
    while (1)
    {
        sprintf(Cadena,"%02i:%02i:%02i",H,M,S);
        MoveCursor(4,0);
        StringLCDVar(Cadena);
        
        while(TIFR1.OCF1A==0); // Wait the 0.25 to finish
        TIFR1.OCF1A=1; //Reset flag
        i++;
        if(i==4)
        {
            i=0;
            S++;
            if(S==60){
                S=0;
                M++;
                if(M==60){
                    M=0;
                    H++;
                    if (H==24) H=0;
                }
            }
        }
        
        if (PINC.0==0 & H<24) {
            H++; 
            if (H==24)
            {
                H=0;
            }     
        } 
        if (PINC.1==0 & H>0) {H--;}
        if (PINC.2==0 & M<60) {
            M++; 
            if (M==60)
            {
                M=0;
                H++;
                if (H==24) H=0;
            } 
        }
        if (PINC.3==0) {
            if (M>0)
            {
                M--;
            } else {
                if (H>0){ H--; M=59; }
            } 
        }
        if (PINC.4==0) {S=0;}    
    
    }
}
