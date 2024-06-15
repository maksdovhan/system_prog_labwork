.586
.model flat, c

.code
Add_512_LONGOP proc
	push ebp
	mov ebp, esp

	mov esi, [ebp+16]
	mov ebx, [ebp+12]
	mov edi, [ebp+8]

	mov ecx, 15
	mov edx, 1
	clc

	mov eax, dword ptr[esi]
	add eax, dword ptr[ebx]
	mov dword ptr[edi], eax

	cycle:
		mov eax, dword ptr[esi+edx*4]
		adc eax, dword ptr[ebx+edx*4]
		mov dword ptr[edi+edx*4], eax
		inc edx
		dec ecx
		jnz cycle

	mov eax, 0
	adc eax, 0
	mov dword ptr [edi+16*4], eax

	pop ebp
	ret 12

Add_512_LONGOP endp

Sub_608_LONGOP proc
	push ebp
	mov ebp, esp
	
	mov esi, [ebp+16]
	mov ebx, [ebp+12]
	mov edi, [ebp+8]

	mov ecx, 18
	mov edx, 1
	clc
	
	mov eax, dword ptr[esi]
	sub eax, dword ptr[ebx]
	mov dword ptr[edi], eax

	cycle:
		mov eax, dword ptr[esi+edx*4]
		sbb eax, dword ptr[ebx+edx*4]
		mov dword ptr[edi+edx*4], eax
		inc edx
		dec ecx
		jnz cycle

	pop ebp
	ret 12

Sub_608_LONGOP endp

end
