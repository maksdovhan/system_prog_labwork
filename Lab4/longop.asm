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

	@cycle:
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
			jmp @cycle
	
	@exit:
		mov edi, [ebp+8]
		mov ecx, 0

		@cycle2:
			cmp ecx, 9
			je @done

			mov eax, [oldResFactorial+4*ecx]
			mov [edi+4*ecx], eax
			mov [oldResFactorial+4*ecx], 0h

			inc ecx
			jmp @cycle2

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

end
