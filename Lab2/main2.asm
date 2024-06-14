.386
.model flat, stdcall
option casemap : none

include module.inc

include \masm32\include\user32.inc
include \masm32\include\kernel32.inc

includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib

.const
	mainWindowTitle db "Лабораторна робота №2", 0
	mainWindowText db "Здоровенькі були!", 13, 10, 13, 10,
					  "Лабораторну роботу виконав:", 13, 10,
					  "студент групи ІО-24,", 13, 10,
					  "Довгань М. С.", 0
	windowTask1 db "Цілий 8-бітовий тип", 0
	windowTask2 db "Цілий 16-бітовий тип", 0
	windowTask3 db "Цілий 32-бітовий тип", 0
	windowTask4 db "Цілий 64-бітовий тип", 0
	windowTask5 db "Плаваюча точка 32-бітовий тип", 0
	windowTask6 db "Плаваюча точка 64-бітовий тип", 0
	windowTask7 db "Плаваюча точка 80-бітовий тип", 0
	lastWindowTitle db "Програма завершила роботу", 0
	lastWindowText db "Дякую за увагу!", 0

.data
	textRes db 64 dup(?)
	num1 db 19
	num2 db -19
	num3 dw 19
	num4 dw -19
	num5 dd 19
	num6 dd -19
	num7 dq 19
	num8 dq -19
	num9 dd 19.0
	num10 dd -38.0
	num11 dd 19.19
	num12 dq 19.0
	num13 dq -38.0
	num14 dq 19.19
	num15 dt 19.0
	num16 dt -38.0
	num17 dt 19.19

.code

main:
	invoke MessageBoxA, 0, ADDR mainWindowText, ADDR mainWindowTitle, 0

	push offset textRes
	push offset num1
	push 8
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR textRes, ADDR windowTask1, 0

	push offset textRes
	push offset num2
	push 8
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR textRes, ADDR windowTask1, 0

	push offset textRes
	push offset num3
	push 16
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR textRes, ADDR windowTask2, 0

	push offset textRes
	push offset num4
	push 16
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR textRes, ADDR windowTask2, 0

	push offset textRes
	push offset num5
	push 32
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR textRes, ADDR windowTask3, 0

	push offset textRes
	push offset num6
	push 32
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR textRes, ADDR windowTask3, 0

	push offset textRes
	push offset num7
	push 64
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR textRes, ADDR windowTask4, 0

	push offset textRes
	push offset num8
	push 64
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR textRes, ADDR windowTask4, 0

	push offset textRes
	push offset num9
	push 32
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR textRes, ADDR windowTask5, 0

	push offset textRes
	push offset num10
	push 32
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR textRes, ADDR windowTask5, 0

	push offset textRes
	push offset num11
	push 32
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR textRes, ADDR windowTask5, 0

	push offset textRes
	push offset num12
	push 64
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR textRes, ADDR windowTask6, 0

	push offset textRes
	push offset num13
	push 64
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR textRes, ADDR windowTask6, 0

	push offset textRes
	push offset num14
	push 64
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR textRes, ADDR windowTask6, 0

	push offset textRes
	push offset num15
	push 80
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR textRes, ADDR windowTask7, 0

	push offset textRes
	push offset num16
	push 80
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR textRes, ADDR windowTask7, 0

	push offset textRes
	push offset num17
	push 80
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR textRes, ADDR windowTask7, 0

	invoke MessageBoxA, 0, ADDR lastWindowText, ADDR lastWindowTitle, 0

	invoke ExitProcess, 0

end main
