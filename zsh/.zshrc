# ─────────────────────────────────────────────
# BREW
# Homebrew PATH initialisieren (Apple Silicon)
# ─────────────────────────────────────────────
if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export SSH_AUTH_SOCK="$HOME/.bitwarden-ssh-agent.sock"

# ─────────────────────────────────────────────
# ZINIT
# Plugin Manager — wird automatisch installiert
# falls noch nicht vorhanden
# ─────────────────────────────────────────────
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# ─────────────────────────────────────────────
# PLUGINS
# Nur was wirklich täglich genutzt wird:
# - syntax-highlighting  → Tippfehler sofort sichtbar
# - completions          → bessere Tab-Completion
# - autosuggestions      → History-Vorschläge (Pfeil rechts)
# - fzf-tab              → fuzzy Completion mit Preview
# ─────────────────────────────────────────────
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Completions initialisieren
autoload -Uz compinit && compinit
zinit cdreplay -q

# ─────────────────────────────────────────────
# KEYBINDINGS
# Emacs Mode — Ctrl+A/E/W/K funktionieren
# auch in Browser, Mail, Spotlight
# ─────────────────────────────────────────────
bindkey -e
bindkey '^p' history-search-backward   # Ctrl+P → ältere Einträge
bindkey '^n' history-search-forward    # Ctrl+N → neuere Einträge

# ─────────────────────────────────────────────
# HISTORY
# Große History, keine Duplikate, geteilt
# zwischen allen Terminal-Sessions
# ─────────────────────────────────────────────
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory        # History anhängen statt überschreiben
setopt sharehistory         # Zwischen Sessions teilen
setopt hist_ignore_space    # Commands mit Leerzeichen davor nicht speichern
setopt hist_ignore_all_dups # Duplikate komplett ignorieren
setopt hist_save_no_dups    # Keine Duplikate in History File
setopt hist_find_no_dups    # Keine Duplikate beim Suchen

# ─────────────────────────────────────────────
# COMPLETION STYLING
# fzf-tab Preview mit eza statt ls
# zeigt Verzeichnisstruktur beim Tab
# ─────────────────────────────────────────────
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'           # Case-insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"           # Farben
zstyle ':completion:*' menu no                                     # fzf übernimmt Menu
zstyle ':fzf-tab:complete:cd:*' fzf-preview \
  'eza --tree --level=2 --color=always $realpath'                  # cd Preview
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview \
  'eza --tree --level=2 --color=always $realpath'                  # zoxide Preview

# ─────────────────────────────────────────────
# ALIASES
# Moderne Tool-Ersätze + häufige Commands
# \ls, \cat etc. → Original falls nötig
# ─────────────────────────────────────────────

# Filesystem
alias ls='eza --icons --color=auto'                        # ls mit Icons
alias ll='eza -la --icons --git'              # Detailansicht + Git Status
alias tree='eza --tree --level=2'             # Verzeichnisbaum
alias cat='bat --paging=never'                # cat mit Syntax-Highlighting
alias grep='rg'                               # schnelleres grep
alias find='fd'                               # intuitiveres find

# Navigation
alias ..='cd ..'
alias ...='cd ../..'

# Git
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph'
alias lg='lazygit'                            # Git TUI

# Docker
alias dk='lazydocker'                         # Docker TUI
alias dps='docker ps'
alias dcu='docker compose up -d'
alias dcd='docker compose down'
alias dcl='docker compose logs -f'

# Tools
alias df='duf'                                # bessere Disk-Übersicht

# ─────────────────────────────────────────────
# MANPAGER
# bat als Man-Page Renderer
# → Syntax-Highlighting in man Pages
# ─────────────────────────────────────────────
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANRWIDTH=80

# ─────────────────────────────────────────────
# SHELL INTEGRATIONS
# fzf  → Ctrl+R History, Ctrl+T Files, Alt+C Dirs
# zoxide → z <dir> statt cd, zi für interaktiv
# starship → Prompt
# ─────────────────────────────────────────────
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"
