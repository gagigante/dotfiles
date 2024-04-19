#! /usr/bin/bash

echo -e "Installing Brew package manager...\n"

if [[ $(command -v brew) == "" ]]; then
    echo "› Installing Hombrew.\n"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
    echo -e "› Homebrew is already installed. Updating Homebrew.\n"
    brew update
    echo -e "\n› Homebrew update is done!"
fi
