#!/bin/bash
#

source ./utils.sh

declare -r GITHUB_REPOSITORY="nikiforovall/dotfiles"

declare -r DOTFILES_ORIGIN="git@github.com:$GITHUB_REPOSITORY.git"
declare -r DOTFILES_TARBALL_URL="https://github.com/$GITHUB_REPOSITORY/tarball/master"
declare dotfilesDirectory="$HOME/projects/dotfiles"
declare skipQuestions=false

seek_confirmation "Warning: This step install applications."
if is_confirmed; then
  e_header "Please, configure you applications before installation:"
  nano ${DOTFILES_DIRECTORY}/app_install.sh
  bash $DOTFILES_DIRECTORY/app_install.sh
else
  e_warning "Skipped applications install."
fi


# ----------------------------------------------------------------------
# | Main                                                               |
# ----------------------------------------------------------------------

main() {

    # Ensure that the following actions
    # are made relative to this file's path.

    cd "$(dirname "${BASH_SOURCE[0]}")" \
        || exit 1

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Ensure the OS is supported and
    # it's above the required version.

    verify_os \
        || exit 1

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    skip_questions "$@" \
        && skipQuestions=true

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    ask_for_sudo

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Check if this script was run directly (./<path>/setup.sh),
    # and if not, it most likely means that the dotfiles were not
    # yet set up, and they will need to be downloaded.

    printf "%s" "${BASH_SOURCE[0]}" | grep "setup.sh" &> /dev/null \
      || download_dotfiles
    # # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    ./create_directories.sh

    # # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # ./create_symbolic_links.sh "$@"

    # # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # ./create_local_config_files.sh

    # # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # ./install/main.sh

    # # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # ./preferences/main.sh

    # # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # if cmd_exists "git"; then

    #     if [ "$(git config --get remote.origin.url)" != "$DOTFILES_ORIGIN" ]; then
    #         ./initialize_git_repository.sh "$DOTFILES_ORIGIN"
    #     fi

    #     # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    #     if ! $skipQuestions; then
    #         ./update_content.sh
    #     fi

    # fi

    # # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # if ! $skipQuestions; then
    #     ./restart.sh
    # fi

}

main "$@"
