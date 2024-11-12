//lucero velazquez morales no.control 22210362
//Contar los bits activados en un número
//Fecha: 10-11-2024
// Programa en ARM64 Assembly 
//https://asciinema.org/a/PParsVzOef4eByPdWVukZ9Xo1

/*
#include <stdio.h>

extern int count_bits(unsigned long number);

int main() {
    unsigned long num = 0xF0F0F0F0F0F0F0F0;
    int result = count_bits(num);
    printf("Número de bits activados: %d\n", result);
    return 0;
}


*/


.global count_bits

count_bits:
    mov     x1, #0          // Inicializar el contador de bits activados
    mov     x2, x0          // Copiar el número a procesar (x0)

count_loop:
    and     x3, x2, #1      // Obtener el bit menos significativo
    add     x1, x1, x3      // Sumar 1 si el bit está activado
    lsr     x2, x2, #1      // Desplazar el número a la derecha
    cmp     x2, #0          // Comparar si el número ha llegado a 0
    bne     count_loop      // Si el número no es 0, continuar el ciclo

    mov     x0, x1          // Devolver el contador
    ret

