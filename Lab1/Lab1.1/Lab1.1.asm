.386
.model flat, stdcall

include \masm32\include\user32.inc
include \masm32\include\kernel32.inc

includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib

.data
    Caption db "� - �������� �� ��������", 0
    Text db "���������� ����!", 10, 13, 10, 13,
            "����������� ������ �������:", 10, 13,
            "������� ����� ��-24,", 10, 13,
            "������� �. �.", 0

.code
start:
    invoke MessageBoxA, 0, ADDR Text, ADDR Caption, 0
    invoke ExitProcess, 0
    
end start
