#asm
    .equ __lcd_port=0x05
    .equ __lcd_EN=1
    .equ __lcd_RS=0
    .equ __lcd_D4=2
    .equ __lcd_D5=3
    .equ __lcd_D6=4
    .equ __lcd_D7=5
#endasm
#include <mega328p.h>
#include <delay.h>
#include <display.h>   
#include <stdio.h>
unsigned char M=0, S=0, D=0, G=0;
char car0[8]={0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00};
char car1[8]={0x0E,0x0E,0x04,0x1F,0x04,0x04,0x0A,0x0A};
char car2[8]={0x06,0x06,0x14,0x0E,0x05,0x04,0x0A,0x12};
char car3[8]={0x0C,0x0C,0x05,0x0E,0x14,0x04,0x0A,0x09};
char Cadena[17];
void main(void)
{
    SetupLCD(); 
    CreateChar(0,car0); // Blank  
    CreateChar(1,car1); // Stationary
    CreateChar(2,car2); // Running to Right
    CreateChar(3,car3); // Running to Left
    PORTD.0=1;
    PORTD.1=1;
    while (1)
    {
        sprintf(Cadena,"%02i:%02i:%i",M,S,D);
        MoveCursor(4,0);
        StringLCDVar(Cadena);
        delay_ms(62);  //0.1 Seconds Adjustment 
        delay_us(350);
        // When pressing the switch stop the increment
        if (PIND.0==0) 
        {
            switch (G) 
            {
                case 0: MoveCursor(7,1); CharLCD(0); MoveCursor(8,1); CharLCD(1); break;
                case 1: MoveCursor(8,1); CharLCD(0); MoveCursor(9,1); CharLCD(2); break;
                case 2: MoveCursor(9,1); CharLCD(0); MoveCursor(10,1); CharLCD(2); break;
                case 3: MoveCursor(10,1); CharLCD(0); MoveCursor(11,1); CharLCD(2); break;
                case 4: MoveCursor(11,1); CharLCD(0); MoveCursor(12,1); CharLCD(2); break;
                case 5: MoveCursor(12,1); CharLCD(0); MoveCursor(13,1); CharLCD(2); break;
                case 6: MoveCursor(13,1); CharLCD(0); MoveCursor(14,1); CharLCD(2); break;
                case 7: MoveCursor(14,1); CharLCD(0); MoveCursor(15,1); CharLCD(1); break;
                case 8: MoveCursor(15,1); CharLCD(0); MoveCursor(14,1); CharLCD(3); break;
                case 9: MoveCursor(14,1); CharLCD(0); MoveCursor(13,1); CharLCD(3); break;
                case 10: MoveCursor(13,1); CharLCD(0); MoveCursor(12,1); CharLCD(3); break;
                case 11: MoveCursor(12,1); CharLCD(0); MoveCursor(11,1); CharLCD(3); break;
                case 12: MoveCursor(11,1); CharLCD(0); MoveCursor(10,1); CharLCD(3); break;
                case 13: MoveCursor(10,1); CharLCD(0); MoveCursor(9,1); CharLCD(3); break;
                case 14: MoveCursor(9,1); CharLCD(0); MoveCursor(8,1); CharLCD(3); break;
                case 15: MoveCursor(8,1); CharLCD(0); MoveCursor(7,1); CharLCD(3); break;
                case 16: MoveCursor(7,1); CharLCD(0); MoveCursor(6,1); CharLCD(3); break;
                case 17: MoveCursor(6,1); CharLCD(0); MoveCursor(5,1); CharLCD(3); break;
                case 18: MoveCursor(5,1); CharLCD(0); MoveCursor(4,1); CharLCD(3); break;
                case 19: MoveCursor(4,1); CharLCD(0); MoveCursor(3,1); CharLCD(3); break;
                case 20: MoveCursor(3,1); CharLCD(0); MoveCursor(2,1); CharLCD(3); break;
                case 21: MoveCursor(2,1); CharLCD(0); MoveCursor(1,1); CharLCD(3); break;
                case 22: MoveCursor(1,1); CharLCD(0); MoveCursor(0,1); CharLCD(1); break;
                case 23: MoveCursor(0,1); CharLCD(0); MoveCursor(1,1); CharLCD(2); break;
                case 24: MoveCursor(1,1); CharLCD(0); MoveCursor(2,1); CharLCD(2); break;
                case 25: MoveCursor(2,1); CharLCD(0); MoveCursor(3,1); CharLCD(2); break;
                case 26: MoveCursor(3,1); CharLCD(0); MoveCursor(4,1); CharLCD(2); break;
                case 27: MoveCursor(4,1); CharLCD(0); MoveCursor(5,1); CharLCD(2); break;
                case 28: MoveCursor(5,1); CharLCD(0); MoveCursor(6,1); CharLCD(2); break;
                case 29: MoveCursor(6,1); CharLCD(0); MoveCursor(7,1); CharLCD(2); break;
            }
            D++;
            G++; 
        }
        if (G==30)
        {
            G=0;
        }
        // If increment is active then continue adding
        if (D==10) 
        {
            D=0;
            S++;
            if(S==60)
            {
                S=0;
                M++;
                if(M==60)
                {
                    M=0;
                }
            }
        }       
        // When pressing push restart timer
        if (PIND.1 ==0) 
        {
            M=0;
            S=0;
            D=0;
            G=0;
            EraseLCD();
        }
    }
}
