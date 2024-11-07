//lucero velazquez morales 
//multiplicación
//codigo en c# (comentario)

/*
using System;

class Program
{
    static void Main()
    {
        int num1 = 15; // Primer número
        int num2 = 5;  // Segundo número
        int resta = num1 - num2; // Realiza la resta

        // Código en ensamblador ARM64
        // MOV X0, #15      ; Cargar el primer número en el registro X0
        // MOV X1, #5       ; Cargar el segundo número en el registro X1
        // SUB X2, X0, X1   ; Restar el valor de X1 de X0 y almacenar en X2
        // Resultado final: X2 = 10

        Console.WriteLine("La resta de {0} y {1} es {2}", num1, num2, resta);
    }
}

*/


.section .data
prompt1: .asciz "Introduce el primer número: "
prompt2: .asciz "Introduce el segundo número: "
result_msg: .asciz "La multiplicación es: %ld\n"
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

    // Multiplicar los números
    ldr x1, =num1
    ldr x1, [x1]         // Cargar el primer número
    ldr x2, =num2
    ldr x2, [x2]         // Cargar el segundo número
    mul x3, x1, x2       // Multiplicar los números
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
