
.model small  
.stack 100h


.data
 
    msgError db 10,13 ,"ERROR, solo se permiten NUMEROS del 1-4","$" 
    msgbienvenida1 db 10,13 ,'====================================================================', 
                   db 10,13 ,'           UNIVERSIDAD MARIANO GÁLVEZ - ARQUITECTURA 8086'
                   db 10,13 ,'====================================================================',
                   db 10,13 , '1. Clasificador de Caracteres'
                   db 10,13 , '2. Generador de Código Hamming (10 bits -> 14 bits)'
                   db 10,13 , '3. Conversor de Bases Numéricas (Decimal a Binario/Hex)'
                   db 10,13 , '4. Juego Interactivo de Aritmética por Mouse (3 Niveles / 12 Preguntas)'
                   db 10,13 , '5. Salir del Sistema',
                   db 10,13 ,'====================================================================',"$" 
    opcion2 db 10,13, " Ingrese una opción [1-5]:", "$"  
    
    bienvenida1 db 10,13 ,"Clasificador de caracteres: ","$" 
    bienvenida2 db 10,13 ,"Generador de Código Hamming: ","$"
    bienvenida3 db 10,13 ,"Conversor de Bases Numéricas: ","$"
    bienvenida4 db 10,13 ,"Juego Interactivo de Aritmética por Mouse (3 Niveles / 12 Preguntas)","$" 
    bienvenida5 db 10,13 ,"Salir del Sistema ","$"  
    
 
    msgcontinuar db 10,13 ,"Desea continuar? S/N","$"   
    
    
    ; --- BUFFERS EN MEMORIA 
    ;BUF_MAYUS   DB 50 DUP(0)
    ;BUF_MINUS   DB 50 DUP(0)
    ;BUF_NUMS    DB 50 DUP(0)
    ;BUF_ESPEC   DB 50 DUP(0)

    ; --- CONTADORES ---
    ;CANT_MAYUS  DB 0
    ;CANT_MINUS  DB 0
    ;CANT_NUMS   DB 0
    ;CANT_ESPEC  DB 0
    
    
.code 

    mov ax,@data
    mov ds,ax    
    
INICIO_PROGRAMA:
    
    ;MOV CANT_MAYUS, 0
    ;MOV CANT_MINUS, 0
    ;MOV CANT_NUMS, 0
    ;MOV CANT_ESPEC, 0

    ;MOV AX, 0003h
    ;INT 10h                      

    ;LEA DX, MSJ_TITULO
    ;MOV AH, 09h
    ;INT 21h
    
    
    ;LEA DX, MSJ_PEDIR
    ;MOV AH, 09h
    ;INT 21h     
    
sol_Dato: 
        MOV ah, 00h
        MOV al, 03h
        INT 10h
      
    lea dx,msgbienvenida1
    mov ah,9
    int 21h
    
    lea dx,opcion2
    mov ah,9
    int 21h
    
    mov ah,1
    int 21h 
    
    mov bl,al  
    
    cmp bl,31h
    jb error
    
    cmp bl,35h
    ja error
    
    case_menu:
    
    cmp bl,31h 
        MOV ah, 00h
        MOV al, 03h
        INT 10h
    je bienvenidas1 
    
    cmp bl,32h 
        MOV ah, 00h
        MOV al, 03h
        INT 10h
    je bienvenidas2
    
    cmp bl,33h
        MOV ah, 00h
        MOV al, 03h
        INT 10h
    je bienvenidas3 
    
    cmp bl,34h 
        MOV ah, 00h
        MOV al, 03h
        INT 10h
    je bienvenidas4
    
     
     
    error:
    lea dx, msgError
    mov ah,9
    int 21h
    
    jmp sol_Dato  
    
    bienvenidas1:
    lea dx, bienvenida1
    mov ah,9
    int 21h 
    jmp continuar1
    
    bienvenidas2:
    lea dx, bienvenida2
    mov ah,9
    int 21h 
    jmp continuar2
    
    bienvenidas3:
    lea dx,bienvenida3
    mov ah,9
    int 21h
    jmp continuar3
    
    bienvenidas4:
    lea dx, bienvenida4
    mov ah,9
    int 21h
    jmp continuar4
    
    continuar1:
    lea dx, msgcontinuar
    mov ah,9
    int 21h
     
    mov ah,1
    int 21h
    
    mov bl,al
    
    cmp bl, 73H
    JZ bienvenidas1 
    cmp bl,6EH 
    JZ sol_Dato
    
    continuar2:
    lea dx, msgcontinuar
    mov ah,9
    int 21h
    JNZ salir
     
    mov ah,1
    int 21h
    
    mov bl,al
    
    cmp bl, 73H
    JZ bienvenidas2
    cmp bl,6EH 
    JZ sol_Dato
    
    continuar3:
    lea dx, msgcontinuar
    mov ah,9
    int 21h
     
    mov ah,1
    int 21h
    
    mov bl,al
    
    cmp bl, 73H
    JZ bienvenidas3
    cmp bl,6EH 
    JZ sol_Dato
    
    
    
    continuar4:
    lea dx, msgcontinuar
    mov ah,9
    int 21h
     
    mov ah,1
    int 21h
    
    mov bl,al
    
    cmp bl, 73H
    JZ bienvenidas4 
     
    
    cmp bl,6EH 
    JZ sol_Dato 
    
    
    salir:
    mov ah, 4ch
    int 21h
    
    
    
    
