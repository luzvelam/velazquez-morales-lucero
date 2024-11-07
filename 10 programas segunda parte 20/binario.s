//lucero velazquez morales 
//Búsqueda binaria ejercicio 15

/*
#include <stdio.h>

// Función para realizar la búsqueda binaria
int busqueda_binaria(int arreglo[], int n, int valor) {
    int inicio = 0;
    int fin = n - 1;

    while (inicio <= fin) {
        int medio = inicio + (fin - inicio) / 2;  // Calcular el índice medio

        // Si el valor está en el medio
        if (arreglo[medio] == valor) {
            return medio;  // Valor encontrado, retornar el índice
        }
        
        // Si el valor es menor que el del medio, buscar en la mitad izquierda
        if (arreglo[medio] > valor) {
            fin = medio - 1;
        }
        // Si el valor es mayor que el del medio, buscar en la mitad derecha
        else {
            inicio = medio + 1;
        }
    }

    return -1;  // Si el valor no se encuentra en el arreglo
}

int main() {
    // Ejemplo de arreglo ordenado
    int arreglo[] = {1, 3, 5, 7, 8, 12, 15, 19, 23};
    int n = sizeof(arreglo) / sizeof(arreglo[0]);  // Obtener el tamaño del arreglo
    int valor_a_buscar = 7;  // Valor que deseamos buscar

    // Llamada a la función de búsqueda binaria
    int resultado = busqueda_binaria(arreglo, n, valor_a_buscar);

    if (resultado != -1) {
        printf("El valor %d se encuentra en el índice %d.\n", valor_a_buscar, resultado);
    } else {
        printf("El valor %d no se encuentra en el arreglo.\n", valor_a_buscar);
    }

    return 0;
}

*/

.section .data
array:      .word 1, 3, 5, 7, 9, 11, 13, 15, 17, 19  // Arreglo ordenado
array_size: .word 10                             // Tamaño del arreglo
target:     .word 7                              // Valor a buscar

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

    mov w6, #0                            // Inicializa el índice de inicio (low)
    mov w7, w2                            // Inicializa el índice final (high) al tamaño del arreglo

binary_search_loop:
    cmp w6, w7                            // Verifica si low <= high
    bgt not_found                         // Si no, el valor no se encuentra

    add w8, w6, w7                        // w8 = low + high
    lsr w8, w8, #1                        // w8 = (low + high) / 2 (dividir entre 2)

    ldr w9, [x3, x8, lsl #2]              // Cargar el elemento en la mitad del arreglo (array[mid])
    cmp w9, w5                            // Compara el valor encontrado con el valor objetivo
    beq found                             // Si son iguales, hemos encontrado el valor

    blt search_right                      // Si el valor es menor que el objetivo, buscar en la mitad derecha
    b search_left                         // Si el valor es mayor, buscar en la mitad izquierda

search_left:
    sub w7, w8, #1                        // high = mid - 1
    b binary_search_loop                  // Repetir la búsqueda

search_right:
    add w6, w8, #1                        // low = mid + 1
    b binary_search_loop                  // Repetir la búsqueda

not_found:
    mov w0, #-1                           // Si no se encuentra el valor, retorna -1
    mov x8, #93                           // Código de salida para ARM Linux
    svc #0                                // Llama al sistema para salir

found:
    mov w0, w8                            // Retorna el índice donde se encontró el valor
    mov x8, #93                           // Código de salida para ARM Linux
    svc #0                                // Llama al sistema para salir
