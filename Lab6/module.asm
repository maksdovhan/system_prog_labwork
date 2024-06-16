.586
.model flat, c
.data
.code

Func proc
    push ebp
    mov ebp, esp
    mov ecx, [ebp+8] ; m
    mov ebx, [ebp+12] ; x
    add ebx, 1 ; додаємо 1 до x

    mov eax, 5
@divident:
    xor edx, edx
    idiv ebx
    neg ebx
    jmp @multiply

@multiply:
    shl eax, 1
    dec ecx
    cmp ecx, 0
    je @final
    jmp @multiply

@final:
    pop ebp
    ret
Func endp

end
