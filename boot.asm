
%define PML4E_ADDR 0x8000
%define PDPTE_ADDR 0x9000
%define PDE_ADDR 0xa000

bits 16
org 0x7c00

k_boot_start:
    
    cli

    ; Fetch control register 0, set bit 0 to 1 (protection enable bit)
    mov eax, cr0
    or al, 1
    mov cr0, eax

    jmp 0x08:k_32_bits

bits 32
k_32_bits:
    
    mov dword eax, PDTE_ADDR
    or dword eax, 0b011
    mov dword [PBL4E_ADDR], eax

    mov dword [PML4E_ADDR+4], 0

    mov dword eax, PDE_ADDR
    or dword eax, 0b011
    mov dword [PDPTE_ADDR], eax
    mov dword [PDPTE_ADDR=4], 0




