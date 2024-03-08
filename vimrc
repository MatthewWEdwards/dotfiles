set noswapfile
set ruler " Show cursor position at all times
set showcmd

" Text Mods   
set tabstop=4   
set shiftwidth=4   
set expandtab   

" Display mods   
set number " 'set nonumber' to unset this  
set relativenumber
set breakindent   
  
" Plugins   
filetype plugin on    
  
" Macros   
let @a = '0f=100i ^[8|dwjq' " places the second word in a line to column 8   
  
" Smart Indent  
set autoindent  
set smartindent  
imap <C-Return> <CR><CR><C-o>k<Tab>  
  
" Highlights 
set hlsearch 
  
" colors 
if &term =~ '256color' 
    " disable Background Color Erase (BCE) so that color schemes 
    " render properly when inside 256-color tmux and GNU screen.  
    " see also http://snk.tuxfamily.org/log/vim-256color-bce.html 
    set t_ut= 
endif 
colorscheme ron  
  
" Mouse 
set mouse=a " 'set mouse=' to disable mouse (enable dropdown menu) 

" Key bindings
:inoremap <C-c> <Esc> "Remap ctrl-c to Esc

" Directory management
"set autochdir

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Text column
set textwidth=100
set colorcolumn=+1

" Scroll in vim popup with jk
inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))

set paste
