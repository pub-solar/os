" Happy yaml configuration
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

let g:gutentags_file_list_command = 'git ls-files'

" quick-scope
" https://github.com/unblevable/quick-scope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Golang
" Go test, Def, Decls shortcut
nmap <Leader>got :GoTest<CR>:botright copen<CR>
autocmd FileType go nmap gd :GoDef<CR>
autocmd FileType go nmap gD :GoDecls<CR>

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

" netrw
let g:netrw_fastbrowse=0

" Auto-FMT rust code on save
let g:rustfmt_autosave = 1

" Indenting in html template tags
let g:html_indent_style1 = "inc"

" yank highlight duration
let g:highlightedyank_highlight_duration = 200

" Markdown options
let g:vim_markdown_folding_disabled = 1

" Haskell options
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

" Emmet
let g:user_emmet_leader_key='<c-n>'

" Ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

