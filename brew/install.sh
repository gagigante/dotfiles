#! /usr/bin/bash

if [[ $(command -v brew) == "" ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    success "Homebrew installed"
else
    info "Homebrew is already installed. Updating Homebrew\n"
    brew update
    success "Homebrew updated"
fi

