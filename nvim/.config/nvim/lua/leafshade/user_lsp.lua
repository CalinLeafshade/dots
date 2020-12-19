local lspconfig = require "lspconfig"
local configs = require "lspconfig/configs"
local completion = require "completion"
local lsp_status = require("lsp-status")

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


local attach = function(client,bufnr)
  completion.on_attach()
  lsp_status.on_attach(client)
  --vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end

local configs = { "lualsp", "tsserver" }

for i,v in ipairs(configs) do
  local config = lspconfig[v]
  config.capabilities = vim.tbl_extend('keep', config.capabilities or {}, lsp_status.capabilities)
  config.setup{
    on_attach=completion.on_attach
  }
end

