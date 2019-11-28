#!/bin/bash
source ./utils.sh

print_in_purple "\n   install-dotnet-global-tools\n\n"
dotnet_tools_list_path="$dotfilesDirectory/artifacts/dotnet-tools.list"
grep -v '^#' $dotnet_tools_list_path
seek_confirmation "Warning: Are you sure you want to install next global tools?"

if is_confirmed; then
    grep -v '^#' $dotnet_tools_list_path | while read -r item ; do
        execute "dotnet tool install -g $item"
    done
else
    e_warning "Skipped installation step."
fi

