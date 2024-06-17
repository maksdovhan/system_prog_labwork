.686
.xmm
.model flat, C
.data

temp dd 4 dup(0)

.code
MyDotProduct_SSE proc dest:DWORD, pB:DWORD, pA:DWORD, bits:DWORD ; Початок процедури MyDotProduct_SSE з чотирма параметрами

	mov edx, bits
	mov esi, pA
	mov ebx, pB
	mov edi, dest

	cycle:
		sub edx, 4
		movups xmm0, [esi+edx*4]
		movups xmm1, [ebx+edx*4]
		mulps xmm0, xmm1
		addps xmm2, xmm0
		cmp edx, 0
	jne cycle

	haddps xmm2, xmm2
	haddps xmm2, xmm2
	movups temp, xmm2
	mov eax, dword ptr[temp]
	mov dword ptr[edi], eax
	ret

MyDotProduct_SSE endp

end
