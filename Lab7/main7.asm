.586
.model flat, stdcall

include module.inc

include \masm32\include\user32.inc
include \masm32\include\kernel32.inc

.data
    mainWindowTitle db "Лабораторна робота №7", 0
	mainWindowText db "Здоровенькі були!", 13, 10, 13, 10,
					  "Лабораторну роботу виконав:", 13, 10,
					  "студент групи ІО-24,", 13, 10,
					  "Довгань М. С.", 0

    Text db 100 dup(0), 0
    Caption db "Обчислене математичне вираження", 0

    result dd 0.0
    iterationsNum dd 7
    one dd 1.0

    firstArray dd 3.7, 2.1, -7.5, 5.8, -4.6, -1.8, 9.3
    secondArray dd -5.6, -4.4, 7.3, 3.9, 1.4, -6.4, 6.3

    lastWindowTitle db "Програма завершила роботу", 0
	lastWindowText db "Дякую за увагу!", 0

.code
main:
    invoke MessageBoxA, 0, ADDR mainWindowText, ADDR mainWindowTitle, 0

    mov edx, 0
    fld one
    fldz

@while:
    fld dword ptr [firstArray + 4 * edx]
    fmul dword ptr [secondArray + 4 * edx]
    faddp st(1), st(0)
    
    inc edx
    cmp edx, iterationsNum
    jl @while
   
    fyl2x
    fstp dword ptr [Result]

    push offset Text
    push Result
    call FloatToDec

    invoke MessageBoxA, 0, ADDR Text, ADDR Caption, 0

    invoke MessageBoxA, 0, ADDR lastWindowText, ADDR lastWindowTitle, 0

    invoke ExitProcess, 0

end main
