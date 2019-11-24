Dotfiles for Windows (PowerShell, WSL, Git Bash)
============================================================

Goals of this setup
-------------------

- target platform: Windows 10
- visually nice terminal: Windows Terminal
- vscode: settings sync
- main shell: zsh
- shell: powershell + oh-my-posh + custom theme
- shell: git bash

Install
--------

### Windows

To set up the `dotfiles` run the appropriate snippet in the terminal:

| OS | Snippet |
|:---|:---|
| `Windows` | `powershell -NoProfile -ExecutionPolicy unrestricted -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; &([scriptblock]::Create((Invoke-WebRequest -UseBasicParsing 'https://raw.github.com/nikiforovall/dotfiles/master/src/windows/app_install.ps1')))` |

TODO: setup git config for *Powershell* and *Git Bash*
### WSL
Setup
-----

| OS | Snippet |
|:---|:---|
| `Ubuntu` | `bash -c "$(wget -qO - https://raw.github.com/nikiforovall/dotfiles/master/src/wsl/os/install.sh)"` |
#### ZSH

#### Git

* .gitconfig
* **!** Change user in git/gitconfig

#### ZSH
* .zshrc
#### Dotnet
* dotnet sdk / dotnet runtime
* dotnet global tools `see artifacts/dotnet-tools.list`
#### Docker
* docker
* docker compose
* Configuration to expose docker to windows deamon
*
TODO: https://github.com/dotnet/cli/blob/master/scripts/register-completions.zsh
TODO: completion for docker, docker-compose

## Resources

TODO:
For more details please see related blog post:


# UPDATE
TODO:
