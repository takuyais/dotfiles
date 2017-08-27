rem Need to run as Administrator

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\NamingTemplates" /v ShortcutNameTemplate /d "%%s.lnk"

pause
