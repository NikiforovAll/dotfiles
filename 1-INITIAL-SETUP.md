# 1-SETUP: Enable WSL

## Prerequisites

* Windows 10

## Goal

* Enable wsl
* Install linux distro

## Steps

### WSL

* Enable the Windows Subsystem for Linux Windows Feature
  * `Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux`
  * [Enable WSL (Ubuntu)](https://docs.microsoft.com/en-us/windows/wsl/install-win10)
* Updating to WSL2
  * `Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform`
* If you want to make wsl2 as default architecture: `wsl --set-default-version 2`

<!-- ### Install linux distro of your flavour

* `curl.exe -L -o ubuntu.appx https://aka.ms/wsl-ubuntu`
* Launch Ubuntu.exe from the Start Menu. You’ll be asked to enter a username and password (for sudo stuff). -->
