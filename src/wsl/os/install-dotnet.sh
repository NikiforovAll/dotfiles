#!/bin/bash
source ./utils.sh

install_dotnet_sdk() {
    curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --channel LTS
    # TODO: FIX dotnet is not added to path
    export PATH="$PATH:$HOME/.dotnet"
}

install_dotnet_global_tools() {
    print_in_purple "\n   dotnet-global-tools\n\n"
    dotnet_tools_list_path="$dotfilesDirectory/artifacts/dotnet-tools.list"
    grep -v '^#' $dotnet_tools_list_path | sed -e 's/^/\t/'
    seek_confirmation "   Warning: Are you sure you want to install next global tools?"
    if is_confirmed; then
        grep -v '^#' $dotnet_tools_list_path | while read -r item ; do
            execute "dotnet tool install -g $item"
        done
    else
        e_warning "   Skipped [install-dotnet-global-tools] installation step."
    fi

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {
    print_in_purple "\n   dotnet-sdk\n\n"
    execute "install_dotnet_sdk" "dotnet-sdk"
    install_dotnet_global_tools
}

main
