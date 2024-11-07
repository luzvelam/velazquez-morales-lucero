//lucero velazquez morales 
//Encontrar el máximo en un arreglo ejercicio 12

/*
#include <stdio.h>

// Declaramos la función de ensamblador
extern void encontrar_maximo();

// Declaramos la variable resultado como externa
extern int resultado;

int main() {
    // Llamamos a la función de ensamblador
    encontrar_maximo();

    // Imprimimos el resultado
    printf("El valor máximo en el arreglo es: %d\n", resultado);
    return 0;
}


*/

   .data
arreglo:
    .word 5, 10, 3, 21, 7, 15, 6    // Ejemplo de arreglo de enteros de 32 bits
longitud:
    .word 7                         // Longitud del arreglo

.global resultado
resultado:
    .word 0                         // Variable para almacenar el máximo

    .text
    .global encontrar_maximo

encontrar_maximo:
    ldr x0, =arreglo                // Cargar la dirección base del arreglo en x0
    ldr w1, =7                      // Cargar la longitud del arreglo en w1 (longitud)
    ldr w2, [x0]                    // Inicializar w2 con el primer elemento (valor máximo inicial)

    mov w3, #1                      // Índice para iterar por el arreglo

buscar_maximo:
    cmp w3, w1                      // Comprobar si llegamos al final del arreglo
    bge fin                         // Si el índice es >= longitud, termina el bucle

    ldr w4, [x0, x3, LSL #2]        // Cargar el siguiente elemento en w4
    cmp w4, w2                      // Comparar el elemento actual con el máximo actual
    ble siguiente                   // Si w4 <= w2, saltar a siguiente
    mov w2, w4                      // Actualizar w2 con el nuevo máximo

siguiente:
    add w3, w3, #1                  // Incrementar el índice
    b buscar_maximo                 // Repetir el bucle

fin:
    ldr x5, =resultado              // Cargar la dirección de 'resultado'
    str w2, [x5]                    // Guardar el valor máximo en 'resultado'
    ret



