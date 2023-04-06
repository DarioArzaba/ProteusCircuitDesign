/*
 * PracticaReloj.c
 *
 * Created: 19/06/2018 12:35:24 p. m.
 * Author: L00638437   Proyecto a 1MHz
 */
 
 /*
 * PracticaReloj.c
 *
 * Created: 19/06/2018 12:35:24 p. m.
 * Author: L00638437   Proyecto a 1MHz
 */
 
  #asm
    .equ __lcd_port=0x0B   //LCD en PuertoD
    .equ __lcd_EN=3
    .equ __lcd_RS=2
    .equ __lcd_D4=4
    .equ __lcd_D5=5
    .equ __lcd_D6=6
    .equ __lcd_D7=7
   #endasm                
 
#include <io.h>
#include <delay.h>
#include <display.h>


unsigned char i=0;
signed char H=0,M=0,S=0;

void main(void)
{
    CLKPR=0x80;
    CLKPR=0x04;     //Arduino nano trabajara a 16MHz/16=1MHz        
    
    SetupLCD();
    
    TCCR1A=0;
    TCCR1B=0x0A;    //Timer 1 en CTC con CK/8
    OCR1AH=31249/256;
    OCR1AL=31249%256;
    while (1)      // El ciclo completo tarda 0.25seg
    {
       //Imprimir hora en el LCD 
       
       while(TIFR1.OCF1A==0);   //Espera a 0.25seg
       TIFR1.OCF1A=1;           //Borra Bandera
       i++;   
      
       if (i==4)
       {
            i=0;
            S++;
            if (S==60)
            {
                S=0;
                M++;
                if (M==60)
                {   
                    M=0;
                    H++;
                    if (H==24)
                        H=0;
                }     
                
            }
       }
       //Revisar switches 
       
       
    }
}
