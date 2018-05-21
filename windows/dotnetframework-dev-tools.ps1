$scriptDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

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
  iex ((new-object net.webclient).DownloadString("http://chocolatey.org/install.ps1")) 
}

if (Install-NeededFor 'autosave') {
  cinstm nodejs.install
  $nodePath = Join-Path $env:programfiles 'nodejs'
   $is64bit = (Get-WmiObject Win32_Processor).AddressWidth -eq 64
  if ($is64bit) {$nodePath = Join-Path ${env:ProgramFiles(x86)} 'nodejs'}
  $env:Path = "$($env:Path);$nodePath"
  npm install -g autosave

  Write-Host 'You still need to enable experimental packages in Chrome and install the Chrome Extension'
  Write-Host 'Details at https://github.com/NV/chrome-devtools-autosave#readme'
}

Write-Host "Grabbing required frameworks"
cinst netframework2 -source webpi
cinst NETFramework35 -source webpi
cinst NETFramework4 -source webpi
cinst NETFramework4Update402 -source webpi
cinst NETFramework4Update402_KB2544514_Only -source webpi
cinst WindowsInstaller31 -source webpi
cinst WindowsInstaller45 -source webpi

cinst roundhouse -pre

Write-Host "Checking for/installing SQLServer Express and Management Studio..."
cinst SQLManagementStudio -source webpi
cinst SQLExpressTools -source webpi
Write-Warning "You will need to supply a password on the screen that is minimized"
cinst SQLExpress -source webpi
Write-Host "Finished checking for/install SQLServer Express and Management Studio"

Write-Host "Checking for/installing Visual Studio Items..."
if (Install-NeededFor 'VS2010 Express & SP1' $false) {
 cinst VWD_RTW -source webpi
 cinst VWD2010SP1AzurePack -source webpi
}

if (Install-NeededFor 'VS2010 Full Edition SP1') {
 cinst VS2010SP1Pack -source webpi
}

cinst MVC3 -source webpi
cinst MVC3Loc -source webpi
Write-Host "Finished checking for/installing Visual Studio Items."

if (Install-NeededFor 'database' $false) {
  & .\build.bat
  $sqlFiles = Join-Path $scriptDir 'code_drop\ProjectName.Database\ProjectName'
  $dbServer = Read-Host "Please tell me the server\instance location of the database (i.e. '(local)'). Press enter to use .\SQLEXPRESS"
  if ($dbServer -eq '') {$dbServer = '.\SQLEXPRESS'}
  & rh /d ProjectName /s $dbServer /f $sqlFiles /silent
}

if (Install-NeededFor 'IIS' $false) {
  cinst ASPNET -source webpi
  cinst ASPNET_REGIIS -source webpi
  cinst DefaultDocument -source webpi
  cinst DynamicContentCompression -source webpi
  cinst HTTPRedirection -source webpi
  cinst IIS7_ExtensionLessURLs -source webpi
  cinst IISExpress -source webpi
  cinst IISExpress_7_5 -source webpi
  cinst IISManagementConsole -source webpi
  cinst ISAPIExtensions -source webpi
  cinst ISAPIFilters -source webpi
  cinst NETExtensibility -source webpi
  cinst RequestFiltering -source webpi
  cinst StaticContent -source webpi
  cinst StaticContentCompression -source webpi
  cinst UrlRewrite2 -source webpi
  cinst WindowsAuthentication -source webpi
}

$projectName = 'ProjectName'
$srcDir = Join-Path $scriptDir "src\$($projectName).Web"
if (Install-NeededFor 'website' $false) {
  $networkSvc = 'NT AUTHORITY\NETWORK SERVICE'
  Write-Host "Setting folder permissions on `'$srcDir`' to 'Read' for user $networkSvc"
  $acl = Get-Acl $srcDir
  $acl.SetAccessRuleProtection($True, $True)
  $rule = New-Object System.Security.AccessControl.FileSystemAccessRule("$networkSvc","Read", "ContainerInherit, ObjectInherit", "None", "Allow");
  $acl.AddAccessRule($rule);
  Set-Acl $srcDir $acl

  Import-Module WebAdministration
  $appPoolPath = "IIS:\AppPools\$projectName"
  #$pool = new-object
  Write-Warning "You can safely ignore the next error if it occurs related to getting an app pool that doesn't exist"
  $pool = Get-Item $appPoolPath
  if ($pool -eq $null) {
    Write-Host "Creating the app pool `'$appPoolPath`'"
    $pool = New-Item $appPoolPath
  }

  $pool.processModel.identityType = "NetworkService"
  $pool | Set-Item
  Set-itemproperty $appPoolPath -Name "managedRuntimeVersion" -Value "v4.0"
  #Set-itemproperty $appPoolPath -Name "managedPipelineMode" -Value "Integrated"
  Start-WebAppPool "$projectName"
  Write-Host "Creating the site `'$projectName`' with appPool `'$projectName`'"
  New-WebApplication "$projectName" -Site "Default Web Site" -PhysicalPath $srcDir -ApplicationPool "$projectName" -Force

  Write-Host 'You still need to open Visual Studio and build the application one time prior to going to the site in a browser.'
}

Write-Host "If you have made it here without errors, you should be setup and ready to hack on the apps."
Write-Warning "If you see any failures happen, you may want to reboot and continue to let installers catch up. This script is idempotent and will only apply changes that have not yet been applied."