//lucero velazquez morales no.control 22210362
//Contar los bits activados en un número
//Fecha: 10-11-2024
// Programa en ARM64 Assembly 

/*
#include <stdio.h>

extern unsigned long count_set_bits(unsigned long num);

int main() {
    unsigned long num;
    
    // Solicitar al usuario que ingrese un número
    printf("Introduce un número: ");
    scanf("%lu", &num);  // Leer el número desde la entrada

    // Llamar a la función ensamblada para contar los bits activados
    printf("Número de bits activados en %lu es: %lu\n", num, count_set_bits(num));

    return 0;
}


*/


.global count_set_bits
.type count_set_bits, %function

count_set_bits:
    mov     x1, x0          // Copiar el número a x1
    mov     x0, #0          // Inicializar el contador de bits activados a 0

count_loop:
    cmp     x1, #0          // Comprobar si el número es 0
    beq     end             // Si es 0, hemos terminado

    // Eliminar el bit más bajo activado (x1 = x1 & (x1 - 1))
    subs    x1, x1, #1      // x1 = x1 - 1
    and     x1, x1, x0      // x1 = x1 & x0

    // Incrementar el contador de bits activados
    add     x0, x0, #1      // Incrementar el contador de bits activados

    b       count_loop      // Repetir el bucle

end:
    ret
