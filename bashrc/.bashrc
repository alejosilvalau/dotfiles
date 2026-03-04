source ~/.local/share/omakub/defaults/bash/rc

# Editor used by CLI
export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"
. "$HOME/.cargo/env"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# pnpm
export PNPM_HOME="/home/alejosilvalau/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

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
