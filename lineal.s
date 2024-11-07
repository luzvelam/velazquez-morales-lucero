//lucero velazquez  morales 
//Búsqueda lineal ejercicio 14

//codigo en c
/*
#include <stdio.h>

// Función para realizar la búsqueda lineal
int busqueda_lineal(int arreglo[], int n, int valor) {
    // Recorremos el arreglo buscando el valor
    for (int i = 0; i < n; i++) {
        if (arreglo[i] == valor) {
            return i;  // Si encontramos el valor, devolvemos el índice
        }
    }
    return -1;  // Si no encontramos el valor, devolvemos -1
}

int main() {
    // Ejemplo de arreglo
    int arreglo[] = {3, 5, 7, 2, 8, 1, 4};
    int n = sizeof(arreglo) / sizeof(arreglo[0]);  // Obtener el tamaño del arreglo
    int valor_a_buscar = 7;  // Valor que deseamos buscar

    int resultado = busqueda_lineal(arreglo, n, valor_a_buscar);

    if (resultado != -1) {
        printf("El valor %d se encuentra en el índice %d.\n", valor_a_buscar, resultado);
    } else {
        printf("El valor %d no se encuentra en el arreglo.\n", valor_a_buscar);
    }

    return 0;
}


*/


.section .data
array:      .word 12, 3, 5, 7, 1, 9, 2     // Arreglo de ejemplo
array_size: .word 7                        // Tamaño del arreglo (número de elementos)
target:     .word 5                        // Valor a buscar en el arreglo

.section .text
.global _start

_start:
    // Cargar el tamaño del arreglo y la dirección del primer elemento
    adrp x1, array_size                   // Carga la página base de array_size en x1
    add x1, x1, :lo12:array_size          // Completa la dirección con el offset bajo de array_size
    ldr w2, [x1]                          // Carga el tamaño del arreglo en w2

    adrp x3, array                        // Carga la página base de array en x3
    add x3, x3, :lo12:array               // Completa la dirección con el offset bajo de array
    adrp x4, target                       // Carga la página base de target en x4
    add x4, x4, :lo12:target              // Completa la dirección con el offset bajo de target
    ldr w5, [x4]                          // Carga el valor a buscar en w5

    mov x6, #0                            // Inicializa el índice a 0 (64 bits ahora)

// Bucle de búsqueda lineal
search_loop:
    cmp w6, w2                            // Verifica si el índice ha alcanzado el tamaño del arreglo (usando w6 para 32 bits)
    beq not_found                         // Si hemos llegado al final, el valor no se encontró

    ldr w7, [x3, x6, lsl #2]              // Carga el elemento actual del arreglo en w7 usando 64 bits en el desplazamiento
    cmp w7, w5                            // Compara el elemento actual con el valor de búsqueda
    beq found                             // Si son iguales, salta a la etiqueta found

    add x6, x6, #1                        // Incrementa el índice (64 bits)
    b search_loop                         // Repite el bucle

not_found:
    mov w0, #-1                           // Si no se encuentra el valor, retorna -1
    mov x8, #93                           // Código de salida para ARM Linux
    svc #0                                // Llama al sistema para salir

found:
    mov w0, w6                            // Retorna el índice donde se encontró el valor
    mov x8, #93                           // Código de salida para ARM Linux
    svc #0                                // Llama al sistema para salir
