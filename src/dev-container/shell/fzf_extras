#!/usr/bin/env zsh
# -----------------------------------------------------------------------------
# directory
# -----------------------------------------------------------------------------

# fzf --preview command for file and directory
if type bat >/dev/null 2>&1; then
    FZF_PREVIEW_CMD='bat --color=always --plain --line-range :$FZF_PREVIEW_LINES {}'
elif type pygmentize >/dev/null 2>&1; then
    FZF_PREVIEW_CMD='head -n $FZF_PREVIEW_LINES {} | pygmentize -g'
else
    FZF_PREVIEW_CMD='head -n $FZF_PREVIEW_LINES {}'
fi

# zdd - cd to selected directory
zdd() {
  local dir
  dir="$(
    find "${1:-.}" -path '*/\.*' -prune -o -type d -print 2> /dev/null \
      | fzf +m \
          --preview='tree -C {} | head -n $FZF_PREVIEW_LINES' \
          --preview-window='right:hidden:wrap' \
          --bind=ctrl-p:toggle-preview \
          --bind=ctrl-x:toggle-sort \
          --header='(view:ctrl-p) (sort:ctrl-x)' \
  )" || return
  cd "$dir" || return
}

# zda - including hidden directories
zda() {
  local dir
  dir="$(
    find "${1:-.}" -type d 2> /dev/null \
      | fzf +m \
          --preview='tree -C {} | head -n $FZF_PREVIEW_LINES' \
          --preview-window='right:hidden:wrap' \
          --bind=ctrl-p:toggle-preview \
          --bind=ctrl-x:toggle-sort \
          --header='(view:ctrl-p) (sort:ctrl-x)' \
  )" || return
  cd "$dir" || return
}

# zdr - cd to selected parent directory
zdr() {
  local dirs=()
  local parent_dir

  get_parent_dirs() {
    if [[ -d "$1" ]]; then dirs+=("$1"); else return; fi
    if [[ "$1" == '/' ]]; then
      for _dir in "${dirs[@]}"; do echo "$_dir"; done
    else
      get_parent_dirs "$(dirname "$1")"
    fi
  }

  parent_dir="$(
    get_parent_dirs "$(realpath "${1:-$PWD}")" \
      | fzf +m \
          --preview 'tree -C {} | head -n $FZF_PREVIEW_LINES' \
          --preview-window='right:hidden:wrap' \
          --bind=ctrl-p:toggle-preview \
          --bind=ctrl-x:toggle-sort \
          --header='(view:ctrl-p) (sort:ctrl-x)' \
  )" || return

  cd "$parent_dir" || return
}

# zst - cd into the directory from stack
zst() {
  local dir
  dir="$(
    dirs \
      | sed 's#\s#\n#g' \
      | uniq \
      | sed "s#^~#$HOME#" \
      | fzf +s +m -1 -q "$*" \
            --preview='tree -C {} | head -n $FZF_PREVIEW_LINES' \
            --preview-window='right:hidden:wrap' \
            --bind=ctrl-p:toggle-preview \
            --bind=ctrl-x:toggle-sort \
            --header='(view:ctrl-p) (sort:ctrl-x)' \
  )"
  # check $dir exists for Ctrl-C interrupt
  # or change directory to $HOME (= no value cd)
  if [[ -d "$dir" ]]; then
    cd "$dir" || return
  fi
}

# zdf - cd into the directory of the selected file
zdf() {
  local file
  file="$(fzf +m -q "$*" \
           --preview="${FZF_PREVIEW_CMD}" \
           --preview-window='right:hidden:wrap' \
           --bind=ctrl-p:toggle-preview \
           --bind=ctrl-x:toggle-sort \
           --header='(view:ctrl-p) (sort:ctrl-x)' \
       )"
  cd "$(dirname "$file")" || return
}

# zz - selectable cd to frecency directory
unalias zz 2>/dev/null
zz() {
  local dir

  dir="$(
    fasd -dl \
      | fzf \
          --tac \
          --reverse \
          --select-1 \
          --no-sort \
          --no-multi \
          --tiebreak=index \
          --bind=ctrl-x:toggle-sort \
          --query "$*" \
          --preview='tree -C {} | head -n $FZF_PREVIEW_LINES' \
          --preview-window='right:hidden:wrap' \
          --bind=ctrl-p:toggle-preview \
          --bind=ctrl-x:toggle-sort \
          --header='(view:ctrl-p) (sort:ctrl-x)' \
  )" || return

  cd "$dir" || return
}

# zd - cd into selected directory with options
# The super function of zdd, zda, zdr, zst, zdf, zz
zd() {
  read -r -d '' helptext <<EOF
usage: zd [OPTIONS]
  zd: cd to selected options below
OPTIONS:
  -d [path]: Directory (default)
  -a [path]: Directory included hidden
  -r [path]: Parent directory
  -s [query]: Directory from stack
  -f [query]: Directory of the selected file
  -z [query]: Frecency directory
  -h: Print this usage
EOF

  usage() {
    echo "$helptext"
  }

  if [[ -z "$1" ]]; then
    # no arg
    zdd
  elif [[ "$1" == '..' ]]; then
    # arg is '..'
    shift
    zdr "$1"
  elif [[ "$1" == '-' ]]; then
    # arg is '-'
    shift
    zst "$*"
  elif [[ "${1:0:1}" != '-' ]]; then
    # first string is not -
    zdd "$(realpath "$1")"
  else
    # args is start from '-'
    while getopts darfszh OPT; do
      case "$OPT" in
        d) shift; zdd  "$1";;
        a) shift; zda "$1";;
        r) shift; zdr "$1";;
        s) shift; zst "$*";;
        f) shift; zdf "$*";;
        z) shift; zz  "$*";;
        h) usage; return 0;;
        *) usage; return 1;;
      esac
    done
  fi
}


# -----------------------------------------------------------------------------
# file
# -----------------------------------------------------------------------------

# e - open 'frecency' files in $VISUAL editor
e() {
  local IFS=$'\n'
  local files=()

  files=(
  "$(
    fasd -fl \
      | fzf \
          --tac \
          --reverse -1 \
          --no-sort \
          --multi \
          --tiebreak=index \
          --bind=ctrl-x:toggle-sort \
          --query "$*" \
          --preview="${FZF_PREVIEW_CMD}" \
          --preview-window='right:hidden:wrap' \
          --bind=ctrl-p:toggle-preview \
          --bind=ctrl-x:toggle-sort \
          --header='(view:ctrl-p) (sort:ctrl-x)' \
      )"
  ) || return

  "${EDITOR:-vim}" "${files[@]}"
}

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  local IFS=$'\n'
  local files=()
  files=(
    "$(fzf-tmux \
          --query="$1" \
          --multi \
          --select-1 \
          --exit-0 \
          --preview="${FZF_PREVIEW_CMD}" \
          --preview-window='right:hidden:wrap' \
          --bind=ctrl-p:toggle-preview \
          --bind=ctrl-x:toggle-sort \
          --header='(view:ctrl-p) (sort:ctrl-x)'
    )"
  ) || return
  "${EDITOR:-vim}" "${files[@]}"
}

# fo - Modified version of fe() where you can press
#   - CTRL-O to open with $OPENER,
#   - CTRL-E or Enter key to open with $EDITOR
fo() {
  local IFS=$'\n'
  local out=()
  local key
  local file

  out=(
    "$(
        fzf-tmux \
          --query="$1" \
          --exit-0 \
          --expect=ctrl-o,ctrl-e
    )"
  )
  key="$(head -1 <<< "${out[@]}")"
  file="$(head -2 <<< "${out[@]}" | tail -1)" || return

  if [[ "$key" == ctrl-o ]]; then
    "${OPENER:-xdg-open}" "$file"
  else
    "${EDITOR:-vim}" "$file"
  fi
}


# -----------------------------------------------------------------------------
# git
# -----------------------------------------------------------------------------
# fco - checkout git branch/tag
fco() {
  local tags
  local branches
  local target

  tags="$(
    git tag \
      | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}'
  )" || return

  branches="$(
    git branch --all \
      | grep -v HEAD \
      | sed 's/.* //' \
      | sed 's#remotes/[^/]*/##' \
      | sort -u \
      | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}'
  )" || return

  target="$(
    printf '%s\n%s' "$tags" "$branches" \
      | fzf-tmux \
          -l40 \
          -- \
          --no-hscroll \
          --ansi \
          +m \
          -d '\t' \
          -n 2 \
          -1 \
          -q "$*"
  )" || return

  git checkout "$(echo "$target" | awk '{print $2}')"
}

# fcoc - checkout git commit
fcoc() {
  local commits
  local commit

  commits="$(
    git log --pretty=oneline --abbrev-commit --reverse
  )" || return

  commit="$(
    echo "$commits" \
      | fzf --tac +s +m -e
  )" || return

  git checkout "$(echo "$commit" | sed "s/ .*//")"
}

# fcs - get git commit sha
# example usage: git rebase -i "$(fcs)"
fcs() {
  local commits
  local commit

  commits="$(
    git log \
      --color=always \
      --pretty=oneline \
      --abbrev-commit \
      --reverse
  )" || return

  commit="$(
    echo "$commits" \
      | fzf \
          --tac \
          +s \
          +m \
          -e \
          --ansi \
          --reverse
  )" || return

  echo -n "$(echo "$commit" | sed "s/ .*//")"
}

# fshow - git commit browser
fshow() {
  local execute

  execute="grep -o \"[a-f0-9]\{7\}\" \
    | head -1 \
    | xargs -I % sh -c 'git show --color=always %'"

  git log \
    --graph \
    --color=always \
    --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" \
    | fzf \
        --ansi \
        --no-sort \
        --reverse \
        --tiebreak=index \
        --bind=ctrl-s:toggle-sort \
        --bind "ctrl-m:execute: ($execute) <<'FZF-EOF'
  {}
FZF-EOF"
}

# fstash - easier way to deal with stashes
# type fstash to get a list of your stashes
# enter shows you the contents of the stash
# ctrl-d shows a diff of the stash against your current HEAD
# ctrl-b checks the stash out as a branch, for easier merging
fstash() {
  local out
  local q
  local k
  local sha

  while out="$(
    # git stash list --pretty='%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs' \
    git stash list \
      | fzf \
          --ansi \
          --no-sort \
          --query="$q" \
          --print-query
          # --expect=ctrl-d,ctrl-b
  )"; do
    # mapfile -t out <<< "$out"
    # q="${out[0]}"
    # k="${out[1]}"
    # echo "$out"
    # sha="${out[-1]}"
    # echo "$sha"
    # sha="${sha%% *}"
    echo "$sha"
    sha=$(echo "$out" | cut -d ":" -f1 | xargs)
    # echo "$out"
    [[ -z "$sha" ]] && continue
    # if [[ "$k" == 'ctrl-d' ]]; then
    #   git diff "$sha"
    # elif [[ "$k" == 'ctrl-b' ]]; then
    #   git stash branch "stash-$sha" "$sha"
    #   break
    # else
    #   git stash show -p "$sha"
    # fi
    git stash show $sha
  done
}

# -----------------------------------------------------------------------------
# pid
# -----------------------------------------------------------------------------

# fkill - kill process
# fkill() {
#   local pid

#   pid="$(
#     ps -ef \
#       | sed 1d \
#       | fzf -m \
#       | awk '{print $2}'
#   )" || return

#   kill -"${1:-9}" "$pid"
# }
