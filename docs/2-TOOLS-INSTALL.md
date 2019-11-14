# 3-TOOLS-INSTALL

## Goal
To install dev essentials:

* Windows Terminal
* PowerShell Setup
* Chrome
* VSCODE
* FiraCode, CascadiaCode
* dotnet (windows, wsl)
* dotnet global tools (windows, wsl)
* docker (wsl - ? TODO:)

## Prerequisites

* Powershell, INITIAL-SETUP.md

> Run `.\windows\app_install.ps1`.

## Install windows terminal

* [microsoft-windows-terminal](https://github.com/Microsoft/Terminal), installed in app_install.ps1
* [cascadia-code](https://github.com/microsoft/cascadia-code), installed in app_install.ps1
* Set profile: `wt_profiles.json` (manually, copy to settings folder)

## Set up PowerShell Profile and Theme

* Install posh-git
  * [oh-my-posh](https://github.com/JanDeDobbeleer/oh-my-posh), installed in app_install.ps1
* Set PowerShell Profile & Theme
  * Run `if (!(Test-Path -Path $PROFILE )) { New-Item -Type File -Path $PROFILE -Force } notepad $PROFILE`
  * Set `ps_profile.ps1` (manually, copy to settings folder)
    * [Theme: SpencerTechy.ps1](https://github.com/spencerwooo/dotfiles#windows)
    * Move this theme to $ThemeSettings.MyThemeLocation

## GIT

* Install *Git Bash* [git](https://chocolatey.org/packages/git), installed in app_install.ps1

In each environement set up:

```bash
git config --global user.email "${email}"
git config --global user.name "${username}"
```

* git auto-completion for zsh - ? TODO:
* git config - ? TODO:
  * .gitconfig (general and zsh specifi)
* git aliases (general and zsh specifi) TODO:

## VSCODE

* [vscode](https://github.com/Microsoft/vscode), installed in app_install.ps1
* configs - ?
  * extension - SYNC vs dotfiles

### dotnet-sdk

### dotnet-global-tools
