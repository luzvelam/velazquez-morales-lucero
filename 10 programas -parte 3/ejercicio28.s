//lucero velazquez morales no.control 22210362
//Establecer, borrar y alternar bits
//fecha:11-11-2024
// Programa en ARM64 Assembly 


/*
#include <stdio.h>

int main() {
    unsigned int num;
    int bit_position;

    // Solicitar el número y la posición del bit al usuario
    printf("Ingrese un número: ");
    scanf("%u", &num);
    printf("Ingrese la posición del bit (0-31): ");
    scanf("%d", &bit_position);

    // Establecer (poner en 1) el bit en la posición especificada
    unsigned int set_bit = num | (1 << bit_position);
    printf("Establecer bit en posición %d: %u\n", bit_position, set_bit);

    // Borrar (poner en 0) el bit en la posición especificada
    unsigned int clear_bit = num & ~(1 << bit_position);
    printf("Borrar bit en posición %d: %u\n", bit_position, clear_bit);

    // Alternar (cambiar el estado) del bit en la posición especificada
    unsigned int toggle_bit = num ^ (1 << bit_position);
    printf("Alternar bit en posición %d: %u\n", bit_position, toggle_bit);

    return 0;
}


*/

.data
    value:    .quad   0x0000B8D8C5750010    // Valor inicial
    mask:     .quad   0x0000B8D8C5750018    // Máscara para bits 8-11
    result:   .quad   0                     // Resultado

    // Mensajes
    msgInit:  .string "Valor inicial: 0x%016lX\n"
    msgMask:  .string "Máscara: 0x%016lX\n"
    msgSet:   .string "Bits establecidos: 0x%016lX\n"
    msgClear: .string "Bits borrados: 0x%016lX\n"
    msgToggl: .string "Bits alternados: 0x%016lX\n"

.text
.global main
.align 2

main:
    stp     x29, x30, [sp, #-16]!
    mov     x29, sp

    // Imprimir valor inicial y máscara
    adrp    x0, msgInit
    add     x0, x0, :lo12:msgInit
    adrp    x1, value
    add     x1, x1, :lo12:value
    bl      printf

    adrp    x0, msgMask
    add     x0, x0, :lo12:msgMask
    adrp    x1, mask
    add     x1, x1, :lo12:mask
    bl      printf

    // Establecer bits
    adrp    x0, value
    add     x0, x0, :lo12:value
    adrp    x1, mask
    add     x1, x1, :lo12:mask
    bl      set_bits
    str     x0, [sp, #-8]!            // Guardar resultado

    adrp    x0, msgSet
    add     x0, x0, :lo12:msgSet
    ldr     x1, [sp], #8              // Recuperar resultado
    bl      printf

    // Borrar bits
    adrp    x0, value
    add     x0, x0, :lo12:value
    adrp    x1, mask
    add     x1, x1, :lo12:mask
    bl      clear_bits
    str     x0, [sp, #-8]!            // Guardar resultado

    adrp    x0, msgClear
    add     x0, x0, :lo12:msgClear
    ldr     x1, [sp], #8              // Recuperar resultado
    bl      printf

    // Alternar bits
    adrp    x0, value
    add     x0, x0, :lo12:value
    adrp    x1, mask
    add     x1, x1, :lo12:mask
    bl      toggle_bits
    str     x0, [sp, #-8]!            // Guardar resultado

    adrp    x0, msgToggl
    add     x0, x0, :lo12:msgToggl
    ldr     x1, [sp], #8              // Recuperar resultado
    bl      printf

    ldp     x29, x30, [sp], #16
    mov     x0, #0
    ret

// Función para establecer bits
set_bits:
    orr     x0, x0, x1
    ret

// Función para borrar bits
clear_bits:
    bic     x0, x0, x1
    ret

// Función para alternar bits
toggle_bits:
    eor     x0, x0, x1
    ret
