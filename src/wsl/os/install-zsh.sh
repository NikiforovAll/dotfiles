#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install() {
    # ZSH
    print_in_purple "\n   zsh\n\n"
    install_package "zsh" "zsh"
    print_in_purple "\n   oh-my-zsh\n\n"
    ZSH="$HOME/.oh-my-zsh"
    if [[ ! -d $ZSH ]]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    else
        print_in_yellow "\n   using local version of oh-my-zsh\n"
    fi
    print_in_green "\n   Password to change default shell to zsh:\n"
    chsh -s $(which zsh)
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
    execute "zsh-autosuggestions-install" "zsh-autosuggestions"

    print_in_purple "\n   plugin.zsh-git-open\n\n"
    execute "zsh-git-open-install" "zsh.git-open"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

zsh-autosuggestions-install(){
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
}

zsh-git-open-install() {
    git clone https://github.com/paulirish/git-open ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/git-open
}

main() {
    print_in_purple "\n install-zsh\n"

    if [ ! -f $HOME/bin/zsh ]; then
        execute "" "zsh (already installed), $ZSH_VERSION"
        return
    fi

    # if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
    # # assume Zsh
    # else [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
    # # assume Bash
    # fi

    seek_confirmation "   Warning: Are you sure you want to zsh?"

    if is_confirmed; then
        install
    else
        e_warning "   Skipped [install-zsh] installation step."
    fi
}

main
