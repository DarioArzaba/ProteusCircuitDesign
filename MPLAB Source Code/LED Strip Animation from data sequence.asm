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
	    bcf chk,1 ;Reiniciar bit Aldo
	    bcf chk,2 ;Reiniciar bit Pame
	    btfsc chk,0  ;El bit vale 0?
	    goto mantenerBompy ;No vale 0
	    goto parpadearBompy ;Si vale 0
	    
	matpame:
	    ;A01369291
	    bcf chk,0 ;Reiniciar bit Bompy
	    bcf chk,1 ;Reiniciar bit Aldo
	    btfsc chk,2
	    goto mantenerPame ;No vale 0
	    goto parpadearPame ;Si vale 0
   
	mataldo:
	    ;A01367475
	    bcf chk,0;Reiniciar bit Bompy
	    bcf chk,2 ;Reiniciar bit Pame
	    btfsc chk,1
	    goto mantenerAldo ;No vale 0
	    goto parpadearAldo ;Si vale 0
 
	apagar:
	   bcf chk,0 ;Reiniciar bit Bompy
	   bcf chk,1 ;Reiniciar bit Aldo
	   clrf PORTB
	   goto main
	   
	parpadearBompy:
	    movlw b'00000010' ;Decimal: 02
	    movwf PORTB
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    clrf PORTB; Apagar el LED
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    bsf chk,0
	    goto mantenerBompy
	    return
	    
	mantenerBompy:
	    movlw b'00000010' ;Decimal: 2
	    movwf PORTB
	    goto main 
	    
	parpadearAldo:
	    movlw b'00000101' ;Decimal: 5
	    movwf PORTB
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    clrf PORTB; Apagar el LED
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    movlw b'00000101' ;Decimal: 5
	    movwf PORTB
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    clrf PORTB; Apagar el LED
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    movlw b'00000101' ;Decimal: 5
	    movwf PORTB
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    clrf PORTB; Apagar el LED
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    movlw b'00000101' ;Decimal: 5
	    movwf PORTB
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    clrf PORTB; Apagar el LED
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    ;SEGUNDO GRUPO DE LEDS
	    movlw b'01110101' ;Decimal: 75
	    movwf PORTB
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    movlw b'00000101' ;Decimal: 5
	    movwf PORTB
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    movlw b'01110101' ;Decimal: 75
	    movwf PORTB
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    movlw b'00000101' ;Decimal: 5
	    movwf PORTB
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    movlw b'01110101' ;Decimal: 75
	    movwf PORTB
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    movlw b'00000101' ;Decimal: 5
	    movwf PORTB
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    movlw b'01110101' ;Decimal: 75
	    movwf PORTB
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    movlw b'00000101' ;Decimal: 5
	    movwf PORTB
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    movlw b'01110101' ;Decimal: 75
	    movwf PORTB
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    movlw b'00000101' ;Decimal: 5
	    movwf PORTB
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    movlw b'01110101' ;Decimal: 75
	    movwf PORTB
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    movlw b'00000101' ;Decimal: 5
	    movwf PORTB
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    bsf chk,1
	    goto mantenerAldo
	    return
   
	mantenerAldo:
	    movlw b'01110101' ;Decimal: 75
	    movwf PORTB
	    goto main 
    
	parpadearPame:
	    movlw b'00000001' ;Decimal: 1
	    movwf PORTB
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    clrf PORTB; Apagar el LED
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    ;SEGUNDO GRUPO DE LEDS
	    movlw b'10010001' ;Decimal: 91
	    movwf PORTB
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    movlw b'00000001' ;Decimal: 1
	    movwf PORTB
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    movlw b'10010001' ;Decimal: 91
	    movwf PORTB
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    movlw b'00000001' ;Decimal: 1
	    movwf PORTB
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    movlw b'10010001' ;Decimal: 91
	    movwf PORTB
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    movlw b'00000001' ;Decimal: 1
	    movwf PORTB
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    movlw b'10010001' ;Decimal: 91
	    movwf PORTB
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    movlw b'00000001' ;Decimal: 1
	    movwf PORTB
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    movlw b'10010001' ;Decimal: 91
	    movwf PORTB
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    movlw b'00000001' ;Decimal: 1
	    movwf PORTB
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    movlw b'10010001' ;Decimal: 91
	    movwf PORTB
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    movlw b'00000001' ;Decimal: 1
	    movwf PORTB
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    movlw b'10010001' ;Decimal: 91
	    movwf PORTB
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    movlw b'00000001' ;Decimal: 1
	    movwf PORTB
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    movlw b'10010001' ;Decimal: 91
	    movwf PORTB
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    movlw b'00000001' ;Decimal: 1
	    movwf PORTB
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    bsf chk,2
	    goto mantenerPame
	    return
    
	mantenerPame:
	    movlw b'10010001' ;Decimal: 91
	    movwf PORTB
	    goto main
    
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
	    return      ; (2)	    
    end