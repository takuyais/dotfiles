#InstallKeybdHook ; Need to count keyboard idle time (without mouse cursor) by A_TimeIdlePhysical
#Persistent
#NoEnv
#SingleInstance force

IME_TOOL_TIP_NUM = 20

; Show IME status with tooltip
SetTimer, IMEToolTip, 50 ; Adjust this period to suppress flicker of the IMEToolTip

IMEToolTip:
MouseGetPos,,, id
title = ahk_id %id%
keyInputIdleMillisec = 400
if (A_TimeIdlePhysical > keyInputIdleMillisec && IsIMEOn(title)) {
    ;if (WinActive(title)) {
    ;    ; Show at caret position
    ;    ToolTip, IME On, A_CaretX , A_CaretY + 20, IME_TOOL_TIP_NUM
    ;} else {
        ; Show at mouse cursor position
        ToolTip, IME On,,, IME_TOOL_TIP_NUM
    ;}
} else {
    Tooltip,,,, IME_TOOL_TIP_NUM
}
Return

; Following are originated from http://www6.atwiki.jp/eamat/pages/17.html by eamat.
; Begin --------------------------------------------------
; List of Windows Messages: https://autohotkey.com/docs/misc/SendMessageList.htm
; WM_IME_CONTROL: https://msdn.microsoft.com/en-us/library/windows/desktop/dd374135(v=vs.85).aspx
IsIMEOn(winTitle="A") {
    Return DllCall("SendMessage"
            , UInt, DllCall("imm32\ImmGetDefaultIMEWnd", Uint, GetWinHandleByTitle(winTitle))
            , UInt, 0x0283  ; Message : WM_IME_CONTROL
            ,  Int, 0x0005  ; wParam  : IMC_GETOPENSTATUS
            ,  Int, 0)      ; lParam  : 0 (lParam is not used.)
        != 0 ; Nonzero indicates that the current IME is open. Zero indicates the current IME is closed.
}

EnableIME(status=true, winTitle="A") {
    Return DllCall("SendMessage"
            , UInt, DllCall("imm32\ImmGetDefaultIMEWnd", Uint, GetWinHandleByTitle(winTitle))
            , UInt, 0x0283  ; Message : WM_IME_CONTROL
            ,  Int, 0x0006  ; wParam  : IMC_SETOPENSTATUS
            ,  Int, status) ; lParam  : 0 (false) or 1 (true)
}

GetWinHandleByTitle(title="A") {
    ControlGet, hwnd, Hwnd,,, %title%
    if (WinActive(title)) {
        ptrSize := !A_PtrSize ? 4 : A_PtrSize
        VarSetCapacity(stGTI, cbSize:=4+4+(ptrSize*6)+16, 0)
        NumPut(cbSize, stGTI,  0, "UInt")  ; DWORD   cbSize;
        hwnd := DllCall("GetGUIThreadInfo", Uint, 0, Uint, &stGTI)
                ? NumGet(stGTI, 8+ptrSize, "UInt") : hwnd
    }

    Return hwnd
}
; End --------------------------------------------------

; Disable F1 help
F1::Return

; Recovery for Alt+vk19
!Esc::vk19

; Copy or cut as plain text
;^+x::
;^+c::
;Send, % RegExReplace(A_ThisHotkey, "[+]")
;Clipboard=%Clipboard%
;Clipwait
;Return

; Paste as plain text
^+v::
Clipboard=%Clipboard%
Clipwait
Send, ^v
Return

!+q::!F4
!+4::!F4

RAlt::vk19 ; Hankaku/Zenkaku
RWin::vk19 ; Hankaku/Zenkaku

#If !WinActive("ahk_exe EXCEL.EXE")
; Insert the current date, inspired by Excel
^;::
SendInput %A_YYYY%-%A_MM%-%A_DD%
Return
#If

; PowerPoint specific
#If WinActive("ahk_exe POWERPNT.EXE")
; Show format shape dialog
^1::
Send, !ho
Return
#If

;#Include %A_ScriptDir%
#Include *i hhkb.ahk
