local execute = vim.api.nvim_command

-- lsp mappings
execute [[ nnoremap <leader>gd    <cmd>lua vim.lsp.buf.declaration()<cr> ]]
execute " nnoremap <c-]> <cmd>lua vim.lsp.buf.definition()<cr> "
execute [[ nnoremap K     <cmd>lua vim.lsp.buf.hover()<cr> ]]
execute [[ nnoremap <leader>J     <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr> ]]
execute [[ nnoremap <leader>gD    <cmd>lua vim.lsp.buf.implementation()<cr> ]]
execute [[ nnoremap <leader>1gD   <cmd>lua vim.lsp.buf.type_definition()<cr> ]]
execute [[ nnoremap <leader>gr    <cmd>lua vim.lsp.buf.references()<cr> ]]
execute [[ nnoremap <leader>gn    <cmd>lua vim.lsp.buf.rename()<cr> ]]
execute [[ nnoremap <leader>g0    <cmd>lua vim.lsp.buf.document_symbol()<cr> ]]
execute [[ nnoremap <leader>gW    <cmd>lua vim.lsp.buf.workspace_symbol()<cr> ]]
execute [[ nnoremap <leader>ga    <cmd>lua vim.lsp.buf.code_action()<cr>]]
execute [[ nnoremap <leader>go    <cmd>lua require('leafshade.user_lsp').organizeImports()<cr>]]

execute [[ map <leader> <Plug>(easymotion-prefix)]]
execute [[ map <leader>j <Plug>(easymotion-j)]]
execute [[ map <leader>k <Plug>(easymotion-k)]]

execute [[ imap <silent> <c-Space> <Plug>(completion_trigger) ]]

execute [[ autocmd BufWritePost *termite/config silent! !killall -USR1 termite ]]
