#pragma config FOSC = XT        // Oscillator Selection bits (XT oscillator)
#pragma config WDTE = OFF       // Watchdog Timer (WDT disabled)
#pragma config PWRTE = OFF      // Power-up Timer Enable bit (Power-up Timer is disabled)
#pragma config CP = OFF         // Code Protection bit (Code protection disabled)

#define t 200
#define _XTAL_FREQ 4000000
#define __delay_ms(x) _delay((unsigned long)((x)*(_XTAL_FREQ/4000.0)))

#include <xc.h>
#include <stdio.h>
#include <stdlib.h>

int aux = 0;
int aux2 = 0;

void semaforo(void){
    PORTA = 0b0010010;
    __delay_ms(1000);
    PORTA = 0b0010100;
    __delay_ms(1000);
    return;
}

void __interrupt() ISR(void){
    __delay_ms(30);
    if (aux == 0 ){
        aux = 1;
        semaforo();
    }
    else{
        aux = 0;
    }
    INTCONbits.INTF = 0; //Limpiamos la bandera para salir de aqui
    return;
}

int main(int argc, char** argv) {
    
    TRISA = 0;
    PORTA = 0;
    INTCON = 0;
    INTCONbits.GIE = 1;
    INTCONbits.INTE = 1;
    OPTION_REGbits.INTEDG = 1;
    
    while (1) {
        if (aux == 0){
            PORTA = 0b0010001;
        }
        else{
            PORTA = 0b0001100;
            __delay_ms(2000);
            aux = 0;
        }  
    }
    return (EXIT_SUCCESS);
}