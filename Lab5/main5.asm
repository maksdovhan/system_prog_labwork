.586
.model flat, stdcall

include module.inc
include longop.inc

include \masm32\include\user32.inc
include \masm32\include\kernel32.inc

.data
	mainWindowTitle db "����������� ������ �5", 0
	mainWindowText db "���������� ����!", 13, 10, 13, 10,
					  "����������� ������ �������:", 13, 10,
					  "������� ����� ��-24,", 13, 10,
					  "������� �. �.", 0

	Value dd 21 dup(0FFFFFFFFh)

	M dd 138
	N dd 138

	windowTitle db "���� M �������� ��� �� N ������� ������", 0

	lastWindowTitle db "�������� ��������� ������", 0
	lastWindowText db "����� �� �����!", 0

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
