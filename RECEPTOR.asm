 __CONFIG _WDT_OFF & _PWRTE_ON & _XT_OSC & _LVP_OFF & _CP_OFF
    LIST P=16F877A
    #INCLUDE <P16F877A.INC>
   CONT_A = 0x20

reset	    org	0x00
		goto	Inicio
		org	0x05
Inicio	
		bsf	STATUS,RP0
		clrf	TRISC
		clrf	TRISB
		movlw	b'00001111'
		movwf	TRISD
		bcf	STATUS,RP0
Principal
		clrf	PORTB
		clrf	PORTC
		call IniciarLCD
IniciarLCD
	    call    Carrito
	    call    Limpiar
	    bcf	    PORTB,1
	    movlw   b'00000110' ; Entry mode set
	    movwf   PORTC
	    call    Enable
	    call    Retardo_20micros
	    call    Retardo_20micros
	    bcf	    PORTB,1
	    movlw   b'00001100' ; LCD on/off
	    movwf   PORTC
	    call    Enable
	    call    Retardo_20micros
	    call    Retardo_20micros
	    bcf	    PORTB,1
	    movlw   b'00011100' ; Movimiento de cursor 
	    movwf   PORTC 
	    call    Enable
	    call    Retardo_20micros
	    call    Retardo_20micros
	    bcf	    PORTC,0
	    movlw   b'00111000' ; FunciÛn set 
	    movwf   PORTC 
	    call    Enable
	    call    Retardo_20micros
	    call    Retardo_20micros
	    call    Home      
	    call    espacio
	    call    espacio
	    call    Caracter
	    call    bi
	    call    i
	    call    e
	    call    n
	    call    v
	    call    e
	    call    n
	    call    i
	    call    d
	    call    o
	    call    Caracter
	    call    Salto
	    call    espacio
	    call    espacio
	    call    Ca
	    call    a
	    call    r
	    call    r
	    call    i
	    call    t
	    call    o
	    call    espacio
	    call    espacio
	    call    Ro
	    call    Fo
	    movlw d'186'
	movwf CONT_A
	call LA_SOSTC3	
	decfsz CONT_A
	goto $-2
	
	call Retardo_20ms
	
	movlw d'148'
	movwf CONT_A
	call SI_C3	
	decfsz CONT_A
	goto $-2
	
	call Retardo_50ms
	
	movlw d'155'
	movwf CONT_A
	call RE_SOSTC4	
	decfsz CONT_A
	goto $-2
	    call Retardo_200ms
	    call Retardo_200ms
	    call Retardo_200ms
	    call Retardo_200ms
	    call Retardo_200ms
	    call Retardo_200ms
	    call Retardo_200ms
	    call Retardo_200ms
	    call Retardo_200ms
	    call Retardo_200ms
	    call Retardo_200ms
	    call Retardo_200ms
	    call Retardo_200ms
	    call Retardo_200ms
	    call Retardo_200ms
	    
	    call    Limpiar

Esperando
	    Main
	    Recto_O_Inverso
	    
	btfss	PORTD,0
	goto	Date
	btfss	PORTD,1
	goto	Date
	btfss	PORTD,2
	goto	Date
	btfss	PORTD,3
	    goto Date
	    goto Pedo
	    
	    Date
	clrf PORTD
	movlw PORTC
	
	btfss PORTD,3
	goto EsInverso?
	goto Recto
	
	EsInverso?
	btfss PORTD,0
	goto STOP
	goto Inverso
	
	Recto
	btfss PORTD,2
	goto Recto2
	goto Izquierda
	
	Recto2
	btfss PORTD,1
	goto Recto3
	goto Derecha
	
	Izquierda
	btfss PORTD,0
	goto AdelanteIzquierda
	goto STOP
	
	Recto3
	btfss PORTD,0
	goto AvanceRecto
	goto STOP
	
	Derecha
	btfss PORTD,0
	goto AdelanteDerecha
	goto STOP
		
	Inverso
	btfss PORTD,2
	goto Inverso2
	goto IzquierdaInverso
	
	Inverso2
	btfss PORTD,1
	goto Inverso3
	goto DerechaInverso
	
	IzquierdaInverso
	btfsc PORTD,0
	goto InversoIzquierda
	goto STOP
	
	Inverso3
	btfsc PORTD,0
	goto InversoRecto
	goto STOP
	
	DerechaInverso
	btfsc PORTD,0
	goto InversoDerecha
	goto STOP
	
	Pedo
	bcf PORTD,4
	bcf PORTD,5
	bcf PORTD,6
	bcf PORTD,7
	    call    LuzRoja
	    call    LuzVerde
	    call    LuzAmarilla
	    
	    call    Emayus
	    call    s
	    call    t
	    call    a
	    call    s
	    call    Salto
	    call    p
	    call    e
	    call    d
	    call    o
	    call    Retardo_200ms
	    call    Retardo_200ms
	    call    Retardo_200ms
	    call    Retardo_200ms
	    call    Retardo_200ms
	    call    Retardo_200ms
	    call    Retardo_200ms
	    call    Retardo_200ms
	    call    TokyoDrift

	    call    Limpiar
	    goto Main
	
	
	    STOP
	bcf PORTD,4
	bcf PORTD,5
	bcf PORTD,6
	bcf PORTD,7
	    call    LuzRoja
	    call    espacio
	    call    Caracter
	    call    espacio
	    call    Emayus
	    call    s
	    call    p
	    call    e
	    call    r
	    call    a
	    call    n
	    call    d
	    call    o
	    call    Salto
	    call    espacio
	    call    espacio
	    call    Imayus
	    call    n
	    call    d
	    call    i
	    call    c
	    call    a
	    call    c
	    call    i
	    call    o
	    call    n
	    call    e
	    call    s
	    call    espacio
	    call    Caracter
	    call    Retardo_200ms
	    call    Retardo_200ms
	    call    ApagarRoja
	    call    Limpiar
	    goto Main
AvanceRectoo
	    AvanceRecto
bcf PORTD,6
	bsf PORTD,7
	bcf PORTD,5
	bsf PORTD,4
	
	    call    LuzVerde
	    call    espacio
	    call    espacio
	    call    A
	    call    v
	    call    a
	    call    n
	    call    c
	    call    e
	    call    espacio
	    call    Ro
	    call    e
	    call    c
	    call    t
	    call    o
	    call    Salto
	    call    espacio
	    call    espacio
	    call    espacio
	    call    espacio
	    call    espacio
	    call    espacio
	    call    Caracter
	    call    FlechaDerecha
	    call    CancionRecto
	    call    Limpiar
	    
	    call    espacio
	    call    espacio
	    call    A
	    call    v
	    call    a
	    call    n
	    call    c
	    call    e
	    call    espacio
	    call    Ro
	    call    e
	    call    c
	    call    t
	    call    o
	    call    Salto
	    call    espacio
	    call    espacio
	    call    espacio
	    call    espacio
	    call    espacio
	    call    espacio
	    call    espacio
	    call    espacio
	    call    espacio
	    call    Caracter
	    call    FlechaDerecha
	    call    CancionRecto 
	    call    ApagarVerde
	    call    Limpiar
	    goto Main
	    
AvanceDer
	    AdelanteDerecha
	
	bcf PORTD,6
	bsf PORTD,7
	
	    call    LuzVerde
	    call    espacio
	    call    espacio
	    call    espacio
	    call    espacio
	    call    A
	    call    v
	    call    a
	    call    n
	    call    c
	    call    e
	    call    Salto
	    call    espacio
	    call    espacio
	    call    espacio
	    call    Dmayus
	    call    e
	    call    r
	    call    e
	    call    c
	    call    h
	    call    a
	    call    espacio
	    call    Caracter
	    call    CancionAvDer
	    call    CancionAvDer 
	    call    ApagarVerde
	    call    Limpiar
	    goto Main
	    
	    
AvanceIzq
	    AdelanteIzquierda
	
	bsf PORTD,4
	bcf PORTD,5
	
	    call    LuzVerde
	    call    espacio
	    call    espacio
	    call    espacio
	    call    Caracter
	    call    espacio
	    call    A
	    call    v
	    call    a
	    call    n
	    call    c
	    call    e
	    call    Salto
	    call    espacio
	    call    espacio
	    call    espacio
	    call    Imayus
	    call    z
	    call    q
	    call    u
	    call    i
	    call    e
	    call    r
	    call    d
	    call    a
	    call    CancionAvIzq
	    call    CancionAvIzq
	    call    ApagarVerde
	    call    Limpiar
	    goto Main
ReversaRecta
	    InversoRecto
	bsf PORTD,6
	bcf PORTD,7
	bsf PORTD,5
	bcf PORTD,4
		    
	    call    espacio
	    call    Ro
	    call    e
	    call    v
	    call    e
	    call    r
	    call    s
	    call    a
	    call    espacio
	    call    Ro
	    call    e
	    call    c
	    call    t
	    call    a
	    call    Salto
	    call    espacio
	    call    espacio
	    call    espacio
	    call    espacio
	    call    espacio
	    call    espacio
	    call    espacio
	    call    espacio
	    call    Caracter
	    call    FlechaIzq
	    call    CancionReversa
	    call    Limpiar
	    
	    call    espacio
	    call    Ro
	    call    e
	    call    v
	    call    e
	    call    r
	    call    s
	    call    a
	    call    espacio
	    call    Ro
	    call    e
	    call    c
	    call    t
	    call    a
	    call    Salto
	    call    espacio
	    call    espacio
	    call    espacio
	    call    espacio
	    call    espacio
	    call    espacio
	    call    Caracter
	    call    FlechaIzq
	    call    CancionReversa
	    call    ApagarAmarilla
	    call    Limpiar
	    goto Main
	    
ReversaDer
	    InversoDerecha
	bsf PORTD,6
	bcf PORTD,7
	
	    call    LuzAmarilla
	    call    espacio
	    call    espacio
	    call    espacio
	    call    espacio
	    call    Ro
	    call    e
	    call    v
	    call    e
	    call    r
	    call    s
	    call    a
	    call    Salto
	    call    espacio
	    call    espacio
	    call    espacio
	    call    espacio
	    call    Dmayus
	    call    e
	    call    r
	    call    e
	    call    c
	    call    h
	    call    a
	    call    espacio
	    call    Caracter
	    call    CancionRevDer
	    call    CancionRevDer
	    call    ApagarAmarilla
	    call    Limpiar
	    goto Main
	    
ReversaIzq
	    InversoIzquierda
	bcf PORTD,4
	bsf PORTD,5
	    call    LuzAmarilla
	    call    espacio
	    call    espacio
	    call    espacio
	    call    Caracter
	    call    espacio
	    call    Ro
	    call    e
	    call    v
	    call    e
	    call    r
	    call    s
	    call    a
	    call    Salto
	    call    espacio
	    call    espacio
	    call    espacio
	    call    espacio
	    call    Imayus
	    call    z
	    call    q
	    call    u
	    call    i
	    call    e
	    call    r
	    call    d
	    call    a
	    call    CancionRevIzq
	    call    CancionRevIzq
	    call    ApagarAmarilla
	    call    Limpiar
	    goto Main
Enable	
	    bsf	    PORTB,2 
	    call    Retardo_2ms
	    call    Retardo_2ms
	    call    Retardo_200micros
	    bcf	    PORTB,2 
	    return
Home    
	    bcf	    PORTB,1
	    movlw   b'00000010'
	    movwf   PORTC
	    call    Enable
	    call    Retardo_2ms
	    return
Limpiar
	    bcf	    PORTB,1
	    movlw   b'00000001'
	    movwf   PORTC
	    call    Enable
	    call    Retardo_2ms
	    return
Salto
	    bcf	    PORTB,1
	    movlw   b'11000000'
	    movwf   PORTC
	    call    Enable
	    call    Retardo_2ms
	    return
	;;;;;;;;;;;;;LETRAS;;;;;;;;;;;;;;;;;    
Po
	movlw   b'01010000'
	    movwf   PORTC
	    bsf	    PORTB,1 
	    call    Enable
	    call    Retardo_2ms
	    return	
	
Fo
	    movlw   b'01000110'
	    movwf   PORTC
	    bsf	    PORTB,1
	    call    Enable
	    call    Retardo_2ms
	    return
Ro	
	    movlw   b'01010010'
	    movwf   PORTC
	    bsf	    PORTB,1 
	    call    Enable
	    call    Retardo_2ms
	    return
	    
c	    movlw   b'01100011'
	    movwf   PORTC
	    bsf	    PORTC,RA0 
	    call    Enable
	    call    Retardo_2ms
	    return
	    
n	    movlw   b'01101110'
	    movwf   PORTC
	    bsf	    PORTB,1 
	    call    Enable
	    call    Retardo_2ms
	    return
	    
t	    movlw   b'01110100'
	    movwf   PORTC
	    bsf	    PORTB,1 
	    call    Enable
	    call    Retardo_2ms
	    return
	    
l	    movlw   b'01101100'
	    movwf   PORTC
	    bsf	    PORTB,1 
	    call    Enable
	    call    Retardo_2ms
	    return
h	    movlw   b'01101000'
	    movwf   PORTC
	    bsf	    PORTB,1 
	    call    Enable
	    call    Retardo_2ms
	    return
	    
r	    movlw   b'01110010'
	    movwf   PORTC
	    bsf	    PORTB,1 
	    call    Enable
	    call    Retardo_2ms
	    return
	    
o	    movlw   b'01101111'
	    movwf   PORTC
	    bsf	    PORTB,1  
	    call    Enable
	    call    Retardo_2ms
	    return
	    
	    
e	    movlw   b'01100101'
	    movwf   PORTC
	    bsf	    PORTB,1 
	    call    Enable
	    call    Retardo_2ms
	    return
	    
s	    movlw   b'01110011'
	    movwf   PORTC
	    bsf	    PORTB,1 
	    call    Enable
	    call    Retardo_2ms
	    return
	    
so
	    movlw   b'01110011'
	    movwf   PORTC
	    bsf	    PORTB,1 
	    call    Enable
	    call    Retardo_2ms
	    return
	    
	    
u	    movlw   b'01110101'
	    movwf   PORTC
	    bsf	    PORTB,1 
	    call    Enable
	    call    Retardo_2ms
	    return
	    
	    	    
v	    movlw   b'01110110'
	    movwf   PORTC
	    bsf	    PORTB,1 
	    call    Enable
	    call    Retardo_2ms
	    return
	    

a	    movlw   b'01100001'
	    movwf   PORTC
	    bsf	    PORTB,1 
	    call    Enable
	    call    Retardo_2ms
	    return
A	    movlw   b'01000001'  
	    movwf   PORTC
	    bsf	    PORTB,1 
	    call    Enable
	    call    Retardo_2ms
	    return
i	    movlw   b'01101001' 
	    movwf   PORTC
	    bsf	    PORTB,1 
	    call    Enable
	    call    Retardo_2ms
	    return 
	    
p	    movlw   b'11110000'
	    movwf   PORTC
	    bsf	    PORTB,1 
	    call    Enable
	    call    Retardo_2ms
	    return
	    
lo	    movlw   b'01110100'
	    movwf   PORTC
	    bsf	    PORTB,1  
	    call    Enable
	    call    Retardo_2ms
	    return
	    
to	    movlw   b'01101100'
	    movwf   PORTC
	    bsf	    PORTB,1 
	    call    Enable
	    call    Retardo_2ms
	    return
	    
d	    
	    movlw   b'01100100'
	    movwf   PORTC
	    bsf	    PORTB,1  
	    call    Enable
	    call    Retardo_2ms
	    return
	    
bb	    
	    movlw   b'01100010'
	    movwf   PORTC
	    bsf	    PORTB,1  
	    call    Enable
	    call    Retardo_2ms
	    return
Ca
	    movlw   b'01000011'
	    movwf   PORTC
	    bsf	    PORTB,1  
	    call    Enable
	    call    Retardo_2ms
	    return
	    	    	    
FlechaDerecha	    
	    movlw   b'01111110'
	    movwf   PORTC
	    bsf	    PORTB,1 
	    call    Enable
	    call    Retardo_2ms
	    return
FlechaIzq	    
	    movlw   b'01111111'
	    movwf   PORTC
	    bsf	    PORTB,1 
	    call    Enable
	    call    Retardo_2ms
	    return
	    
	    
w	    movlw   b'01010111'
	    movwf   PORTC
	    bsf	    PORTB,1 
	    call    Enable
	    call    Retardo_2ms
	    return

espacio
	    movlw   b'10100000'  
	    movwf   PORTC
	    bsf	    PORTB,1 
	    call    Enable
	    call    Retardo_2ms
	    return
especial
	    movlw   B'11111011'  
	    movwf   PORTC
	    bsf	    PORTB,1 
	    call    Enable
	    call    Retardo_2ms
	    return
	    
Emayus	    
	    movlw   b'01000101'  
	    movwf   PORTC
	    bsf	    PORTB,1  
	    call    Enable
	    call    Retardo_2ms
	    return
	    
Imayus
	    movlw   b'01001001'  
	    movwf   PORTC
	    bsf	    PORTB,1 
	    call    Enable
	    call    Retardo_2ms
	    return

Dmayus
	    movlw   b'01000100'  
	    movwf   PORTC
	    bsf	    PORTB,1  
	    call    Enable
	    call    Retardo_2ms
	    return
	    
z
	    movlw   b'01111010'  
	    movwf   PORTC
	    bsf	    PORTB,1 
	    call    Enable
	    call    Retardo_2ms
	    return
	    
q
	    movlw   b'01110001'  
	    movwf   PORTC
	    bsf	    PORTB,1 
	    call    Enable
	    call    Retardo_2ms
	    return
bi
	    movlw   b'01000010'  
	    movwf   PORTC
	    bsf	    PORTB,1 
	    call    Enable
	    call    Retardo_2ms
	    return

;*Caracteres Especiales
	Caracter
	movlw   b'00000000'
	movwf   PORTC
	bsf	PORTB,1 
	call    Enable
	return
	
	Carrito
	bcf PORTB,1
	movlw b'00000000'	;1ra fila Escribe y Guarda
	movwf PORTC
	call Enable
	bcf PORTB,1
	movlw b'01000000'
	movwf PORTC
	call Enable
	bsf PORTB,1
	movlw b'00000000'	;2da fila Escribe y Guarda
	movwf PORTC
	call Enable
	bcf PORTB,1
	movlw b'01000001'
	movwf PORTC
	call Enable
	bsf PORTB,1

	movlw b'00010010'	;3ra fila Escribe y Guarda
	movwf PORTC
	call Enable
	bcf PORTB,1
	movlw b'01000010'
	movwf PORTC
	call Enable
	bsf PORTB,1

	movlw b'00011010'	;4ta fila Escribe y Guarda
	movwf PORTC
	call Enable
	bcf PORTB,1
	movlw b'01000011'
	movwf PORTC
	call Enable
	bsf PORTB,1

	movlw b'00011111'	;5ta fila Escribe y Guarda
	movwf PORTC
	call Enable
	bcf PORTB,1
	movlw b'01000100'
	movwf PORTC
	call Enable
	bsf PORTB,1

	movlw b'00011010'	;6ta fila Escribe y Guarda
	movwf PORTC
	call Enable
	bcf PORTB,1
	movlw b'01000101'
	movwf PORTC
	call Enable
	bsf PORTB,1

	movlw b'00010010'	;7ma fila 
	movwf PORTC
	call Enable		;no se porque cuando guardo en las últimas dos se desverga el caracter asi que lo quite
	movlw b'00000000'	;8va fila
	movwf PORTC
	call Enable
	
	Caracter1
	movlw   b'00001000'
	movwf   PORTC
	bsf	PORTB,1 
	call    Enable
	return
	 
	;** NOTAS MUSICALES **;

	LA_SOSTC3
	bsf PORTB,7
	call Retardo_1ms
	nop
	bcf PORTB,7
	call Retardo_1ms
	call Retardo_20micros
	nop
	return 
	
	SI_C3
	bsf PORTB,7
	call Retardo_1ms

	nop
	bcf PORTB,7
	call Retardo_1ms
	nop
	return
	
	RE_SOSTC4
	bsf PORTB,7
	call Retardo_500micros
	call Retardo_200micros
	call Retardo_100micros
	call Retardo_5micros
	nop
	bcf PORTB,7
	call Retardo_500micros
	call Retardo_200micros
	call Retardo_100micros
	call Retardo_5micros
	nop
	return
	
	FA_C4
	bsf PORTB,7
	call Retardo_500micros
	call Retardo_200micros
	call Retardo_10micros
	call Retardo_5micros
	nop
	bcf PORTB,7
	call Retardo_500micros
	call Retardo_200micros
	call Retardo_10micros
	call Retardo_5micros
	nop
	return
	
	FA_SOSTC4
	bsf PORTB,7
	call Retardo_500micros
	call Retardo_100micros
	call Retardo_50micros
	call Retardo_20micros
	call Retardo_5micros
	nop
	bcf PORTB,7
	call Retardo_500micros
	call Retardo_100micros
	call Retardo_50micros
	call Retardo_20micros
	call Retardo_5micros
	nop
	return
	
	SOL_SOSTC4
	bsf PORTB,7
	call Retardo_500micros
	call Retardo_100micros
	nop
	bcf PORTB,7
	call Retardo_500micros
	call Retardo_100micros
	nop
	return
		
CancionRecto
	movlw d'186'
	movwf CONT_A
	call LA_SOSTC3	
	decfsz CONT_A
	goto $-2
	call Retardo_10ms
	
	movlw d'148'
	movwf CONT_A
	call SI_C3	
	decfsz CONT_A
	goto $-2
	call Retardo_10ms
	return
	
CancionAvDer
	movlw d'240'
	movwf CONT_A
	call FA_SOSTC4	
	decfsz CONT_A
	goto $-2
	call Retardo_10ms
	
	movlw d'250'
	movwf CONT_A
	call SOL_SOSTC4	
	decfsz CONT_A
	goto $-2
	call Retardo_10ms
	return
	
CancionAvIzq
	movlw d'155'
	movwf CONT_A
	call RE_SOSTC4	
	decfsz CONT_A
	goto $-2
	call Retardo_10ms
	
	movlw d'186'
	movwf CONT_A
	call LA_SOSTC3	
	decfsz CONT_A
	goto $-2
	call Retardo_10ms
	
	return
	
CancionReversa
	movlw d'255'
	movwf CONT_A
	call FA_C4	
	decfsz CONT_A
	goto $-2
	movlw d'25'
	movwf CONT_A
	call FA_C4	
	decfsz CONT_A
	goto $-2
	call Retardo_10ms
	
	movlw d'155'
	movwf CONT_A
	call RE_SOSTC4	
	decfsz CONT_A
	goto $-2
	call Retardo_10ms
	return
	
CancionRevDer
	movlw d'255'
	movwf CONT_A
	call FA_C4	
	decfsz CONT_A
	goto $-2
	return
	
CancionRevIzq
	movlw d'148'
	movwf CONT_A
	call SI_C3	
	decfsz CONT_A
	goto $-2
	call Retardo_10ms
	return
TokyoDrift
	
	movlw d'186'
	movwf CONT_A
	call LA_SOSTC3	
	decfsz CONT_A
	goto $-2
	
	call Retardo_100ms
	
	movlw d'186'
	movwf CONT_A
	call LA_SOSTC3	
	decfsz CONT_A
	goto $-2
	
	call Retardo_100ms
	
	movlw d'186'
	movwf CONT_A
	call LA_SOSTC3	
	decfsz CONT_A
	goto $-2
	
	call Retardo_100ms
	
	movlw d'186'
	movwf CONT_A
	call LA_SOSTC3	
	decfsz CONT_A
	goto $-2
	
	call Retardo_100ms
	
	movlw d'186'
	movwf CONT_A
	call LA_SOSTC3	
	decfsz CONT_A
	goto $-2
	
	call Retardo_20ms
	
	movlw d'148'
	movwf CONT_A
	call SI_C3	
	decfsz CONT_A
	goto $-2
	
	call Retardo_50ms
	
	movlw d'155'
	movwf CONT_A
	call RE_SOSTC4	
	decfsz CONT_A
	goto $-2
	
	call Retardo_50ms
	
	movlw d'186'
	movwf CONT_A
	call LA_SOSTC3	
	decfsz CONT_A
	goto $-2
	
	call Retardo_100ms
	
	movlw d'186'
	movwf CONT_A
	call LA_SOSTC3	
	decfsz CONT_A
	goto $-2
	
	call Retardo_100ms
	
	movlw d'186'
	movwf CONT_A
	call LA_SOSTC3	
	decfsz CONT_A
	goto $-2
	
	call Retardo_20ms
	
	movlw d'148'
	movwf CONT_A
	call SI_C3	
	decfsz CONT_A
	goto $-2
	
	call Retardo_50ms
	
	movlw d'155'
	movwf CONT_A
	call RE_SOSTC4	
	decfsz CONT_A
	goto $-2
	
	call Retardo_50ms
	
	movlw d'186'
	movwf CONT_A
	call LA_SOSTC3	
	decfsz CONT_A
	goto $-2
	
	call Retardo_100ms
	
	movlw d'186'
	movwf CONT_A
	call LA_SOSTC3	
	decfsz CONT_A
	goto $-2
	
	call Retardo_100ms
	
	movlw d'186'
	movwf CONT_A
	call LA_SOSTC3	
	decfsz CONT_A
	goto $-2
	
	call Retardo_20ms
	
	movlw d'148'
	movwf CONT_A
	call SI_C3	
	decfsz CONT_A
	goto $-2
	
	call Retardo_50ms
	
	movlw d'155'
	movwf CONT_A
	call RE_SOSTC4	
	decfsz CONT_A
	goto $-2
	
	call Retardo_50ms
	
	movlw d'255'
	movwf CONT_A
	call FA_C4	
	decfsz CONT_A
	goto $-2
	movlw d'25'
	movwf CONT_A
	call FA_C4	
	decfsz CONT_A
	goto $-2
	
	call Retardo_100ms
	
	
	movlw d'255'
	movwf CONT_A
	call FA_C4	
	decfsz CONT_A
	goto $-2
	movlw d'25'
	movwf CONT_A
	call FA_C4	
	decfsz CONT_A
	goto $-2
	
	call Retardo_50ms
	
	movlw d'250'
	movwf CONT_A
	call SOL_SOSTC4	
	decfsz CONT_A
	goto $-2
	
	call Retardo_50ms
	
	movlw d'240'
	movwf CONT_A
	call FA_SOSTC4	
	decfsz CONT_A
	goto $-2

	call Retardo_50ms
	
	movlw d'140'
	movwf CONT_A
	call FA_C4	
	decfsz CONT_A
	goto $-2
	
	call Retardo_50ms
	
	movlw d'186'
	movwf CONT_A
	call RE_SOSTC4	
	decfsz CONT_A
	goto $-2
	
	call Retardo_100ms
	
	movlw d'248'
	movwf CONT_A
	call RE_SOSTC4	
	decfsz CONT_A
	goto $-2
	
	call Retardo_100ms
	
	movlw d'250'
	movwf CONT_A
	call SOL_SOSTC4	
	decfsz CONT_A
	goto $-2
	
	call Retardo_50ms
	
	movlw d'240'
	movwf CONT_A
	call FA_SOSTC4	
	decfsz CONT_A
	goto $-2

	call Retardo_50ms
	
	movlw d'140'
	movwf CONT_A
	call FA_C4	
	decfsz CONT_A
	goto $-2
	
	call Retardo_50ms
	
	movlw d'186'
	movwf CONT_A
	call RE_SOSTC4	
	decfsz CONT_A
	goto $-2
	
	call Retardo_100ms
	
	movlw d'248'
	movwf CONT_A
	call RE_SOSTC4	
	decfsz CONT_A
	goto $-2
	
	call Retardo_100ms
	
	movlw d'186'
	movwf CONT_A
	call LA_SOSTC3	
	decfsz CONT_A
	goto $-2
	
	call Retardo_20ms
	
	movlw d'148'
	movwf CONT_A
	call SI_C3	
	decfsz CONT_A
	goto $-2
	
	call Retardo_50ms
	
	movlw d'155'
	movwf CONT_A
	call RE_SOSTC4	
	decfsz CONT_A
	goto $-2
	
	call Retardo_50ms
	
	movlw d'186'
	movwf CONT_A
	call LA_SOSTC3	
	decfsz CONT_A
	goto $-2
	
	call Retardo_100ms
	
	movlw d'186'
	movwf CONT_A
	call LA_SOSTC3	
	decfsz CONT_A
	goto $-2
	
	call Retardo_100ms
	
	movlw d'186'
	movwf CONT_A
	call LA_SOSTC3	
	decfsz CONT_A
	goto $-2
	
	call Retardo_20ms
	
	movlw d'148'
	movwf CONT_A
	call SI_C3	
	decfsz CONT_A
	goto $-2
	
	call Retardo_50ms
	
	movlw d'155'
	movwf CONT_A
	call RE_SOSTC4	
	decfsz CONT_A
	goto $-2
	call Retardo_50ms
	
	movlw d'186'
	movwf CONT_A
	call LA_SOSTC3	
	decfsz CONT_A
	goto $-2
	
	call Retardo_100ms
	
	movlw d'186'
	movwf CONT_A
	call LA_SOSTC3	
	decfsz CONT_A
	goto $-2
	
	call Retardo_200ms
	call Retardo_200ms
	call Retardo_200ms
	call Retardo_200ms
	call Retardo_200ms
	call Retardo_200ms
;; Encendido de Leds
    LuzVerde
	bsf PORTB,3
	return
    
    LuzAmarilla
	bsf PORTB,4
	return
	
    LuzRoja
	bsf PORTB,5
	return
	
ApagarVerde
	bcf PORTB,3
	return

ApagarAmarilla
	bcf PORTB,4
	return

ApagarRoja
	bcf PORTB,5
	return

	call Retardo_50ms
#INCLUDE <RETARDOS.INC> 
END
	









