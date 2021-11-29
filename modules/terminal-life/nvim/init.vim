set nocompatible              " be iMproved, required
filetype indent plugin on                  " required

set modeline
set modelines=1
set nowrap

set viminfo='100,<100,s20 " vim file history

set hidden

set expandtab
set shiftwidth=2
set number
set relativenumber

set undolevels=1000
set undoreload=10000

set updatetime=300

let mapleader = " "

nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>
vmap <c-s> <Esc><c-s>gv

noremap <leader>y "+y
noremap <leader>p "+p

noremap i <Up>
noremap j <Left>
noremap k <Down>
noremap h i

vnoremap K L
vnoremap I H
vnoremap H I

nnoremap K L
nnoremap I H
nnoremap H I

map <c-w>i :wincmd k<CR>
map <c-w>j :wincmd h<CR>
map <c-w>k :wincmd j<CR>
map <c-w>l :wincmd l<CR>

map <c-w>I :wincmd K<CR>
map <c-w>J :wincmd H<CR>
map <c-w>K :wincmd J<CR>
map <c-w>L :wincmd L<CR>

" replay macro for each line of a visual selection
xnoremap @q :normal @q<CR>
xnoremap @@ :normal @@<CR>

" reselect and re-yank any text that is pasted in visual mode
xnoremap p pgvy

" Escape overwrite
inoremap jj <Esc>

" Open new buffer
nmap <leader>T :enew<cr>

" Move to the next buffer
nmap <leader>l :bnext<CR>

" Move to the previous buffer
nmap <leader>j :bprevious<CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>q :bp <BAR> bd #<CR>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

nmap <c-p> :Files<CR>
imap <c-p> <ESC>:Files<CR>

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Clear quickfix shortcut
nmap <Leader>c :ccl<CR>

" Remember cursor position
" Vim jumps to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

