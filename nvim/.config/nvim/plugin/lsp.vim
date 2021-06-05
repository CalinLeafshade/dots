set completeopt=menuone,noinsert,noselect

nnoremap <leader>gd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>vi :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>vsh :lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>vrr :lua vim.lsp.buf.references()<CR>
nnoremap <leader>vrn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>gh :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>gca :lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>gf :lua vim.lsp.buf.formatting()<CR>
nnoremap <leader>gsd :lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <leader>gp :lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <leader>gn :lua vim.lsp.diagnostic.goto_next()<CR>

let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

set omnifunc=v:lua.vim.lsp.omnifunc

lua <<EOF

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

  local pid = vim.fn.getpid()
  local omnisharp_bin = "/usr/bin/omnisharp"

  lspconfig.omnisharp.setup{
      cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) };
  }

  lspconfig.tsserver.setup{ on_attach= completion.on_attach }
  lspconfig.lualsp.setup{ on_attach= completion.on_attach }
  lspconfig.graphql.setup{}

EOF
