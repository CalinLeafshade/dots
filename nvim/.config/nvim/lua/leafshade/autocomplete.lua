local execute = vim.api.nvim_command
local opt = vim.opt

execute [[ set shortmess+=c ]]

execute [[ inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>" ]]
execute [[ inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>" ]]
execute [[ imap <c-p> <Plug>(completion_trigger) ]]

opt.completeopt = {"menuone","noinsert","noselect"}


