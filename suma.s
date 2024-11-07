//lucero velazquez morales 
//suma 

/*
using System;
class Program
{
    static void Main()
    {
        int num1 = 5; // Primer número
        int num2 = 10; // Segundo número
        int suma = num1 + num2; // Realiza la suma

        // Código en ensamblador ARM64
        // MOV X0, #5       ; Cargar el primer número en el registro X0
        // MOV X1, #10      ; Cargar el segundo número en el registro X1
        // ADD X2, X0, X1   ; Sumar los valores de X0 y X1 y almacenar en X2
        // Resultado final: X2 = 15

        Console.WriteLine("La suma de {0} y {1} es {2}", num1, num2, suma);
    }
}

*/


.section .data
prompt1: .asciz "Introduce el primer número: "
prompt2: .asciz "Introduce el segundo número: "
result_msg: .asciz "La suma es: %ld\n"
scanf_format: .asciz "%ld"  // Formato para leer long int

num1: .quad 0
num2: .quad 0
result: .quad 0

.section .text
.global main

main:
    // Pedir el primer número
    ldr x0, =prompt1
    bl printf

    // Leer el primer número
    ldr x0, =scanf_format // Cargar formato de scanf
    ldr x1, =num1        // Cargar dirección de num1
    bl scanf

    // Pedir el segundo número
    ldr x0, =prompt2
    bl printf

    // Leer el segundo número
    ldr x0, =scanf_format // Cargar formato de scanf
    ldr x1, =num2        // Cargar dirección de num2
    bl scanf

    // Sumar los números
    ldr x1, =num1
    ldr x1, [x1]         // Cargar el primer número
    ldr x2, =num2
    ldr x2, [x2]         // Cargar el segundo número
    add x3, x1, x2       // Sumar los números
    ldr x0, =result
    str x3, [x0]         // Almacenar el resultado

    // Mostrar el resultado
    ldr x0, =result_msg
    ldr x1, =result
    ldr x1, [x1]         // Cargar el resultado
    bl printf

    // Salir del programa
    mov x0, #0
    mov x8, #93
    svc 0
