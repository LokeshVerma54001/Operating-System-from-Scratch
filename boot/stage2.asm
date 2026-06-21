BITS 16
ORG 0x8000

start:
    mov ax,0
    mov ds,ax
    mov ax, 0xB800
    mov es, ax
    xor di, di
    mov si, message

.print:
    lodsb
    cmp al, 0
    je .done
    mov [es:di], al
    inc di
    mov byte [es:di], 0x0A
    inc di
    jmp .print

.done:
    cli

.hang:
    hlt
    jmp .hang

message db "Hello from Stage 2!", 0