//Lucero velazquez morales No.Control 22210362
//
//fecha: 11-11-2024
// Archivo: mcm.s
// Descripción: Implementación del cálculo del MCM usando el algoritmo de Euclides para encontrar el MCD

/*



*/



.global mcm_func
.type mcm_func, %function

// Función principal para calcular el MCM
mcm_func:
    // Argumentos en X0 y X1
    // X0 = a, X1 = b

    // Llamar a la función gcd (MCD)
    mov x2, x0          // Copiar a en x2
    mov x3, x1          // Copiar b en x3
    bl gcd_func         // Llamar a la función gcd_func

    // Guardar el resultado de gcd en x4
    mov x4, x0          // x0 tiene el MCD

    // Calcular el producto a * b
    mul x5, x2, x3      // x5 = a * b

    // Dividir el producto por el MCD: (a * b) / MCD(a, b)
    sdiv x0, x5, x4     // x0 = (a * b) / MCD(a, b)

    // Retornar el resultado (MCM)
    ret

// Algoritmo de Euclides para calcular el MCD
gcd_func:
    cmp x0, x1          // Comparar a y b
    beq end_gcd         // Si son iguales, saltar al final
    bgt sub_a           // Si a > b, saltar a restar b de a
    sub x1, x1, x0      // Si a < b, restar a de b
    b gcd_func          // Volver a empezar

sub_a:
    sub x0, x0, x1      // Restar b de a
    b gcd_func          // Volver a empezar

end_gcd:
    ret                 // Retornar el resultado del MCD (x0)
