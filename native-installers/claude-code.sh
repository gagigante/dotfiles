#!/usr/bin/env bash

if [[ $(command -v claude) == "" ]]; then
    curl -fsSL https://claude.ai/install.sh | bash
    success "Claude Code installed"
else
    info "Claude Code is already installed"
fi
