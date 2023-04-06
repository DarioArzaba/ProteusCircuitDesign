#include "p16f84a.inc"

; CONFIG
; __config 0xFFF9
__CONFIG _FOSC_XT & _WDTE_OFF & _PWRTE_OFF & _CP_OFF
 c1 EQU 0x0C ;Registro de memoria contador 1
 c2 EQU 0x0D ;Registro de memoria contador 2
 chk EQU 0x0E ;0 Bompy, 1 Aldo, 2 Pame
    
    org 0
	bsf STATUS, RP0 ;Cambiar al banco 1 de la memoria de datos
	clrf TRISB ;Configurar TRISB con 0 para que las terminales sean salidas
	bcf STATUS, RP0 ;Cambiar al banco 0 de la memoria de datos
	clrf chk
	
	seq1:
	    btfss PORTA,0 
	    call estado1 ;VALE 0
	    goto seq2 ;VALE 1

	seq2:
	    btfss PORTA,0 
	    call estado2 ;VALE 0
	    goto seq3 ;VALE 1

	seq3:
	    btfss PORTA,0 
	    call estado3 ;VALE 0
	    goto seq1 ;VALE 1

	estado1:
	    movlw b'00000101'
	    movwf PORTB
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    clrf PORTB; Apagar el LED
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms

	estado2:
	    movlw b'00001010' ;Decimal: 5
	    movwf PORTB
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    clrf PORTB; Apagar el LED
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms

	estado3:
	    movlw b'00001111' ;Decimal: 5
	    movwf PORTB
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    clrf PORTB; Apagar el LED
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms


	demora_100ms:
		movlw .130
		movwf c1
		Repeticion1:
		    movlw .255
		    movfw c2
		Repeticion2:
		    decfsz  c2,1    ; (1 si no sale, 2 si sale)     
		    goto  Repeticion2    ; (2) 
		    decfsz  c1,1  ; (1 si no sale, 2 si sale) 
		    goto  Repeticion1  ; (2) 
		return
    end