.586
.model flat, stdcall

include module.inc
include longop.inc

include \masm32\include\user32.inc
include \masm32\include\kernel32.inc

.data
	mainWindowTitle db "Лабораторна робота №5", 0
	mainWindowText db "Здоровенькі були!", 13, 10, 13, 10,
					  "Лабораторну роботу виконав:", 13, 10,
					  "студент групи ІО-24,", 13, 10,
					  "Довгань М. С.", 0

	Value dd 21 dup(0FFFFFFFFh)

	M dd 138
	N dd 138

	windowTitle db "Зсув M молодших бітів на N позицій вправо", 0

	lastWindowTitle db "Програма завершила роботу", 0
	lastWindowText db "Дякую за увагу!", 0

	textbuf dd 1 dup(?)

.code
main5:
	invoke MessageBoxA, 0, ADDR mainWindowText, ADDR mainWindowTitle, 0

	push M
	push N
	push offset Value
	call Shr_LONGOP

	push offset textbuf
	push offset Value
	push 672
	call StrHex_MY
	
	invoke MessageBoxA, 0, ADDR textbuf, ADDR windowTitle, 0

	invoke MessageBoxA, 0, ADDR lastWindowText, ADDR lastWindowTitle, 0

	invoke ExitProcess, 0

end main5
