""" VIM CONFIGURATION (no externel plugins)
" Last Updated: 12/02/2024

set nocompatible " disable compatibility with vi

colorscheme slate " others desert, peachpuff
set termguicolors " 24-bit true color support
syntax on " syntax highlight

set title " dynamic title
set titlestring=%F " full path of the file

set number " line numbers
set relativenumber " relative line numbers
set cursorline " highlight current line
set laststatus=2 " displays statusline (HIDDEN)
set noshowmode " hide mode from the command line

set textwidth=80 " maximum width for line wrapping
" set colorcolumn=80 " highlight a vertical line at column

set wildmenu " better command-line completion
set wildmode=longest,list,full " file and command-line tab completion
set completeopt=menuone,longest,preview " auto completion as you type

set tabstop=4 " number of spaces in a tab
set softtabstop=4 " number of spaces when pressing tab
set expandtab " replaces typed tabs the number of spaces
set shiftwidth=4 " number of spaces for each level of indentation
set scrolloff=8 " scrolling show upcoming lines

set autoindent " ineindents a new line to match the previous line's indentation
set smartindent " automatically aliging code within blocks

set nohlsearch " disable highlighting of search matches
set incsearch " incremental search highlighting

set ignorecase " peforms a case-insensitive search
set smartcase " peforms case-sensitive search based on characters

set noswapfile " no swap files
set nobackup " no backups
" let &undodir = expand("$HOME") . "/.vim/undodir" " customte custom file
" set undofile " store undo history

set mouse=a " mouse support

set splitbelow " split new buffer below
set termwinsize=10x0 " set terminal window height

" open netrw
nnoremap <Space>e :Explore<CR>

" open terminal
nnoremap <Space>t :term<CR>
" exit terminal mode back to normal mode
tnoremap <Space>b <C-\><C-n>

" sets numbers and relativenumbers ON
nnoremap cp+ :set number relativenumber<CR>
" sets numbers and  relativenumbers OFF
nnoremap cp- :set nonumber norelativenumber<CR>

" copy selected text to clipboard
vnoremap <C-c> "+y
" paste text from clipboard
nnoremap <C-p> "+p:%!fmt -w 80<CR>

" custom auto-pairing
inoremap (<CR> ()<Left>
inoremap [<CR> []<Left>
inoremap {<CR> {}<Left>
inoremap "<CR> ""<Left>
inoremap '<CR> ''<Left>
inoremap <<CR> <><Left>

" format file
nnoremap <Space>f gg=G

" navigate completion menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" navigate between windows
nnoremap <Space>w <C-w><C-w>

" modes
let g:currentmode={
       \ 'n'  : 'NORMAL ',
       \ 'v'  : 'VISUAL ',
       \ 'V'  : 'VISUAL-Line ',
       \ "\<C-V>" : 'VISUAL-Block ',
       \ 'i'  : 'INSERT ',
       \ 'c'  : 'COMMAND ',
       \ 't'  : 'TERMINAL ',
       \}

" custom statusline
if has('statusline')
  " set statusline+=%{SyntaxItem()} " syntax highlight group under cursor
  set statusline+=\         " empty space
  set statusline+=\ %{toupper(g:currentmode[mode()])} " current mode
  set statusline+=\|\       " pipe character
  set statusline+=%m        " modified flag
  set statusline+=%=%F      " file name
  set statusline+=%=        " right-align items
  set statusline+=%l:       " current line number
  set statusline+=%c\       " column number
  set statusline+=\         " empty space
endif

" shows what highlight group is under the cursor
function! SyntaxItem()
  return synIDattr(synID(line("."),col("."),1),"name")
endfunction

" remove trailing whitespaces before saving
au BufWritePre * :%s/\s\+$//e

" activate cursoline
au BufEnter,WinEnter * setlocal cursorline
" disable cursorline when leaving buffer
au BufLeave,WinLeave * setlocal nocursorline

" autocommand to check if files are netrw
au Filetype netrw call CheckIfNetrw()
" makes the function call when entring buffer or window
au BufEnter,WinEnter * call CheckIfNetrw()
" removes statusline if user enters netrw
function! CheckIfNetrw()
  if &filetype ==# 'netrw'
    setlocal laststatus=0
  else
    setlocal laststatus=2
  endif
endfunction

" calls custom command for grep search
command! -nargs=+ Grep :call GrepSearch(<q-args>)
" takes the given parameter and makes a vimgrep search
function! GrepSearch(args)
    let l:command = 'vimgrep /\c' . a:args . '/j **/*'
    try
        execute l:command
        copen
    catch
        echoerr 'Error executing vimgrep'
    endtry
endfunction

""" GVim configs
" check if running in GUI (GVim) or terminal
" if has("gui_running")
"     "set guioptions-=m " hides menu bar
"     set guioptions-=T " hides toolbar
"     set guioptions-=r " hides scrollbar
"
"     set columns=90 " set width
"     set lines=44 " set height
" endif


