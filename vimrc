" === VIM SETTINGS ===================================="
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
set relativenumber

if $COLORTERM == 'truecolor'
  set termguicolors
endif

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=90

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
  Plugin 'catppuccin/vim', { 'as': 'catppuccin' }
  Plugin 'tomasiser/vim-code-dark', " For VSCode dark colorscheme
  Plugin 'tomasr/molokai'
  Plugin 'crusoexia/vim-monokai' " Monokai theme
  
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
  Plugin 'sheerun/vim-polyglot'
 
  " All of your plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set background=dark
"let g:terminal_ansi_colors = [
    "\ '#282828', '#cc241d', '#98971a', '#d79921', '#458588', '#b16286', '#689d6a', '#a89984',
    "\ '#928374', '#fb4934', '#b8bb26', '#fabd2f', '#83a598', '#d3869b', '#8ec07c', '#ebdbb2',
"\]

" colorscheme codedark " VSCode dark

" Install Molokai theme
" colorscheme molokai
" colorscheme catppuccin_macchiato

"-- COLOR & THEME CONFIG
"let g:gruvbox_italic=1
"let g:gruvbox_contrast_dark = 'hard'
" colorscheme gruvbox
" colorscheme molokai
"colorscheme monokai
colorscheme catppuccin_mocha

let mapleader=","
nnoremap <leader>e :botright term<CR>
nnoremap <leader>h :nohlsearch<ENTER>

"--- Change the color scheme ------------------------------------------"
" colorscheme sonokai

"--- FZF settings --------------------------------"
" Function for searching within files using FZF
function! SearchInFiles(query)
  "----- Install Ripgrep And Or The_Silver_Searcher -----"
  if executable('rg')
    " Use ripgrep if available
    call fzf#vim#grep(
          \ 'rg --column --line-number --no-heading --color=always --smart-case --hidden --glob "!.git/*" --glob "!node_modules/*" '.shellescape(a:query), 1,
          \ fzf#vim#with_preview(), 0)
  elseif executable('ag')
    " Use The Silver Searcher if ripgrep is not available
    call fzf#vim#grep(
          \ 'ag --nocolor --nogroup --column '.shellescape(a:query), 1,
          \ fzf#vim#with_preview(), 0)
  else
    echo "Neither ripgrep (rg) nor The Silver Searcher (ag) is installed."
  endif
endfunction

nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>b :Buffers <CR>
nnoremap <silent> <leader>g :call SearchInFiles(input('Search for: '))<CR>
nnoremap <silent> <leader>gf :GFiles <CR>

"--- Mistfly statusline settings ------------------------------------------"
" Don't show the mode as it is present in statusline; always show the statusline"
set noshowmode laststatus=2

nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFocus<CR>
let g:NERDTreeGitStatusWithFlags = 1
let NERDTreeShowHidden=1

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
nnoremap <silent>K :call ShowDocumentation()<CR>
nnoremap <leader>c  <Plug>(coc-codeaction)

nnoremap <leader>rs :CocRestart<CR>

" Popup lazygit
nnoremap <leader>lg :silent !lazygit<CR>

" Normal mode: Move line up/down
nnoremap <silent> <A-j> :m .+1<CR>==
nnoremap <silent> <A-k> :m .-2<CR>==

" Insert mode: Move line up/down (and stay in insert mode)
inoremap <silent> <A-j> <Esc>:m .+1<CR>==gi
inoremap <silent> <A-k> <Esc>:m .-2<CR>==gi

" Visual mode (line-wise): Move selection up/down
vnoremap <silent> <A-j> :m '>+1<CR>gv=gv
vnoremap <silent> <A-k> :m '<-2<CR>gv=gv

" Visual Block mode: Move block up/down
xnoremap <silent> <A-j> :m '>+1<CR>gv=gv
xnoremap <silent> <A-k> :m '<-2<CR>gv=gv

" Visual mode: Indent and unindent with Tab and Shift+Tab
vnoremap <silent> <Tab> >gv
vnoremap <silent> <S-Tab> <gv

" Visual Block mode: Indent and unindent block
xnoremap <silent> <Tab> >gv
xnoremap <silent> <S-Tab> <gv
