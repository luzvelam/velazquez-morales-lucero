//lucero velazquez morales no.control 22210362
//Máximo Común Divisor (MCD)
//Fecha: 11-11-2024
// Programa en ARM64 Assembly 
// https://asciinema.org/a/PQhGOe7HibNbwVngCDirwtJhn

/*

#include <stdio.h>

// Declaración de la función ensambladora
extern long gcd_func(long a, long b);

int main() {
    long a, b;

    // Capturar los valores de a y b desde el usuario
    printf("Ingrese el primer número (positivo): ");
    scanf("%ld", &a);
    printf("Ingrese el segundo número (positivo): ");
    scanf("%ld", &b);

    // Validar que los números sean positivos
    if (a <= 0 || b <= 0) {
        printf("Error: Ambos números deben ser positivos y mayores que cero.\n");
        return 1;
    }

    // Llamar a la función ensambladora que ejecuta la macro gcd
    long result = gcd_func(a, b);

    // Imprimir el resultado
    printf("El MCD de %ld y %ld es: %ld\n", a, b, result);

    return 0;
}


*/


.macro gcd a, b
gcd_\@:
    cmp \a, \b         // Comparar a y b
    b.eq end_gcd       // Si son iguales, saltar al final
    b.gt sub_a         // Si a > b, saltar a restar b de a
    sub \b, \b, \a     // Si a < b, restar a de b
    b gcd_\@           // Volver a comenzar

sub_a:
    sub \a, \a, \b     // Restar b de a
    b gcd_\@           // Volver a comenzar

end_gcd:
.endm

// Función en ensamblador que calcula el MCD
// Se compilará y se llamará desde C
.text
.globl gcd_func
.type gcd_func, %function
gcd_func:
    // Argumentos en X0 y X1
    // X0 = a, X1 = b
    gcd x0, x1         // Llamar a la macro gcd con los argumentos en X0 y X1
    ret                 // Retornar el resultado en X0 para ARM64 (Raspbian OS)

