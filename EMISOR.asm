    __CONFIG _WDT_OFF& _PWRTE_ON& _XT_OSC& _LVP_OFF& _CP_OFF
    LIST P=16F877A
    #INCLUDE <P16F877A.INC>
; Direcciones de variables

    
; Constantes     
    ; pines del puerto c
ADELANTE    = 0
ADELANTE_DER= 2
ADELANTE_IZQ= 1
    
REVERSA     = 4    
REVERSA_DER = 5
REVERSA_IZQ = 3
    
CONTROL	    = 6
    ; pines del puerto a
EJE_X	    = 1
EJE_Y	    = 0	
    
CBLOCK 24h
    TX	      
ANALOG_READ_X 
ANALOG_READ_Y 
CONTA_1       
CONTA_2 
CONTA_3 
LED_ACTIVO 
PUERTOS 
 Guarda_W 
 Guarda_STATUS
 Guarda_CONTA_1
 Guarda_CONTA_2
 Guarda_CONTA_3 
ENDC

	org 0x00          
	goto inicio
   	org 0X04
    	goto INTERRUPCIONWOO 	;Vector de interrupción

;configuracion de puertos
inicio bsf STATUS, RP0
	MOVLW	B'111111'	; PUERTO ENTRADA JOYSTICK
	MOVWF	TRISA
	MOVLW	B'11111111'	; PUERTO DE ENTRADA CONTROL PUSH
	MOVWF	TRISD
	CLRF	TRISC		; PUERTO DE SALIDA DE TRANSMISIÓN
	MOVLW	B'00000000'
	MOVWF	ADCON1
       movlw b'00000001' 
       movwf TRISB;
       BCF OPTION_REG,6   ; INTERRUPCION POR FLANCO DESCENDENTE (CUANDO SE APRIETA EL PB)
       bcf STATUS,RP0     
       MOVLW B'10010000'  ; HABILITAMOS INTERRUPCION, QUE SEAN LAS EXTERNAS INT Y GIE
       MOVWF INTCON	  ; CONFIGURACION REG INTCON
       clrf PORTC
       clrf PORTD; se limpia puerto B

PUHS
      ;BTFSS PORTB,0       ;si el bit 0 del puerto B esta en 1, salta
      GOTO  SECUENCIA      ;ir a SECUENCIA
      ;GOTO FIN            ; sino terminar programa

INTERRUPCIONWOO
movlw b'1111'
      movwf PORTC
   clrw
	clrf PORTC
	call Retardo_200ms
	bsf PORTB,1
	call Retardo_200ms
	bcf PORTB,1
	call Retardo_200ms
	bsf PORTB,1
	call Retardo_200ms
	bcf PORTB,1
	call Retardo_200ms
	bsf PORTB,1
	call Retardo_200ms
	bcf PORTB,1
	call Retardo_200ms
	bsf PORTB,1
	call Retardo_200ms
	bcf PORTB,1
	call Retardo_200ms
	bsf PORTB,1
	call Retardo_200ms
	bcf PORTB,1
	call Retardo_200ms
	bsf PORTB,1
	call Retardo_200ms
	bcf PORTB,1
	call Retardo_200ms
	bcf PORTB,1
	call Retardo_200ms
	bsf PORTB,1
	call Retardo_200ms

 FinInterrupcion

  	swapf Guarda_STATUS,W 	;Restauramos valor de STATUS.
 	movwf STATUS
 	swapf Guarda_W,F 	;Restaura W como estaba antes de producirse
 	swapf Guarda_W,W 	;interrupción.
 	movf Guarda_CONTA_1,W 	;Restaura los registros utilizados en esta
 	movwf CONTA_1 		;subrutina y también en la principal.
 	movf Guarda_CONTA_2,W
 	movwf CONTA_2
 	movf Guarda_CONTA_3,W
 	movwf CONTA_3
 	bcf INTCON,INTF 	;Limpia flag de reconocimiento de la interrupción.
 	retfie 			;Retorna y vuelve a habilitar las interrupciones.

SECUENCIA
		
CONTROL_CHECK
	BTFSS	PORTD,CONTROL
	GOTO	CONTROL_A
	GOTO	CONTROL_D
CONTROL_A
	; Obtenemos los valores analogicos de los potenciometros en los dos ejes, el X y el Y
	MOVLW	B'11000101'	
	MOVWF	ADCON0
	CALL	Retardo_20ms
	MOVF	ADRESH,0	; guardamos el valor analogico de 8 bits del eje x en la variable ANALOG_READ_X
	MOVWF	ANALOG_READ_X
	CALL	Retardo_20ms
	BSF	ADCON0,2
	
	MOVLW	B'11001101'	
	MOVWF	ADCON0
	CALL	Retardo_20ms
	MOVF	ADRESH,0	; guardamos el valor analogico de 8 bits del eje x en la variable ANALOG_READ_X
	MOVWF	ANALOG_READ_Y
	CALL	Retardo_20ms
	BSF	ADCON0,2
	; Traducimos los valores obtenidos y realizamos una conversión
	
	CLRF	TX
	
	MOVLW	d'85'	
	SUBWF	ANALOG_READ_Y,0	; Checamos si en el eje x la palanca se encuentra hacia abajo
	BTFSS	STATUS,C
	BSF	TX,0
	
	MOVLW	D'170'
	SUBWF	ANALOG_READ_Y,0	; Checamos si en el eje x la palanca se encuentra hacia arriba
	BTFSC	STATUS,C
	BSF	TX,3
	
	MOVLW	d'85'	
	SUBWF	ANALOG_READ_X,0 ; Checamos si en el eje y la palanca se encuentra hacia la izq
	BTFSS	STATUS,C
	BSF	TX,2
	
	MOVLW	D'170'
	SUBWF	ANALOG_READ_X,0 ; Checamos si en el eje y la palanca se encuentra hacia la derecha
	BTFSC	STATUS,C
	BSF	TX,1
	
	MOVF	TX,0
	MOVWF	PORTC
	
	GOTO	CONTROL_CHECK	

CONTROL_D
	BTFSC	PORTD,ADELANTE
	GOTO	AVANZA
	
	BTFSC	PORTD,REVERSA
	GOTO	RETROCEDE
	
	BTFSC	PORTD,ADELANTE_DER
	GOTO	VUELTA_ADELANTE_DER
	
	BTFSC	PORTD,ADELANTE_IZQ
	GOTO	VUELTA_ADELANTE_IZQ
	
	BTFSC	PORTD,REVERSA_DER
	GOTO	VUELTA_REVERSA_DER
	
	BTFSC	PORTD,REVERSA_IZQ
	GOTO	VUELTA_REVERSA_IZQ
	
	CLRF	PORTC
	GOTO	CONTROL_CHECK

AVANZA
	MOVLW	B'1000'
	MOVWF	PORTC
	GOTO	CONTROL_CHECK
VUELTA_ADELANTE_DER
	MOVLW	B'1010'
	MOVWF	PORTC
	GOTO	CONTROL_CHECK
VUELTA_ADELANTE_IZQ
	MOVLW	B'1100'
	MOVWF	PORTC
	GOTO	CONTROL_CHECK
RETROCEDE
	MOVLW	B'0001'
	MOVWF	PORTC
	GOTO	CONTROL_CHECK
VUELTA_REVERSA_DER
	MOVLW	B'0011'
	MOVWF	PORTC
	GOTO	CONTROL_CHECK
VUELTA_REVERSA_IZQ
	MOVLW	B'0101'
	MOVWF	PORTC
	GOTO	CONTROL_CHECK

FIN    BTFSC PORTB,0        ;etiqueta fin, si el bit 0 del puerto B esta en 0, salta.
       ;GOTO PUHS
       #INCLUDE <RETARDOS.INC>

       END                  
