#!/bin/bash
source ./utils.sh

seek_confirmation "Warning: Are you sure you want to install?"
if is_confirmed; then
    dotnet_tools_list_path='../../../artifacts/dotnet-tools.list'
    grep -v '^#' $dotnet_tools_list_path
    grep -v '^#' $dotnet_tools_list_path | while read -r item ; do
        dotnet tool install -g $item
    done
else
    e_warning "Skipped installation step."
fi

