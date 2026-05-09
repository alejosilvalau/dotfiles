source ~/.local/share/omakub/defaults/bash/rc

# Editor used by CLI
export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"

export PATH="$HOME/.cargo/bin:$PATH"
. "$HOME/.cargo/env"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
#

export NODE_PATH="$PNPM_HOME/global/5/node_modules:$NODE_PATH"

export PRETTIERD_DEFAULT_CONFIG="$HOME/.prettierrc"

# This preserves the Omakub arrow but adds the Blue Path (\w) before it
# \[\033[01;34m\] makes the path blue
# \uf0a9 is your circle arrow icon
export PS1="\[\033[01;34m\]\w \[\033[00m\]"$(echo -e '\uf0a9 ')""

# Only run these if we are in an interactive terminal
if [[ $- == *i* ]]; then
  # Show hidden files in tab completion
  bind 'set match-hidden-files on'

  # Better Tab experience
  bind "set show-all-if-ambiguous on"
  bind 'TAB: menu-complete'
fi

# SQL Server tools
export PATH="$PATH:/opt/mssql-tools18/bin"

# Auto-activate .venv when entering a directory
auto_activate_venv() {
  if [ -d ".venv" ]; then
    source .venv/bin/activate
  elif [ -d "venv" ]; then
    source venv/bin/activate
  elif [ -n "$VIRTUAL_ENV" ]; then
    deactivate
  fi
}
PROMPT_COMMAND="auto_activate_venv;$PROMPT_COMMAND"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"
eval "$(pyenv virtualenv-init -)"

# Tmux-sessionizer aliases
# Direct project jumps
alias tsA="tmux-sessionizer \"/media/$USER/Int. Media/AlnixDev/Projects\""
alias tsJ="tmux-sessionizer \"/media/$USER/Int. Media/Job\""
alias tsD="tmux-sessionizer \"$HOME/Desktop/Job\""
alias tsS="tmux-sessionizer \"$HOME/dotfiles\""
alias tsN="tmux-sessionizer \"$HOME/.config/nvim\""

# Direct vault jumps
alias tsV="tmux-sessionizer \"/media/$USER/Archive/AlnixDev/vault-alnix404\""
alias tsB="tmux-sessionizer \"/media/$USER/Archive/AlnixDev/vault-alnixdev\""
alias tsU="tmux-sessionizer \"/media/$USER/Archive/Job/vault-university\""
alias tsP="tmux-sessionizer \"/media/$USER/Archive/Personal/vault-personal\""
alias tsE="tmux-sessionizer \"$HOME/Desktop/vault-desktop\""

# Fuzzy search
alias ts="tmux-sessionizer"
