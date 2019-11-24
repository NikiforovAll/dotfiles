$globalToolSourceLocation="$PSScriptRoot/../../artifacts/dotnet-tools.list" | Resolve-Path
$title    = 'Installing dotnet global tools from - ' + $globalToolSourceLocation
$question = 'Are you sure you want to proceed?'

$choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
$choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Yes'))
$choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&No'))

$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)

if ($decision -eq 0) {
    Write-Host 'confirmed'
    Get-Content -Path $globalToolSourceLocation | Where-Object {$_ -notlike "#*"} | ForEach-Object {
        dotnet tool install -g
    }
} else {
    Write-Host 'cancelled'
}

