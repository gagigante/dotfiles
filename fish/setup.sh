#! /usr/bin/bash

info "Creating config.fish"
cp $DOTFILES/fish/base.fish $DOTFILES/fish/config.fish

info "Adding homebrew to fish"
local brew_location=$(which brew)
echo -e "\n# Brew\n$brew_location shellenv | source" >> $DOTFILES/fish/config.fish

# TODO: setup color scheme

info "Setting fish as default shell"
chsh -s /usr/bin/fish
