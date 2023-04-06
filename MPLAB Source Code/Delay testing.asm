
#include "p16f84a.inc"

; _config 0xFFF9
__CONFIG _FOSC_XT & _WDTE_OFF & _PWRTE_OFF & _CP_OFF
    
    org 0 ; indicar el origen de programa en la localidad 0
    
    
    demora_500ms:
	call demora_100ms
	call demora_100ms
	return

demora_100ms:
    movlw .130
    movwf c1
    
 Repeticion1:
    movlw .255
    movwf c2
    
 Repeticion2:
    
    
    
    
    
    
    
    
    
    
    
    
    bsf STATUS, RP0 ; cambiar al banco 1 de la memoria de datos
    clrf TRISB ; configurar TRISB con 0 para que las terminales sean salidas
    bcf STATUS, RP0 ; cambiar al banco 0 de la memoria de datos
    movlw .7
    movwf PORTB
    repetir:
	nop
	goto repetir
    end

