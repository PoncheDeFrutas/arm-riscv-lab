// 15.1 - ABI, AAPCS64 y mapa de registros
//
// Objetivo:
//   Pasar argumentos por x0/x1 y recibir retorno por x0 segun AAPCS64.
//
// Registros usados:
//   x0 = primer argumento, retorno de sumar_abi y codigo de salida.
//   x1 = segundo argumento de sumar_abi.
//   x8 = numero de syscall Linux AArch64 al salir.
//   x30 = link register usado por bl/ret.

.global _start

.section .text
_start:
    // preparar llamada ABI normal
    mov x0, #19             // primer argumento para sumar_abi
    mov x1, #23             // segundo argumento para sumar_abi
    bl sumar_abi            // llamada normal: retorno vuelve en x0

    // exit(x0)
    mov x8, #93             // syscall exit; x8 aqui pertenece al contrato Linux
    svc #0                  // terminar con 42

sumar_abi:
    // funcion hoja compatible con la calling convention
    add x0, x0, x1          // retorno = argumento0 + argumento1
    ret                     // volver al caller usando x30
