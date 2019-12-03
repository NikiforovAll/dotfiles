#!/bin/bash
source ./utils.sh

install() {
    # INFO: https://gorails.com/setup/ubuntu/18.04

    # curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
    # curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    # echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    # # Ruby needs yarn and nodejs apparantly, cool 😔
    # sudo apt-get update
    # sudo apt-get install -yq git-core zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev nodejs yarn
    # sudo apt-get install -yq libgdbm-dev libncurses5-dev automake libtool bison libffi-dev
    # gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
    # curl -sSL https://get.rvm.io | bash -s stable
    # source ~/.rvm/scripts/rvm
    # rvm install 2.6.5
    # rvm use 2.6.5 --default
    # ruby -v
    # gem install bundler

    # INFO: https://linuxize.com/post/how-to-install-ruby-on-ubuntu-18-04/#installing-ruby-using-rbenv
    sudo apt update
    sudo apt install git curl libssl-dev libreadline-dev zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev

    curl -sL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash -
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
    rbenv install 2.5.1
    rbenv global 2.5.1
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {
    print_in_purple "\n   install-ruby\n"
    seek_confirmation "   Warning: Are you sure you want to install ruby?"
    if is_confirmed; then
        # execute "install" "ruby; ruby.bundler"
        install
        # https://github.com/bundler/bundler/issues/5211
        execute "gem install bundler" "gem.bundler"
        execute "gem install jekyll" "gem.jekyll"
        # install
    else
        e_warning "   Skipped [install-ruby] installation step."
    fi

}

main
