#! /usr/bin/bash

DOTFILES=$(pwd -P)

info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
  printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

link_file () {
    local src=$1 dst=$2

    info "Linking $src -> $dst"
    ln -sf "$src" "$dst"

    if [ $? -eq 0 ]; then
        success "Linking successful: $src -> $dst"
    else
        fail "Error occurred while linking: $src -> $dst"
    fi
}

# install_dotfiles () {
#   info 'installing dotfiles'

#   local overwrite_all=false backup_all=false skip_all=false

#   find -H "$DOTFILES" -maxdepth 2 -name 'links.prop' -not -path '*.git*' | while read linkfile
#   do
#     cat "$linkfile" | while read line
#     do
#         local src dst dir
#         src=$(eval echo "$line" | cut -d '=' -f 1)
#         dst=$(eval echo "$line" | cut -d '=' -f 2)
#         dir=$(dirname $dst)

#         mkdir -p "$dir"
#         link_file "$src" "$dst"
#     done
#   done
#}
#

read_link_file() {
    local file_path=$1
    local src dst
    
    # TODO: handle not found file err

    while IFS= read -r line || [[ -n "$line" ]]; do
        src=$(eval echo "$line" | cut -d '=' -f 1)
        dst=$(eval echo "$line" | cut -d '=' -f 2)
    done < "$file_path"

    echo "$src,$dst"
}

setup_git() {
    info "Setup git"

    values=($(read_link_file "./git/links.prop"))

    IFS=',' read -r src dst <<< "$values"

    link_file "$src" "$dst"

    success "Git setup finished"
    success "------------------\n"
}

setup_brew() {
    info "Setup homebrew"

    info "Installing homebrew"
    source ./brew/install.sh
    
    # TODO: install other software

    success "Homebrew setup finished"
    success "-----------------------\n"
}

setup_fish() {
    info "Setup fish"

    info "Installing fish using Homebrew"
    source ./fish/install.sh
   
    info "Setup config.fish"
    source ./fish/setup.sh

    values=($(read_link_file "./fish/links.prop"))

    IFS=',' read -r src dst <<< "$values"

    link_file "$src" "$dst"

    success "Fish setup finished"
    success "-------------------\n"
}

setup_starship() {
    info "Setup starship"

    info "Installing starship using Homebrew"
    source ./starship/install.sh

    values=($(read_link_file "./starship/links.prop"))

    IFS=',' read -r src dst <<< "$values"

    link_file "$src" "$dst"

    info "Loading theme in config.fish" 
    source ./starship/init.sh

    success "Starship setup finished"
    success "-----------------------\n"
}

setup_git
setup_brew
setup_fish
setup_starship
