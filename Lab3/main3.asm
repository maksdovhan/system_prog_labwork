.586
.model flat, stdcall

include module.inc
include longop.inc

include \masm32\include\user32.inc
include \masm32\include\kernel32.inc

 
.data
	mainWindowTitle db "Лабораторна робота №3", 0
	mainWindowText db "Здоровенькі були!", 13, 10, 13, 10,
					  "Лабораторну роботу виконав:", 13, 10,
					  "студент групи ІО-24,", 13, 10,
					  "Довгань М. С.", 0

	firstAddA dd 16 dup(?)
	titleAddFirstA db "Значення А", 0

	firstAddB dd 16 dup(?)
	titleAddFirstB db "Значення B", 0

	firstAddRes dd 17 dup(0)
	titleAddFirstRes db "Перше додавання", 0

	secondAddA dd 0000000Eh, 0000000Fh, 00000010h, 00000011h, 00000012h, 00000013h, 00000014h, 00000015h, 
				  00000016h, 00000017h, 00000018h, 00000019h, 0000001Ah, 0000001Bh, 0000001Ch, 0000001Dh
	secondAddB dd 80000003h, 80000003h, 80000003h, 80000003h, 80000003h, 80000003h, 80000003h, 80000003h,
				  80000003h, 80000003h, 80000003h, 80000003h, 80000003h, 80000003h, 80000003h, 80000003h

	secondAddRes dd 17 dup(0)
	titleAddSecondRes db "Друге додавання", 0

	firstSubA dd 00000000h, 00000000h, 00000000h, 00000000h, 00000000h, 00000000h, 00000000h,
				 00000000h, 00000000h, 00000000h, 00000000h, 00000000h, 00000000h, 00000000h,
				 00000000h, 00000000h, 00000000h, 00000000h, 00000000h
	firstSubB dd 0000000Eh, 0000000Fh, 00000010h, 00000011h, 00000012h, 00000013h, 00000014h,
			     00000015h, 00000016h, 00000017h, 00000018h, 00000019h, 0000001Ah, 0000001Bh,
			     0000001Ch, 0000001Dh, 0000001Eh, 0000001Fh, 00000020h

	firstSubRes dd 19 dup(0)
	titleSubFirstRes db "Перше віднімання", 0

	secondSubA dd 0000000Eh, 0000000Fh, 00000010h, 00000011h, 00000012h, 00000013h, 00000014h,
				  00000015h, 00000016h, 00000017h, 00000018h, 00000019h, 0000001Ah, 0000001Bh,
				  0000001Ch, 0000001Dh, 0000001Eh, 0000001Fh, 00000020h
	secondSubB dd 00000001h, 00000001h, 00000001h, 00000001h, 00000001h, 00000001h, 00000001h,
				  00000001h, 00000001h, 00000001h, 00000001h, 00000001h, 00000001h, 00000001h,
				  00000001h, 00000001h, 00000001h, 00000001h, 00000001h

	secondSubRes dd 19 dup(0)
	titleSubSecondRes db "Друге віднімання", 0

	lastWindowTitle db "Програма завершила роботу", 0
	lastWindowText db "Дякую за увагу!", 0

	TextBuf dd 19 dup(0)


.code
main3:
	invoke MessageBoxA, 0, ADDR mainWindowText, ADDR mainWindowTitle, 0

	mov eax, 16
	mov ebx, 0
	mov ecx, 80010001h
	cycleFirstAdd:
		mov dword ptr[firstAddA+4*ebx], ecx
		mov dword ptr[firstAddB+4*ebx], 80000003h
		inc ebx
		add ecx, 10000h
		dec eax
		jnz cycleFirstAdd

	push offset textbuf
	push offset firstAddA
	push 512
	call StrHex_MY

	invoke MessageBoxA, 0, ADDR textbuf, ADDR titleAddFirstA, 0

	push offset textbuf
	push offset firstAddB
	push 512
	call StrHex_MY

	invoke MessageBoxA, 0, ADDR textbuf, ADDR titleAddFirstB, 0

	;---------- First Add ----------

	push offset firstAddA
	push offset firstAddB
	push offset firstAddRes
	call Add_512_LONGOP

	push offset textbuf
	push offset firstAddRes
	push 544
	call StrHex_MY

	invoke MessageBoxA, 0, ADDR textbuf, ADDR titleAddFirstRes, 0

	;---------- Second Add ----------

	push offset secondAddA
	push offset secondAddB
	push offset secondAddRes
	call Add_512_LONGOP

	push offset textbuf
	push offset secondAddRes
	push 544
	call StrHex_MY

	invoke MessageBoxA, 0, ADDR textbuf, ADDR titleAddSecondRes, 0

	;---------- First Substract ----------

	push offset firstSubA
	push offset firstSubB
	push offset firstSubRes
	call Sub_608_LONGOP

	push offset textbuf
	push offset firstSubRes
	push 608
	call StrHex_MY

	invoke MessageBoxA, 0, ADDR textbuf, ADDR titleSubFirstRes, 0

	;---------- Second Substract ----------

	push offset secondSubA
	push offset secondSubB
	push offset secondSubRes
	call Sub_608_LONGOP

	push offset textbuf
	push offset secondSubRes
	push 608
	call StrHex_MY

	invoke MessageBoxA, 0, ADDR textbuf, ADDR titleSubSecondRes, 0

	invoke MessageBoxA, 0, ADDR lastWindowText, ADDR lastWindowTitle, 0

	invoke ExitProcess, 0

end main3
