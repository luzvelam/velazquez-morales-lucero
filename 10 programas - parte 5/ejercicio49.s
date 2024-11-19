//Lucero velazquez morales No.Control 22210362
//Descripcion:Leer entrada desde el teclado
//fecha: 18-11-2024
//Programa en ARM64 Assembly 

/*
#include <stdio.h>

int main() {
    int entero;
    float decimal;
    char cadena[100];

    // Leer un entero
    printf("Introduce un número entero: ");
    scanf("%d", &entero);
    printf("Número entero: %d\n", entero);

    // Leer un número decimal (flotante)
    printf("Introduce un número decimal: ");
    scanf("%f", &decimal);
    printf("Número decimal: %.2f\n", decimal);

    // Leer una cadena de caracteres (hasta un espacio)
    printf("Introduce una cadena de texto: ");
    scanf("%s", cadena);  // Nota: scanf no maneja espacios en la cadena
    printf("Cadena leída: %s\n", cadena);

    return 0;
}

*/

.section .data
prompt_msg: .asciz "Introduce texto: "   // Mensaje de solicitud
output_msg: .asciz "Texto ingresado: %s\n" // Mensaje de salida

.section .bss
.lcomm buffer, 100                        // Buffer de 100 bytes para almacenar la entrada

.section .text
.global _start

_start:
    // Escribir mensaje de solicitud en pantalla
    mov x0, 1                              // File descriptor (1 = stdout)
    ldr x1, =prompt_msg                    // Dirección del mensaje de solicitud
    mov x2, 15                             // Tamaño del mensaje
    mov x8, 64                             // Syscall write (64 en ARM64)
    svc 0                                  // Llamada al sistema

    // Leer entrada desde el teclado
    mov x0, 0                              // File descriptor (0 = stdin)
    ldr x1, =buffer                        // Dirección del buffer para guardar la entrada
    mov x2, 100                            // Tamaño máximo a leer
    mov x8, 63                             // Syscall read (63 en ARM64)
    svc 0                                  // Llamada al sistema

    // Mostrar el texto ingresado
    mov x0, 1                              // File descriptor (1 = stdout)
    ldr x1, =output_msg                    // Dirección del mensaje de salida
    ldr x2, =buffer                        // Dirección del buffer donde está el texto
    mov x8, 64                             // Syscall write (64 en ARM64)
    svc 0                                  // Llamada al sistema

    // Salir del programa
    mov x8, 93                             // Syscall exit (93 en ARM64)
    mov x0, 0                              // Código de salida
    svc 0                                  // Llamada al sistema
