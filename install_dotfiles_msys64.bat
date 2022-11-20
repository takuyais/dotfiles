@rem Need to run as Administrator
@setlocal

pushd "%SystemDrive%\msys64\home\%USERNAME%"
if errorlevel 1 (
  goto :exit
)

@rem Bash
mklink .bashrc_local "%USERPROFILE%\dotfiles\bashrc"
mklink .aliases_tortoisegit "%USERPROFILE%\dotfiles\aliases_tortoisegit"
mklink .gitconfig "%USERPROFILE%\dotfiles\gitconfig"
mklink .gitconfig.local "%USERPROFILE%\dotfiles\gitconfig.private-win"
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

reg import open_msys2_ucrt64_here.reg
@rem reg import open_msys2_mingw64_here.reg

:exit
popd
@endlocal
@pause

@rem TODO
@rem  * Add following codes to .bashrc.
@rem    source /usr/share/git/completion/git-prompt.sh
@rem    source /usr/share/git/completion/git-completion.bash
@rem    source "${HOME}/.bashrc_local"
@rem  * Edit .bash_profile to add "${HOME}/.local/bin" to the PATH.
@rem  * Install git-credential-manager.
@rem    https://github.com/GitCredentialManager/git-credential-manager/issues/389
