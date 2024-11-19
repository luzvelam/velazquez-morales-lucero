//Lucero velazquez morales No.Control 22210362
//Descripcion: 	Escribir en un archivo
//fecha: 18-11-2024
//Programa en ARM64 Assembly 
//https://asciinema.org/a/ve14dKdz0GZHmqgEwhDYCmvZD


/*
#include <stdio.h>

int main() {
    // Abrir el archivo en modo escritura
    FILE *archivo = fopen("output.txt", "w");
    if (archivo == NULL) {
        perror("Error al abrir el archivo");
        return 1;
    }

    // Escribir texto en el archivo
    fprintf(archivo, "Hola desde ensamblador ARM64\n");
    fprintf(archivo, "Escribiendo más líneas...\n");

    // Cerrar el archivo
    fclose(archivo);

    printf("Texto escrito correctamente en output.txt\n");
    return 0;
}


*/


.global _start

.section .data
    filename: .asciz "output.txt"  // Nombre del archivo a escribir
    message:  .asciz "Hola desde ensamblador ARM64\n"  // Mensaje que se escribirá en el archivo
    len = . - message  // Longitud del mensaje

.section .text
_start:
    // Abrir el archivo para escritura
    mov x8, 56               // syscall: openat
    mov x0, -100             // dirfd (AT_FDCWD)
    ldr x1, =filename        // filename
    mov x2, 577              // flags: O_CREAT | O_WRONLY | O_TRUNC (octal 01001)
    mov x3, 0644             // mode: permisos rw-r--r--
    svc 0

    // Guardar el descriptor del archivo en x10
    mov x10, x0

    // Escribir en el archivo
    mov x8, 64               // syscall: write
    mov x0, x10              // file descriptor
    ldr x1, =message         // buffer (mensaje a escribir)
    mov x2, len              // tamaño del mensaje
    svc 0

    // Cerrar el archivo
    mov x8, 57               // syscall: close
    mov x0, x10              // file descriptor
    svc 0

    // Salir del programa
    mov x8, 93               // syscall: exit
    mov x0, 0                // código de salida
    svc 0
