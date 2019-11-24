Dotfiles for Windows (PowerShell, WSL, Git Bash)
============================================================

Goals of this setup
-------------------

- 💻target platform: Windows 10
- ⌨visually nice terminal: Windows Terminal
- vscode: settings sync
- 🐚 main shell: zsh
- shell: powershell + oh-my-posh + custom theme
- shell: git bash

Install
--------

### Windows

To set up the `dotfiles` run the appropriate snippet in the terminal:

| OS | Snippet |
|:---|:---|
| `Windows` | `powershell -NoProfile -ExecutionPolicy unrestricted -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; &([scriptblock]::Create((Invoke-WebRequest -UseBasicParsing 'https://raw.github.com/nikiforovall/dotfiles/master/src/windows/app_install.ps1')))` |

### WSL
Setup
-----

| OS | Snippet |
|:---|:---|
| `Ubuntu` | `bash -c "$(wget -qO - https://raw.github.com/nikiforovall/dotfiles/master/src/wsl/os/install.sh)"` |

(⚠️  **DO NOT** run the `setup` snippet if you do not fully understand
[what it does][setup]. Seriously, **DON'T**!)

## Resources

TODO:
For more details please see related blog post:


# UPDATE
TODO:
