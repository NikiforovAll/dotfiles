#!/bin/bash
#
declare -r GITHUB_REPOSITORY="nikiforovall/dotfiles"
declare -r DOTFILES_ORIGIN="git@github.com:$GITHUB_REPOSITORY.git"
declare -r DOTFILES_TARBALL_URL="https://github.com/$GITHUB_REPOSITORY/tarball/master"
declare -r DOTFILES_UTILS_URL="https://raw.githubusercontent.com/$GITHUB_REPOSITORY/master/src/wsl/os/utils.sh"
declare dotfilesDirectory="$HOME/dotfiles"
# declare DOTFILES_DIRECTORY="$HOME/projects/dotfiles"
declare skipQuestions=true
# ----------------------------------------------------------------------
# | Helper Functions (you might want to go right to *main* part)       |
# ----------------------------------------------------------------------

download() {

    local url="$1"
    local output="$2"

    if command -v "curl" &> /dev/null; then

        curl -LsSo "$output" "$url" &> /dev/null
        #     │││└─ write output to file
        #     ││└─ show error messages
        #     │└─ don't show the progress meter
        #     └─ follow redirects

        return $?

    elif command -v "wget" &> /dev/null; then

        wget -qO "$output" "$url" &> /dev/null
        #     │└─ write output to file
        #     └─ don't show output

        return $?
    fi

    return 1

}

download_utils() {

    local tmpFile=""

    tmpFile="$(mktemp /tmp/XXXXX)"

    download "$DOTFILES_UTILS_URL" "$tmpFile" \
        && source "$tmpFile" \
        && rm -rf "$tmpFile" \
        && return 0

   return 1

}

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
    if [ -x "utils.sh" ]; then
        . "utils.sh" || exit 1
      # printf "Using cached utils"
    else
      printf "Trying to download utils..."
      download_utils || exit 1
    fi
    # # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # source ./utils.sh
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

    ./create_local_config_files.sh "$@"

    # # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    if cmd_exists "git"; then

        if [ "$(git config --get remote.origin.url)" != "$DOTFILES_ORIGIN" ]; then
            ./initialize_git_repository.sh "$DOTFILES_ORIGIN"
        fi
        # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    fi
    # if ! $skipQuestions; then
    #     ./restart.sh
    # fi

}

main "$@"
