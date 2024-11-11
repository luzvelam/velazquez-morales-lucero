//lucero velazquez morales 
//verificar si un numero es primo

//codigo en python
/*
# Verificar si un número es primo
num = int(input("Introduce un número entero positivo: "))

if num <= 1:
    print(f"{num} no es un número primo.")
else:
    es_primo = True
    for i in range(2, int(num ** 0.5) + 1):
        if num % i == 0:
            es_primo = False
            break

    if es_primo:
        print(f"{num} es un número primo.")
    else:
        print(f"{num} no es un número primo.")

*/

.section .data
prompt: .asciz "Introduce un número: "
result_msg: .asciz "El número %ld es primo.\n"
not_prime_msg: .asciz "El número %ld no es primo.\n"
scanf_format: .asciz "%ld"

num: .quad 0

.section .text
.global main

main:
    // Pedir un número
    ldr x0, =prompt
    bl printf

    // Leer el número
    ldr x0, =scanf_format
    ldr x1, =num
    bl scanf

    // Cargar el número en x1
    ldr x1, =num
    ldr x1, [x1]

    // Comprobar si el número es menor que 2
    cmp x1, #2
    blt not_prime      // Si num < 2, no es primo

    // Comenzar a verificar divisores
    mov x2, #2         // x2 será el divisor
    mov x3, x1         // Guardamos el número original en x3

check_loop:
    // Calcular x2 * x2
    mul x4, x2, x2
    cmp x4, x3
    bgt is_prime       // Si x2 * x2 > num, es primo

    // Verificar si num es divisible por x2
    mov x0, x3        // Mover num a x0
    sdiv x5, x0, x2   // x5 = num / x2
    mul x6, x5, x2    // x6 = x5 * x2
    cmp x6, x3        // Comparar x6 con num
    beq not_prime      // Si son iguales, no es primo

    // Incrementar divisor
    add x2, x2, #1
    b check_loop

is_prime:
    // Imprimir que es primo
    ldr x0, =result_msg
    ldr x1, =num
    ldr x1, [x1]      // Cargar el número
    bl printf
    b end_program

not_prime:
    // Imprimir que no es primo
    ldr x0, =not_prime_msg
    ldr x1, =num
    ldr x1, [x1]      // Cargar el número
    bl printf

end_program:
    // Salir del programa
    mov x0, #0
    mov x8, #93
    svc 0
