.586
.model flat, stdcall
include \masm32\include\kernel32.inc
include \masm32\include\user32.inc
include module.inc
include longop.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib
option casemap :none

.data

Caption db "Я програма на асемблері",0  
Text db "Автор: студентка групи ІО-25 Дем'яненко Катерина", 13, 10,
     "y = 5 / (x + 1) * 2^m", 0
    
Caption_Int db "Перевірка ділення на 10" ,0
Caption_n_factorial db "n!" ,0
Caption_function db "Функція" ,0
textBuf_Int dd 12 dup(?)
textBuf_n_factorial dd 80 dup(?)
textBuf_function dd 30 dup(?)

var dd 13 dup(0)
x dd 48 ; 48!
y dd 0

number dd 40 ; число для перевірки ділення на 10
intP dd 0
fractP dd 0

.code
start:

    ; Початкове вікно
    invoke MessageBoxA, 0, ADDR Text, ADDR Caption, 0

    push offset number
    push offset intP
    push offset fractP
    push 32
    call Div10_LONGOP
    push offset textBuf_Int
    push offset intP
    push 32
    call Str_Dec_MY
    invoke MessageBoxA, 0, ADDR textBuf_Int, ADDR Caption_Int, 0

    ; n!
    mov [var], 1
    @fact:
        push offset var
        push x
        call Calc_Nx32_LONGOP
        dec x
        jne @fact
    push offset textBuf_n_factorial
    push offset var
    push 450
    call Str_Dec_MY
    invoke MessageBoxA, 0, ADDR textBuf_n_factorial, ADDR Caption_n_factorial, 0

    ; функція
    push 4 ; x = 4
    push 3 ; m = 3
    call Func ; y = 5/(4+1)*2^3 = 8
    mov y, eax
    push offset textBuf_function
    push offset y
    push 32
    call Str_Dec_MY
    invoke MessageBoxA, 0, ADDR textBuf_function, ADDR Caption_function, 0
    invoke ExitProcess, 0

end start
