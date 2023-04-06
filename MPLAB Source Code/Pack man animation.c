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
#define ADC_VREF_TYPE ((0<<REFS1) | (1<<REFS0) | (0<<ADLAR)) // ADV Voltage Ref

unsigned int read_adc(unsigned char adc_input) {
    // Used to Read the Conversion Result
    ADMUX=adc_input | ADC_VREF_TYPE;
    delay_us(10); // ADC Input Voltage Stabilization Delay
    ADCSRA|=(1<<ADSC); // Start Conversion
    while ((ADCSRA & (1<<ADIF))==0); // Wait for Conversion to finish
    ADCSRA|=(1<<ADIF);
    return ADCW;
}

void delayPacMan() {
    delay_ms(read_adc(0)/4);
} 

void message() 
{
   MoveCursor(5,0);
   StringLCD("Hello");
   MoveCursor(3,1);
   StringLCD("Mr. PacMan");
}

unsigned char PacMan1[8]={0x0E,0x1D,0x1E,0x1C,0x1E,0x1F,0x0E,0x00}; // Open Right
unsigned char PacMan2[8]={0x0E,0x1D,0x1F,0x1E,0x1F,0x1F,0x0E,0x00}; // Closed Right
unsigned char PacMan3[8]={0x0E,0x17,0x1F,0x0F,0x1F,0x1F,0x0E,0x00}; // Open Left
unsigned char PacMan4[8]={0x0E,0x17,0x1F,0x1F,0x1F,0x1F,0x0E,0x00}; // Closed Left
signed char i = 0;
signed char G = 0;
signed char T = 0;
void main(void)
{
    CLKPR=0x80;
    CLKPR=0x04;
    
    ADMUX=ADC_VREF_TYPE; // ADC Voltage Reference: AVCC pin 
    // Digital input buffers on ADC0: On, ADC1: On, ADC2: On, ADC3: On, ADC4: Off, ADC5: On
    DIDR0=(0<<ADC5D) | (0<<ADC4D) | (0<<ADC3D) | (0<<ADC2D) | (0<<ADC1D) | (1<<ADC0D);
    // ADC Auto Trigger Source: ADC Stopped
    ADCSRA=(1<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (0<<ADPS2) | (1<<ADPS1) | (1<<ADPS0);
    ADCSRB=(0<<ADTS2) | (0<<ADTS1) | (0<<ADTS0);  

    SetupLCD();

    CreateChar(0,PacMan1);
    CreateChar(1,PacMan2); 
    CreateChar(2,PacMan3);
    CreateChar(3,PacMan4); 
    
    PORTC.1=1;

    while (1)
    {
        message();
        if (PINC.1==0&T==0) {T=1;}
        if (PINC.1==1&T==0) {T=3; G=15;}
        if (T==1){
            for (i=G;i<16;i++)
            {
                G++;
                if (PINC.1==1) {T=3; G--; G--; break;} // If right up (1) toggle go to (3)
                MoveCursor(i,0);
                CharLCD(0);
                delayPacMan();
                MoveCursor(i,0);
                CharLCD(1);
                delayPacMan();           
                MoveCursor(i,0);
                CharLCD(' ');
            }
            if (T==1) {T=2;} // If right up (1) end same go to (2)
        }
        if (T==2){
            for (i=G;i>=0;i--)               
            {
                G--;
                if (PINC.1==1) {T=4; G++; G++; break;} // If left down (2) toggle go to right down (4)
                MoveCursor(i,1);
                CharLCD(2); 
                delayPacMan();
                MoveCursor(i,1);
                CharLCD(3);
                delayPacMan();           
                MoveCursor(i,1);
                CharLCD(' '); 
         
            }
            if (T==2) {T=0;} // If left down (2) end then go to end 
        }
        if (T==3){
            for (i=G;i>=0;i--)               
            {
                G--; 
                if (PINC.1==0) {T=1; G++; G++; break;} // If left up (3) toggle go to (1)
                MoveCursor(i,0);
                CharLCD(2);
                delayPacMan();
                MoveCursor(i,0);
                CharLCD(3);
                delayPacMan();           
                MoveCursor(i,0);
                CharLCD(' ');
            }
            if (T==3) {T=4;} // If left up (3) end same go to (4)
        }
        if (T==4){
            for (i=G;i<16;i++)
            {
                G++;
                if (PINC.1==0) {T=2; G--; G--; break;} // If right down (4) toggle go to left down (2)
                MoveCursor(i,1);
                CharLCD(0);
                delayPacMan();
                MoveCursor(i,1);
                CharLCD(1);
                delayPacMan();           
                MoveCursor(i,1);
                CharLCD(' ');              
            }
            if (T==4) {T=0;} // // If right down (4) end then go to end 
        }
    }
}
