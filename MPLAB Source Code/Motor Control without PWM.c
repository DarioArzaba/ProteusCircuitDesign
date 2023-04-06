// CONFIG
#pragma config FOSC = XT        // Oscillator Selection bits (XT oscillator)
#pragma config WDTE = OFF       // Watchdog Timer (WDT disabled)
#pragma config PWRTE = OFF      // Power-up Timer Enable bit (Power-up Timer is disabled)
#pragma config CP = OFF         // Code Protection bit (Code protection disabled)

#define _XTAL_FREQ 4000000
#define __delay_ms(x) _delay((unsigned long)((x)*(_XTAL_FREQ/4000.0)))

#include <xc.h>
#include <stdio.h>
#include <stdlib.h>

//NEW
int power = 0;
int sentido = 0;

//OLD
int ctr = 0;
int temp = 0;
int in1 = 1;
int in2 = 0;

void __interrupt() ISR(void){
    __delay_ms(30);
    
    if (INTCONbits.INTF == 1){
        if (power == 0){
            power = 1; //Encender
        }
        else{
            power = 0; //Apagar
        }
    }
    else{
        if (PORTBbits.RB5 == 1){
            if (sentido == 0){
                sentido = 1; //Clockwise
            }
            else{
                sentido = 0; //Anticlockwise
            }
        }
        if (PORTBbits.RB6 == 1){
            ctr = 2;
        }
        if (PORTBbits.RB7 == 1){
            ctr = 3;
        }
    }
    
    temp = PORTB; //Leer la variable (viene en el manual)
    INTCONbits.RBIF = 0; //Limpiar la bandera de interrupcion
    INTCONbits.INTF = 0; //Limpiamos la bandera para salir de aqui
    return;
}

int main(int argc, char** argv) {
    TRISA = 0; //Salidas
    
    PORTA = 0;
    
    INTCON = 0;
    INTCONbits.GIE = 1;
    INTCONbits.RBIE = 1; /*Relacionada a RB4-RB7*/
    INTCONbits.INTE = 1;
    
    /* ACTIVAR SENTIDO
     PORTAbits.RA0 = 0;
     PORTAbits.RA1 = 0;
    */

    while(1){ 
        if (power == 1){
            if (sentido == 1){ //ANTI-CLOCKWISE
                PORTAbits.RA0 = 1;
                PORTAbits.RA1 = 0;
            }
            else{ //CLOCKWISE
                PORTAbits.RA0 = 0;
                PORTAbits.RA1 = 1;
            }
        }
        else{
            PORTAbits.RA0 = 0;
            PORTAbits.RA1 = 0;
        }
    }
}