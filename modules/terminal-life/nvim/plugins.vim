" Happy yaml configuration
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Golang
" Go test shortcut
nmap <Leader>got :GoTest<CR>

" Go formatting
autocmd FileType go setlocal noexpandtab shiftwidth=4 tabstop=4 softtabstop=4 nolist

" vim-go disable text-objects
let g:go_textobj_enabled = 0

" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0

" GitGutter and vim Magit
" inspired by: https://jakobgm.com/posts/vim/git-integration/
" Don't map gitgutter keys automatically, set them ourselves
let g:gitgutter_map_keys = 0

" Jump between hunks
nmap <Leader>gn <Plug>(GitGutterNextHunk)  " git next
nmap <Leader>gp <Plug>(GitGutterPrevHunk)  " git previous

" Hunk-add and hunk-revert for chunk staging
nmap <Leader>ga <Plug>(GitGutterStageHunk)  " git add (chunk)
nmap <Leader>gu <Plug>(GitGutterUndoHunk)   " git undo (chunk)

" Open vimagit pane
nnoremap <leader>gs :Magit<CR>       " git status

" Push to remote
nnoremap <leader>gP :! git push<CR>  " git Push

" Quick conflict resolution in git mergetool nvim
" http://vimcasts.org/episodes/fugitive-vim-resolving-merge-conflicts-with-vimdiff/
nmap <Leader>[ :diffget //2<CR>
nmap <Leader>] :diffget //3<CR>
