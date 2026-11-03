.model small
.stack 100h

.DATA

    ;----------------------------------------
    ; MENSAJES DEL MENU PRINCIPAL
    ;----------------------------------------

    msgError db 13,10,"ERROR, solo se permiten NUMEROS del 1-5","$"
    msgErrorSN db 13,10,"Ingrese S o N solamente","$"

    msgbienvenida1 db 13,10,'====================================================================',13,10
                   db '           UNIVERSIDAD MARIANO GALVEZ - ARQUITECTURA 8086',13,10
                   db '====================================================================',13,10
                   db '1. Clasificador de Caracteres',13,10
                   db '2. Generador de Codigo Hamming (10 bits -> 14 bits)',13,10
                   db '3. Conversor de Bases Numericas (Decimal a Binario/Hex)',13,10
                   db '4. Juego Interactivo de Aritmetica por Mouse (3 Niveles / 12 Preguntas)',13,10
                   db '5. Salir del Sistema',13,10
                   db '====================================================================','$'

    opcionM db 13,10,"Ingrese una opcion [1-5]: $"

    bienvenida2 db 13,10,"Generador de Codigo Hamming: $"
    bienvenida3 db 13,10,"Conversor de Bases Numericas: $"
    bienvenida4 db 13,10,"Juego Interactivo de Aritmetica por Mouse: $"

    msgcontinuar db 13,10,"Desea continuar? S/N: $"

    opcion db ?

    ;----------------------------------------
    ; VARIABLES DEL MODULO 1
    ; CLASIFICADOR DE CARACTERES
    ;----------------------------------------

    MSJ_TITULO DB 13,10,'==================================================',13,10
               DB '             CLASIFICADOR DE CARACTERES',13,10
               DB '==================================================$'

    MSJ_PEDIR DB 13,10,'Ingrese exactamente 19 caracteres: $'

    MSJ_RESULT DB 13,10,13,10,'--- RESUMEN DE CLASIFICACION ---$'

    MSJ_MAYUS DB 13,10,13,10,'1. MAYUSCULAS [Total: $'
    MSJ_MINUS DB 13,10,13,10,'2. MINUSCULAS [Total: $'
    MSJ_NUMS DB 13,10,13,10,'3. NUMEROS    [Total: $'
    MSJ_ESPEC DB 13,10,13,10,'4. ESPECIALES [Total: $'

    MSJ_LISTA DB ']: $'
    MSJ_VACIO DB 'Ninguno$'

    ;para pruebas le deje 19 pero deberian de ser 50
    BUF_TODO  DB 19 DUP(0)


    BUF_MAYUS DB 40 DUP('$')
    BUF_MINUS DB 40 DUP('$')
    BUF_NUMS  DB 40 DUP('$')
    BUF_ESPEC DB 40 DUP('$')

    CANT_MAYUS DB 0
    CANT_MINUS DB 0
    CANT_NUMS DB 0
    CANT_ESPEC DB 0  
    
    
    ;---------------------------------
    ; 2) VARIABLES DEL MODULO HAMMING
    ;----------------------------------

    msgHamming DB 10,13,'===== CODIGO HAMMING =====',10,13,'$'  
    msgPedirH DB 10,13,'Ingrese 10 bits: $'
    msgErrorH DB 10,13,'Error: ingrese exactamente 10 bits (0 y 1).',10,13,'$' 
    msgResultadoH DB 10,13,10,13,'Codigo Hamming de 14 bits: $'
    entradaH DB 11,0,11 DUP(0) 
    codigoH DB 14 DUP(0) 
      ;---------------- FIN VARIABLES MODULO 2 ----------------
     
    ;---------------- VARIABLES MODULO 3 ----------------

    entradaD DB 4,0,4 DUP(0)
    numero   DB 0
    temporal DB 0
    
    binario  DB 8 DUP(0)
    
    hex1     DB 0
    hex2     DB 0
    
    msgDecimal DB 10,13,"Ingrese un decimal de 0 a 255: $"
    msgErrorD  DB 10,13,"Error: ingrese un numero entre 0 y 255.",10,13,"$"
    msgBinario DB 10,13,"Binario de 8 bits: $"
    msgHex     DB 10,13,"Hexadecimal de 2 digitos: $"  
    
    ;---------------- FIN VARIABLES MODULO 3 ----------------


    ;----------------------------------------
    ; VARIABLES DEL MODULO 4
    ; Juego Interactivo de Aritmética por Mouse (3 Niveles / 12 Preguntas)
    ;----------------------------------------   
    msgOpc4Titulo DB 10,13,'==================================================',10,13
                  DB       '             Juego "Math Quiz Click" ',10,13   
                  DB       '             Seleccione un nivel ',10,13
                  DB       '==================================================',10,13
                  DB '   1) Facil: Sumas y restas con operandos de 1 dígito (0-9)', 10, 13
                  DB '   2) Medio: operandos de hasta 2 dígitos (0-50)', 10, 13
                  DB '   3) Dificil: Operaciones compuestas', 10, 13
                  DB "===============================================================================$"
    SelecNivel   DB 10, 13, 10, 13, 'En que nivel empiezas: $'




msgCorrecto    DB 10, 13, 10, 13, 'Felicidades Respuesta Correcta $',10,13
msgIincorrecto DB 10, 13, 10, 13, 'Error Respuesta Equivocada  $',10,13
msgTeclaCont   DB 10, 13, 10, 13, 'Presiona cualquier tecla para continuar... $'


puntos        DB 0            
totalPreg       DB 0            
msgResul   DB 10, 13, 10, 13, 'Terminaste el juego. Puntaje total: $'


; ------------------------------------------------------------
;  NIVEL 1 (FACIL): sumas y restas, operandos 0 - 9
; ------------------------------------------------------------
Nivel1p1   DB 10, 13, 'Pregunta: Cuanto es 5 + 6?',10,13
           DB '   1) 12       ',10,13
           DB '   2) 10       ',10,13
           DB '   3) 11       $'      ; correcta

Nivel1p2   DB 10, 13, 'Pregunta: Cuanto es 8 - 3?',10,13
           DB '   1) 6        ',10,13
           DB '   2) 5        ',10,13    ; correcta
           DB '   3) 4        $'      

Nivel1p3   DB 10, 13, 'Pregunta: Cuanto es 9 + 7?',10,13
           DB '   1) 16       ',10,13   ; correcta
           DB '   2) 17       ',10,13
           DB '   3) 15       $'      

Nivel1p4   DB 10, 13, 'Pregunta: Cuanto es 9 - 6?',10,13
           DB '   1) 2        ',10,13
           DB '   2) 4        ',10,13
           DB '   3) 3        $'      ; correcta
    
; ------------------------------------------------------------
;  NIVEL 2 (MEDIO): sumas, restas y multiplicaciones, operandos 0 - 50
; ------------------------------------------------------------
Nivel2p1   DB 10, 13, 'Pregunta: Cuanto es 40 - 17?', 10, 13
           DB '   1) 33       ', 10, 13
           DB '   2) 23       ', 10, 13   ; correcta
           DB '   3) 22       $'      

Nivel2p2   DB 10, 13, 'Pregunta: Cuanto es 12 x 4?', 10, 13
           DB '   1) 48       ', 10, 13       ; correcta
           DB '   2) 44       ', 10, 13
           DB '   3) 52       $'      

Nivel2p3   DB 10, 13, 'Pregunta: Cuanto es 27 + 36?', 10, 13
           DB '   1) 62       ', 10, 13
           DB '   2) 64       ', 10, 13
           DB '   3) 63       $'      ; correcta

Nivel2p4   DB 10, 13, 'Pregunta: Cuanto es 50 - 29?', 10, 13
           DB '   1) 21       ', 10, 13    ; correcta
           DB '   2) 29       ', 10, 13
           DB '   3) 31       $'      


; ------------------------------------------------------------
;  NIVEL 3 (DIFICIL): combinadas o multiplicacion/division, resultados hasta 255
; ------------------------------------------------------------
Nivel3p1   DB 10, 13, 'Pregunta: Cuanto es 14 x 15?', 10, 13
           DB '   1) 200      ', 10, 13
           DB '   2) 210      ', 10, 13     ; correcta
           DB '   3) 220      $'      

Nivel3p2  DB 10, 13, 'Pregunta: Cuanto es (30 + 20) x 4?', 10, 13
          DB '   1) 180      ', 10, 13
          DB '   2) 220      ', 10, 13
          DB '   3) 200      $'      ; correcta

Nivel3p3  DB 10, 13, 'Pregunta: Cuanto es 196 / 14?', 10, 13
          DB '   1) 14       ', 10, 13      ; correcta
          DB '   2) 12       ', 10, 13
          DB '   3) 16       $'      

Nivel3p4  DB 10, 13, 'Pregunta: Cuanto es 200 + 5 x 9?', 10, 13
          DB '   1) 235      ', 10, 13
          DB '   2) 245      ', 10, 13        ; correcta
          DB '   3) 255      $'      

.CODE



inicio proc

    mov ax,@data
    mov ds,ax

menu_principal:

    call mostrar_menu
    call leer_opcion
    call validar_opcion

    cmp opcion,35h
    je salir

    call mostrar_modulo

repetir_modulo:

    call preguntar_continuar

    cmp al,53h
    je repetir

    cmp al,73h
    je repetir

    jmp menu_principal

repetir:

    call mostrar_modulo
    jmp repetir_modulo

inicio endp


mostrar_menu proc

    mov ah,00h
    mov al,03h
    int 10h

    lea dx,msgbienvenida1
    mov ah,09h
    int 21h

    lea dx,opcionM
    mov ah,09h
    int 21h

    ret

mostrar_menu endp



; LEER OPCION

leer_opcion proc

    mov ah,01h
    int 21h

    mov opcion,al

    ret

leer_opcion endp


; VALIDAR OPCION


validar_opcion proc

validar:

    mov bl,opcion

    cmp bl,31h
    jb error_opcion

    cmp bl,35h
    ja error_opcion

    ret

error_opcion:

    lea dx,msgError
    mov ah,09h
    int 21h

    lea dx,opcionM
    mov ah,09h
    int 21h

    call leer_opcion

    jmp validar

validar_opcion endp



; ACA ES PARA MOSTRAR Y EJECUTAR MODULO Y VALIDO


mostrar_modulo proc

    mov ah,00h
    mov al,03h
    int 10h

    cmp opcion,31h
    je modulo1

    cmp opcion,32h
    je modulo2

    cmp opcion,33h
    je modulo3

    cmp opcion,34h
    je modulo4

    ret

modulo1:

    call clasificador
    ret

modulo2:
    ;aqui iria el call a hamming mio 
    call hamming

modulo3:
     ;aqui iria el call al conversor tuyo 
    call convertidor
    ret

modulo4:
    ;call juego entre los 2
    Call juego    
    ret

mostrar_modulo endp



; MODULO 1 - CLASIFICADOR DE CARACTERES


clasificador proc

    ; REINICIAR CONTADORES

    mov CANT_MAYUS,0
    mov CANT_MINUS,0
    mov CANT_NUMS,0
    mov CANT_ESPEC,0

    ; MOSTRAR TITULO

    lea dx,MSJ_TITULO
    mov ah,09h
    int 21h

    lea dx,MSJ_PEDIR
    mov ah,09h
    int 21h


    mov si,0
    mov cx,19

CAPTURA:

    mov ah,01h
    int 21h

    mov BUF_TODO[si],al

    inc si
    dec cx
    jnz CAPTURA

    mov si,0
    mov cx,19

CLASIFICAR:

    mov bl,BUF_TODO[si]

    ; MAYUSCULAS

    cmp bl,41h
    jb  ES_MINUS

    cmp bl,5Ah
    ja  ES_MINUS

    mov al,CANT_MAYUS
    mov ah,0
    mov di,ax
    add di,di                    

    mov BUF_MAYUS[di],bl
    mov BUF_MAYUS[di+1],' '

    inc CANT_MAYUS
    jmp SIGUIENTE

ES_MINUS:

    ; MINUSCULAS

    cmp bl,61h
    jb  ES_NUM

    cmp bl,7Ah
    ja  ES_NUM

    mov al,CANT_MINUS
    mov ah,0
    mov di,ax
    add di,di

    mov BUF_MINUS[di],bl
    mov BUF_MINUS[di+1],' '

    inc CANT_MINUS
    jmp SIGUIENTE

ES_NUM:

    ; NUMEROS

    cmp bl,30h
    jb  ES_ESPEC

    cmp bl,39h
    ja  ES_ESPEC

    mov al,CANT_NUMS
    mov ah,0
    mov di,ax
    add di,di

    mov BUF_NUMS[di],bl
    mov BUF_NUMS[di+1],' '

    inc CANT_NUMS
    jmp SIGUIENTE

ES_ESPEC:

    ; ESPECIALES

    mov al,CANT_ESPEC
    mov ah,0
    mov di,ax
    add di,di

    mov BUF_ESPEC[di],bl
    mov BUF_ESPEC[di+1],' '

    inc CANT_ESPEC

SIGUIENTE:

    inc si
    dec cx
    jnz CLASIFICAR


    mov al,CANT_MAYUS
    mov ah,0
    mov di,ax
    add di,di
    mov BUF_MAYUS[di],'$'

    mov al,CANT_MINUS
    mov ah,0
    mov di,ax
    add di,di
    mov BUF_MINUS[di],'$'

    mov al,CANT_NUMS
    mov ah,0
    mov di,ax
    add di,di
    mov BUF_NUMS[di],'$'

    mov al,CANT_ESPEC
    mov ah,0
    mov di,ax
    add di,di
    mov BUF_ESPEC[di],'$'


    lea dx,MSJ_RESULT
    mov ah,09h
    int 21h

    lea dx,MSJ_MAYUS
    lea si,BUF_MAYUS
    mov al,CANT_MAYUS
    call imprimir_categoria

    lea dx,MSJ_MINUS
    lea si,BUF_MINUS
    mov al,CANT_MINUS
    call imprimir_categoria

    lea dx,MSJ_NUMS
    lea si,BUF_NUMS
    mov al,CANT_NUMS
    call imprimir_categoria

    lea dx,MSJ_ESPEC
    lea si,BUF_ESPEC
    mov al,CANT_ESPEC
    call imprimir_categoria

    ret

clasificador endp


imprimir_categoria proc

    mov cl,al                    

    mov ah,09h
    int 21h                    

    mov al,cl
    mov ah,0
    mov bl,10
    div bl                       

    mov bh,ah

    cmp al,1
    jb  UNIDAD

    add al,30h
    mov dl,al
    mov ah,02h
    int 21h

UNIDAD:

    mov dl,bh
    add dl,30h
    mov ah,02h
    int 21h

    lea dx,MSJ_LISTA
    mov ah,09h
    int 21h

    cmp cl,0
    ja  HAY_DATOS

    lea dx,MSJ_VACIO
    jmp IMPRIMIR

HAY_DATOS:

    mov dx,si                  

IMPRIMIR:

    mov ah,09h
    int 21h

    ret

imprimir_categoria endp

;------------------- INICIO MODULO 2 HAMMING ---------------------------------------------

    HAMMING PROC
    
        lea dx,msgHamming
        mov ah,09h
        int 21h
    
        lea dx,msgPedirH
        mov ah,09h
        int 21h
    
        ; Leo los 10 bits
        lea dx,entradaH
        mov ah,0Ah
        int 21h
    
        ;verifico si si son 10
        cmp entradaH[1],10
        jne errorH
    
   
        mov si,2
        mov cx,10
    
validarH:

        MOV AL, entradaH[SI]
    
        CMP AL, 30H
        JB errorH
    
        CMP AL, 31H
        JA errorH
    
        INC SI
        LOOP validarH
    
        JMP guardar_datos
        
    
    errorH:
    
        lea dx,msgErrorH
        mov ah,09h
        int 21h  
        
        ;pido otra vez 
        lea dx,entradaH
        mov ah,0Ah
        int 21h
    
        ret
    guardar_datos:    
    ;guardo los bits que entren en sus respectivas posiciones evitando tocar los de paridad     
    MOV SI, 2    ;inicio desde la posicion 2

    MOV AL, entradaH[SI]  
    ;ascii a numero
    SUB AL, 30H
    MOV codigoH[2], AL
    INC SI
    
    MOV AL, entradaH[SI]  
    
    SUB AL, 30H
    MOV codigoH[4], AL
    INC SI
    
    MOV AL, entradaH[SI]
    SUB AL, 30H
    MOV codigoH[5], AL
    INC SI

    MOV AL, entradaH[SI]
    SUB AL, 30H
    MOV codigoH[6], AL
    INC SI
    
    MOV AL, entradaH[SI]
    SUB AL, 30H
    MOV codigoH[8], AL
    INC SI
    
    MOV AL, entradaH[SI]
    SUB AL, 30H
    MOV codigoH[9], AL
    INC SI
    
    MOV AL, entradaH[SI]
    SUB AL, 30H
    MOV codigoH[10], AL
    INC SI
    
    MOV AL, entradaH[SI]
    SUB AL, 30H
    MOV codigoH[11], AL
    INC SI
    
    MOV AL, entradaH[SI]
    SUB AL, 30H
    MOV codigoH[12], AL
    INC SI
    
    MOV AL, entradaH[SI]
    SUB AL, 30H
    MOV codigoH[13], AL 
        
    logica_hamming:
    
     ; PARIDAD 1

    MOV AL, codigoH[2]
    ADD AL, codigoH[4]
    ADD AL, codigoH[6]
    ADD AL, codigoH[8]
    ADD AL, codigoH[10]
    ADD AL, codigoH[12]
    
    MOV AH, 0
    MOV BL, 2
    DIV BL
    
    MOV codigoH[0], AH
    
      ;paridad 2
      

        MOV AL, codigoH[2]
        ADD AL, codigoH[5]
        ADD AL, codigoH[6]
        ADD AL, codigoH[9]
        ADD AL, codigoH[10]
        ADD AL, codigoH[13]
        
        MOV AH, 0
        MOV BL, 2
        DIV BL
        
        MOV codigoH[1], AH
      
      ;paridad 3
       
       MOV AL, codigoH[4]
       ADD AL, codigoH[5]
       ADD AL, codigoH[6]
       ADD AL, codigoH[11]
       ADD AL, codigoH[12]
       ADD AL, codigoH[13]
      
       MOV AH, 0
       MOV BL, 2
       DIV BL
        
       MOV codigoH[3], AH  
       
       
        ; PARIDAD 4

        MOV AL, codigoH[8]
        ADD AL, codigoH[9]
        ADD AL, codigoH[10]
        ADD AL, codigoH[11]
        ADD AL, codigoH[12]
        ADD AL, codigoH[13]
        
        MOV AH, 0
        MOV BL, 2
        DIV BL
        
        MOV codigoH[7], AH    
        
        
        LEA DX, msgResultadoH
        MOV AH, 09H
        INT 21H    
        
        
        
        MOV SI, 0
        MOV CX, 14
        
        MOSTRAR_HAMMING:  
 
         MOV DL, codigoH[SI]
         ADD DL, 30H
         MOV AH, 02H
         INT 21H
        
         INC SI
         LOOP MOSTRAR_HAMMING 
         
         jmp repetir_modulo
     
    HAMMING ENDP


; -----------------------------------AQUI TERMINA HAMMMIGN MODULO 2   -------------------------------------------------




;------- MODULO 3 -----------------------------------------------------------------------------------


convertidor PROC


pedirD:

    lea dx,msgDecimal
    mov ah,09h
    int 21h

 
    lea dx,entradaD
    mov ah,0Ah
    int 21h

    ; Verifico que no este vacio
    cmp entradaD[1],0
    je errorD

    ; Verifico que tenga maximo 3 digitos
    cmp entradaD[1],3
    ja errorD


    ;---------------- VALIDAR LOS CARACTERES ----------------

    mov si,2
    mov cl,entradaD[1]
    mov ch,0

validarD:

    mov al,entradaD[si]

    cmp al,30h
    jb errorD

    cmp al,39h
    ja errorD

    inc si
    loop validarD


    ;---------------- CONVERTIR ASCII A DECIMAL ----------------

    mov numero,0
    mov si,2 
    ;estos dos se hacen en combo para usar el contador Cx del loop
    mov cl,entradaD[1]
    mov ch,0

convertirDecimal:

    ; Multiplicar el numero acumulado por 10
    mov al,numero
    mov bl,10
    mul bl
    ; Obtener el siguiente digito
    mov dl,entradaD[si]
    sub dl,30h
    mov dh,0

    ; Sumar el nuevo digito
    add ax,dx

    ; Verificar que no supere 255
    cmp ax,255
    ja errorD

    mov numero,al

    inc si
    loop convertirDecimal


    ;---------------- CONVERSION A BINARIO ----------------

    mov al,numero    ;pmi numero original que ya volvi decimal
    mov temporal,al  ;para guardar el cociente

    mov si,0 ;desla posicion 0 del arreglo
    mov cx,8

convertirBinario:

    mov al,temporal
    mov ah,0 
    
    mov bl,2
    div bl

    ; Guardar el residuo
    mov binario[si],ah       ;fraccion

    ; Guardar el cociente
    mov temporal,al  ;numero grande

    inc si
    loop convertirBinario


    ;---------------- MOSTRAR BINARIO ----------------

    lea dx,msgBinario
    mov ah,09h
    int 21h

    ;aqui lo hago al reves para mostrar los numeros
    mov si,7
    mov cx,8

mostrarBinario:

    mov dl,binario[si]
    add dl,30h
    mov ah,02h
    int 21h

    dec si
    loop mostrarBinario


    ;---------------- CONVERSION A HEXADECIMAL ----------------

    mov al,numero
    mov ah,0
    mov bl,16
    div bl

    ; Guardo cociente y residuo
    mov hex1,al
    mov hex2,ah


    ;---------------- MOSTRAR HEXADECIMAL ----------------

    lea dx,msgHex
    mov ah,09h
    int 21h


    ; aqui valido 

    mov dl,hex1
    
    ;si en hex es de 0-9
    cmp dl,9
    jbe primerNumero

     
    ;si en hex es de 10-15  
    add dl,37h
    jmp mostrarPrimer

primerNumero:

    add dl,30h

mostrarPrimer:

    mov ah,02h
    int 21h


    ; Mostrar segundo digito lo mismo
      
      
    ;si en hex es de 0-9
    mov dl,hex2
    cmp dl,9
    jbe segundoNumero

     ;si en hex es de 10-15
    add dl,37h
    jmp mostrarSegundo

segundoNumero:

    add dl,30h

mostrarSegundo:

    mov ah,02h
    int 21h

    ret


errorD:

    lea dx,msgErrorD
    mov ah,09h
    int 21h

    jmp pedirD


convertidor ENDP

;------------------- FIN MODULO 3 CONVERSOR DE BASES -----------------------------

 
;------- MODULO 4 -----------------------------------------------------------------------------------
J_X_MIN    equ 24          ; columna 3: numero de la opcion
 J_Y_MIN    equ 16
 J_Y_OP1    equ 23
 J_Y_OP2    equ 31
 J_Y_OP3    equ 39
 juego_ANCHO_1D equ 55          ; respuesta de 1 digito  (X maximo)
 juego_ANCHO_2D equ 63          ; respuesta de 2 digitos
 juego_ANCHO_3D equ 71          ; respuesta de 3 digitos
 
 juego proc

    mov puntos,0                ; reiniciar puntaje en cada partida

    ; inicia juego 
    lea dx,msgOpc4Titulo       
    mov ah,09h
    int 21h


 juego_pedir:
    lea dx,SelecNivel
    mov ah,09h
    int 21h

    mov ah,01h
    int 21h

    cmp al,'1'
    je  juego_elige1
    cmp al,'2'
    je  juego_elige2
    cmp al,'3'
    je  juego_elige3
    jmp  juego_pedir                 ; tecla invalida: volver a preguntar

 juego_elige1:
    mov totalPreg,12            ; niveles 1 + 2 + 3
    jmp  juego_mouse
 juego_elige2:
    mov totalPreg,8             ; niveles 2 + 3
    jmp  juego_mouse
 juego_elige3:
    mov totalPreg,4             ; solo nivel 3

 juego_mouse:                   ; inicializar mouse 
    mov ax,0000h
    int 33h
    cmp ax,0000h
    jne  juego_mouse_ok
    ret
 juego_mouse_ok:
    cmp totalPreg,12
    je  juego_nivel1
    cmp totalPreg,8
    je  juego_nivel2
    jmp juego_nivel3


    ; ---------------- NIVEL 1 ----------------
    ; SI = pregunta, BL = opcion correcta, DI = X maximo segun digitos
 juego_nivel1:

    lea si,Nivel1p1
    mov bl,3
    mov di,juego_ANCHO_2D
    call  juego_pregunta

    lea si,Nivel1p2
    mov bl,2
    mov di, juego_ANCHO_1D
    call  juego_pregunta

    lea si,Nivel1p3
    mov bl,1
    mov di, juego_ANCHO_2D
    call  juego_pregunta

    lea si,Nivel1p4
    mov bl,3
    mov di, juego_ANCHO_1D
    call  juego_pregunta


    ; ---------------- NIVEL 2 ----------------
 juego_nivel2:

    lea si,Nivel2p1
    mov bl,2
    mov di, juego_ANCHO_2D
    call  juego_pregunta

    lea si,Nivel2p2
    mov bl,1
    mov di, juego_ANCHO_2D
    call  juego_pregunta

    lea si,Nivel2p3
    mov bl,3
    mov di, juego_ANCHO_2D
    call  juego_pregunta

    lea si,Nivel2p4
    mov bl,1
    mov di, juego_ANCHO_2D
    call  juego_pregunta


    ; ---------------- NIVEL 3 ----------------
 juego_nivel3:

    lea si,Nivel3p1
    mov bl,2
    mov di, juego_ANCHO_3D
    call  juego_pregunta

    lea si,Nivel3p2
    mov bl,3
    mov di, juego_ANCHO_3D
    call  juego_pregunta

    lea si,Nivel3p3
    mov bl,1
    mov di, juego_ANCHO_2D
    call  juego_pregunta

    lea si,Nivel3p4
    mov bl,2
    mov di, juego_ANCHO_3D
    call juego_pregunta

    ; ---------------- RESULTADO FINAL ----------------
    mov ax,0003h
    int 10h

    lea dx,msgResul
    mov ah,09h
    int 21h
                                               
    mov al,puntos               ; "X de Y"
    call juego_ImprimirNum

    mov ah,02h
    mov dl,' '
    int 21h
    mov dl,'d'
    int 21h
    mov dl,'e'
    int 21h
    mov dl,' '
    int 21h

    mov al,totalPreg
    call  juego_ImprimirNum

    lea dx,msgTeclaCont
    mov ah,09h
    int 21h
    mov ah,08h                  ; esperar una tecla
    int 21h

    ret

 juego endp
 



  juego_pregunta proc
    push bp
    mov bp,sp
    push di                     ; [bp-2] = X maximo
    mov bh,0
    push bx                     ; [bp-4] = opcion correcta
                                
    mov ax,0003h                ; limpiar pantalla
    int 10h

    mov dx,si                   ; imprimir pregunta
    mov ah,09h
    int 21h

    mov ax,0001h                ; mostrar puntero
    int 33h

 juego_leer:
    mov ax,0003h
    int 33h                     ; BX = botones, CX = X, DX = Y

    test bx,1                   
    jz  juego_pausa

    cmp cx,J_X_MIN
    jb  juego_pausa
    cmp cx,[bp-2]
    ja  juego_pausa

    cmp dx,J_Y_MIN
    jb  juego_pausa
    cmp dx,J_Y_OP1
    jbe  juego_op1
    cmp dx,J_Y_OP2
    jbe  juego_op2
    cmp dx,J_Y_OP3
    jbe  juego_op3
    jmp  juego_pausa

 juego_op1:
    mov al,1
    jmp  juego_eval
 juego_op2:
    mov al,2
    jmp  juego_eval
 juego_op3:
    mov al,3

 juego_eval:
    cmp al,byte ptr [bp-4]
    je  juego_acierto
    lea dx,msgIincorrecto
    jmp  juego_mostrar
 juego_acierto:
    inc puntos
    lea dx,msgCorrecto

 juego_mostrar:
    push dx                     ; guardar mensaje 

 juego_soltar:                       ; esperar a soltar el boton
    mov ax,0003h
    int 33h
    test bx,1
    jnz  juego_soltar

    mov ax,0002h                ; ocultar puntero
    int 33h

    mov ah,02h                  
    mov bh,0
    mov dh,5
    mov dl,0
    int 10h

    pop dx
    mov ah,09h
    int 21h

    lea dx,msgTeclaCont
    mov ah,09h
    int 21h

    mov ah,08h
    int 21h

    mov sp,bp
    pop bp
    ret

 juego_pausa:
    mov cx,00h                 
    mov dx,0F000h
    mov ah,86h
    int 15h
    jmp  juego_leer
 juego_pregunta endp



 ; imprime el numero que se guardo en AL (0 a 99)
 juego_ImprimirNum proc
    push ax
    push bx
    push dx

    mov ah,0
    mov bl,10
    div bl                      ; AL = decenas, AH = unidades
    mov bh,ah

    cmp al,0
    je juego_Unidades
    add al,'0'
    mov dl,al
    mov ah,02h
    int 21h

juego_Unidades:
    mov dl,bh
    add dl,'0'
    mov ah,02h
    int 21h

    pop dx
    pop bx
    pop ax
    ret
 juego_ImprimirNum endp
 

;------------------- FIN MODULO 4 JUEGO -----------------------------   



;--------- FUNCIONAMIENTO DE SALIDA GENERAL ----------------------------------------------------------------

preguntar_continuar proc

preguntar:

    lea dx,msgcontinuar
    mov ah,09h
    int 21h

    mov ah,01h
    int 21h

    cmp al,53h
    je respuesta_valida

    cmp al,73h
    je respuesta_valida

    cmp al,4Eh
    je respuesta_valida

    cmp al,6Eh
    je respuesta_valida

    lea dx,msgErrorSN
    mov ah,09h
    int 21h

    jmp preguntar

respuesta_valida:

    ret

preguntar_continuar endp


salir proc

    mov ah,4Ch
    int 21h

salir endp



END inicio     





