; MULTIBOOT HEADER

MBALIGN     equ 1<<0              ; align loaded modules on page boundaries
MEMINFO     equ 1<<1              ; provide memory map
FLAGS       equ MBALIGN | MEMINFO ; this is the multiboot 'flag' field 
MAGIC       equ 0x1BADB002        ; 'magic number' lets bootloader
                                  ; find the header

CHECKSUM    equ -(MAGIC + FLAGS)  ; checksum of above, to prove we are multiboot

; Declare a header as in the Multiboot Standard. We put this into a special
; section so we can force the header to be in the start of the final program.

section .multiboot
align 4
    dd MAGIC
    dd FLAGS
    dd CHECKSUM

; Currently the stack pointer register (esp) points at anything and using it
; may cause massive harm. Instead, we'll provide our own stack. We will allocate
; room for a small temporary stack by creating a symbol at the bottom of it,
; then allocating 16384 bytes for it, and finally creating a symbol at the top

section .bootstrap_stack, nobits
align 4
stack_bottom:
    times 16384 db 0
stack_top:

; The linker script specifies _start ss the entry point to the kernel
; and the bootloader will jump to this position once the kernel has been loaded.
; it doesn't make sense to return from this function as the bootloader is gone
section .text
global _start
_start:
    ; Here is the start of the kernel. The bootloader will load and run our
    ; our operating system.

    ; first we need a stack.
    mov esp, stack_top

    ; we are now ready to actually execute C code.
    extern kernel_main
    call kernel_main

    cli

.hang:
    hlt
    jmp .hang

