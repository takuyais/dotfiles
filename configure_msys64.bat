@echo off
rem Need to run as Administrator
setlocal

pushd "%SystemDrive%\msys64\home\%USERNAME%"
mklink .gitconfig "%USERPROFILE%\dotfiles\gitconfig"
mklink .gitconfig.local "%USERPROFILE%\dotfiles\gitconfig.local"
mklink .gitignore_global "%USERPROFILE%\.gitignore_global"
popd

reg import open_mingw64_here.reg

endlocal
pause
