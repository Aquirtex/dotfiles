# dotfiles

Persönliche Dotfiles — Mac + VPS (Debian).
Verwaltet mit [GNU Stow](https://www.gnu.org/software/stow/).

## Struktur

```
dotfiles/
├── zsh/
│   └── .zshrc
├── tmux/
│   └── .config/tmux/tmux.conf
├── vim/
│   └── .vimrc
├── starship/
│   └── .config/starship.toml
├── ghostty/
│   └── .config/ghostty/config    # Mac only
├── Brewfile                       # Mac Packages
└── README.md
```

---

## Setup Mac

### 1. Homebrew installieren
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Repo klonen
```bash
git clone git@github.com:Aquirtex/dotfiles.git ~/dotfiles
```

### 3. Packages installieren
```bash
brew bundle --file=~/dotfiles/Brewfile
```

### 4. Alte Configs sichern (falls vorhanden)
```bash
mkdir ~/dotfiles-backup
cp ~/.zshrc ~/dotfiles-backup/ 2>/dev/null
cp ~/.vimrc ~/dotfiles-backup/ 2>/dev/null
cp ~/.config/tmux/tmux.conf ~/dotfiles-backup/ 2>/dev/null
```

### 5. Stow ausführen
```bash
cd ~/dotfiles
stow zsh tmux vim starship ghostty
```

### 6. Nerd Font installieren
```bash
brew install --cask font-jetbrains-mono-nerd-font
```
Dann in Ghostty Config: `font-family = JetBrainsMonoNL Nerd Font Mono`

### 7. tmux Plugin Manager installieren
```bash
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
```

### 8. Catppuccin für tmux manuell installieren
> ⚠️ Catppuccin wird NICHT via tpm installiert — tpm hat einen Name-Conflict mit catppuccin/tmux.
> Immer manuell klonen!

```bash
mkdir -p ~/.config/tmux/plugins/catppuccin
git clone -b v2.1.3 https://github.com/catppuccin/tmux.git \
  ~/.config/tmux/plugins/catppuccin/tmux
```

### 9. tmux starten + restliche Plugins installieren
```bash
tmux
# Ctrl+A + I → tmux-sensible + tmux-yank installieren
```

### 10. Vim Catppuccin Colorscheme installieren
```bash
mkdir -p ~/.vim/colors
curl -o ~/.vim/colors/catppuccin_mocha.vim \
  https://raw.githubusercontent.com/catppuccin/vim/main/colors/catppuccin_mocha.vim
```

---

## Setup VPS (Debian)

```bash
# Tools installieren
apt install vim tmux fzf zoxide stow ripgrep fd-find bat eza

# Repo klonen
git clone git@github.com:Aquirtex/dotfiles.git ~/dotfiles

# Stow — kein Ghostty auf VPS
cd ~/dotfiles
stow zsh tmux vim starship

# tpm installieren
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

# Catppuccin manuell installieren
mkdir -p ~/.config/tmux/plugins/catppuccin
git clone -b v2.1.3 https://github.com/catppuccin/tmux.git \
  ~/.config/tmux/plugins/catppuccin/tmux

# tmux starten + Plugins installieren
tmux
# Ctrl+A + I

# Vim Catppuccin
mkdir -p ~/.vim/colors
curl -o ~/.vim/colors/catppuccin_mocha.vim \
  https://raw.githubusercontent.com/catppuccin/vim/main/colors/catppuccin_mocha.vim
```

> Hinweis: Auf VPS in `.vimrc` `clipboard=unnamedplus` statt `clipboard=unnamed`

---

## SSH Config

SSH Config wird **nicht** in Git verwaltet — liegt in Vaultwarden als Secure Note.

```
# Struktur ~/.ssh/config (manuell anlegen)
Host github-personal
  HostName github.com
  User git
  IdentityFile ~/.ssh/github_florian_mac
  IdentitiesOnly yes

Host github-darkflare
  HostName github.com
  User git
  IdentityFile ~/.ssh/github
  IdentitiesOnly yes
```

---

## Tastenkürzel

### tmux (Prefix = Ctrl+A)

| Aktion | Keybind |
|--------|---------|
| Split vertikal | `Prefix + v` |
| Split horizontal | `Prefix + s` |
| Pane navigieren | `Prefix + h/j/k/l` |
| Pane resizen | `Prefix + H/J/K/L` (repeatable) |
| Letztes Window | `Prefix + Ctrl+A` |
| Window umbenennen | `Prefix + ,` |
| Config reload | `Prefix + r` |
| Copy Mode | `Prefix + [` |
| Plugins installieren | `Prefix + I` |
| Plugins updaten | `Prefix + U` |

### vim (Leader = Leertaste)

| Aktion | Keybind |
|--------|---------|
| Speichern | `Leader + w` |
| Suche löschen | `Leader + h` |
| Split Navigation | `Ctrl + h/j/k/l` |
| Wort ersetzen | `ciw` |
| Zeile löschen | `dd` |
| Zeile kopieren | `yy` |
| Einfügen | `p` |
| Wiederholen | `.` |
| Undo/Redo | `u` / `Ctrl+r` |
| Datei Anfang/Ende | `gg` / `G` |

---

## Theme

Catppuccin Mocha — konsistent in Ghostty, tmux, vim, starship.

### Tokyo Night wechseln
- Ghostty: `theme = tokyonight_storm`
- tmux: Catppuccin neu klonen mit Tokyo Night variant
- vim: Tokyo Night colorscheme installieren
