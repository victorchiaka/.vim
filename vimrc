" === VIM SETTINGS ===================================="

set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

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
  Plugin 'bluz71/vim-mistfly-statusline'
  Plugin 'airblade/vim-gitgutter' " Git modification indicator
  Plugin 'jiangmiao/auto-pairs' " Auto pair
  Plugin 'neoclide/coc.nvim' " Conqueror of completion
  Plugin 'lambdalisue/fern-renderer-nerdfont.vim'
  Plugin 'lambdalisue/fern.vim'
  Plugin 'lambdalisue/fern-git-status.vim'
  Plugin 'lambdalisue/fern-renderer-devicons.vim'
  Plugin 'lambdalisue/nerdfont.vim'
  
  " All of your plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" === VIM SETTINGS ===================================="

syntax enable
filetype plugin indent on
set hlsearch incsearch ignorecase
set modifiable
set number
set encoding=UTF-8

if $COLORTERM == 'truecolor'
  set termguicolors
endif

let g:fern_renderer_devicons_disable_warning = 1

let mapleader=","
nnoremap <leader>e :botright term<CR>
nnoremap <leader>h :nohlsearch<ENTER>

"--- Change the color scheme ------------------------------------------"
colorscheme sonokai

"--- FZF settings --------------------------------"
nnoremap <silent> <leader>f :Lines<CR>
nnoremap <silent> <leader>b :Buffers <CR>
nnoremap <silent> <leader>g :GFiles <CR>

"--- Mistfly statusline settings ------------------------------------------"
" Don't show the mode as it is present in statusline; always show the statusline"
set noshowmode laststatus=2

" --- Fern Settings --- "
"  Additional configuration for git status and icons
let g:fern#renderer = "nerdfont"

" let g:fern#default_exclude = '\%(\.DS_Store\|__pycache__\|.pytest_cache\|.ruff_cache\|.git\)'
" let g:fern#renderer = "devicons"
let g:fern#default_hidden = 1
nnoremap <leader>n :Fern . -drawer -toggle<CR>

" Coc Settings
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


" Formatting selected code
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
nmap <leader>ca  <Plug>(coc-codeaction)
