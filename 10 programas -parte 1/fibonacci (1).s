//lucero velazquez morales 
//serie de fibonacci

//codigo en python

/*
# Serie de Fibonacci hasta el enésimo término
n = int(input("Introduce la cantidad de términos de la serie de Fibonacci que deseas ver: "))

# Inicializamos los dos primeros términos
fibonacci = [0, 1]

if n <= 0:
    print("Por favor, introduce un número positivo.")
elif n == 1:
    print(f"Serie de Fibonacci hasta {n} término: {fibonacci[0]}")
else:
    # Generamos la serie de Fibonacci hasta n términos
    for i in range(2, n):
        siguiente = fibonacci[i - 1] + fibonacci[i - 2]
        fibonacci.append(siguiente)

    print(f"Serie de Fibonacci hasta {n} términos: {fibonacci[:n]}")

*/



.section .data
prompt: .asciz "Introduce el número de términos de la serie de Fibonacci: "
result_msg: .asciz "Fibonacci[%ld] = %ld\n"
scanf_format: .asciz "%ld"

n_terms: .quad 0
fib1: .quad 0
fib2: .quad 1

.section .text
.global main

main:
    // Pedir el número de términos
    ldr x0, =prompt
    bl printf

    // Leer el número de términos
    ldr x0, =scanf_format
    ldr x1, =n_terms
    bl scanf

    // Cargar el número de términos en x1
    ldr x1, =n_terms
    ldr x1, [x1]

    // Verificar si n es menor o igual a 0
    cmp x1, #0
    ble end_program      // Si n <= 0, salir

    // Inicializar los primeros dos términos de Fibonacci
    ldr x4, =fib1
    ldr x5, =fib2
    mov x0, #0           // Primer término (0)
    str x0, [x4]         // fib1 = 0

    mov x0, #1           // Segundo término (1)
    str x0, [x5]         // fib2 = 1

    // Imprimir el primer término
    ldr x0, =result_msg
    mov x1, #0           // Índice 0
    ldr x2, [x4]         // Cargar fib1 (0)
    bl printf

    // Si solo se quiere imprimir el primer término, salir
    cmp x1, #1
    beq end_program

    // Imprimir el segundo término
    mov x1, #1           // Índice 1
    ldr x0, =result_msg
    ldr x2, [x5]         // Cargar fib2 (1)
    bl printf

    // Calcular y mostrar el resto de los términos
    mov x7, #2           // Contador de términos ya impresos

fibonacci_loop:
    // Cargar los dos últimos términos
    ldr x10, [x4]        // fib1
    ldr x11, [x5]        // fib2
    add x12, x10, x11    // x12 = fib1 + fib2

    // Imprimir el término actual
    ldr x0, =result_msg
    mov x1, x7           // Índice actual
    mov x2, x12          // Valor a imprimir
    bl printf

    // Actualizar los términos
    str x11, [x4]        // fib1 = fib2
    str x12, [x5]        // fib2 = nuevo término (x12)

    // Incrementar el contador
    add x7, x7, #1
    cmp x7, x1
    blt fibonacci_loop

end_program:
    // Salir del programa
    mov x0, #0
    mov x8, #93
    svc 0

