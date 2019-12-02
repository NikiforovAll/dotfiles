# Ensure that Get-ChildItemColor is loaded
Import-Module Get-ChildItemColor

# Set l and ls alias to use the new Get-ChildItemColor cmdlets
Set-Alias l Get-ChildItemColor -Option AllScope
Set-Alias ls Get-ChildItemColorFormatWide -Option AllScope

function Enter-AdminPSSession {
    Start-Process -Verb RunAs (Get-Process -Id $PID).Path
}
# Optionally also define a short alias name:
# Note: 'psadmin' is a nonstandard alias name; a more conformant name would be
#       the somewhat clunky 'etasn'
#       ('et' for 'Enter', 'a' for admin, and 'sn'` for session)
Set-Alias psadmin Enter-AdminPSSession

Import-Module posh-git
Import-Module oh-my-posh

# Set theme
Set-Theme SpencerTechy


Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
