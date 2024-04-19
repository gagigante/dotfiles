#! /usr/bin/bash

echo -e "Installing brew packages from Brewfile...\n"

brew bundle install --file=~/Brewfile
