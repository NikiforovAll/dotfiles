# Windows 10 Setup Script
# Run this script in PowerShell

# -----------------------------------------------------------------------------
# Self elevate administrative permissions in this script
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

function Check-Command($cmdname) {
  return [bool](Get-Command -Name $cmdname -ErrorAction SilentlyContinue)
}

# -----------------------------------------------------------------------------
# Set a new computer name
# $computerName = Read-Host 'Enter New Computer Name'
# Write-Host "Renaming this computer to: " $computerName  -ForegroundColor Yellow
# Rename-Computer -NewName $computerName

# -----------------------------------------------------------------------------
# Remove a few pre-installed UWP applications
# To list all appx packages:
# Get-AppxPackage | Format-Table -Property Name,Version,PackageFullName
Write-Host "Removing UWP Rubbish..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
$uwpRubbishApps = @(
  "king.com.CandyCrushFriends",
  "Microsoft.3DBuilder",
  "Microsoft.Print3D",
  "Microsoft.BingNews",
  "Microsoft.OneConnect",
  "Microsoft.Microsoft3DViewer",
  "HolographicFirstRun",
  "Microsoft.MixedReality.Portal"
  "Microsoft.MicrosoftSolitaireCollection",
  "Microsoft.Getstarted",
  "Microsoft.WindowsFeedbackHub",
  "Microsoft.XboxApp",
  "Fitbit.FitbitCoach",
  "4DF9E0F8.Netflix")

foreach ($uwp in $uwpRubbishApps) {
  Get-AppxPackage -Name $uwp | Remove-AppxPackage
}

# -----------------------------------------------------------------------------
# Install Chocolatey and some apps
if (Check-Command -cmdname 'choco') {
  Write-Host "Choco is already installed, skip installation."
}
else {
  Write-Host ""
  Write-Host "Installing Chocolatey for Windows..." -ForegroundColor Green
  Write-Host "------------------------------------" -ForegroundColor Green
  Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

Write-Host ""
Write-Host "Installing Applications..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green

if (Check-Command -cmdname 'git') {
  Write-Host "Git is already installed, checking new version..."
  choco update git -y
}
else {
  Write-Host ""
  Write-Host "Installing Git for Windows..." -ForegroundColor Green
  choco install git --params "/NoShellIntegration /NoAutoCrlf /SChannel /WindowsTerminal" -y
}

if (Check-Command -cmdname 'node') {
  Write-Host "Node.js is already installed, checking new version..."
  choco update nodejs -y
}
else {
  Write-Host ""
  Write-Host "Installing Node.js..." -ForegroundColor Green
  choco install nodejs-lts -y
}

# -----------------------------------------------------------------------------
# Install packages: choco
Write-Host "Installing Apps via chocolatey package manager..." -ForegroundColor Green

# VSCODE
choco install vscode -y
code --intall-extension Shan.code-settings-sync

choco install firacode-ttf -y
choco install cascadiacode -y
choco install googlechrome -y
choco install microsoft-windows-terminal -y

# -----------------------------------------------------------------------------
# Install modules and change Set-ExecutionPolicy to "Unrestricted"
Install-Module posh-git -Scope CurrentUser
Install-Module oh-my-posh -Scope CurrentUser
Install-Module -AllowClobber Get-ChildItemColor
Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser

# -----------------------------------------------------------------------------
# Install dotnet sdk

Write-Host "Installing dotnet SDKs for Windows..." -ForegroundColor Green
powershell -NoProfile -ExecutionPolicy unrestricted -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; &([scriptblock]::Create((Invoke-WebRequest -UseBasicParsing 'https://dot.net/v1/dotnet-install.ps1'))) -Channel LTS"


# -----------------------------------------------------------------------------
# Install WSL
Write-Host ""
Write-Host "Installing WSL..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform

# -----------------------------------------------------------------------------
# Restart Windows
Write-Host "------------------------------------" -ForegroundColor Green
Read-Host -Prompt "Setup is done, restart is needed, press [ENTER] to restart computer."
Restart-Computer
