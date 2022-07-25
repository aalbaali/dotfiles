" ======================================
" install vim-plug if it isn't installed
" ======================================
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
     \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ======================================
" Install plugins
" ======================================
call plug#begin('~/.config/nvim/plugged')

Plug 'morhetz/gruvbox'
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'             " Git comments
Plug 'leafgarland/typescript-vim'
Plug 'vim-utils/vim-man'              " View `man` pages in vim
Plug 'lyuts/vim-rtags'
Plug 'mrtazz/DoxygenToolkit.vim'      " Auto-insert Doxygen comments
Plug 'tpope/vim-commentary'           " Easily comment / uncomment blocks
Plug 'skywind3000/asyncrun.vim'       " Run commands / builds in background 
Plug 'christoomey/vim-tmux-navigator' " Seamless navigation between vim and tmux
Plug 'sheerun/vim-polyglot'           " Better syntax highlighting
Plug 'w0ng/vim-hybrid'                " Colorscheme
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }  " Install fzf (fast fuzzy searcher)
Plug 'junegunn/fzf.vim'               " fzf vim extension
Plug 'airblade/vim-gitgutter'         " Git status on side bar and git operations
Plug 'rhysd/vim-clang-format'         " Commands for applying clang-formatting
Plug 'preservim/nerdtree'             " Navigate files using a tree structure

Plug 'arcticicestudio/nord-vim'       " Build for vim's terminal and GUI mode with true colors
Plug 'tmsvg/pear-tree'                " Pair brackets, braces, etc.
Plug 'jamestthompson3/nvim-remote-containers'  " similar to vscode remote container
Plug 'cdelledonne/vim-cmake'          " CMake support 

if has('patch-8.1.2269')
  Plug 'ycm-core/YouCompleteMe' " Autocomplete and much more
else
  Plug 'ycm-core/YouCompleteMe', { 'commit':'d98f896' }
endif
call plug#end()

" ======================================
" Settings
" ======================================
syntax on                   " Sets syntax highlighting to on
set noerrorbells            " Turns off error sounds/bells after end of line
set tabstop=2               " Tabstop: 2 characters long
set softtabstop=2           " Tabstop: 2 spaces long
set shiftwidth=2            " Indent next line (after hitting 'enter') by 2 spaces
set expandtab               " Converts tabs to white space
set smartindent             " Attempts smart indentation (auto indent) for different languages
set nu                      " Set line numbering
set nowrap                  " Do not wrap
set noswapfile              " Do not swap files when writing in vim
set nobackup                " No backup file. Instead, use undodir/undofile.
set undodir=~/.nvim/undodir " Undo directory for 'backup'
set incsearch               " Incremental search
set paste                   " Well formatted pasting and no comments when inserting new lines
set colorcolumn=100         " Color column at this limit
highlight ColorColumn ctermbg=0 guibg=lightblue
set ruler                   " Show row and column
set splitright              " New verticalsplits go to the right
set splitbelow              " New horizontal splits go below
set ignorecase              " Ignore case when using a search pattern
set smartcase               " Override 'ignorecase' when pattern has upper case character
set number                  " Show line numbers
set wildmode=longest,list   " Get bash-like tab completions
set showmatch               " Show matching brackets.
set nohlsearch              " Highlight search results
set autoindent              " Indent a new line the same amount as the line just typed
set cc=100                  " Set an 100 column border for good coding style

" colorscheme
colorscheme gruvbox
set background=dark

filetype plugin indent on   " allows auto-indenting depending on file type

" allows rg to always to detect root and use .gitignore for faster searching
if executable('rg')
  let g:rg_derive_root='true'
endif

" Never automatically continue comment when starting next line and 
" delete comment character when joining commented lines
au FileType * set fo-=c fo-=r fo-=o fo+=j

" Set C++ comment strings to `//` instead of `/* */`
autocmd FileType c,cpp setlocal commentstring=//\ %s

" ======================================
" Plugin settings and shortcuts
" ======================================
" Variables
let g:cmake_link_complie_commands = 1
let g:cmake_default_config = 'build'

" CMake shortcuts
nmap <leader>cg : CMakeGenerate<cr>
nmap <leader>cb : CMakeBuild<cr>

" -- fzf
nnoremap <leader>o :Files<CR>
nnoremap <leader>i :Buffers<CR>
nnoremap <leader>/ :Lines<CR>
nnoremap <leader>a :Ag<space>
nnoremap <leader>p :History<CR>
nnoremap <leader>: :History:<CR>
let $FZF_DEFAULT_COMMAND = 'ag -g ""' " ignore files in .gitignore
let g:fzf_layout = { 'down': '~40%' }

function! FZFSameName(sink, pre_command, post_command)
    let current_file_no_extension = expand("%:t:r")
    let current_file_with_extension = expand("%:t")
    execute a:pre_command
    call fzf#run(fzf#wrap({
          \ 'source': 'find -name "' . current_file_no_extension . '.*" | grep -Ev "*' . current_file_with_extension . '$"',
          \ 'options': -1, 'sink': a:sink}))
    execute a:post_command
endfunction
nnoremap <leader>ff :call FZFSameName('e', '', '')<CR>
nnoremap <leader>fh :call FZFSameName('e', 'wincmd h', '')<CR>
nnoremap <leader>fl :call FZFSameName('e', 'wincmd l', '')<CR>
nnoremap <leader>fk :call FZFSameName('e', 'wincmd k', '')<CR>
nnoremap <leader>fj :call FZFSameName('e', 'wincmd j', '')<CR>
nnoremap <leader>fH :call FZFSameName('leftabove vsplit', '', 'wincmd h')<CR>
nnoremap <leader>fL :call FZFSameName('rightbelow vsplit', '', 'wincmd l')<CR>
nnoremap <leader>fK :call FZFSameName('leftabove split', '', 'wincmd k')<CR>
nnoremap <leader>fJ :call FZFSameName('rightbelow split', '', 'wincmd j')<CR>

" vim-gutter
function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction
set statusline+=%{GitStatus()}

" vim-clang-format
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>

" nerdtree mappings
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR><C-w>w
let NERDTreeMapActivateNode='<space>'

" -- vim-fugitive
nnoremap <leader>gb :Git blame<CR>

" -- YouCompleteMe
let g:ycm_confirm_extra_conf = 0
let g:ycm_show_diagnostics_ui = 1
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_always_populate_location_list = 1
let g:ycm_auto_hover=''
let g:ycm_clangd_args=['--header-insertion=never']
nnoremap <leader>yd :YcmDebugInfo<CR>
nnoremap <leader>yr :YcmRestartServer<CR>
nnoremap <leader>yt :YcmCompleter GetType<CR>
nnoremap <leader>yf :YcmCompleter FixIt<CR>
nnoremap <leader>yi :YcmCompleter GoToInclude<CR>
nnoremap <leader>yc :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>yn :YcmCompleter GoToDefinition<CR>
nnoremap <leader>ya :YcmCompleter GoToReference<CR>
nnoremap <leader>ym :YcmCompleter GoToImplementation<CR>
