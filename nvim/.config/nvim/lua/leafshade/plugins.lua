local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'

-- Install packer if required
if fn.empty(fn.glob(install_path)) > 0 then
	execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end



execute [[ packadd packer.nvim ]]
execute [[ autocmd BufWritePost plugins.lua PackerCompile ]]


return require("packer").startup(function()

	use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
	}

	use {
		'nvim-lua/completion-nvim',
		{
			'neovim/nvim-lspconfig',
			config = function() require('leafshade.user_lsp') end
		}
	}

  use "ryuta69/elly.vim"

  use { "prettier/vim-prettier", run = "yarn install" }
  use "sheerun/vim-polyglot"
  use "digitaltoad/vim-pug"

  use 'euclidianAce/BetterLua.vim'
  use 'sainnhe/forest-night'
  use 'tjdevries/express_line.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'nvim-lua/lsp-status.nvim'

end)


