#!/bin/bash
#
declare -r GITHUB_REPOSITORY="nikiforovall/dotfiles"
declare -r DOTFILES_ORIGIN="git@github.com:$GITHUB_REPOSITORY.git"
declare -r DOTFILES_TARBALL_URL="https://github.com/$GITHUB_REPOSITORY/tarball/master"
declare -r DOTFILES_UTILS_URL="https://raw.githubusercontent.com/$GITHUB_REPOSITORY/master/src/wsl/os/utils.sh"
declare dotfilesDirectory="$HOME/dotfiles"
declare DOTFILES_DIRECTORY="$HOME/dotfiles"
declare skipQuestions=false
# ----------------------------------------------------------------------
# | Main                                                               |
# ----------------------------------------------------------------------

main() {

    # Ensure that the following actions
    # are made relative to this file's path.

    cd "$(dirname "${BASH_SOURCE[0]}")" \
        || exit 1
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    # Load utils
    source ./utils.sh
    
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    # Ensure the OS is supported and
    # it's above the required version.

    verify_os \
        || exit 1
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    # ask_for_sudo
    # Check if this script was run directly (./<path>/setup.sh),
    # and if not, it most likely means that the dotfiles were not
    # yet set up, and they will need to be downloaded.
    # # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    printf "%s" "${BASH_SOURCE[0]}" | grep "install.sh" &> /dev/null \
      || download_dotfiles
    # NOTE: this one changes working directory to install repo
    # # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    # TODO: change this, this mofo is dangerous
    find . -name "*.sh" -exec chmod +x {} +
    ./create_directories.sh
    # # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    ./create_symbolic_links.sh "$@"

    # # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    ./create_local_config_files.sh

    # # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    if cmd_exists "git"; then

        if [ "$(git config --get remote.origin.url)" != "$DOTFILES_ORIGIN" ]; then
            ./initialize_git_repository.sh "$DOTFILES_ORIGIN"
        fi
        # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    fi
}

main "$@"
