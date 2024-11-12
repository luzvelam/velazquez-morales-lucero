//Lucero velazquez morales No.Control 22210362
//fecha: 11-11-2024
//Programa en ARM64 Assembly 
// Descripción: Cálculo del MCM en ensamblador ARM64
//https://asciinema.org/a/388dw2uEOjEmJFUeguZa5MLof




/*
#include <stdio.h>

// Declaración de la función ensambladora
extern long mcm_func(long a, long b);

int main() {
    long a, b;

    // Capturar los valores de a y b desde el usuario
    printf("Ingrese el primer número: ");
    scanf("%ld", &a);
    printf("Ingrese el segundo número: ");
    scanf("%ld", &b);

    // Validar que los números sean positivos
    if (a <= 0 || b <= 0) {
        printf("Error: Ambos números deben ser positivos y mayores que cero.\n");
        return 1;
    }

    // Llamar a la función ensambladora que ejecuta el cálculo del MCM
    long result = mcm_func(a, b);

    // Imprimir el resultado
    printf("El MCM de %ld y %ld es: %ld\n", a, b, result);

    return 0;
}


*/



.global mcm_func
.text

// Función que calcula el MCD
gcd:
    cmp x1, x0            // Comparar b y a
    b.eq end_gcd          // Si son iguales, termina
    b.gt greater          // Si b > a, saltar a 'greater'
    sub x0, x0, x1        // Resta b de a
    b gcd                 // Repite
greater:
    sub x1, x1, x0        // Resta a de b
    b gcd                 // Repite
end_gcd:
    mov x0, x0            // MCD almacenado en x0
    ret

// Función principal mcm_func
mcm_func:
    stp x29, x30, [sp, -16]!  // Guardar registros de marco
    mov x29, sp               // Actualizar marco de pila

    mov x2, x0                // Guardar a en x2
    mov x3, x1                // Guardar b en x3

    bl gcd                    // Llamar a gcd(a, b)
    mov x4, x0                // Guardar resultado del MCD en x4

    // Calcular MCM = (a * b) / MCD
    mul x0, x2, x3            // Multiplicar a y b
    udiv x0, x0, x4           // Dividir el producto por el MCD

    ldp x29, x30, [sp], 16    // Restaurar registros de marco
    ret
