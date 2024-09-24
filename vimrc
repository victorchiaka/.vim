" === VIM SETTINGS ===================================="
" Enable clipboard support
set clipboard=unnamedplus

" Enables mouse
set mouse=a

set nobackup
set nowritebackup

syntax enable
syntax on
filetype plugin indent on
set hlsearch incsearch ignorecase
set number
" set relativenumber
set encoding=UTF-8
set fileformat=unix

set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent
set smartindent
set smarttab
set expandtab
set nowrap


if $COLORTERM == 'truecolor'
  set termguicolors
endif



" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=100

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Initialize Vundle
set nocompatible              " Be iMproved
filetype off                  " required

" Set Vundle variables before other settings
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

  " Let Vundle manage Vundle, required
  Plugin 'VundleVim/Vundle.vim'
  
  " Plugins go here
  Plugin 'junegunn/fzf', { 'do': './install --all && ln -s $(pwd) ~/.fzf'}
  Plugin 'junegunn/fzf.vim'
  Plugin 'sainnhe/sonokai' " Colorscheme
  Plugin 'morhetz/gruvbox' " Colorscheme
  Plugin 'tomasiser/vim-code-dark' " For VSCode dark colorscheme
  
  Plugin 'bluz71/vim-mistfly-statusline'
  Plugin 'airblade/vim-gitgutter' " Git modification indicator
  Plugin 'jiangmiao/auto-pairs' " Auto pair
  Plugin 'neoclide/coc.nvim' " Conqueror of completion
  Plugin 'preservim/nerdtree'
  Plugin 'Xuyuanp/nerdtree-git-plugin'
  Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plugin 'ryanoasis/vim-devicons'
  Plugin 'lambdalisue/nerdfont.vim'
  Plugin 'scrooloose/nerdcommenter'
  Plugin 'wakatime/vim-wakatime' " Wakatime
  
  " All of your plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"-- COLOR & THEME CONFIG
"let g:gruvbox_italic=1
"let g:gruvbox_contrast_dark = 'hard'
"colorscheme gruvbox

"set t_Co=256
"set t_ut=
"colorscheme codedark " Setting the colorscheme

set background=dark
"let g:terminal_ansi_colors = [
    "\ '#282828', '#cc241d', '#98971a', '#d79921', '#458588', '#b16286', '#689d6a', '#a89984',
    "\ '#928374', '#fb4934', '#b8bb26', '#fabd2f', '#83a598', '#d3869b', '#8ec07c', '#ebdbb2',
"\]

" Install Molokai theme
Plugin 'tomasr/molokai'
colorscheme molokai

let mapleader=","
nnoremap <leader>e :botright term<CR>
nnoremap <leader>h :nohlsearch<ENTER>

"--- Change the color scheme ------------------------------------------"
" colorscheme sonokai

"--- FZF settings --------------------------------"
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>b :Buffers <CR>
nnoremap <silent> <leader>g :GFiles <CR>

"--- Mistfly statusline settings ------------------------------------------"
" Don't show the mode as it is present in statusline; always show the statusline"
set noshowmode laststatus=2

nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFocus<CR>
let g:NERDTreeGitStatusWithFlags = 1


" Coc Settings
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ 'coc-pyright',
  \ ]
" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" To select options in the list
inoremap <silent><expr> <C-j>
  \ coc#pum#visible() ? coc#pum#next(1) :
  \ CheckBackspace() ? "\<Tab>" :
  \ coc#refresh()
inoremap <expr><C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Commenting
vmap gc <plug>NERDCommenterToggle
nmap gcc <plug>NERDCommenterToggle

"" Formatting selected code
xmap <leader>ff  <Plug>(coc-format-selected)
nmap <leader>ff  <Plug>(coc-format-selected)

" Formatting the whole file
nnoremap <leader>v :call CocActionAsync('format')<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    " Fallback to vim's default K behavior (show man page)
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>
nnoremap <leader>ac  <Plug>(coc-codeaction)

nnoremap <leader>rs :CocRestart<CR>
