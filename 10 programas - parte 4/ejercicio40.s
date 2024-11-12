//lucero velazquez morales No.Control 22210362
//Descripcion:Convertir binario a decimal
//Fecha : 12-11-2024
//Programa en ARM64 Assembly 
// https://asciinema.org/a/k32JzRJmMDsE2KfI8lbbSeO50


/*
#include <stdio.h>

// Declaración de la función en Assembly que convierte binario a decimal
extern int binary_to_decimal(const char *binary);

int main() {
    char bin_input[32];

    // Pedir al usuario que ingrese un número binario
    printf("Ingrese un número binario: ");
    scanf("%s", bin_input);

    // Llamar a la función en Assembly para convertir el binario a decimal
    int decimal = binary_to_decimal(bin_input);

    // Imprimir el resultado
    printf("El número decimal es: %d\n", decimal);

    return 0;
}

*/

.section .text
.global binary_to_decimal

binary_to_decimal:
    // x0 = dirección de la cadena (input binario)
    mov x9, #0              // Inicializar el acumulador (resultado decimal) en x9
    mov x10, #0             // Índice para recorrer la cadena

loop:
    ldrb w8, [x0, x10]      // Leer el siguiente carácter (byte) en w8
    cmp w8, #0              // Comparar con el carácter nulo ('\0')
    beq end_loop            // Si es nulo, terminamos el ciclo

    // Multiplicar el acumulador por 2 (desplazamiento a la izquierda)
    lsl x9, x9, #1

    // Convertir el carácter ('0' o '1') al valor numérico y sumarlo
    sub w8, w8, '0'         // Convertir carácter ASCII a número (0 o 1)
    add x9, x9, x8          // Sumar el bit al resultado acumulado

    // Incrementar el índice y continuar el ciclo
    add x10, x10, #1
    b loop

end_loop:
    // Devolver el resultado en x0
    mov x0, x9
    ret
