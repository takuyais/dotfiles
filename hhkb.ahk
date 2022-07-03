#If WinActive("ahk_exe mintty.exe") or WinActive("ahk_exe putty.exe")
; Recovery for Shift+Ins
+F12::Return
#If

;$Esc::
;$!Esc::
;Send, % GetKeyState("Alt", "P") ? "{Esc}" : "{vk19}"
;Return
