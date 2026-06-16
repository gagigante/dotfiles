#! /usr/bin/bash

if [[ $(command -v codex) == "" ]]; then
    curl -fsSL https://chatgpt.com/codex/install.sh | sh
    success "Codex installed"
else
    info "Codex is already installed"
fi
