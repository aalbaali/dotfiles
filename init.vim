" install vim-plug if not installed already
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync
endif

" specify directory for plugins
call plug#begin('~/.config/nvim/plugged')

Plug 'arcticicestudio/nord-vim'

" initialize plugin system

Plug 'morhetz/gruvbox'
" Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'leafgarland/typescript-vim'
Plug 'vim-utils/vim-man'
Plug 'lyuts/vim-rtags'
" Plug 'git@github.com:kien/ctrlp.vim.git'
" Plug 'ctrlpvim/ctrlp.vim'
Plug 'mrtazz/DoxygenToolkit.vim' " Auto-insert Doxygen comments
Plug 'tpope/vim-commentary' " Easily comment / uncomment blocks
Plug 'skywind3000/asyncrun.vim' " Run commands / builds in background 
Plug 'christoomey/vim-tmux-navigator' " Seamless navigation between vim and tmux
Plug 'sheerun/vim-polyglot' " Better syntax highlighting
Plug 'w0ng/vim-hybrid' " Colorscheme
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'jamestthompson3/nvim-remote-containers'  " similar to vscode remote container

Plug 'ycm-core/YouCompleteMe' " Autocomplete and much more

call plug#end()

" Settings
syntax on                   " Sets syntax highlighting to on
set noerrorbells            " Turns off error sounds/bells after end of line
set tabstop=2               " tabstop: 2 characters long
set softtabstop=2           " tabstop: 2 spaces long
set shiftwidth=2            " indent next line (after hitting 'enter') by 2 spaces
set smartindent             " attempts smart indentation (auto indent) for different languages
set nu                      " set line numbering
set noswapfile              " do not swap files when writing in vim
set nobackup                " no backup file. Instead, use undodir/undofile.
set undodir=~/.nvim/undodir " undo directory for 'backup'
set incsearch               " incremental search
set colorcolumn=100         " color column at this limit
highlight ColorColumn ctermbg=0 guibg=lightblue
set ruler                   " show row and column
set splitright              " new verticalsplits go to the right
set splitbelow              " new horizontal splits go below
set ignorecase              " ignore case when using a search pattern
set smartcase               " override 'ignorecase' when pattern has upper case character
set number                  " show line numbers
"set nowrap                  " do not wrap
set wrap                    " automatically wrap text that extends beyond the screen length
colorscheme gruvbox         " colorscheme
set background=dark

set showmatch               " show matching brackets.
set mouse=v                 " middle-click paste with mouse
set nohlsearch              " highlight search results
set autoindent              " indent a new line the same amount as the line just typed
set wildmode=longest,list   " get bash-like tab completions
set cc=100                  " set an 100 column border for good coding style
filetype plugin indent on   " allows auto-indenting depending on file type
set expandtab               " converts tabs to white space

" allows rg to always to detect root and use .gitignore for faster searching
if executable('rg')
  let g:rg_derive_root='true'
endif

" Never automatically continue comment when starting next line and 
" delete comment character when joining commented lines
au FileType * set fo-=c fo-=r fo-=o fo+=j

