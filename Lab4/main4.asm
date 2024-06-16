.586
.model flat, stdcall

include module.inc
include longop.inc

include \masm32\include\user32.inc
include \masm32\include\kernel32.inc

.data
	mainWindowTitle db "����������� ������ �4", 0
	mainWindowText db "���������� ����!", 13, 10, 13, 10,
					  "����������� ������ �������:", 13, 10,
					  "������� ����� ��-24,", 13, 10,
					  "������� �. �.", 0

	computeFactorialN db "���������� ��������� (n!):", 0
	computeFactorialNN db "���������� �������� ��������� (n! * n!):", 0
	computeFirstMultiplicationNN db "���������� �������� ���������� N * N:", 0
	computeMultiplicationN32 db "���������� �������� ���������� N * 32:", 0
	computeSecondMultiplicationNN db "���������� �������� ���������� N * N:", 0

	lastWindowTitle db "�������� ��������� ������", 0
	lastWindowText db "����� �� �����!", 0

	firstFactorialN dd 48
	resFirstFactorialN dd 9 dup(0h), 0

	secondFactorialN dd 48, 0
	resSecondFactorial1N dd 9 dup(0h)
	resSecondFactorial2N dd 9 dup(0h)
	resSecondFactorial dd 18 dup(0h)

	firstValueNN dd 9 dup(0FFFFFFFFh)
	secondValueNN dd 9 dup(0FFFFFFFFh)
	firstResNN dd 18 dup(0h)

	firstValueN32 dd 9 dup(0FFFFFFFFh)
	secondValueN32 dd 0FFFFFFFFh
	resN32 dd 10 dup(0h)

	thirdValueNN dd 9 dup(55555555h)
	fourthValueNN dd 00000001h, 00000000h, 00000000h, 00000000h, 00000000h,
					  00000000h, 00000000h, 00000000h, 80000000h
	secondResNN dd 18 dup(0h)

	textbufFirstFactorial db 9 dup(?)
	textbufSecondFactorial db 18 dup(?)
	textbufFirstNN db 18 dup(?)
	textbufN32 db 10 dup(?)
	textbufSecondNN db 18 dup(?)

.code
main4:
	invoke MessageBoxA, 0, ADDR mainWindowText, ADDR mainWindowTitle, 0

	;---------- ���������� ��������� n! ----------

	push firstFactorialN
	push offset resFirstFactorialN
	call Factorial
	
	push offset textbufFirstFactorial
	push offset resFirstFactorialN
	push 288
	call StrHex_MY
	
	invoke MessageBoxA, 0, ADDR textbufFirstFactorial, ADDR computeFactorialN, 0

	;---------- ���������� �������� ��������� n! * n! ----------

	push secondFactorialN
	push offset resSecondFactorial1N
	call Factorial
	
	push secondFactorialN
	push offset resSecondFactorial2N
	call Factorial
	
	push offset resSecondFactorial1N
	push offset resSecondFactorial2N
	push 9
	push offset resSecondFactorial
	call Mul_NN_LONGOP

	push offset textbufSecondFactorial
	push offset resSecondFactorial
	push 576
	call StrHex_MY
	
	invoke MessageBoxA, 0, ADDR textbufSecondFactorial, ADDR computeFactorialNN, 0

	;---------- ���������� �������� �������� ���� ���������� �������� N * N ----------

	push offset firstValueNN
	push offset secondValueNN
	push 9
	push offset firstResNN
	call Mul_NN_LONGOP

	push offset textbufFirstNN
	push offset firstResNN
	push 576
	call StrHex_MY

	invoke MessageBoxA, 0, ADDR textbufFirstNN, ADDR computeFirstMultiplicationNN, 0
	
	;----------- ���������� �������� �������� ���� ���������� �������� N * 32 ----------

	push offset firstValueN32
	push secondValueN32
	push 9
	push offset resN32
	call Mul_N32_LONGOP

	push offset textbufN32
	push offset resN32
	push 320
	call StrHex_MY

	invoke MessageBoxA, 0, ADDR textbufN32, ADDR computeMultiplicationN32, 0
	
	;---------- ���������� �������� �������� ���� ���������� �������� N * N ----------

	push offset thirdValueNN
	push offset fourthValueNN
	push 9
	push offset secondResNN
	call Mul_NN_LONGOP

	push offset textbufSecondNN
	push offset secondResNN
	push 576
	call StrHex_MY

	invoke MessageBoxA, 0, ADDR textbufSecondNN, ADDR computeSecondMultiplicationNN, 0

	invoke MessageBoxA, 0, ADDR lastWindowText, ADDR lastWindowTitle, 0

	invoke ExitProcess, 0

end main4
