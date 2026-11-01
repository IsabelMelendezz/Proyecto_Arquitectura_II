
.model small
.stack 100h

.DATA

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

    bienvenida1 db 13,10,"Clasificador de caracteres: $"
    bienvenida2 db 13,10,"Generador de Codigo Hamming: $"
    bienvenida3 db 13,10,"Conversor de Bases Numericas: $"
    bienvenida4 db 13,10,"Juego Interactivo de Aritmetica por Mouse (3 Niveles / 12 Preguntas): $"

    msgcontinuar db 13,10,"Desea continuar? S/N: $"

    opcion db ?

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
    je mostrar_otro

    cmp al,73h
    je mostrar_otro

    jmp menu_principal

mostrar_otro:

    call mostrar_modulo
    jmp repetir_modulo

inicio endp



mostrar_menu proc
             
             
    ;para limpiar la pantalla          
    mov ah,00h  ;para acceder a video
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


leer_opcion proc

    mov ah,01h
    int 21h

    mov opcion,al

    ret

leer_opcion endp



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


mostrar_modulo proc
     
     ;limpio pantalla 
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
;aqui voy a tocar yo para lo de la clasificacion de numeros 

    lea dx,bienvenida1
    mov ah,09h
    int 21h

    ret

modulo2:
 ;aqui tambien yo para hamming 
    lea dx,bienvenida2
    mov ah,09h
    int 21h

    ret

modulo3:
      ;aqui tu para el converor se bases numericas
    lea dx,bienvenida3
    mov ah,09h
    int 21h

    ret

modulo4:
      ;entre los dos el juego 
    lea dx,bienvenida4
    mov ah,09h
    int 21h

    ret

mostrar_modulo endp


preguntar_continuar proc

preguntar:

    lea dx,msgcontinuar
    mov ah,09h
    int 21h

    mov ah,01h
    int 21h
      
      ;valido todos los ASCII posibles de la s y n 
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

endp inicio
