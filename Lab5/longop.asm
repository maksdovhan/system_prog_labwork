.586
.model flat, c

.data
	count dd 0h
	factorialValue dd 1h
	resFactorial dd 18 dup(0h)
	oldResFactorial dd 18 dup(0h)
	
.code
Factorial proc
	push ebp
	mov ebp, esp
	mov ecx, 1
	add oldResFactorial, 1
	clc

	@maincycle:
		cmp ecx, dword ptr[ebp+12]
		jg @exit
		mov factorialValue, ecx
		push offset oldResFactorial
		push factorialValue
		push 18
		push offset resFactorial
		call Mul_N32_LONGOP
		mov ecx, 0

		@copy:
			cmp ecx, 9
			je @next

			mov eax, [resFactorial+4*ecx]
			mov [oldResFactorial+4*ecx], eax
			mov [resFactorial+4*ecx], 0

			inc ecx
			jmp @copy

		@next:
			mov ecx, factorialValue
			inc ecx
			jmp @maincycle
	
	@exit:
		mov edi, [ebp+8]
		mov ecx, 0

		@secondcycle:
			cmp ecx, 9
			je @done

			mov eax, [oldResFactorial+4*ecx]
			mov [edi+4*ecx], eax
			mov [oldResFactorial+4*ecx], 0h

			inc ecx
			jmp @secondcycle

		@done:
			pop ebp
			ret 8

Factorial endp

Mul_N32_LONGOP proc
	push ebp
	mov ebp, esp

	mov edi, [ebp+8]
	mov ebx, [ebp+16]
	mov esi, [ebp+20]
	xor ecx, ecx
	xor eax, eax			 
	xor edx, edx			 
	clc

	@cycle:
		cmp ecx, dword ptr[ebp+12]
		je @exit
		mov eax, dword ptr[esi+4*ecx]
		mul ebx
		add [edi+4*ecx], eax
		add [edi+4*ecx+4], edx
		inc ecx
		jmp @cycle
		
	@exit:
		xor ecx, ecx
		pop ebp
		ret 16

Mul_N32_LONGOP endp

Mul_NN_LONGOP proc
	push ebp
	mov ebp, esp
	
	mov edi, [ebp+8]
	mov ecx, 0
	mov count, 0
	xor edx, edx
	clc

	@maincycle:
		mov eax, count
		cmp eax, dword ptr[ebp+12]
		je @exit
		
		mov esi, [ebp+16]
		mov ebx, dword ptr[esi+4*eax]
		
		@secondcycle:
			cmp ecx, dword ptr[ebp+12]
			je @Done
			mov esi, [ebp+20]
			mov eax, dword ptr[esi+4*ecx]
			mul ebx
			add ecx, count
			clc
			add [edi+4*ecx], eax
			adc [edi+4*ecx+4], edx
			jnc @next
			mov eax, ecx

			@cf:
				inc eax
				add dword ptr[edi+4*eax+4], 1
				jc @cf

			@next:
				sub ecx, count
				inc ecx
				jmp @secondcycle

		@Done:
			xor ecx, ecx
			add count, 1
			jmp @maincycle

	@exit:
		mov count, 0
		pop ebp
		ret 16

Mul_NN_LONGOP endp

ReadOneBit proc
	push ebp
	mov ebp, esp

	xor ah, ah
	xor cl, cl
	push ecx
	push edx
	push edi

	xor ecx, ecx
	xor ebx, ebx

	mov ebx, [ebp+8]
	mov edi, [ebp+12]

	mov ecx, ebx
	shr ebx, 3

	and ecx, 07h
	mov al, 1
	shl al, cl

	mov ah, byte ptr [edi+ebx]
	and ah, al

	shl ebx, 3
	pop edi
	pop edx
	pop ecx
	pop ebp
	ret 8

ReadOneBit endp

OneBitRightShift proc
	push ebp
	mov ebp, esp

	xor ah, ah
	push edx
	push ecx

	mov edx, [ebp+12]
	mov ecx, [ebp+8]

	push edx
	push ecx
	call ReadOneBit

	shr al, 1
	shr ebx, 3

	cmp ah, 0
	jz @setzero 
	or byte ptr [edx+ebx], al
	jmp @exit
 
	@setzero:
		 not al
		 and byte ptr [edx+ebx], al 
		
	@exit:
		shl ebx, 3
		xor eax, eax
		pop ecx
		pop edx
		pop ebp
		ret 8

OneBitRightShift endp

Shr_LONGOP proc
	push ebp
	mov ebp, esp

	xor ecx, ecx
	xor edx, edx
	push esi
	
	mov esi, [ebp+16]
	mov edx, [ebp+12]
	mov edi, [ebp+8]
	
	@cycle:
		cmp edx, 0
		jle @exit
		xor ecx, ecx

		@inner_cycle:
			push edi
			push ecx
			call OneBitRightShift

			inc ecx
			cmp ecx, [ebp+16]
			jl @inner_cycle

		cmp esi, 0
		jl @exit
		push edi
		push esi
		call ReadOneBit

		shr ebx, 3
		not al
		and byte ptr[edi+ebx], al
		shl ebx, 3
		
		dec esi
		dec edx
		jmp @cycle

	@exit:
		pop esi
		pop ebp
		ret 16

Shr_LONGOP endp

end
