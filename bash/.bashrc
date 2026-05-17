# ─────────────────────────────────────────────
# GUARD
# Non-interactive shells → exit immediately
# ─────────────────────────────────────────────
case $- in
    *i*) ;;
      *) return;;
esac

# ─────────────────────────────────────────────
# PATH
# ─────────────────────────────────────────────
export PATH="$HOME/.local/bin:$PATH"

# ─────────────────────────────────────────────
# HISTORY
# Large history, no duplicates
# ─────────────────────────────────────────────
HISTSIZE=10000
HISTFILESIZE=10000
HISTCONTROL=ignoreboth:erasedups
shopt -s histappend
shopt -s checkwinsize

# ─────────────────────────────────────────────
# COMPLETION
# Tab completion for docker, git, systemctl etc.
# ─────────────────────────────────────────────
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# ─────────────────────────────────────────────
# COLORS
# ─────────────────────────────────────────────
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# ─────────────────────────────────────────────
# ALIASES
# ─────────────────────────────────────────────

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ll='ls -la --color=auto'
alias la='ls -A --color=auto'
alias ls='ls --color=auto'

# Git
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph'

# Docker
alias lzd='lazydocker'
alias dps='docker ps'
alias dcu='docker compose up -d'
alias dcd='docker compose down'
alias dcl='docker compose logs -f'
alias dce='docker compose exec'
alias dcr='docker compose restart'

# Systemd
alias sc='sudo systemctl'
alias jl='sudo journalctl'

# Quick edits
alias bashrc='vim ~/.bashrc && source ~/.bashrc'

# ─────────────────────────────────────────────
# STARSHIP
# Prompt — must be at the end
# ─────────────────────────────────────────────
eval "$(starship init bash)"
