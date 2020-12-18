winget install Microsoft.WindowsTerminal --silent

Write-Host "Installing common..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
$apps = @(
    "Google.Chrome",
    "Telegram.TelegramDesktop",
    "Foxit.FoxitReader")
foreach ($app in $apps) {
    winget install $app --silent
}

Write-Host "Installing dev essentials..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
$dev_apps = @(
    "Docker.DockerDesktopEdge",
    "Microsoft.WindowsTerminal",
    "Microsoft.VisualStudioCode",
    "Microsoft.VisualStudioCodeInsiders")
foreach ($app in $dev_apps) {
    winget install $app --silent
}
Write-Host "Installing dev essentials..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
$runtimes = @(
    "Microsoft.dotnet",
    "Microsoft.dotNetFramework",
    "Microsoft.dotnetRuntime",
    "OpenJS.NodeJS",
    "Python.Python")
foreach ($app in $runtimes) {
    winget install $app --silent
}
