// CONFIG
#pragma config FOSC = XT        // Oscillator Selection bits (XT oscillator)
#pragma config WDTE = OFF       // Watchdog Timer Enable bit (WDT disabled)
#pragma config PWRTE = OFF      // Power-up Timer Enable bit (PWRT disabled)
#pragma config BOREN = OFF      // Brown-out Reset Enable bit (BOR disabled)
#pragma config LVP = OFF        // Low-Voltage (Single-Supply) In-Circuit Serial Programming Enable bit (RB3 is digital I/O, HV on MCLR must be used for programming)
#pragma config CPD = OFF        // Data EEPROM Memory Code Protection bit (Data EEPROM code protection off)
#pragma config WRT = OFF        // Flash Program Memory Write Enable bits (Write protection off; all program memory may be written to by EECON control)
#pragma config CP = OFF         // Flash Program Memory Code Protection bit (Code protection off)

#define _XTAL_FREQ 4000000
#define __delay_ms(x) _delay((unsigned long)((x)*(_XTAL_FREQ/4000.0)))

#include <xc.h>
#include <stdio.h>
#include <stdlib.h>

int aux=0;

void __interrupt() ISR(void)
{
    __delay_ms(10);
    
    if(aux==1)
        aux=0;
    else
        aux=1;
    
    INTCONbits.INTF=0;
    
    return;
}

int main(int argc, char** argv) {

    ADCON1=6;
    TRISA=0;
    TRISB=1;
    TRISC=0;
    TRISD=0;
    TRISE=0;
    PORTA=0;
    PORTB=0;
    PORTC=0;
    PORTD=0;
    PORTE=0;
    
    INTCON=0;
    INTCONbits.GIE=1;
    INTCONbits.INTE=1;
    
    
    while(1)
    {
        if(aux==1)
        {
            PORTA=0b11111111;
            __delay_ms(500);
            PORTA=0;
            __delay_ms(500);
        }
        else
        {
            PORTA=0;
            __delay_ms(100);
        }
    
    }
    return (EXIT_SUCCESS);
}