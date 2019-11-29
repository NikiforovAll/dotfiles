#!/bin/bash
source ./utils.sh

install() {
sudo apt-get install  curl apt-transport-https ca-certificates software-properties-common

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

    sudo apt update

    sudo apt install docker-ce

    sudo usermod -aG docker $USER

    pip install docker-compose
    # TODO: FIX docker is not added to $PATH
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {
    print_in_purple "\n   install-docker\n"
    seek_confirmation "   Warning: Are you sure you want to install docker?"
    if is_confirmed; then
        echo "\n"
        execute "install" "docker"
    else
        e_warning "   Skipped [install-docker] installation step."
    fi
}

main
