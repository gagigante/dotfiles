# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

# History prefix search with arrow keys
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

# Completion
autoload -Uz compinit && compinit

# Aliases
alias cls='clear'
alias ll='ls -lAh'
alias la='ls -A'
alias ..='cd ..'
alias ...='cd ../..'

# Plugins
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# fnm
eval "$(fnm env --use-on-cd --shell zsh)"

# Starship
eval "$(starship init zsh)"
