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

int Encendido = 0;
int Activado = 0;
int Alarma = 0;
int temp = 0;

void __interrupt() ISR(void){
    __delay_ms(30);
    //BOTON DE EMERGENCIA CON BIT DE INTERRUPCION
    if (INTCONbits.INTF == 1){
        if (Encendido == 1) {
            Alarma = 1;
        } else {
            Alarma = 0;
        }
    } else {
        //BOTON GENERAL DE ENCENDIDO
        if (PORTBbits.RB2 == 1){
            if (Encendido == 1) {
                Encendido = 0;
            } else {
                Encendido = 1;
            }
        }
        //ACTIVAR Y DESACTIVAR ALARMA (TAMBIEN APAGAR BUZZER)
        if (PORTBbits.RB1 == 1){
            if (Alarma = 1) {
                Alarma = 0;
            }
            if (Encendido == 1){
                if (Activado == 1){
                    Activado = 0;
                } else {
                    Activado = 1;
                }     
            }
        }
        //SENSORES DE PUERTA Y VENTANAS
        if (PORTBbits.RB3 == 1 || PORTBbits.RB4 == 1 || PORTBbits.RB5 == 1 || PORTBbits.RB6 == 1){
            if (Activado == 1) {
                Alarma = 1;
            }
        }
    }
    
    temp = PORTB; //Read
    INTCONbits.RBIF = 0; //Clean Int
    INTCONbits.INTF = 0; //Clean Int
    return;
}

int main(int argc, char** argv) {
    
    TRISA = 0; //SALIDAS PUERTO A
    TRISB = 0b11111111; //PUERTO B COMO ENTRADAS
    PORTA = 0; //PUERTOS APAGADOS INICIALMENTE
    PORTB = 0; //PUERTOS APAGADOS INICIALMENTE
    INTCON = 0;
    INTCONbits.GIE=1;
    INTCONbits.INTE=1;
    INTCONbits.RBIE = 1; /*RB4-RB7*/
    
    while(1){
        
        // Si esta ENCENDIDO, ACTIVADO y SONANDO activar buzzer y desactivar LEDS
        if (Encendido == 1) {
            if (Activado == 1){
                if (Alarma == 1) {
                    PORTAbits.RA2 = 1;
                    PORTAbits.RA1 = 0;
                    PORTAbits.RA0 = 0;
                } else {
                    // Si esta ENCENDIDO ACTIVADO PERO NO SONANDO desactivar buzzer y parpadear VERDE
                    PORTAbits.RA2 = 0;
                    PORTAbits.RA1 = 0;
                    PORTAbits.RA0 = 1;
                    __delay_ms(50);
                    PORTAbits.RA0 = 0;
                    __delay_ms(50);
                }
            } else {
                // Si esta ENCENDIDO PERO NO ACTIVADO apagar VERDE y PRENDER ROJO
                PORTAbits.RA1 = 1;
                PORTAbits.RA0 = 0;
            }
        } else {
            // Finalmente si NO ESTA ENCENDIDO apagar buzzer y todos los LEDS
            PORTAbits.RA0 = 0;
            PORTAbits.RA1 = 0;
            PORTAbits.RA2 = 0;
        }
    }
    return (EXIT_SUCCESS);
}