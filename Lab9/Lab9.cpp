// Lab9.cpp : Defines the entry point for the application.
//

#include "framework.h"
#include <cstdlib>
#include <string>
#include "Lab9.h"

#include "vectsse.h"
#include "vectfpu.h"

#define MAX_LOADSTRING 100

// Global Variables:
HINSTANCE hInst;                                // current instance
WCHAR szTitle[MAX_LOADSTRING];                  // The title bar text
WCHAR szWindowClass[MAX_LOADSTRING];            // the main window class name

// Forward declarations of functions included in this code module:
ATOM                MyRegisterClass(HINSTANCE hInstance);
BOOL                InitInstance(HINSTANCE, int);
LRESULT CALLBACK    WndProc(HWND, UINT, WPARAM, LPARAM);
INT_PTR CALLBACK    About(HWND, UINT, WPARAM, LPARAM);

void myWorkSSE(HWND hWnd);
void myWorkFPU(HWND hWnd);
void myWorkCPP(HWND hWnd);


int APIENTRY wWinMain(_In_ HINSTANCE hInstance,
                     _In_opt_ HINSTANCE hPrevInstance,
                     _In_ LPWSTR    lpCmdLine,
                     _In_ int       nCmdShow)
{
    UNREFERENCED_PARAMETER(hPrevInstance);
    UNREFERENCED_PARAMETER(lpCmdLine);

    // TODO: Place code here.

    // Initialize global strings
    LoadStringW(hInstance, IDS_APP_TITLE, szTitle, MAX_LOADSTRING);
    LoadStringW(hInstance, IDC_LAB9, szWindowClass, MAX_LOADSTRING);
    MyRegisterClass(hInstance);

    // Perform application initialization:
    if (!InitInstance (hInstance, nCmdShow))
    {
        return FALSE;
    }

    HACCEL hAccelTable = LoadAccelerators(hInstance, MAKEINTRESOURCE(IDC_LAB9));

    MSG msg;

    // Main message loop:
    while (GetMessage(&msg, nullptr, 0, 0))
    {
        if (!TranslateAccelerator(msg.hwnd, hAccelTable, &msg))
        {
            TranslateMessage(&msg);
            DispatchMessage(&msg);
        }
    }

    return (int) msg.wParam;
}



//
//  FUNCTION: MyRegisterClass()
//
//  PURPOSE: Registers the window class.
//
ATOM MyRegisterClass(HINSTANCE hInstance)
{
    WNDCLASSEXW wcex;

    wcex.cbSize = sizeof(WNDCLASSEX);

    wcex.style          = CS_HREDRAW | CS_VREDRAW;
    wcex.lpfnWndProc    = WndProc;
    wcex.cbClsExtra     = 0;
    wcex.cbWndExtra     = 0;
    wcex.hInstance      = hInstance;
    wcex.hIcon          = LoadIcon(hInstance, MAKEINTRESOURCE(IDI_LAB9));
    wcex.hCursor        = LoadCursor(nullptr, IDC_ARROW);
    wcex.hbrBackground  = (HBRUSH)(COLOR_WINDOW+1);
    wcex.lpszMenuName   = MAKEINTRESOURCEW(IDC_LAB9);
    wcex.lpszClassName  = szWindowClass;
    wcex.hIconSm        = LoadIcon(wcex.hInstance, MAKEINTRESOURCE(IDI_SMALL));

    return RegisterClassExW(&wcex);
}

//
//   FUNCTION: InitInstance(HINSTANCE, int)
//
//   PURPOSE: Saves instance handle and creates main window
//
//   COMMENTS:
//
//        In this function, we save the instance handle in a global variable and
//        create and display the main program window.
//
BOOL InitInstance(HINSTANCE hInstance, int nCmdShow)
{
   hInst = hInstance; // Store instance handle in our global variable

   HWND hWnd = CreateWindowW(szWindowClass, szTitle, WS_OVERLAPPEDWINDOW,
      CW_USEDEFAULT, 0, CW_USEDEFAULT, 0, nullptr, nullptr, hInstance, nullptr);

   if (!hWnd)
   {
      return FALSE;
   }

   ShowWindow(hWnd, nCmdShow);
   UpdateWindow(hWnd);

   return TRUE;
}

//
//  FUNCTION: WndProc(HWND, UINT, WPARAM, LPARAM)
//
//  PURPOSE: Processes messages for the main window.
//
//  WM_COMMAND  - process the application menu
//  WM_PAINT    - Paint the main window
//  WM_DESTROY  - post a quit message and return
//
//
LRESULT CALLBACK WndProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
{
    switch (message)
    {
    case WM_COMMAND:
        {
            int wmId = LOWORD(wParam);
            // Parse the menu selections:
            switch (wmId)
            {
            case ID_TASK_SSE:
                myWorkSSE(hWnd);
                break;
            case ID_TASK_FPU:
                myWorkFPU(hWnd);
                break;
            case ID_TASK_C:
                myWorkCPP(hWnd);
                break;

            case IDM_ABOUT:
                DialogBox(hInst, MAKEINTRESOURCE(IDD_ABOUTBOX), hWnd, About);
                break;
            case IDM_EXIT:
                DestroyWindow(hWnd);
                break;
            default:
                return DefWindowProc(hWnd, message, wParam, lParam);
            }
        }
        break;
    case WM_PAINT:
        {
            PAINTSTRUCT ps;
            HDC hdc = BeginPaint(hWnd, &ps);
            // TODO: Add any drawing code that uses hdc here...
            EndPaint(hWnd, &ps);
        }
        break;
    case WM_DESTROY:
        PostQuitMessage(0);
        break;
    default:
        return DefWindowProc(hWnd, message, wParam, lParam);
    }
    return 0;
}

// Message handler for about box.
INT_PTR CALLBACK About(HWND hDlg, UINT message, WPARAM wParam, LPARAM lParam)
{
    UNREFERENCED_PARAMETER(lParam);
    switch (message)
    {
    case WM_INITDIALOG:
        return (INT_PTR)TRUE;

    case WM_COMMAND:
        if (LOWORD(wParam) == IDOK || LOWORD(wParam) == IDCANCEL)
        {
            EndDialog(hDlg, LOWORD(wParam));
            return (INT_PTR)TRUE;
        }
        break;
    }
    return (INT_PTR)FALSE;
}
void myWorkSSE(HWND hWnd)
{
    float* arrayA = new float[4320];
    float* arrayB = new float[4320];
    float result0 = 0;

    for (int i = 0; i < 4320; i++) arrayA[i] = 0.001f * (float)(i + 1);
    for (int i = 0; i < 4320; i++) arrayB[i] = 0.001f * (float)(i + 1);

    MyDotProduct_SSE(&result0, arrayB, arrayA, 4320);


    std::string text = std::to_string(result0);
    MessageBoxA(hWnd, text.c_str(), "��������� ������� SSE", MB_OK);

    SYSTEMTIME st;
    long tst, ten;
    GetLocalTime(&st);
    tst = 60000 * (long)st.wMinute + 1000 * (long)st.wSecond + (long)st.wMilliseconds;

    for (long i = 0; i < 1000000; i++)
    {
        MyDotProduct_SSE(&result0, arrayB, arrayA, 4320);
    }

    GetLocalTime(&st);
    ten = 60000 * (long)st.wMinute + 1000 * (long)st.wSecond + (long)st.wMilliseconds - tst;

    delete[]arrayA;
    delete[]arrayB;
    std::string text2 = std::to_string(ten);
    MessageBoxA(hWnd, text2.c_str(), "��� ��������� SSE", MB_OK);

}

void myWorkFPU(HWND hWnd)
{
    float* arrayA = new float[4320];
    float* arrayB = new float[4320];
    float result0 = 0;

    for (int i = 0; i < 4320; i++) arrayA[i] = 0.001f * (float)(i + 1);
    for (int i = 0; i < 4320; i++) arrayB[i] = 0.001f * (float)(i + 1);

    MyDotProduct_FPU(&result0, arrayB, arrayA, 4320);



    std::string text = std::to_string(result0);
    MessageBoxA(hWnd, text.c_str(), "��������� ������� FPU", MB_OK);

    SYSTEMTIME st;
    long tst, ten;
    GetLocalTime(&st);
    tst = 60000 * (long)st.wMinute + 1000 * (long)st.wSecond + (long)st.wMilliseconds;

    for (long i = 0; i < 1000000; i++)
    {
        MyDotProduct_FPU(&result0, arrayB, arrayA, 4320);
    }
    GetLocalTime(&st);
    ten = 60000 * (long)st.wMinute + 1000 * (long)st.wSecond + (long)st.wMilliseconds - tst;

    delete[]arrayA;
    delete[]arrayB;
    std::string text2 = std::to_string(ten);
    MessageBoxA(hWnd, text2.c_str(), "��� ��������� FPU", MB_OK);
}

void myWorkCPP(HWND hWnd)
{
    float* arrayA = new float[4320];
    float* arrayB = new float[4320];
    float result = 0;

    for (int i = 0; i < 4320; i++) arrayA[i] = 0.001f * (float)(i + 1);
    for (int i = 0; i < 4320; i++) arrayB[i] = 0.001f * (float)(i + 1);

    SYSTEMTIME st;
    long tst, ten;
    GetLocalTime(&st);
    tst = 60000 * (long)st.wMinute + 1000 * (long)st.wSecond + (long)st.wMilliseconds;

    for (long i = 0; i < 1000000; i++)
    {
        result = 0;
        for (long i = 0; i < 4320; i++)
        {
            result = result + arrayA[i] * arrayB[i];
        }

    }

    GetLocalTime(&st);
    ten = 60000 * (long)st.wMinute + 1000 * (long)st.wSecond + (long)st.wMilliseconds - tst;
    delete[]arrayA;
    delete[]arrayB;

    std::string text = std::to_string(result);
    MessageBoxA(hWnd, text.c_str(), "��������� ������� �++", MB_OK);

    std::string text3 = std::to_string(ten);
    MessageBoxA(hWnd, text3.c_str(), "��� ��������� �++", MB_OK);
}
