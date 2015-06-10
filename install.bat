@echo off
rem Need to run as addministrator
setlocal

cd /d %userprofile%

mklink .gitconfig dotfiles\gitconfig
mklink _vimrc dotfiles\vimrc
mklink _gvimrc dotfiles\gvimrc

endlocal
pause

