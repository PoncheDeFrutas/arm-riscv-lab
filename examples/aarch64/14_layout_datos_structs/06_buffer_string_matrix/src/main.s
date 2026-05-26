// 14.6 - Buffer, String y Matrix
//
// Objetivo:
//   Usar layouts distintos para string dinamico y matriz contigua.
//
// Registros usados:
//   x0 = self, retorno de funcion, fd para write y codigo de salida.
//   w1 = byte a insertar o columna para matrix_get.
//   x1 = direccion para write.
//   x2 = longitud para write, puntero de datos o fila.
//   x3 = len, rows o valor temporal.
//   x4 = cap o cols.
//   x5 = indice lineal.
//   x6 = offset en bytes.
//   x8 = numero de syscall Linux AArch64.

.equ STR_DATA, 0
.equ STR_LEN, 8
.equ STR_CAP, 16
.equ STR_SIZE, 24
.equ MAT_DATA, 0
.equ MAT_ROWS, 8
.equ MAT_COLS, 16
.equ MAT_SIZE, 24

.global _start

.section .bss
string_storage:
    .skip 8

.section .data
.balign 8
string_desc:
    .quad string_storage
    .quad 0
    .quad 8
matrix_data:
    .quad 10, 11
    .quad 12, 13
matrix_desc:
    .quad matrix_data
    .quad 2
    .quad 2

.section .text
_start:
    // construir string dinamico "OK\n"
    adr x0, string_desc     // self = String
    mov w1, #79             // byte ASCII 'O'
    bl string_push_byte     // agregar 'O'
    cmp x0, #0              // revisar retorno
    b.ne error              // ne = fallo de push
    adr x0, string_desc     // recargar self
    mov w1, #75             // byte ASCII 'K'
    bl string_push_byte     // agregar 'K'
    cmp x0, #0              // revisar retorno
    b.ne error              // ne = fallo de push
    adr x0, string_desc     // recargar self
    mov w1, #10             // byte salto de linea
    bl string_push_byte     // agregar '\n'
    cmp x0, #0              // revisar retorno
    b.ne error              // ne = fallo de push

    // validar matrix[1][1] == 13
    adr x0, matrix_desc     // self = Matrix
    mov x2, #1              // fila 1
    mov x1, #1              // columna 1
    bl matrix_get           // retornar matrix[1][1]
    cmp x0, #13             // validar valor esperado
    b.ne error              // ne = layout o indice incorrecto

    // write(stdout, string.data, string.len)
    mov x0, #1              // fd 1 = stdout
    adr x1, string_desc     // direccion del descriptor String
    ldr x2, [x1, #STR_LEN]  // longitud explicita del string
    ldr x1, [x1, #STR_DATA] // puntero a los bytes del string
    mov x8, #64             // syscall write
    svc #0                  // imprimir OK\n
    cmp x0, #0              // revisar retorno
    b.lt error              // lt = write fallo

    // exit(0)
    mov x0, #0              // codigo exitoso
    b salir                 // saltar a salida comun

error:
    mov x0, #1              // codigo 1 = fallo de validacion

salir:
    mov x8, #93             // syscall exit
    svc #0                  // terminar proceso

string_push_byte:
    // cargar descriptor de String
    ldr x2, [x0, #STR_DATA] // puntero al almacenamiento
    ldr x3, [x0, #STR_LEN]  // longitud usada
    ldr x4, [x0, #STR_CAP]  // capacidad total
    cmp x3, x4              // comparar len contra cap
    b.cs string_full        // cs = len >= cap, no hay espacio

    // escribir byte y actualizar longitud
    strb w1, [x2, x3]       // data[len] = byte
    add x3, x3, #1          // len = len + 1
    str x3, [x0, #STR_LEN]  // guardar longitud nueva
    mov x0, #0              // retorno 0 = exito
    ret                     // volver al caller

string_full:
    mov x0, #1              // retorno 1 = sin capacidad
    ret                     // volver al caller

matrix_get:
    // calcular row * cols + col
    ldr x3, [x0, #MAT_DATA] // puntero a datos contiguos
    ldr x4, [x0, #MAT_COLS] // cantidad de columnas
    mul x5, x2, x4          // fila * columnas
    add x5, x5, x1          // indice lineal = fila * cols + col
    lsl x6, x5, #3          // offset en bytes = indice * 8
    ldr x0, [x3, x6]        // retornar elemento matrix[row][col]
    ret                     // volver al caller
