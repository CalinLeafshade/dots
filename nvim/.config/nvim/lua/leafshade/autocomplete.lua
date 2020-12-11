local execute = vim.api.nvim_command
local opt = vim.opt

execute [[ set shortmess+=c ]]

execute [[ inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>" ]]
execute [[ inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>" ]]

opt.completeopt = {"menuone","noinsert","noselect"}

