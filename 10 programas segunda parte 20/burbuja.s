//lucero velazquez morales 
//Ordenamiento burbuja ejercicio 16

/*
#include <stdio.h>

// Función para realizar el ordenamiento burbuja
void burbuja(int arreglo[], int n) {
    for (int i = 0; i < n - 1; i++) {  // Hacer pasar varias veces por el arreglo
        for (int j = 0; j < n - i - 1; j++) {  // Comparar elementos adyacentes
            // Si el elemento actual es mayor que el siguiente, intercambiamos
            if (arreglo[j] > arreglo[j + 1]) {
                // Intercambiar los elementos
                int temp = arreglo[j];
                arreglo[j] = arreglo[j + 1];
                arreglo[j + 1] = temp;
            }
        }
    }
}

// Función para imprimir el arreglo
void imprimir_arreglo(int arreglo[], int n) {
    for (int i = 0; i < n; i++) {
        printf("%d ", arreglo[i]);
    }
    printf("\n");
}

int main() {
    // Ejemplo de arreglo a ordenar
    int arreglo[] = {64, 34, 25, 12, 22, 11, 90};
    int n = sizeof(arreglo) / sizeof(arreglo[0]);  // Obtener el tamaño del arreglo

    printf("Arreglo original: ");
    imprimir_arreglo(arreglo, n);

    // Llamar a la función de ordenamiento
    burbuja(arreglo, n);

    printf("Arreglo ordenado: ");
    imprimir_arreglo(arreglo, n);

    return 0;
}

*/

#####################################################################
.global _start 

.section .data
array:      .word 8, 3, 7, 1, 4  // Arreglo de ejemplo a ordenar
length:     .word 5              // Longitud del arreglo
msg:        .asciz "Array sorted!\n"  // Mensaje de confirmación

.section .text
_start:
    // Cargar la dirección del arreglo y su longitud
    ldr x0, =array               // x0 apunta al inicio del arreglo
    ldr x1, =length              // x1 contiene la dirección de length
    ldr w1, [x1]                 // w1 tiene la longitud del arreglo

bubble_sort:
    mov w2, w1                   // w2 = longitud del arreglo (contador de pasadas)
    subs w2, w2, 1               // w2 = longitud - 1
    b.le done                    // Si longitud <= 1, el arreglo ya está ordenado

outer_loop:
    mov w3, 0                    // w3 es el índice para comparar
    mov w4, 0                    // Flag para saber si hubo intercambio en esta pasada

inner_loop:
    add x5, x0, x3, lsl #2       // x5 = dirección de array[w3]
    ldr w6, [x5]                 // w6 = array[w3]
    ldr w7, [x5, #4]             // w7 = array[w3 + 1]

    cmp w6, w7                   // Comparar array[w3] con array[w3 + 1]
    ble skip_swap                // Si array[w3] <= array[w3 + 1], no hacer intercambio

    // Intercambio de array[w3] y array[w3 + 1]
    str w7, [x5]                 // array[w3] = array[w3 + 1]
    str w6, [x5, #4]             // array[w3 + 1] = array[w3]
    mov w4, 1                    // Setear el flag de intercambio

skip_swap:
    add w3, w3, 1                // Incrementar índice
    subs w6, w3, w2              // Comparar índice con longitud - 1
    b.lt inner_loop              // Si w3 < longitud - 1, continuar con inner_loop

    cmp w4, 0                    // Comprobar si hubo algún intercambio en esta pasada
    beq done                     // Si no hubo intercambio, el arreglo está ordenado
    subs w2, w2, 1               // Reducir el tamaño efectivo del arreglo
    b outer_loop                 // Repetir el proceso con la pasada siguiente

done:
    // Imprimir mensaje de confirmación
    ldr x0, =1                   // Descriptor de archivo para stdout
    ldr x1, =msg                 // Dirección del mensaje
    mov x2, 14                   // Longitud del mensaje ("Array sorted!\n")
    mov x8, 64                   // syscall número para write
    svc 0

    // Terminar el programa
    mov x8, 93                   // syscall número para exit
    mov x0, 0                    // código de salida
    svc 0


