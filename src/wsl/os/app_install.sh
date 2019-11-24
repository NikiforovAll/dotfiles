#!/bin/bash
source ./utils.sh

export DEBIAN_FRONTEND=noninteractive

# TODO: uncomment this before release version
# apt update
# apt upgrade -y

# ZSH
print_in_purple "\n   zsh\n\n"
install_package "zsh" "zsh"
chsh -s /bin/zsh

print_in_purple "\n   oh-my-zsh\n\n"

#  Git
print_in_purple "\n   git\n\n"
install_package "Git" "git"
# nodejs
#------------------------------------------------
print_in_purple "\n   node\n\n"
execute "curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash - &>/dev/null" "updating node based on https://deb.nodesource.com/setup_13.x"
install_package "nodejs" "nodejs"
# fixing nodejs for ubuntu
#
ln -s /usr/bin/nodejs /usr/bin/node
print_in_purple "\n   NPM\n\n"
install_npm_package "npm"

print_in_purple "\n   yo\n\n"
install_npm_package "yo"

print_in_purple "\n   unzip\n\n"
install_package "zip" "unzip"
install_package "zip" "zip"

print_in_purple "\n   shellCheck\n\n"
install_package "ShellCheck" "shellcheck"

print_in_purple "\n   xclip\n\n"
install_package "xclip" "xclip"

print_in_purple "\n   curl\n\n"
install_package "curl" "curl"

print_in_purple "\n   tree\n\n"
install_package "tree" "tree"

print_in_purple "\n   jq\n\n"
install_package "jq" "jq"

print_in_purple "\n   python\n\n"
install_package "python" "python"
install_package "python-pip" "python-pip"

print_in_purple "\n   Rust compiler & package manager\n\n"

execute "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash /dev/stdin -y"
source $HOME/.cargo/env

print_in_purple "\n   diffr\n\n"
# Diff tool
execute "cargo install diffr"

print_in_purple "\n   GNOME vim\n\n"
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

print_in_purple "\n   dotnet-global-tools"
./install-dotnet-global-tools.sh

print_in_purple "\n   docker\n\n"
execute \
    "./install-docker.sh"

