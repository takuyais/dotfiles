@echo off
rem Need to run as Administrator
setlocal

cd /d "%userprofile%"
mklink .gitconfig dotfiles\gitconfig
mklink .gitconfig.local dotfiles\gitconfig.local
mklink _vimrc dotfiles\vimrc
mklink _gvimrc dotfiles\gvimrc

cd /d "%appdata%\Code\User"
if not errorlevel 1 (
    mklink settings.json "%userprofile%\dotfiles\settings.json"
    mklink keybindings.json "%userprofile%\dotfiles\keybindings.json"
)

endlocal
pause
