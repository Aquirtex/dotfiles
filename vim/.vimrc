" ─────────────────────────────────────────────
" ALLGEMEIN
" ─────────────────────────────────────────────
set nocompatible               " Kein vi-Kompatibilitätsmodus
filetype plugin indent on      " Filetype Detection + Indent Rules
syntax on                      " Syntax Highlighting

" ─────────────────────────────────────────────
" OPTIK
" ─────────────────────────────────────────────
set number relativenumber      " Absolute + relative Zeilennummern
                               " → '5k' = 5 Zeilen rauf, sofort sichtbar
set cursorline                 " Aktuelle Zeile highlighten
" set colorcolumn=80             " Vertikale Linie bei 80 Zeichen
set background=dark
colorscheme catppuccin_mocha   " Theme — catppuccin muss in ~/.vim/colors/

" ─────────────────────────────────────────────
" VERHALTEN
" ─────────────────────────────────────────────
set mouse=a                    " Maus aktivieren
set clipboard=unnamed          " System-Clipboard (Mac)
                               " → VPS: clipboard=unnamedplus
set scrolloff=8                " 8 Zeilen Abstand beim Scrollen
set sidescrolloff=8            " Gleich für horizontales Scrollen
set wrap                       " Lange Zeilen umbrechen
set hidden                     " Buffer wechseln ohne speichern

" ─────────────────────────────────────────────
" SUCHE
" ─────────────────────────────────────────────
set incsearch                  " Live-Suche während tippen
set hlsearch                   " Treffer highlighten
set ignorecase                 " Case-insensitiv suchen
set smartcase                  " Außer bei Großbuchstaben

" ─────────────────────────────────────────────
" EINRÜCKUNG
" Filetype-spezifisch — YAML/JSON: 2 Spaces
" Python/Shell: 4 Spaces (Standards)
" ─────────────────────────────────────────────
set expandtab                  " Tabs → Spaces
autocmd FileType yaml,json,html,css,javascript
  \ setlocal tabstop=2 shiftwidth=2
autocmd FileType python,sh,bash
  \ setlocal tabstop=4 shiftwidth=4

" ─────────────────────────────────────────────
" COMPLETION + UI
" ─────────────────────────────────────────────
set wildmenu                   " Tab-Completion für : Befehle
set wildmode=longest:full,full " Completion Verhalten
set laststatus=2               " Statusleiste immer anzeigen
set showmode                   " Aktuellen Mode anzeigen
set ruler                      " Zeile/Spalte in Statusleiste

" Statusleiste
set statusline=%f              " Dateiname
set statusline+=%m             " [+] wenn ungespeichert
set statusline+=%=             " Rechts ab hier
set statusline+=%l/%L          " Zeile/Gesamt
set statusline+=\ %p%%         " Prozent durch Datei

" ─────────────────────────────────────────────
" LEADER KEY
" Leertaste als Leader — gut erreichbar
" ─────────────────────────────────────────────
let mapleader = " "

" ─────────────────────────────────────────────
" KEYBINDINGS
" ─────────────────────────────────────────────

" Schnell speichern
nnoremap <leader>w :w<CR>

" Suche highlighting deaktivieren
nnoremap <leader>h :nohlsearch<CR>

" Split Navigation ohne Ctrl+W+W
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

" Zeile rauf/runter verschieben (Normal + Visual)
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Einrückung in Visual Mode beibehalten
vnoremap < <gv
vnoremap > >gv
