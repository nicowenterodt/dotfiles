eval "$(/opt/homebrew/bin/brew shellenv)"

# Locale/environment
export LANG=en_US.UTF-8

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# rbenv (login shell path setup)
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - zsh)"
