.686
.model flat, stdcall

include \masm32\include\user32.inc
include \masm32\include\kernel32.inc

includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib

.data
    mainWindowTitle db "Lab1_cpuid", 0
    mainWindowText db "Здоровенькі були!", 13, 10, 13, 10, 
                      "Лабораторну роботу виконав:", 10, 13,
                      "студент групи ІО-24,", 10, 13,
                      "Довгань М. С.", 0

    res dd 160 dup(0)

    Vendor db 16 dup(0)
    CaptionVendor db "CPUID 0 Vendor string", 0

    VendorExt db 48 dup(0)
    CaptionVendorExt db "CPUID 80000002h - 80000004h VendorExt string", 0

    Caption0 db "CPUID 0", 0
    Text0 db  'EAX=xxxxxxxx', 13, 10,
              'EBX=xxxxxxxx', 13, 10,
              'ECX=xxxxxxxx', 13, 10,
              'EDX=xxxxxxxx', 0

    Caption1 db "CPUID 1", 0
    Text1 db  'EAX=xxxxxxxx', 13, 10,
              'EBX=xxxxxxxx', 13, 10,
              'ECX=xxxxxxxx', 13, 10,
              'EDX=xxxxxxxx', 0

    Caption2 db "CPUID 2", 0
    Text2 db  'EAX=xxxxxxxx', 13, 10,
              'EBX=xxxxxxxx', 13, 10,
              'ECX=xxxxxxxx', 13, 10,
              'EDX=xxxxxxxx', 0

    Caption00h db "CPUID 80000000h", 0
    Text00h db 'EAX=xxxxxxxx', 13, 10,
               'EBX=xxxxxxxx', 13, 10,
               'ECX=xxxxxxxx', 13, 10,
               'EDX=xxxxxxxx', 0

    Caption01h db "CPUID 80000001h", 0
    Text01h db 'EAX=xxxxxxxx', 13, 10,
               'EBX=xxxxxxxx', 13, 10,
               'ECX=xxxxxxxx', 13, 10,
               'EDX=xxxxxxxx', 0

    Caption02h db "CPUID 80000002h", 0
    Text02h db 'EAX=xxxxxxxx', 13, 10,
               'EBX=xxxxxxxx', 13, 10,
               'ECX=xxxxxxxx', 13, 10,
               'EDX=xxxxxxxx', 0

    Caption03h db "CPUID 80000003h", 0
    Text03h db 'EAX=xxxxxxxx', 13, 10,
               'EBX=xxxxxxxx', 13, 10,
               'ECX=xxxxxxxx', 13, 10,
               'EDX=xxxxxxxx', 0

    Caption04h db "CPUID 80000004h", 0
    Text04h db 'EAX=xxxxxxxx', 13, 10,
               'EBX=xxxxxxxx', 13, 10,
               'ECX=xxxxxxxx', 13, 10,
               'EDX=xxxxxxxx', 0

    Caption05h db "CPUID 80000005h", 0
    Text05h db 'EAX=xxxxxxxx', 13, 10,
               'EBX=xxxxxxxx', 13, 10,
               'ECX=xxxxxxxx', 13, 10,
               'EDX=xxxxxxxx', 0

    Caption08h db "CPUID 80000008h", 0
    Text08h db 'EAX=xxxxxxxx', 13, 10,
               'EBX=xxxxxxxx', 13, 10,
               'ECX=xxxxxxxx', 13, 10,
               'EDX=xxxxxxxx', 0

.code
    DwordToStrHex proc
        push ebp 
        mov ebp, esp
        mov ebx, [ebp+8]
        mov edx, [ebp+12]
        xor eax, eax
        mov edi, 7

    @next:
        mov al, dl
        and al, 0Fh
        add ax, 48
        cmp ax, 58
        jl @store
        add ax, 7

    @store:
        mov [ebx+edi], al
        shr edx, 4
        dec edi
        cmp edi, 0
        jge @next
        pop ebp
        ret 8

    DwordToStrHex endp

main:

    ; -------- Main Window --------

    invoke MessageBoxA, 0, ADDR mainWindowText, ADDR mainWindowTitle, 0

    ; -------- CPUID 0 --------

    mov eax, 0
    cpuid
    mov dword ptr[res], eax
    mov dword ptr[res+4], ebx
    mov dword ptr[res+8], ecx
    mov dword ptr[res+12], edx

    mov dword ptr[Vendor], ebx
    mov dword ptr[Vendor+4], edx 
    mov dword ptr[Vendor+8], ecx

    push [res]
    push offset [Text0+4]
    call DwordToStrHex
    push [res+4]
    push offset [Text0+18]
    call DwordToStrHex 
    push [res+8]
    push offset [Text0+32]
    call DwordToStrHex 
    push [res+12]
    push offset [Text0+46]
    call DwordToStrHex

    invoke MessageBoxA, 0, ADDR Text0, ADDR Caption0, 0

    ; -------- Vendor --------

    invoke MessageBoxA, 0, ADDR Vendor, ADDR CaptionVendor, 0

    ; -------- CPUID 1 --------

    mov eax, 1
    cpuid
    mov dword ptr[res+16], eax
    mov dword ptr[res+20], ebx
    mov dword ptr[res+24], ecx
    mov dword ptr[res+28], edx

    push [res+16] 
    push offset [Text1+4] 
    call DwordToStrHex
    push [res+20]
    push offset [Text1+18]
    call DwordToStrHex 
    push [res+24]
    push offset [Text1+32]
    call DwordToStrHex 
    push [res+28]
    push offset [Text1+46]
    call DwordToStrHex
    
    invoke MessageBoxA, 0, ADDR Text1, ADDR Caption1, 0

    ; -------- CPUID 2 --------

    mov eax, 2
    cpuid
    mov dword ptr[res+32], eax
    mov dword ptr[res+36], ebx
    mov dword ptr[res+40], ecx
    mov dword ptr[res+44], edx

    push [res+32] 
    push offset [Text2+4] 
    call DwordToStrHex
    push [res+36] 
    push offset [Text2+18]
    call DwordToStrHex 
    push [res+40] 
    push offset [Text2+32]
    call DwordToStrHex 
    push [res+44] 
    push offset [Text2+46]
    call DwordToStrHex

    invoke MessageBoxA, 0, ADDR Text2, ADDR Caption2, 0

    ; -------- CPUID 80000000h --------

    mov eax, 80000000h
    cpuid
    mov dword ptr[res+48], eax
    mov dword ptr[res+52], ebx
    mov dword ptr[res+56], ecx
    mov dword ptr[res+60], edx

    push [res+48] 
    push offset [Text00h+4] 
    call DwordToStrHex
    push [res+52] 
    push offset [Text00h+18]
    call DwordToStrHex 
    push [res+56] 
    push offset [Text00h+32]
    call DwordToStrHex 
    push [res+60] 
    push offset [Text00h+46]
    call DwordToStrHex

    invoke MessageBoxA, 0, ADDR Text00h, ADDR Caption00h, 0

    ; -------- CPUID 80000001h --------

    mov eax, 80000001h
    cpuid
    mov dword ptr[res+64], eax
    mov dword ptr[res+68], ebx
    mov dword ptr[res+72], ecx
    mov dword ptr[res+76], edx

    push [res+64] 
    push offset [Text01h+4] 
    call DwordToStrHex
    push [res+68] 
    push offset [Text01h+18]
    call DwordToStrHex 
    push [res+72] 
    push offset [Text01h+32]
    call DwordToStrHex 
    push [res+76] 
    push offset [Text01h+46]
    call DwordToStrHex

    invoke MessageBoxA, 0, ADDR Text01h, ADDR Caption01h, 0

    ; -------- CPUID 80000002h --------

    mov eax, 80000002h
    cpuid
    mov dword ptr[res+80], eax
    mov dword ptr[res+84], ebx
    mov dword ptr[res+88], ecx
    mov dword ptr[res+92], edx

    mov dword ptr[VendorExt], eax
    mov dword ptr[VendorExt+4], ebx
    mov dword ptr[VendorExt+8], ecx
    mov dword ptr[VendorExt+12], edx 

    push [res+80] 
    push offset [Text02h+4] 
    call DwordToStrHex
    push [res+84] 
    push offset [Text02h+18]
    call DwordToStrHex 
    push [res+88] 
    push offset [Text02h+32]
    call DwordToStrHex 
    push [res+92] 
    push offset [Text02h+46]
    call DwordToStrHex

    invoke MessageBoxA, 0, ADDR Text02h, ADDR Caption02h, 0

    ; -------- CPUID 80000003h --------

    mov eax, 80000003h
    cpuid
    mov dword ptr[res+96], eax
    mov dword ptr[res+100], ebx
    mov dword ptr[res+104], ecx
    mov dword ptr[res+108], edx

    mov dword ptr[VendorExt+16], eax
    mov dword ptr[VendorExt+20], ebx
    mov dword ptr[VendorExt+24], ecx
    mov dword ptr[VendorExt+28], edx 

    push [res+96] 
    push offset [Text03h+4] 
    call DwordToStrHex
    push [res+100] 
    push offset [Text03h+18]
    call DwordToStrHex 
    push [res+104] 
    push offset [Text03h+32]
    call DwordToStrHex 
    push [res+108] 
    push offset [Text03h+46]
    call DwordToStrHex

    invoke MessageBoxA, 0, ADDR Text03h, ADDR Caption03h, 0

    ; -------- CPUID 80000004h --------

    mov eax, 80000004h
    cpuid
    mov dword ptr[res+112], eax
    mov dword ptr[res+116], ebx
    mov dword ptr[res+120], ecx
    mov dword ptr[res+124], edx

    mov dword ptr[VendorExt+32], eax
    mov dword ptr[VendorExt+36], ebx
    mov dword ptr[VendorExt+40], ecx
    mov dword ptr[VendorExt+44], edx 

    push [res+112] 
    push offset [Text04h+4] 
    call DwordToStrHex
    push [res+116] 
    push offset [Text04h+18]
    call DwordToStrHex 
    push [res+120] 
    push offset [Text04h+32]
    call DwordToStrHex 
    push [res+124] 
    push offset [Text04h+46]
    call DwordToStrHex

    invoke MessageBoxA, 0, ADDR Text04h, ADDR Caption04h, 0

    ; -------- VendorExt --------

    invoke MessageBoxA, 0, ADDR VendorExt, ADDR CaptionVendorExt, 0

    ; -------- CPUID 80000005h --------

    mov eax, 80000005h
    cpuid
    mov dword ptr[res+128], eax
    mov dword ptr[res+132], ebx
    mov dword ptr[res+136], ecx
    mov dword ptr[res+140], edx
    
    push [res+128] 
    push offset [Text05h+4] 
    call DwordToStrHex
    push [res+132] 
    push offset [Text05h+18]
    call DwordToStrHex 
    push [res+136] 
    push offset [Text05h+32]
    call DwordToStrHex 
    push [res+140] 
    push offset [Text05h+46]
    call DwordToStrHex

    invoke MessageBoxA, 0, ADDR Text05h, ADDR Caption05h, 0

    ; -------- CPUID 80000008h --------

    mov eax, 80000008h
    cpuid
    mov dword ptr[res+144], eax
    mov dword ptr[res+148], ebx
    mov dword ptr[res+152], ecx
    mov dword ptr[res+156], edx

    push [res+144] 
    push offset [Text08h+4] 
    call DwordToStrHex
    push [res+148] 
    push offset [Text08h+18]
    call DwordToStrHex 
    push [res+152] 
    push offset [Text08h+32]
    call DwordToStrHex 
    push [res+156] 
    push offset [Text08h+46]
    call DwordToStrHex

    invoke MessageBoxA, 0, ADDR Text08h, ADDR Caption08h, 0

    invoke ExitProcess, 0

end main
