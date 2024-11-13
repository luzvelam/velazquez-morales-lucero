//lucero velazquez morales No.Control 22210362
//Descripcion: Rotación de un arreglo (izquierda/derecha)
//Fecha : 12-11-2024
//Programa en ARM64 Assembly 

/*
#include <stdio.h>

// Función para rotar un arreglo hacia la izquierda
void rotarIzquierda(int arr[], int n) {
    int temp = arr[0];  // Guardamos el primer elemento
    for (int i = 0; i < n - 1; i++) {
        arr[i] = arr[i + 1];  // Desplazamos cada elemento hacia la izquierda
    }
    arr[n - 1] = temp;  // Colocamos el primer elemento al final
}

// Función para rotar un arreglo hacia la derecha
void rotarDerecha(int arr[], int n) {
    int temp = arr[n - 1];  // Guardamos el último elemento
    for (int i = n - 1; i > 0; i--) {
        arr[i] = arr[i - 1];  // Desplazamos cada elemento hacia la derecha
    }
    arr[0] = temp;  // Colocamos el último elemento al principio
}

// Función para imprimir el arreglo
void imprimirArreglo(int arr[], int n) {
    for (int i = 0; i < n; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");
}

int main() {
    int arreglo[] = {1, 2, 3, 4, 5};
    int n = sizeof(arreglo) / sizeof(arreglo[0]);

    // Imprimir arreglo original
    printf("Arreglo original: ");
    imprimirArreglo(arreglo, n);

    // Rotar a la izquierda
    rotarIzquierda(arreglo, n);
    printf("Arreglo después de rotar a la izquierda: ");
    imprimirArreglo(arreglo, n);

    // Rotar a la derecha
    rotarDerecha(arreglo, n);
    printf("Arreglo después de rotar a la derecha: ");
    imprimirArreglo(arreglo, n);

    return 0;
}

*/

.data
arreglo: .word 32145435, 5345, 12345, 6789, 10234  // Arreglo de ejemplo con 5 elementos
tamano: .word 5                                    // Tamaño del arreglo
msg_elemento: .string "%d\n"                       // Formato para imprimir cada elemento

.text
.global main
.align 2

.global _start

_start:
    // Llamar a la función main
    bl main   

main:
    // Prologo de la función main
    stp     x29, x30, [sp, #-16]!   // Guardar el frame pointer y el link register
    mov     x29, sp

    // Preparar variables
    ldr     x1, =tamano             // Cargar la dirección de 'tamano' en x1
    ldr     w1, [x1]                // Cargar el valor de 'tamano' en w1 (32 bits)
    adrp    x2, arreglo             // Dirección base del arreglo
    add     x2, x2, :lo12:arreglo   // Dirección base del arreglo

    // Inicializar el máximo y segundo máximo
    ldr     w3, [x2], #4            // Cargar el primer elemento
    mov     w4, w3                  // El primer elemento es el máximo
    mov     w5, w3                  // El segundo máximo inicialmente es el primero

    // Bucle para recorrer el arreglo y encontrar el máximo y segundo máximo
buscar_maximo:
    cbz     w1, fin_buscar_maximo   // Si w1 es 0 (tamaño = 0), terminar el bucle

    ldr     w3, [x2], #4            // Cargar el siguiente elemento

    cmp     w3, w4                  // Comparar el elemento con el máximo actual
    ble     siguiente               // Si w3 <= w4, ir a siguiente
    mov     w5, w4                  // El segundo máximo es el anterior máximo
    mov     w4, w3                  // El nuevo máximo es w3

siguiente:
    cmp     w3, w5                  // Comparar el elemento con el segundo máximo actual
    bge     fin_buscar_maximo       // Si w3 >= w5, continuar al siguiente
    mov     w5, w3                  // Actualizar el segundo máximo

    b       buscar_maximo           // Volver a comprobar el siguiente elemento

fin_buscar_maximo:
    // Imprimir el segundo máximo
    adrp    x0, msg_elemento        // Cargar el mensaje para printf
    add     x0, x0, :lo12:msg_elemento
    mov     w1, w5                  // Colocar el segundo máximo en w1 para printf
    bl      printf                  // Llamar a printf para imprimir el segundo máximo

    // Reiniciar el contador y dirección para imprimir el arreglo
    ldr     w1, [x1]                // Cargar el tamaño de nuevo
    adrp    x2, arreglo             // Dirección base del arreglo
    add     x2, x2, :lo12:arreglo   // Dirección base del arreglo

loop_imprimir:
    cbz     w1, fin_programa        // Si no quedan elementos, terminar

    ldr     w3, [x2], #4            // Cargar elemento y avanzar dirección del arreglo
    mov     w1, w3                  // Colocar el elemento en w1 para printf
    adrp    x0, msg_elemento        // Cargar el mensaje para printf
    add     x0, x0, :lo12:msg_elemento
    bl      printf                  // Llamar a printf para imprimir el elemento

    sub     w1, w1, #1              // Decrementar el contador de elementos
    b       loop_imprimir           // Repetir para el siguiente elemento

fin_programa:
    // Epílogo de la función main
    ldp     x29, x30, [sp], #16     // Restaurar el frame pointer y el link register
    mov     x0, #0                  // Código de salida 0
    ret
