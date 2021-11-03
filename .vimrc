" install vim-plug if it isn't installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
     \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'jremmen/vim-reprgrep'
Plug 'tpope/vim-fugitive'
Plug 'leafgarland/typescript-vim'
Plug 'vim-utils/vim-man'
Plug 'lyuts/vim-rtags'
Plug 'git@github.com:kien/ctrlp.vim.git'
Plug 'mrtazz/DoxygenToolkit.vim' " Auto-insert Doxygen comments
Plug 'tpope/vim-commentary' " Easily comment / uncomment blocks
Plug 'skywind3000/asyncrun.vim' " Run commands / builds in background 
Plug 'christoomey/vim-tmux-navigator' " Seamless navigation between vim and tmux
Plug 'sheerun/vim-polyglot' " Better syntax highlighting
Plug 'w0ng/vim-hybrid' " Colorscheme

if has('patch-8.1.2269')
  Plug 'ycm-core/YouCompleteMe' " Autocomplete and much more
else
  Plug 'ycm-core/YouCompleteMe', { 'commit':'d98f896' }
endif
call plug#end()

syntax on " Sets syntax highlighting to on
set noerrorbells " no error sounds/bells after end of line
set tabstop=2 softtabstop=2 " tabstop: 2 characters long. tabstop: 2 spaces long.
set shiftwidth=2 " indent next line (after hitting 'enter') by 2 spaces
set expandtab " convert tabs to spaces
set smartindent " attempts smart indentation (auto indent) for different languages
set nu " set line numbering
set nowrap " do not wrap numbers
set noswapfile " no swap files when writing in vim (I think they're usually there for backup
set nobackup " no backup file. We're doing undodir/undofile instead. 
set undodir=~/.vim/undodir "undo directory for 'backup'
set incsearch " incremental search

set colorcolumn=100 " colors column at this limit
highlight ColorColumn ctermbg=0 guibg=lightgrey

" Settings
set ruler " show row and column
set splitright " new verticalsplits go to the right
set splitbelow " new horizontal splits go below
set ignorecase " ignore case when using a search patter
set smartcase " override 'ignorecase' when pattern has upper case character
set number " show line numbers
set softtabstop=2 " always use spaces, never tabs
"set updatetime=250 " 250 ms between screen updates
set wildmode=list:longest,full " list completions on command line, cycle through with tab
"set wrap " automatically wrap text that extends beyond the screen length

" Ruler has column and AsyncRun status
" set rulerformat=%60(%=%t\ %c\ %{g:asyncrun_status}%)

" colorscheme
colorscheme gruvbox
set background=dark

" allows rg to always to detect root and use .gitignore for faster searching
if executable('rg')
  let g:rg_derive_root='true'
endif


