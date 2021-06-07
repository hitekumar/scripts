" This setting prevents vim from emulating the original vi's bugs and limitations.
" set nocompatible

" The first setting tells vim to use "autoindent" (that is, use the current line's indent level to set the indent level of new lines). The second makes vim attempt to intelligently guess the indent level of any new line based on the previous line, assuming the source file is in a C-like language. Combined, they are very useful in writing well-formatted source code.
set autoindent
set smartindent

" I prefer 4-space tabs to 8-space tabs. The first setting sets up 4-space tabs, and the second tells vi to use 4 spaces when text is indented (auto or with the manual indent adjustmenters.)
se nu
set tabstop=4
set shiftwidth=4
" to convert tab to space characters 
set expandtab

" This setting will cause the cursor to very briefly jump to a brace/parenthese/bracket's "match" whenever you type a closing or opening brace/parenthese/bracket. I've had almost no mismatched-punctuation errors since I started using this setting.
set showmatch

" I find the toolbar in the GUI version of vim (gvim) to be somewhat useless visual clutter. This option gets rid of the toolbar.
" set guioptions-=T

" This setting prevents vi from making its annoying beeps when a command doesn't work. Instead, it briefly flashes the screen -- much less annoying.
" set vb t_vb=

" This setting ensures that each window contains a statusline that displays the current cursor position.
set ruler

" By default, search matches are highlighted. I find this annoying most of the time. This option turns off search highlighting. You can always turn it back on with :set hls.
" set nohls
set hls

" With this nifty option, vim will search for text as you enter it. For instance, if you type /bob to search for bob, vi will go to the first "b" after you type the "b," to the first "bo" after you type the "o," and so on. It makes searching much faster, since if you pay attention you never have to enter more than the minimum number of characters to find your target location. Make sure that you press Enter to accept the match after vim finds the location you want.
"set incsearch

" By default, vim doesn't let the cursor stray beyond the defined text. This setting allows the cursor to freely roam anywhere it likes in command mode. It feels weird at first but is quite useful.
" set virtualedit=all

" set noic
" set ic
" set cursorline
syntax on

" to enable proper pasting
" set paste
" to enable searching for multiple works on same line
" eg /copy.*scp
" set magic

" use mouse to scroll up/down when using tmux
" set mouse=a
" if has("mouse_sgr")
"    set ttymouse=sgr
" else
"    set ttymouse=xterm2
" end

" func to swap two windows in a vi session
" To use (assuming your mapleader is set to \) you would:
" 1. Move to the window to mark for the swap via ctrl-w movement
" 2. Type \mw
" 3. Move to the window you want to swap
" 4. Type \pw

" function! MarkWindowSwap()
"    let g:markedWinNum = winnr()
" endfunction

" function! DoWindowSwap()
"    "Mark destination
"    let curNum = winnr()
"    let curBuf = bufnr( "%" )
"    exe g:markedWinNum . "wincmd w"
"    "Switch to source and shuffle dest->source
"    let markedBuf = bufnr( "%" )
"    "Hide and open so that we aren't prompted and keep history
"    exe 'hide buf' curBuf
"    "Switch to dest and shuffle source->dest
"    exe curNum . "wincmd w"
"    "Hide and open so that we aren't prompted and keep history
"    exe 'hide buf' markedBuf 
" endfunction

"nmap <silent> <leader>mw :call MarkWindowSwap()<CR>
"nmap <silent> <leader>pw :call DoWindowSwap()<CR>

" copied from arun for cscope 
"if has ("cscope")
"    set csprg=/router/bin/cscope
"    set csto=0
"    set cst
"    "cs add $PWD/cscope.out $PWD
"    set csverb
"endif

filetype on

" Mappings for interfacing w/ cscope stuff
" Ctrl-E (Searches) finds this C symbol
map <C-S> :cs find s <C-R>=expand("<cword>")<CR><CR>

" Ctrl-] finds the definition as if it were using tags
" map <C-]> :cs find g <C-R>=expand("<cword>")<CR><CR>

" Ctrl-K finds functions calling this function
map <C-K> :cs find c <C-R>=expand("<cword>")<CR><CR>

" Ctrl-A finds all instances of the text under cursor
" map <C-A> :cs find t <C-R>=expand("<cword>")<CR><CR>
map <C-A> :cs find c <C-R>=expand("<cword>")<CR><CR>

" Ctrl-J finds functions called by this function
map <C-J> :cs find d <C-R>=expand("<cword>")<CR><CR>

" Ctrl-I finds files including this file
map <C-I> :cs find i <C-R>=expand("<cfile>")<CR><CR>

" map <C-V> /<C-R>=expand("<cword>")<CR><CR>
map <S-V> ?<C-R>=expand("<cword>")<CR><CR>
map <C-X> :buffers<CR>

"To make ctrl c, ctrl v work
" vmap <C-c> "+yi
"vmap <C-x> "+c
"vmap <C-v> c<ESC>"+p
"imap <C-v> <C-r><C-o>+

"Hotkeys for ctags
map <F5> :TlistToggle<CR>
map <F6> :TlistUpdate<CR>
map <F8> :'a,'b w!~/t
map <Tab> <C-w>w
map <C-\>q :set cscopequickfix=s-,c-,d-,i-,t-,e-,f-
map <C-\>n :set cscopequickfix=""

"let $PATH = '/ws/pkunders-sjc/ctags-5.8:$PATH'


" set csprg=/router/bin/cscope
source ~/cscope_maps.vim
" tmux shows only half screen
"set term=xterm

"runtime=~/vim80/runtime/syntax/syntax.vim

" to show file name
set laststatus=2
set statusline+=%F\ %l\:%c

hi ModeMsg	guifg=goldenrod
hi Ignore	guifg=grey40
color desert
"colorscheme delek   
"colorscheme zellner
"colorscheme morning  
set backspace=indent,eol,start  " more powerful backspacing
