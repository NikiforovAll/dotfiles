#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install() {
    # ZSH
    install_package "zsh" "zsh"
    print_in_purple "\n   oh-my-zsh\n\n"
    ZSH="$HOME/.oh-my-zsh"
    if [[ ! -d $ZSH ]]; then
        execute "sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\" --unattended"
        # sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\" --unattended
        chsh -s /bin/zsh
    else
        print_in_yellow "\n   using local version of oh-my-zsh\n"
    fi
    ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
    ZSH_THEME_TO_INSTALL="$ZSH_CUSTOM/themes/spaceship-prompt"
    ZSH_THEME_TO_SYMLINK="$ZSH_CUSTOM/themes/spaceship.zsh-theme"

    print_in_purple "\n   theme.oh-my-zsh\n\n"
    # print_in_yellow "\n   installing theme $ZSH_THEME_TO_INSTALL"
    if [[ ! -d $ZSH_THEME_TO_INSTALL ]]; then
        execute "git clone https://github.com/denysdovhan/spaceship-prompt.git $ZSH_THEME_TO_INSTALL"
        ln -s "$ZSH_THEME_TO_INSTALL/spaceship.zsh-theme" "$ZSH_THEME_TO_SYMLINK"
    else
        print_in_yellow "\n   using local version of theme from $ZSH_THEME_TO_INSTALL\n\n"
    fi

    print_in_purple "\n   plugin.zsh-syntax-highlighting\n\n"
    install_package "zsh-syntax-highlighting" "zsh-syntax-highlighting"

    print_in_purple "\n   plugin.zsh-autosuggestions\n\n"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {
    print_in_purple "\n   zsh\n\n"
    install
}

main
