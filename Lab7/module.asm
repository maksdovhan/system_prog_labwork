.586
.model flat, c

.data 
	points dw 8
	min dd ?
	result_local dd ?

.code
FloatToDec proc
    push ebp
    mov ebp, esp
    mov edi, [ebp+12]
    mov esi, [ebp+8]

    mov eax, esi
    and eax, 80000000h
    cmp eax, 0

    je @no_sign
        mov byte ptr [edi], 45
        inc edi

    @no_sign:
    mov ecx, edi
    mov eax, esi
    and eax, 7F800000h
    shr eax, 23
    cmp eax, 0

    jne @zero_exp
        mov byte ptr [edi], 48
        jmp @endproc

    @zero_exp:
    cmp eax, 0FFh
    jne @inf_nan
        mov word ptr [edi], 6E69h
        mov word ptr [edi+2], 7974h
        jmp @endproc

    @inf_nan:
    sub eax, 7Fh
    cmp eax, 0
    jge @denormalized

    mov byte ptr [edi], 48
    inc ecx
    mov ebx, esi
    and ebx, 7FFFFFh
    add ebx, 800000h
    mov edx, 0FFFFFFFFh
    imul edx
    mov edx, ecx
    mov ecx, eax
    shr ebx, cl
    mov ecx, edx
    jmp @fraction

    @denormalized:
    jg @greater_than_one
        mov byte ptr [edi], 49
        inc ecx
        mov ebx, esi
        and ebx, 7FFFFFh
        jmp @fraction

    @greater_than_one:
    push ecx
    mov ecx, 23
    sub ecx, eax 
    push ecx
    mov eax, esi
    and eax, 7FFFFFh
    add eax, 800000h
    xor ebx, ebx
    mov ebx, 1
    shl ebx, cl
    mov edx, ebx

    @calculate_fraction_mask:
        inc cl
        shl ebx, 1
        add ebx, edx
        cmp cl, 24
    jne @calculate_fraction_mask

    mov edx, eax
    and edx, ebx
    mov ebx, eax
    sub ebx, edx
    pop ecx
    shr edx, cl
    mov eax, 23
    sub eax, ecx
    mov ecx, eax
    shl ebx, cl

    mov eax, edx
    pop ecx
    push ebx
    mov ebx, 10

    @integer_part:
        xor edx, edx
        div ebx
        add edx, 48
        mov byte ptr [ecx], dl
        inc ecx
        cmp eax, 0
    jne @integer_part

    mov eax, ecx
    dec eax

    @swap:
        xor edx, edx
        mov dh, byte ptr [eax]
        mov dl, byte ptr [edi]
        mov byte ptr [eax], dl
        mov byte ptr [edi], dh
        inc edi
        dec eax
        cmp edi, eax 
    jl @swap
    pop ebx

    @fraction:
        mov byte ptr [ecx], 44
        inc ecx
        mov ax, points

    @fraction_loop:
        shl ebx, 1
        mov edx, ebx
        shl edx, 2
        add ebx, edx
        mov edx, ebx
        and edx, 0FF800000h
        shr edx, 23
        add dl, 48
        mov [ecx], dl 
        and ebx, 7FFFFFh
        inc ecx
        dec ax
        cmp ax, 0
        jne @fraction_loop

    @endproc:
    pop ebp
    ret 8

FloatToDec endp

end
