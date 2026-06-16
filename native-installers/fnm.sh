#!/usr/bin/env bash

if [[ $(command -v fnm) == "" ]]; then
    curl -o- https://fnm.vercel.app/install | bash
    success "fnm installed"
else
    info "fnm is already installed"
fi
