#include "p16f84a.inc"

; CONFIG
; __config 0xFFF9
__CONFIG _FOSC_XT & _WDTE_OFF & _PWRTE_OFF & _CP_OFF
 c1 EQU 0x0C ;Registro de memoria contador 1
 c2 EQU 0x0D ;Registro de memoria contador 2
 d1 EQU 0x0E ;Registro de primer digito
 d2 EQU 0x0F ;Registro de segundo digito
 d3 EQU 0x0A ;Registro de tercer digito
 d4 EQU 0x0B ;Registro de cuarto digito
 
    org 0
	bsf STATUS, RP0 ;Cambiar al banco 1 de la memoria de datos
	clrf TRISA ;Configurar TRISB con 0 para que las terminales sean salidas
	bcf STATUS, RP0 ;Cambiar al banco 0 de la memoria de datos
	clrf PORTA
	
	leer_contra:
	    check1digit:
		btfsc PORTB, 0 ;Se valida el boton 1
		goto save_digit1_0; El boton 1 se presiono
		btfsc PORTB, 1 ;Se valida el boton 2
		goto save_digit1_1; El boton 2 se presiono
		btfsc PORTB, 2  ;Se valida el boton 3
		goto save_digit1_2 ;El boton 3 se presiono
		btfsc PORTB, 3  ;Se valida el boton 4
		goto save_digit1_3 ;El boton 4 se presiono
		btfsc PORTB, 4  ;Se valida el boton 5
		goto save_digit1_4 ;El boton 5 se presiono
		goto check1digit ;REINICIAR CICLO 1

	    save_digit1_0:
		bsf d1,0
		call demora_500ms
		goto check2digit

	    save_digit1_1:
		bsf d1,1
		call demora_500ms
		goto check2digit

	    save_digit1_2:
		bsf d1,2
		call demora_500ms
		goto check2digit

	    save_digit1_3:
		bsf d1,3
		call demora_500ms
		goto check2digit

	    save_digit1_4:
		bsf d1,4
		call demora_500ms
		goto check2digit

	    check2digit:
		btfsc PORTB, 0 ;Se valida el boton 1
		goto save_digit2_0; El boton 1 se presiono
		btfsc PORTB, 1 ;Se valida el boton 2
		goto save_digit2_1; El boton 2 se presiono
		btfsc PORTB, 2  ;Se valida el boton 3
		goto save_digit2_2 ;El boton 3 se presiono
		btfsc PORTB, 3  ;Se valida el boton 4
		goto save_digit2_3 ;El boton 4 se presiono
		btfsc PORTB, 4  ;Se valida el boton 5
		goto save_digit2_4 ;El boton 5 se presiono
		goto check2digit ;REINICIAR CICLO 2

	    save_digit2_0:
		bsf d2,0
		call demora_500ms
		goto check3digit

	    save_digit2_1:
		bsf d2,1
		call demora_500ms
		goto check3digit

	    save_digit2_2:
		bsf d2,2
		call demora_500ms
		goto check3digit

	    save_digit2_3:
		bsf d2,3
		call demora_500ms
		goto check3digit

	    save_digit2_4:
		bsf d2,4
		call demora_500ms
		goto check3digit

	    check3digit:
		btfsc PORTB, 0 ;Se valida el boton 1
		goto save_digit3_0; El boton 1 se presiono
		btfsc PORTB, 1 ;Se valida el boton 2
		goto save_digit3_1; El boton 2 se presiono
		btfsc PORTB, 2  ;Se valida el boton 3
		goto save_digit3_2 ;El boton 3 se presiono
		btfsc PORTB, 3  ;Se valida el boton 4
		goto save_digit3_3 ;El boton 4 se presiono
		btfsc PORTB, 4  ;Se valida el boton 5
		goto save_digit3_4 ;El boton 5 se presiono
		goto check3digit ;REINICIAR CICLO 2

	    save_digit3_0:
		bsf d3,0
		call demora_500ms
		goto check4digit

	    save_digit3_1:
		bsf d3,1
		call demora_500ms
		goto check4digit

	    save_digit3_2:
		bsf d3,2
		call demora_500ms
		goto check4digit

	    save_digit3_3:
		bsf d3,3
		call demora_500ms
		goto check4digit

	    save_digit3_4:
		bsf d3,4
		call demora_500ms
		goto check4digit

	    check4digit:
		btfsc PORTB, 0 ;Se valida el boton 1
		goto save_digit4_0; El boton 1 se presiono
		btfsc PORTB, 1 ;Se valida el boton 2
		goto save_digit4_1; El boton 2 se presiono
		btfsc PORTB, 2  ;Se valida el boton 3
		goto save_digit4_2 ;El boton 3 se presiono
		btfsc PORTB, 3  ;Se valida el boton 4
		goto save_digit4_3 ;El boton 4 se presiono
		btfsc PORTB, 4  ;Se valida el boton 5
		goto save_digit4_4 ;El boton 5 se presiono
		goto check4digit ;REINICIAR CICLO 2

	    save_digit4_0:
		bsf d4,0
		call demora_500ms
		goto validar_contra

	    save_digit4_1:
		bsf d4,1
		call demora_500ms
		goto validar_contra

	    save_digit4_2:
		bsf d4,2
		call demora_500ms
		goto validar_contra

	    save_digit4_3:
		bsf d4,3
		call demora_500ms
		goto validar_contra

	    save_digit4_4:
		bsf d4,4
		call demora_500ms
		goto validar_contra
	
	validar_contra: ;CONTRASEÑA  = 9175
	    btfss d1,4
	    goto contra_inco ;CONTRASEÑA INCORRECTA
	    btfss d2,0
	    goto contra_inco ;CONTRASEÑA INCORRECTA
	    btfss d3,3
	    goto contra_inco
	    btfss d4,2
	    goto contra_inco
	    goto contra_corec
	    
	    contra_corec:
		movlw b'00001111'
		movwf PORTA
		goto contra_corec
	    
	    contra_inco:
		movlw b'00000011'
		movwf PORTA
		goto contra_inco
		
		
	
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
	        
	demora_500ms:
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	    call demora_100ms
	
    end