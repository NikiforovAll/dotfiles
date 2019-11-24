# 2-TOOLS-INSTALL

## Goal
To install dev essentials:

* Windows Terminal
* chocolatey as package manager for windows
* PowerShell
* Git
* vscode
* Fonts: FiraCode, CascadiaCode
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

## PowerShellCore (optional)

* Install PowerShellCore, [powershell-core-on-windows](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-windows)
* Run `dotnet tool install --global PowerShell`, manually
* Copy `ps_core_profile.ps1` to `$PROFILE` folder
* Copy theme to $ThemeSettings.MyThemeLocation folder
* Running options: (manually)
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
  * `Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck`
  * `Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser`

## GIT (Git Bash)

* Install *Git Bash* [git](https://chocolatey.org/packages/git), installed in app_install.ps1

In each environnement set up:

```bash
git config --global user.email "${email}"
git config --global user.name "${username}"
```
* git config - ? TODO:
  * .gitconfig
* git aliases (general and zsh specifi) TODO:

## vscode

* [vscode](https://github.com/Microsoft/vscode), installed in app_install.ps1
* I recommend to use wonderful extension called *Settings Sync*. In fact, it is already present in ./app_install.ps1.
* For more details, please see: <https://marketplace.visualstudio.com/items?itemName=Shan.code-settings-sync>

### dotnet-sdk

You could easily install dotnet sdk via install scripts: <https://dotnet.microsoft.com/download/dotnet-core/scripts>, installed in app_install.ps1
Examples: <https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-install-script#examples>

### dotnet-global-tools

### docker

Install docker for windows: <https://docs.docker.com/docker-for-windows/install/>. The suggested way of doing it is to use installer.
