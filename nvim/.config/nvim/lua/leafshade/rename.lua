
local function rename(name)

  local curfile = vim.fn.expand("%:p")
  local curfilepath = vim.fn.expand("%:p:h")
  local newname = curfilepath .. "/" .. name

  vim.api.nvim_command(" saveas " .. newname)

end

--vim.api.nvim_command [[command! -nargs=1 Rename :lua require("leafshade.rename")("<f-args>")]]
vim.api.nvim_command [[command! -nargs=1 Rename :call v:lua.require('leafshade.rename')(<f-args>) ]]

return rename

--[[command! -nargs=* -complete=file -bang Rename :call Rename("<args>", "<bang>")

function! Rename(name, bang)
    let l:curfile = expand("%:p")
    let l:curfilepath = expand("%:p:h")
    let l:newname = l:curfilepath . "/" . a:name
    let v:errmsg = ""
    silent! exec "saveas" . a:bang . " " . fnameescape(l:newname)
    if v:errmsg =~# '^$\|^E329'
        if expand("%:p") !=# l:curfile && filewritable(expand("%:p"))
            silent exec "bwipe! " . fnameescape(l:curfile)
            if delete(l:curfile)
                echoerr "Could not delete " . l:curfile
            endif
        endif
    else
        echoerr v:errmsg
    endif
endfunction

--]]
