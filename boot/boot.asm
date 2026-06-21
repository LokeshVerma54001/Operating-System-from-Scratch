BITS 16
ORG 0x7C00

;The CPU starts in 16-bit Real Mode, so NASM assembles the code accordingly.
;The BIOS loads the boot sector into memory at address 0x7C00.

start:
    mov si, message
;SI (Source Index) is a register that will point to the start of our string.

print_loop:
    lodsb
    ;Reads one byte from the address pointed to by SI.
    ;Stores it in the AL register.
    ;Increments SI to point to the next character.
    cmp al, 0
    ;Our string ends with a null byte (0).
    ;When we reach it, we're done printing.
    je halt
    mov ah, 0x0E
    ;Interrupt 0x10 handles video.
    ;Print the character stored in AL
    int 0x10
    ;This calls the BIOS video service, which prints the character.
    jmp print_loop

halt:
    cli
    ;Disable hardware interrupts.

hang:
    hlt
    ;This tells the CPU to halt until an interrupt occurs.
    jmp hang
    ;Without this, the CPU would continue executing whatever bytes happen to follow our boot sector, leading to unpredictable behavior.

message db "My first OS!", 0

times 510-($-$$) db 0
dw 0xAA55
;The last two bytes of the boot sector must be 0x55 and 0xAA