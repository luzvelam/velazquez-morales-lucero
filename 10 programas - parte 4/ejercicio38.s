//lucero velazquez morales No.Control 22210362
//Descripcion: Implementar una cola usando un arreglo
//Fecha : 12-11-2024
//Programa en ARM64 Assembly 
//https://asciinema.org/a/EY1XD1I5xIB323BwRHxuQT4dK

/*
#include <stdio.h>

// Declaración de funciones en ensamblador
extern int enqueue(int value);
extern int dequeue();

int main() {
    int value;

    // Insertar valores en la cola
    enqueue(10);
    enqueue(20);
    enqueue(30);

    // Extraer e imprimir valores de la cola
    value = dequeue();
    if (value != -1) printf("Dequeued: %d\n", value);
    else printf("Queue is empty\n");

    value = dequeue();
    if (value != -1) printf("Dequeued: %d\n", value);
    else printf("Queue is empty\n");

    value = dequeue();
    if (value != -1) printf("Dequeued: %d\n", value);
    else printf("Queue is empty\n");

    // Intento de extraer de una cola vacía
    value = dequeue();
    if (value != -1) printf("Dequeued: %d\n", value);
    else printf("Queue is empty\n");

    return 0;
}

*/

        .section .data
queue:  .word 0, 0, 0, 0, 0        // Cola con espacio para 5 elementos
size:   .word 5                    // Tamaño de la cola
head:   .word 0                    // Índice de la cabeza de la cola
tail:   .word 0                    // Índice de la cola
count:  .word 0                    // Número de elementos en la cola

        .section .text
        .global enqueue
        .global dequeue

// Función enqueue: Inserta en la cola
// Argumento: w0 (valor a insertar)
enqueue:
        ldr x1, =size
        ldr w1, [x1]

        ldr x2, =tail
        ldr w3, [x2]
        ldr x4, =count
        ldr w5, [x4]

        cmp w5, w1
        b.eq enqueue_full         // Si la cola está llena, retorna

        ldr x6, =queue
        add x7, x6, x3, LSL #2    // Calcula la posición en el arreglo
        str w0, [x7]

        add w3, w3, #1
        cmp w3, w1
        csel w3, w3, wzr, ne
        str w3, [x2]

        add w5, w5, #1
        str w5, [x4]
        ret

enqueue_full:
        mov w0, #-1               // Retorna -1 si la cola está llena
        ret

// Función dequeue: Extrae de la cola
// Retorna: w0 (valor extraído, o -1 si la cola está vacía)
dequeue:
        ldr x1, =size
        ldr w1, [x1]

        ldr x2, =head
        ldr w3, [x2]
        ldr x4, =count
        ldr w5, [x4]

        cmp w5, #0
        b.eq dequeue_empty        // Si la cola está vacía, retorna -1

        ldr x6, =queue
        add x7, x6, x3, LSL #2    // Calcula la posición en el arreglo
        ldr w0, [x7]

        add w3, w3, #1
        cmp w3, w1
        csel w3, w3, wzr, ne
        str w3, [x2]

        sub w5, w5, #1
        str w5, [x4]
        ret

dequeue_empty:
        mov w0, #-1               // Retorna -1 si la cola está vacía
        ret


