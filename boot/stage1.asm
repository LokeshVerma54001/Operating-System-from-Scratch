BITS 16
ORG 0x7C00

start:

    mov [BOOT_DRIVE], dl

    mov ax, 0
    mov ds, ax
    mov es, ax

    mov ah, 0x02        ; BIOS Read Sectors
    mov al, 1           ; Read 1 sector
    mov ch, 0           ; Cylinder
    mov cl, 2           ; Sector 2
    mov dh, 0           ; Head
    mov dl, [BOOT_DRIVE]

    mov bx, 0x8000      ; Load address

    int 0x13            ;intrupt for reading disk

    jc disk_error

    jmp 0x0000:0x8000

disk_error:

    mov si, error

.print:

    lodsb
    cmp al,0
    je $

    mov ah,0x0E
    int 0x10

    jmp .print

BOOT_DRIVE db 0

error db "Disk Read Error!",0

times 510-($-$$) db 0
dw 0xAA55