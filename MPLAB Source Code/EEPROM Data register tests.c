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

void __interrupt() ISR(void){
    TMR0 = 48;
    
    if(PORTBbits.RB0 == 1){
        PORTBbits.RB0 = 0;
    }
    else{
        PORTBbits.RB0 = 1;
    }
    
    INTCONbits.T0IF = 0; //Cerrrar la interrupción 
    
    return;
}

int main(int argc, char** argv) {
    
    TRISB = 0;
    PORTB = 0;
    //Configurar interrupciones PREESCALADOR
    INTCON = 0;
    INTCONbits.GIE = 1;
    INTCONbits.T0IE = 1;
    OPTION_REGbits.T0CS = 0;
    OPTION_REGbits.PSA = 0;
    OPTION_REGbits.PS2 = 0;
    OPTION_REGbits.PS1 = 1;
    OPTION_REGbits.PS0 = 1;
    TMR0 = 48;
    
    while (1){
        NOP();
    }

    return (EXIT_SUCCESS);
}

