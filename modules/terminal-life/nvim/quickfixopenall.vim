"Usage:
"   1. Perform a vimgrep search
"       :vimgrep /def/ *.rb
"   2. Issue QuickFixOpenAll command
"       :QuickFixOpenAll
function!   QuickFixOpenAll()
    if empty(getqflist())
        return
    endif
    let s:prev_val = ""
    for d in getqflist()
        let s:curr_val = bufname(d.bufnr)
        if (s:curr_val != s:prev_val)
            exec "edit " . s:curr_val
        endif
        let s:prev_val = s:curr_val
    endfor
endfunction

command! QuickFixOpenAll call QuickFixOpenAll()
