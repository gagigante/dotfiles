if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Brew
/home/linuxbrew/.linuxbrew/bin/brew shellenv | source

# Starship theme
starship init fish | source