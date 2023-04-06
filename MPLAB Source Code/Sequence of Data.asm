#include "p16f84a.inc"

; CONFIG
; __config 0xFFF9
__CONFIG _FOSC_XT & _WDTE_OFF & _PWRTE_OFF & _CP_OFF
    
    org 0
	bsf STATUS, RP0 ;Cambiar al banco 1 de la memoria de datos
	clrf TRISB ;Configurar TRISB con 0 para que las terminales sean salidas
	bcf STATUS, RP0 ;Cambiar al banco 0 de la memoria de datos
	
	main:
	    btfsc PORTA,0
	    goto vale1 ;El primer bit vale 1
	    goto vale0 ;El primer bit vale 0
	    
	vale0:
	    btfsc PORTA,1
	    goto matbompy ;Combinación 10 /LEDs:00000010
	    goto apagar ;Combinación 00 /LEDs:00000000
	
	vale1:
	    btfsc PORTA,1
	    goto matpame ;Combinación 11 /LEDs:01011011
	    goto mataldo ;Combinación 01 /LEDs:01001011
	    
	matbompy:
	    ;A01367202
	    movlw b'00000010' ;Decimal: 02
	    movwf PORTB
	    goto main
	    
	matpame:
	    ;A01369291
	    movlw b'01011011' ;Decimal: 91
	    movwf PORTB
	    goto main
	    
	mataldo:
	    ;A01367475
	    movlw b'01001011' ;Decimal: 75
	    movwf PORTB
	    goto main  
	    
	apagar:
	   clrf PORTB
	   goto main
    end


