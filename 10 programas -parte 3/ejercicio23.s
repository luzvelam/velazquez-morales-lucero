//lucero velazquez morales no.control 22210362
//ejercicio 23- 	Conversión de entero a ASCII
//fecha: 10-11-2024


/*
#include <stdio.h>
#include <stdlib.h>  // Para usar la función itoa()

// Función para convertir un entero a una cadena (ASCII)
void integer_to_ascii(int num, char *str) {
    sprintf(str, "%d", num);  // Convierte el entero num a una cadena en formato decimal
}

int main() {
    int number = 12345;
    char str[20];  // Asegúrate de que el arreglo sea lo suficientemente grande

    integer_to_ascii(number, str);

    printf("El número como cadena ASCII es: %s\n", str);

    return 0;
}

*/

.global _start

.section .data
msg:    .asciz "El valor ASCII es: "
char:   .byte 65               // El valor ASCII de 'A'

.section .text
_start:
    // Escribir el mensaje en stdout
    mov x0, #1                  // Número de archivo: 1 = stdout
    ldr x1, =msg                // Dirección del mensaje
    ldr x2, =19                  // Longitud del mensaje
    mov x8, #64                 // Número de syscall para 'write'
    svc #0                       // Hacer la llamada al sistema

    // Escribir el valor ASCII (carácter 'A') desde la sección de datos
    mov x0, #1                  // Número de archivo: 1 = stdout
    ldr x1, =char               // Dirección del valor ASCII (carácter 'A')
    mov x2, #1                  // Longitud (1 byte)
    mov x8, #64                 // Número de syscall para 'write'
    svc #0                       // Hacer la llamada al sistema

    // Finalizar el programa
    mov x0, #0                  // Código de salida
    mov x8, #93                 // Número de syscall para 'exit'
    svc #0                       // Hacer la llamada al sistema

