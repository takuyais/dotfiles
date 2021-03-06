@echo off
rem Need to run as Administrator
setlocal

cd /d "%USERPROFILE%"
mklink .gitconfig dotfiles\gitconfig
mklink .gitconfig.local dotfiles\gitconfig.local
mklink _vimrc dotfiles\vimrc
mklink _gvimrc dotfiles\gvimrc
mkdir ctags.d\
mklink ctags.d\config.ctags ..\dotfiles\config.ctags

cd /d "%APPDATA%\Code\User"
if not errorlevel 1 (
    mklink settings.json "%USERPROFILE%\dotfiles\settings.json"
    mklink keybindings.json "%USERPROFILE%\dotfiles\keybindings.json"
)

rem reg import NamingTemplates.reg

rem Use SetEnvironmentVariable instead of SETX, to avoid side effects.
set GREP_OPTIONS=--exclude-dir=".svn" --exclude-dir=".git" --exclude-dir="node_modules" --exclude-dir="target" --exclude="*.class" --exclude "*.map"
rem powershell -Command "[Environment]::SetEnvironmentVariable('GREP_OPTIONS', $env:GREP_OPTIONS, 'User')"

endlocal
pause
