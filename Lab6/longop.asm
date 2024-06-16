.686
.model flat, c

.data
    count dd 0h
    x dd 1
    n dd 0
    counter_in dd 5
    counter_out dd 5

    num10 db 10
    inner dd 0
    num7 db 7
    minn db 0
    spacee db 3

    fpart db 0

.code

Calc_Nx32_LONGOP proc
    push ebp
    mov ebp, esp
    mov edi, [ebp+12]
    mov ebx, [ebp+8]
    mov x, ebx 
    mov n, 11
    xor ebx, ebx
    xor ecx, ecx
@mult32:
    mov eax, dword ptr[edi + ecx]
    mul x
    mov dword ptr[edi + ecx], eax
    clc
    adc dword ptr[edi + ecx], ebx
    mov ebx, edx
    add ecx, 4
    dec n
    jnz @mult32
    pop ebp
    ret 8
Calc_Nx32_LONGOP endp


Div_Column_LONGOP proc
    xor ebx, ebx
    xor ecx, ecx
    dec edx
    cmp byte ptr[esi + edx], 0
    jnz @cycleout
    inc bl
@cycleout:
    mov ch, byte ptr[esi + edx]
@cycleinner:
    shl cl, 1
    shl bh, 1
    shl ch, 1
    jnc @zero
    inc bh
@zero:
    cmp bh, num10
    jc @less
    inc cl
    sub bh, num10
@less:
    inc inner
    cmp inner, 8
    jnz @cycleinner
    mov byte ptr[esi + edx], cl
    mov inner, 0
    sub edx, 1
    jnc @cycleout
    ret
Div_Column_LONGOP endp


Str_Dec_MY proc
    push ebp
    mov ebp,esp
    mov edx, [ebp+8]
    shr edx, 3
    mov esi, [ebp+12]
    mov edi, [ebp+16]
    mov eax, edx
    shl eax, 2
    mov cl, byte ptr[esi + edx - 1]
    and cl, 128
    cmp cl, 128
    jnz @plus
    mov minn, 1
    push edx
@minus:
    not byte ptr[esi + edx - 1]
    sub edx, 1
    jnz @minus
    inc byte ptr[esi + edx]
    pop edx
@plus:
@cycle:
    push edx
    call Div_Column_LONGOP
    pop edx
    add bh, 48
    mov byte ptr[edi + eax], bh
    dec eax
    cmp bl, 0
    jz @cycle
    dec edx
    jnz @cycle
    cmp minn, 1
    jc @nomin
    mov byte ptr[edi + eax + 1], 45
    dec eax
@nomin:
    inc eax
@space:
    mov byte ptr[edi + eax], 32
    sub eax, 1
    jnc @space
    pop ebp
    ret 12
Str_Dec_MY endp


Div10_LONGOP proc
    push ebp
    mov ebp, esp
    mov esi, [ebp + 20]
    mov edi, [ebp + 16]
    mov ebx, [ebp + 12]
    mov eax, [ebp + 8]
    mov x, eax
    push ebx
    xor edx, edx
    mov ecx, x
    dec x
    mov ebx, x
@cycle:
    push ecx
    mov ecx, 10
    mov eax, dword ptr[esi + 4*ebx]
    div ecx
    mov fpart, dl
    mov dword ptr[edi + 4*ebx], eax
    dec ebx
    pop ecx
    dec ecx
    jnz @cycle
    pop ebx
    mov al, fpart
    mov byte ptr[ebx], al
    pop ebp
    ret 16
Div10_LONGOP endp

end
