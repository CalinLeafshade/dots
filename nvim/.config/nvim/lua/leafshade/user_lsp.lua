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


local attach = function(client)

  completion.on_attach(client)

end

lspconfig.lualsp.setup{on_attach=attach}
lspconfig.tsserver.setup{on_attach=attach}

