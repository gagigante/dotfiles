#!/usr/bin/env bash

source ./bin/logger.sh

DOTFILES=$(pwd -P)

# Creates a symlink from src to dst, creating parent directories as needed.
link_file() {
    local src=$1 dst=$2
    local dir
    dir=$(dirname "$dst")

    mkdir -p "$dir"
    info "Linking $src -> $dst"
    ln -sf "$src" "$dst"

    if [ $? -eq 0 ]; then
        success "Linked: $src -> $dst"
    else
        fail "Failed to link: $src -> $dst"
    fi
}

# Reads a .prop file of "src=dst" pairs and calls link_file for each entry.
read_links() {
    local file_path=$1

    while IFS='=' read -r src dst || [[ -n "$src" ]]; do
        src=$(eval echo "$src")
        dst=$(eval echo "$dst")
        link_file "$src" "$dst"
    done < "$file_path"
}

# Installs Homebrew if missing, then installs all packages declared in the Brewfile.
setup_brew() {
    info "Setting up Homebrew"
    source ./native-installers/brew.sh
    brew bundle --file=./brew/Brewfile
    success "Homebrew setup finished\n"
}

# Sources every installer in native-installers/ except brew.sh, which is handled by setup_brew.
setup_native_installers() {
    info "Running native installers"
    for installer in ./native-installers/*.sh; do
        [[ "$installer" == *"brew.sh" ]] && continue
        source "$installer"
    done
    success "Native installers finished\n"
}

# Iterates over every directory in configs/ and symlinks its declared files into the system.
setup_configs() {
    info "Setting up configs"
    for links_file in ./configs/*/links.prop; do
        read_links "$links_file"
    done
    success "Configs setup finished\n"
}

setup_brew
setup_native_installers
setup_configs
