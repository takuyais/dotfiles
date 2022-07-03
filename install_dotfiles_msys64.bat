@rem Need to run as Administrator
@setlocal

pushd "%SystemDrive%\msys64\home\%USERNAME%"

@rem Bash
mklink .bashrc_local "%USERPROFILE%\dotfiles\bashrc"
mklink .aliases_tortoisegit "%USERPROFILE%\dotfiles\aliases_tortoisegit"
mklink .gitconfig "%USERPROFILE%\dotfiles\gitconfig"
mklink .gitconfig.local "%USERPROFILE%\dotfiles\gitconfig.local"
mklink .gitignore_global "%USERPROFILE%\.gitignore_global"

@rem Vim
mklink .vimrc "%USERPROFILE%\dotfiles\vimrc"
mklink .gvimrc "%USERPROFILE%\dotfiles\gvimrc"
@rem mklink /d vimfiles "%USERPROFILE%\vimfiles"
robocopy "%USERPROFILE%\vimfiles" vimfiles\ /e /xd swap
mkdir vimfiles\swap

@rem XDG Base Directory
mkdir .local\bin
mkdir .local\share

@rem Etc.
mklink .npmrc "%USERPROFILE%\.npmrc"
robocopy "%USERPROFILE%\.aws" .aws\ /e

popd

reg import open_mingw64_here.reg

@endlocal
@pause
