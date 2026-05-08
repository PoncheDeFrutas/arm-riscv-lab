.equ ARENA_BASE, 0
.equ ARENA_USED, 8
.equ ARENA_CAP,  16
.equ ARENA_SIZE, 24

.bss
arena_storage:
    .skip 16

.data
arena_desc:
    .quad arena_storage
    .quad 0
    .quad 16

.text
.global _start
_start:
    ldr x0, =arena_desc
    mov x1, #4
    bl arena_alloc
    cbz x0, error

    mov w2, #'A'
    strb w2, [x0]
    mov w2, #'B'
    strb w2, [x0, #1]
    mov w2, #'C'
    strb w2, [x0, #2]
    mov w2, #'D'
    strb w2, [x0, #3]

    ldr x0, =arena_desc
    mov x1, #4
    bl arena_alloc
    cbz x0, error

    mov w2, #'E'
    strb w2, [x0]
    mov w2, #'F'
    strb w2, [x0, #1]
    mov w2, #'G'
    strb w2, [x0, #2]
    mov w2, #'H'
    strb w2, [x0, #3]

    ldr x0, =arena_desc
    bl arena_reset

    mov x0, #0
    mov x8, #93
    svc #0

error:
    mov x0, #1
    mov x8, #93
    svc #0

arena_alloc:
    ldr x2, [x0, #ARENA_BASE]
    ldr x3, [x0, #ARENA_USED]
    ldr x4, [x0, #ARENA_CAP]

    add x5, x3, x1
    cmp x5, x4
    b.hi arena_full

    add x6, x2, x3
    str x5, [x0, #ARENA_USED]
    mov x0, x6
    ret

arena_full:
    mov x0, #0
    ret

arena_reset:
    str xzr, [x0, #ARENA_USED]
    ret
