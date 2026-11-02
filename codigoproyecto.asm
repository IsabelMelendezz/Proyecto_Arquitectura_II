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
    
     
    ;----------------------------------------
    ; VARIABLES DEL MODULO 3
    ; Conversor de Bases Numéricas
    ;----------------------------------------   
    msgOpc3Titulo DB 10,13,'==================================================',10,13
                  DB       '             CONVERSOR DE BASES NUMERICAS',10,13
                  DB       '==================================================$'
    msgOpc3Ingreso  DB 10,13,"Ingrese un decimal de 0 a 255: $"
    msgOpc3Binario  DB 10,13, "Binario de 8 bits: $"  
    msgOpc3Hexa     DB 10,13,'Hexadecimal (2 digitos): $'
    msgOpc3Error    DB 10,13, "Solo se permite ingresar numeros del 0 al 255 $"
    VectorHexaDigitos DB  '0123456789ABCDEF'
    numero       DB 0  
    Hexa         DB 0 


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
    lea dx,bienvenida2
    mov ah,09h
    int 21h
    ret

modulo3:
     ;aqui iria el call al conversor tuyo 
    call convertidor
    ret

modulo4:
        ;call juego entre los 2
    lea dx,bienvenida4
    mov ah,09h
    int 21h
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





;------- MODULO 3 -----------------------------------------------------------------------------------




convertidor proc
 
    ; MOSTRAR TITULO
 
    lea dx,msgOpc3Titulo
    mov ah,09h
    int 21h
 
op3_pedir:
 
    lea dx,msgOpc3Ingreso
    mov ah,09h
    int 21h
 
    xor bx,bx               ;bx para acumular el numero
    xor si,si               ;si para los digitos que lee
 
op3_leer:
 
    mov ah,01h
    int 21h
 
    cmp al,13               ; Enter
    je  op3_fin_lectura
 
    cmp al,'0'
    jb  op3_error
    cmp al,'9'
    ja  op3_error
 
    sub al,30h              ; ASCII a valor
    xor ah,ah
    mov cx,ax               ; cx para el nuevo digito
 
    mov ax,bx               ; ax = acumulado * 10 + digito
    mov dx,10
    mul dx
    add ax,cx
 
    cmp ax,255              ; validar rango 0-255
    ja  op3_error
 
    mov bx,ax
    inc si
 
    cmp si,3                ; maximo 3 digitos
    jb  op3_leer
 
op3_fin_lectura:
 
    cmp si,0                ; si no escribio nada, error
    je  op3_error
 
    mov numero,bl           ; guardar el valor (0-255 cabe en 8 bits)
 
    ;---------------- BINARIO (8 bits) ----------------
 
    lea dx,msgOpc3Binario
    mov ah,09h
    int 21h
 
    mov bl,numero
    mov cx,8
 
op3_bits:
 
    shl bl,1                ; el bit sale hacia el carry
    jc  op3_uno
    mov dl,'0'
    jmp op3_imprimir_bit
 
op3_uno:
 
    mov dl,'1'
 
op3_imprimir_bit:
 
    mov ah,02h
    int 21h
    loop op3_bits
 
    ;---------------- HEXADECIMAL (2 digitos) ----------------
 
    lea dx,msgOpc3Hexa
    mov ah,09h
    int 21h
 
    ; digito alto (4 bits mas significativos)
    mov al,numero
    mov cl,4
    shr al,cl
    xor ah,ah
    mov si,ax
    mov dl,VectorHexaDigitos[si]
    mov ah,02h
    int 21h
 
    ; digito bajo (4 bits menos significativos)
    mov al,numero
    and al,0Fh
    xor ah,ah
    mov si,ax
    mov dl,VectorHexaDigitos[si]
    mov ah,02h
    int 21h
 
    ret                     ; regresa a mostrar_modulo y preguntar_continuar
 
op3_error:
 
    lea dx,msgOpc3Error
    mov ah,09h
    int 21h
    jmp op3_pedir           ; vuelve a pedir el numero
 
convertidor endp














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





