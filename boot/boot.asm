;Lesson 4 – Writing Directly to Video Memory (No BIOS)

BITS 16
ORG 0x7C00

start:
    mov ax, 0xB800
    ;VGA memory starts at 0xB800
    mov es, ax
    ;es now points to VGA memory
    xor di, di
    ;di is destination index, stores position on screen 
    ;initially DI = 0 which means top-left corner
    mov si, message

print:
    lodsb
    cmp al, 0
    je done
    mov [es:di], al
    ;writes the character stored in al into VGA memory
    inc di
    mov byte [es:di], 0x0A
    ;this is for the color byte (white)
    inc di
    ;increment di twice cuz first stores character and second one color
    jmp print

done:
    cli

hang:
    hlt
    jmp hang

message db "Direct VGA Memory!", 0

times 510-($-$$) db 0
dw 0xAA55