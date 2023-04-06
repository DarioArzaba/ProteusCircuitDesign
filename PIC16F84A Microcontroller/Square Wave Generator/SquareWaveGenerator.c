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

int temp = 0;
int aux1 = 0;
int aux2 = 0;
int auxON = 0;

void __interrupt() ISR(void){
    PORTAbits.RA0 = 1;
    aux1 = 1;
    if(INTCONbits.INTF == 1){
        if(auxON ==0){
            auxON = 1;
        }
        else{
            auxON = 0;
        }
    }
    else{
        if (PORTBbits.RB4 == 1){
            aux2 = 1;
        }
        if (PORTBbits.RB5 == 1){
            aux2 = 2;
        }
        if (PORTBbits.RB6 == 1){
            aux2 = 3;
        }
        if (PORTBbits.RB7 == 1){
            aux2 = 4;
        }
    }
    __delay_ms(300);
    PORTAbits.RA0 = 0;
    
    temp = PORTB; //Leer la variable (viene en el manual)
    INTCONbits.RBIF = 0; //Limpiar la bandera de interrupcion
    INTCONbits.INTF = 0; //Limpiamos la bandera para salir de aqui
    return;
}

void PWM_25(void){
    PORTBbits.RB1 = 1;
    __delay_ms(25);
    PORTBbits.RB1 = 0;
    __delay_ms(75);
    return;
}

void PWM_50(void){
    PORTBbits.RB1 = 1;
    __delay_ms(50);
    PORTBbits.RB1 = 0;
    __delay_ms(50);
    return;
}

void PWM_75(void){
    PORTBbits.RB1 = 1;
    __delay_ms(75);
    PORTBbits.RB1 = 0;
    __delay_ms(25);
    return;
}

void PWM_100(void){
    PORTBbits.RB1 = 1;
    return;
}

int main(int argc, char** argv) {
    TRISA = 0; //Configurar puerto A como salidas
    TRISB = 0b11110001;
    PORTA = 0; //El puerto inicia apagado
    PORTB = 0;
    
    INTCON = 0;
    INTCONbits.GIE = 1;
    INTCONbits.RBIE = 1; /*Relacionada a RB4-RB7*/
    INTCONbits.INTE = 1;
    
    while(1){
        if (aux1 == 1){
            aux1 = 0;
            
            if (auxON == 1){
                switch (aux2){
                case 1:
                    PORTA = 0;
                    PWM_25();
                    PORTAbits.RA1 = 1;
                    break;
                case 2:
                    PORTA = 0;
                    PORTAbits.RA2 = 1;
                    PWM_50();
                    break;
                case 3:
                    PORTA = 0;
                    PORTAbits.RA3 = 1;
                    PWM_75();
                    break;
                case 4:
                    PORTA = 0;
                    PORTAbits.RA4 = 1;
                    PWM_100();
                    break; 
                default:
                    PORTA = 0;
                    break;      
                }
            }
            else{
                PORTA = 0;
                PORTBbits.RB1 = 0;
            }  
        }
        else if (auxON == 1){
            
            switch (aux2){
                case 1:
                    PWM_25();
                    break;
                case 2:
                    PWM_50();
                    break;
                case 3:
                    PWM_75();
                    break;
                case 4:
                    PWM_100();
                    break; 
                default:
                    PORTA = 0;
                    break;      
            } 
        }
        else{
            PORTA = 0;
            PORTBbits.RB1 = 0;
        }
    }
    return (EXIT_SUCCESS);
}