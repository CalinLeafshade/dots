local lspconfig = require "lspconfig"
local configs = require "lspconfig/configs"
local completion = require "completion"

if not configs.lualsp then
	configs.lualsp = {
		default_config = {
			cmd = {'lua-lsp'};
			filetypes = {'lua'};
			root_dir = function(fname)
				return lspconfig.util.find_git_ancestor(fname) or vim.loop.os_homedir()
			end;
			settings = {};
		}
	};
end

local function onCompleteDone()
  local bufnr = vim.api.nvim_get_current_buf()
  local completed_item_var = vim.v.completed_item
  print(vim.inspect(completed_item_var))
  if
    completed_item_var and
    completed_item_var.user_data and
    completed_item_var.user_data.lsp and
    completed_item_var.user_data.lsp.completion_item
   then
    local item = completed_item_var.user_data.lsp.completion_item
    vim.lsp.buf_request(bufnr, "completionItem/resolve", item, function(err, _, result)
      if err or not result then
        print(vim.inspect(err))
        return
      end
      print(vim.inspect(result))
      if result.additionalTextEdits then
        vim.lsp.util.apply_text_edits(result.additionalTextEdits, bufnr)
      end
    end)
  end
end

local function organizeImports()
  local context = { source = { organizeImports = true } }
  local params = vim.lsp.util.make_range_params()
  params.context = context

  vim.lsp.buf_request(0, "textDocument/codeAction", params, function(err, _, result)
    if err then
      print(vim.inspect(err))
      return
    end
    print(vim.inspect(result))
    if not result then return end
    result = result[1].result
    if not result then return end
    local edit = result[1].edit
    vim.lsp.util.apply_workspace_edit(edit)
  end)

end

local function onAttach(client, buf) 

  completion.on_attach(client)
  vim.api.nvim_command("autocmd CompleteDone <buffer> lua require('leafshade.user_lsp').onCompleteDone()")

end




lspconfig.lualsp.setup{on_attach=onAttach}
lspconfig.tsserver.setup{
  cmd = {
   "typescript-language-server",
   "--stdio"
   },
  on_attach = onAttach
}

return {
  onCompleteDone = onCompleteDone,
  organizeImports = organizeImports
}
