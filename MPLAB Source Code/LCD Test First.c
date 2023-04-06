#asm
    .equ __lcd_port=0x05
    .equ __lcd_EN=1
    .equ __lcd_RS=0
    .equ __lcd_D4=2
    .equ __lcd_D5=3
    .equ __lcd_D6=4
    .equ __lcd_D7=5
#endasm
#include <io.h>
#include <delay.h>
#include <display.h>                  
char car0[8]={0x0A,0x0A,0x0A,0x00,0x11,0x0E,0x00,0x00};
char car1[8]={0x00,0x15,0x0E,0x1F,0x0E,0x15,0x00,0x00};    
char car2[8]={0x02,0x04,0x0E,0x01,0x0F,0x11,0x0F,0x00};  
void main()
{
    SetupLCD(); 
    CreateChar(0,car0);  
    CreateChar(1,car1);
    CreateChar(2,car2);
    while(1)
    {
        MoveCursor(0,0);
        StringLCD("Clase de Micros");  
        MoveCursor(1,1);
        StringLCD("Invierno 2023");
        delay_ms(2000);
        EraseLCD();
        MoveCursor(2,0);
        StringLCD("Iniciar");
        CharLCD(2);
        StringLCD(" la");  
        MoveCursor(0,1);
        StringLCD("parte pr");
        CharLCD(2);
        StringLCD("ctica");
        CharLCD(0);
        CharLCD(1);
        delay_ms(2000);
        EraseLCD();
    }              
}
