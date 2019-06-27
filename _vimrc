set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim


call vundle#begin()

	Plugin 'gmarik/Vundle.vim'
	Plugin 'tomasr/molokai'
	Plugin 'bling/vim-airline'
	Plugin 'scrooloose/nerdtree'
	Plugin 'jistr/vim-nerdtree-tabs'
	Plugin 'scrooloose/syntastic'
	Plugin 'altercation/vim-colors-solarized'
	Plugin 'blueshirts/darcula'	
call vundle#end()


filetype plugin indent on

set number
set ruler
set showcmd
set incsearch
set hlsearch

" ----- scrooloose/syntastic settings -----
let g:syntastic_error_symbol = '?'
let g:syntastic_warning_symbol = "?"
augroup mySyntastic
  au!
  au FileType tex let b:syntastic_mode = "passive"
augroup END

set guioptions-=r
set guioptions-=m
set guioptions-=L
set guioptions-=T

set guifont=Anonymous_Pro:h15

set lines=40 columns=150

syntax enable
let g:airline#extensions#tabline#enabled = 1
let g:nerdtree_tabs_open_on_console_startup = 0

colorscheme darcula
let laststatus=2

" Open nerdtree with \t
nmap <silent> <leader>t :NERDTreeTabsToggle<CR>


source $VIMRUNTIME/vimrc_example.vim

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

