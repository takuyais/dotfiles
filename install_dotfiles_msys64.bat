@echo off
rem Need to run as Administrator
setlocal

pushd "%SystemDrive%\msys64\home\%USERNAME%"
mklink .bashrc_local "%USERPROFILE%\dotfiles\bashrc"
mklink .aliases_tortoisegit "%USERPROFILE%\dotfiles\aliases_tortoisegit"
mklink .gitconfig "%USERPROFILE%\dotfiles\gitconfig"
mklink .gitconfig.local "%USERPROFILE%\dotfiles\gitconfig.local"
mklink .gitignore_global "%USERPROFILE%\.gitignore_global"
mklink .vimrc "%USERPROFILE%\dotfiles\vimrc"
mklink .gvimrc "%USERPROFILE%\dotfiles\gvimrc"
rem mklink /d vimfiles "%USERPROFILE%\vimfiles"
xcopy /e "%USERPROFILE%\vimfiles" vimfiles\
mkdir vimfiles\swap
mklink .npmrc "%USERPROFILE%\.npmrc"
xcopy /e "%USERPROFILE%\.aws" .aws\
popd

reg import open_mingw64_here.reg

endlocal
pause
