//Lucero velazquez morales No.Control 22210362
//Descripcion: 	Verificar si un número es Armstrong
//fecha: 18-11-2024
//Programa en ARM64 Assembly 

/*
#include <stdio.h>
#include <math.h>

// Función para contar los dígitos de un número
int contar_digitos(int numero) {
    int digitos = 0;
    while (numero != 0) {
        numero /= 10;
        digitos++;
    }
    return digitos;
}

// Función para verificar si un número es Armstrong
int es_armstrong(int numero) {
    int digitos = contar_digitos(numero);
    int suma = 0, temp = numero;

    while (temp != 0) {
        int digito = temp % 10;
        suma += pow(digito, digitos);
        temp /= 10;
    }

    return suma == numero;
}

int main() {
    int numero;

    printf("Ingrese un número para verificar si es Armstrong: ");
    scanf("%d", &numero);

    if (es_armstrong(numero)) {
        printf("%d es un número Armstrong.\n", numero);
    } else {
        printf("%d no es un número Armstrong.\n", numero);
    }

    return 0;
}

*/

.section .data
prompt_msg: .asciz "Introduce un número:\n"          // Mensaje para solicitar número
error_msg: .asciz "Error: Entrada inválida. Solo se permiten números.\n"
msg_armstrong: .asciz "Es un número de Armstrong\n"  // Mensaje si es Armstrong
msg_not_armstrong: .asciz "No es un número de Armstrong\n" // Mensaje si no es Armstrong
buffer: .space 10                                    // Buffer para almacenar la entrada del usuario

.section .text
.global _start

_start:
    // Solicitar número al usuario
    mov x0, 1
    ldr x1, =prompt_msg
    mov x2, 21                        // Tamaño del mensaje
    mov x8, 64                        // Syscall write (64 para ARM64)
    svc 0

    // Leer entrada del usuario
    mov x0, 0
    ldr x1, =buffer
    mov x2, 10                        // Tamaño máximo a leer
    mov x8, 63                        // Syscall read (63 para ARM64)
    svc 0

    // Convertir cadena a número (atoi simple con validación)
    ldr x1, =buffer
    mov w0, 0                         // Inicializamos el número (num = 0)
    mov w4, 10                        // Constante 10 para multiplicar en `atoi_loop`

atoi_loop:
    ldrb w2, [x1], #1                 // Leer siguiente carácter
    cmp w2, 10                        // Comparar con '\n' (fin de entrada)
    beq end_atoi                      // Si es '\n', terminar conversión
    cmp w2, '0'                       // Verificar si es menor que '0'
    blt error                         // Si es menor, error
    cmp w2, '9'                       // Verificar si es mayor que '9'
    bgt error                         // Si es mayor, error
    sub w2, w2, '0'                   // Convertir a número
    mul w0, w0, w4                    // Multiplicar acumulador por 10
    add w0, w0, w2                    // Agregar dígito
    b atoi_loop                       // Repetir para el siguiente carácter

end_atoi:
    // Verificación del número de Armstrong
    mov w1, w0                        // Guardamos el número original
    mov w2, 0                         // Inicializamos sum a 0

check_armstrong:
    mov w3, w1
    mov w4, 10
    udiv w5, w3, w4
    msub w6, w5, w4, w3               // Obtener dígito
    mul w7, w6, w6
    mul w7, w7, w6
    add w2, w2, w7
    mov w1, w5
    cmp w1, 0
    bne check_armstrong

    // Comparar la suma calculada
    cmp w2, w0
    bne not_armstrong

    // Es un número de Armstrong
    ldr x0, =msg_armstrong
    mov x2, 27                        // Tamaño del mensaje de Armstrong con \n
    b print_message                   // Saltar a imprimir mensaje y terminar

not_armstrong:
    ldr x0, =msg_not_armstrong        // No es un número de Armstrong
    mov x2, 31                        // Tamaño del mensaje de No Armstrong con \n

print_message:
    mov x1, x0
    mov x0, 1                         // File descriptor (stdout)
    mov x8, 64                        // Syscall write
    svc 0
    b end                             // Finalizar el programa

error:
    // Imprimir mensaje de error
    ldr x0, =error_msg
    mov x1, x0
    mov x2, 44                        // Tamaño del mensaje de error
    mov x8, 64                        // Syscall write
    svc 0

end:
    mov x8, 93                        // Syscall exit
    mov x0, 0                         // Código de salida 0
    svc 0

