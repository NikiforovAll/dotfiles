function Install-NeededFor {
param(
   [string] $packageName = ''
  ,[bool] $defaultAnswer = $true
)
  if ($packageName -eq '') {return $false}

  $yes = '6'
  $no = '7'
  $msgBoxTimeout='-1'
  $defaultAnswerDisplay = 'Yes'
  $buttonType = 0x4;
  if (!$defaultAnswer) { $defaultAnswerDisplay = 'No'; $buttonType= 0x104;}

  $answer = $msgBoxTimeout
  try {
    $timeout = 10
    $question = "Do you need to install $($packageName)? Defaults to `'$defaultAnswerDisplay`' after $timeout seconds"
    $msgBox = New-Object -ComObject WScript.Shell
    $answer = $msgBox.Popup($question, $timeout, "Install $packageName", $buttonType)
  }
  catch {
  }

  if ($answer -eq $yes -or ($answer -eq $msgBoxTimeout -and $defaultAnswer -eq $true)) {
    write-host "Installing $packageName"
    return $true
  }

  write-host "Not installing $packageName"
  return $false
}

# Install Chocolatey
if (Install-NeededFor 'chocolatey') {
    Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# VSCODE
choco install visualstudiocode
#code --intall-extension Shan.code-settings-sync

# ConEmu
choco install conemu
# GIT 
choco install git
git config --global user.name "NikiforovAll"
git config --global user.email "nikiforovalekcey@gmail.com"
git config --global alias.hist "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short"
git config --global alias.st status
git config --global alias.ll "log --pretty=format:'%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]' --decorate --numstat"
git config --global alias.ls "log --pretty=format:'%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]' --decorate"
# Nodejs and NPM
choco install nodejs
# Dotnet core SDK
choco install dotnetcore-sdk --pre
# Docker
if (Install-NeededFor 'docker') {
    choco install docker
}
# Java
if (Install-NeededFor 'java runtime') {
    choco install jre8
}

