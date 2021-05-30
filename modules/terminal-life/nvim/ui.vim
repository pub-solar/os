let g:base16_shell_path = $XDG_CONFIG_HOME . "/zsh/base16.sh"
let base16colorspace = 256
set termguicolors
let g:sonokai_style = 'shusia'
let g:sonokai_enable_italic = 1
let g:sonokai_disable_italic_comment = 1
let g:sonokai_transparent_background = 1
colorscheme sonokai
set background=dark

let g:airline#extensions#tabline#enabled = 1 " Enable the list of buffers
let g:airline#extensions#tabline#fnamemod = ':t' " Show just the filename
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_powerline_fonts = 1 " Use powerline fonts
let g:airline_theme = 'sonokai'

