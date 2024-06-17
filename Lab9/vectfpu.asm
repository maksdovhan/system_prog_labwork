.686
.xmm
.model flat, c

.data

temp dd 4 dup(0)

.code

MyDotProduct_FPU proc dest:DWORD, pB:DWORD, pA:DWORD, bits:DWORD ; Початок процедури MyDotProduct_FPU з чотирма параметрами

	mov edx, bits
	mov esi, pA
	mov ebx, pB
	mov edi, dest
	fld dword ptr[temp]

	cycle:
		dec edx
		fld dword ptr[esi+edx*4]
		fmul dword ptr[ebx+edx*4]
		faddp st(1), st(0)
		cmp edx, 0
	jne cycle
	fstp dword ptr[edi]
	ret

MyDotProduct_FPU endp

end
