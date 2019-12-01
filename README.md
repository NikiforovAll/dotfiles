Dotfiles for Windows (Windows Terminal, WSL, ZSH)
============================================================

Facilitates developing with WSL. Installs major dependencies and handy tools for .NET developer.

Goals of this setup
-------------------

- target platform: Windows 10
- visually nice terminal: Windows Terminal
- vscode: settings sync
- app-install: install essentials - tools/utilities/programs
- main shell: zsh
- shell: powershell + oh-my-posh + custom theme
- shell: git bash

Windows (PowerShell, Git Bash) # TBD
-------------------

To install `dotfiles` run the next snippet in the terminal:

| OS | Snippet |
|:---|:---|
| `Windows` | `powershell -NoProfile -ExecutionPolicy unrestricted -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; &([scriptblock]::Create((Invoke-WebRequest -UseBasicParsing 'https://raw.github.com/nikiforovall/dotfiles/master/src/windows/app_install.ps1')))` |

WSL
-------------------

To install the `dotfiles` run the next snippet in the terminal:

| OS | Snippet |
|:---|:---|
| `Ubuntu` | `bash -c "$(wget -qO - https://raw.github.com/nikiforovall/dotfiles/master/src/wsl/os/install.sh)"` |

Resources
-------------------

Demo: For more details please see related blog post: <https://nikiforovall.github.io/productivity/2019/11/30/nikiforovall-setup.html>

Credits:
-------------------

Checkout out this awesome dotfile repository: <https://github.com/alrra/dotfiles>
