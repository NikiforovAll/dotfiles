#!/bin/bash


source ./utils.sh

export DEBIAN_FRONTEND=noninteractive

# apt update
# apt upgrade -y

# Essential package
# apt -y install build-essential # This one is so big
#  Git
print_in_purple "\n   Git\n\n"
install_package "Git" "git"
# nodejs
#------------------------------------------------
print_in_purple "\n   Node\n\n"
execute "curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash - &>/dev/null" "updating node based on https://deb.nodesource.com/setup_13.x"
install_package "nodejs" "nodejs"
print_in_purple "\n   NPM\n\n"
install_npm_package "npm"

print_in_purple "\n   unzip\n\n"
install_package "zip" "unzip"
install_package "zip" "zip"

print_in_purple "\n   ShellCheck\n\n"
install_package "ShellCheck" "shellcheck"

print_in_purple "\n   xclip\n\n"
install_package "xclip" "xclip"

print_in_purple "\n   curl\n\n"
install_package "curl" "curl"

print_in_purple "\n   tree\n\n"
install_package "tree" "tree"

print_in_purple "\n   jq\n\n"
install_package "jq" "jq"

print_in_purple "\n   GNOME Vim\n\n"
install_package "GNOME Vim" "vim-gnome"
# ------------------------------------------------
print_in_purple "\n   jira-cmd\n\n"

install_npm_package "jira-cmd"

print_in_purple "\n   $EXA_BUILD\n\n"
EXA_BUILD="exa-linux-x86_64"
EXA_FILENAME="exa-linux-x86_64-0.9.0.zip"
EXA_URL="https://github.com/ogham/exa/releases/download/v0.9.0/$EXA_FILENAME"
curl -sL $EXA_URL -o "/tmp/$EXA_FILENAME"
unzip "/tmp/$EXA_FILENAME" -d /tmp &>/dev/null
sudo mv "/tmp/$EXA_BUILD" /usr/local/bin/exa

print_in_purple "\n   dotnet-sdk\n\n"
curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --channel LTS
# TODO: install dotnet sdk tools in wsl
# TODO: check - https://github.com/dotnet/cli/blob/master/scripts/register-completions.zsh

# docker
# TODO:

