-- Install packer
local execute = vim.api.nvim_command

local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

vim.api.nvim_exec(
	[[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]],
	false
)

local use = require("packer").use

require("packer").startup(function()
	use("wbthomason/packer.nvim") -- Package manager
	use("sainnhe/everforest")
	use("tpope/vim-fugitive") -- Git commands in nvim
	use("tpope/vim-commentary") -- "gc" to comment visual regions/lines
	use("tpope/vim-scriptease")
	use("kyazdani42/nvim-web-devicons")
	use("junegunn/goyo.vim")
	use("junegunn/limelight.vim")
	use("svermeulen/vimpeccable")
	use("digitaltoad/vim-pug")
	use("sbdchd/neoformat")
	use("rafamadriz/friendly-snippets")
	use("vimwiki/vimwiki")
  use("p00f/nvim-ts-rainbow")
	use("ElPiloto/telescope-vimwiki.nvim")
  use("ellisonleao/glow.nvim")
  use({'kkoomen/vim-doge', run = function() vim.fn['doge#install()']() end })
  use {
    's1n7ax/nvim-window-picker',
    config = function()
        require'window-picker'.setup()
    end,
  }
  use {
  "folke/todo-comments.nvim",
  requires = "nvim-lua/plenary.nvim",
  config = function()
    require("todo-comments").setup()
  end
}

  -- DAP
  use 'mfussenegger/nvim-dap'



	use("windwp/nvim-autopairs")
	use("ThePrimeagen/harpoon")

	-- Rust
	use("rust-lang/rust.vim")

	-- Treesitter
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("nvim-treesitter/playground")

	-- JS/TS

	use("leafgarland/typescript-vim")
	use("peitalin/vim-jsx-typescript")
	use("jose-elias-alvarez/nvim-lsp-ts-utils")
	use("jose-elias-alvarez/null-ls.nvim")
	--use 'styled-components/vim-styled-components'

	-- LSP
	use("ray-x/lsp_signature.nvim")

	--- Generic syntax
	use({ "potatoesmaster/i3-vim-syntax" })

	use({
		"phaazon/hop.nvim",
		as = "hop",
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		end,
	})

use {
	"SmiteshP/nvim-gps",
	requires = "nvim-treesitter/nvim-treesitter"
}

	-- UI to select things (files, grep results, open buffers...)
	use({ "nvim-telescope/telescope.nvim", requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } } })
	use("nvim-telescope/telescope-file-browser.nvim")
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use("itchyny/lightline.vim") -- Fancier statusline

	-- Add indentation guides even on blank lines
	use({ "lukas-reineke/indent-blankline.nvim" })

	-- Add git related info in the signs columns and popups
	use("neovim/nvim-lspconfig") -- Collection of configurations for built-in LSP client
	use({ "L3MON4D3/LuaSnip" })
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"onsails/lspkind-nvim",
			"saadparwaiz1/cmp_luasnip",
		},
	})
end)

local opt = vim.opt



--Incremental live completion
opt.inccommand = "nosplit"

--Set highlight on search
opt.ignorecase = true
opt.smartcase = true
opt.equalalways = true
opt.updatetime = 1000
opt.scrolloff = 10
opt.hlsearch = false
opt.incsearch = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.autoindent = true
opt.cindent = true
opt.wrap = true
opt.expandtab = true
opt.swapfile = false
opt.formatoptions = opt.formatoptions
	- "a" -- Auto formatting is BAD.
	- "t" -- Don't auto format my code. I got linters for that.
	+ "c" -- In general, I like it when comments respect textwidth
	+ "q" -- Allow formatting comments w/ gq
	- "o" -- O and o, don't continue comments
	+ "r" -- But do continue when pressing enter.
	+ "n" -- Indent past the formatlistpat, not underneath it.
	+ "j" -- Auto-remove comments if possible.
	- "2" -- I'm not in gradeschool anymore

--Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

--Do not save when switching buffers
opt.hidden = true

--Enable mouse mode
opt.mouse = "a"

--Enable break indent
opt.breakindent = true

--Save undo history
vim.cmd([[set undofile]])

vim.cmd([[
set guifont=Cascadia\ Code:h14
]])

vim.cmd([[set path+=/usr/share/cc65/include]])

require("nvim-gps").setup()

_G.gps_location = function()
  local gps = require "nvim-gps"
  return gps.is_available() and gps.get_location() or ""
end
vim.opt.winbar = "%{%v:lua.gps_location()%}"

--Case insensitive searching UNLESS /C or capital in search
opt.ignorecase = true
opt.smartcase = true

--Decrease update time
opt.updatetime = 250
vim.wo.signcolumn = "yes"

--Set colorscheme (order is important here)
opt.termguicolors = true
opt.background = "dark"
vim.cmd([[colorscheme everforest]])

require("nvim-autopairs").setup({})
require'window-picker'.setup()

--Set statusbar
vim.g.lightline = {
	colorscheme = "everforest",
	active = { left = { { "mode", "paste" }, { "gitbranch", "readonly", "filename", "modified" } } },
	component_function = { gitbranch = "fugitive#head" },
}

--Remap comma as leader key
vim.g.mapleader = ","
vim.g.maplocalleader = ","

local vimp = require("vimp")
local telescope = require("telescope")
local builtin = require("telescope.builtin")
local hop = require("hop")
require("telescope").load_extension("vimwiki")

--Remap for dealing with word wrap
vim.api.nvim_set_keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

vimp.nnoremap("<leader>s", function()
	hop.hint_words()
end)
vimp.nnoremap({ "silent" }, "<leader>r", ':silent exec "!love ."<CR>')
vimp.inoremap({ "expr" }, "<M-f>", "expand('%:t:r')")

-- DAP
local dap = require("dap");

dap.adapters.node2 = {
  type = "executable",
  command = "node-debug"
}

dap.configurations.typescript = {
  {
    type = "node2",
    request = "attach",
    name = "Attach Program",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    skipFiles = { "<node_internals>/**" },
    port = 9229
  }
}

vimp.nnoremap("<leader>db", function() dap.toggle_breakpoint() end)
vimp.nnoremap("<leader>dc", function() dap.continue() end)
vimp.nnoremap("<leader>ds", function() dap.step_over() end)
vimp.nnoremap("<leader>di", function() dap.step_into() end)

-- Harpoon

local hui = require("harpoon.ui")
local mark = require("harpoon.mark")

vimp.nnoremap("<leader>vw", function()
	require("telescope").extensions.vimwiki.vimwiki()
end)

vimp.nnoremap("<leader>hh", function()
	hui.toggle_quick_menu()
end)
vimp.nnoremap("<leader>ha", function()
	mark.add_file()
end)
vimp.nnoremap("<leader>j", function()
	hui.nav_file(1)
end)
vimp.nnoremap("<leader>k", function()
	hui.nav_file(2)
end)
vimp.nnoremap("<leader>l", function()
	hui.nav_file(3)
end)
vimp.nnoremap("<leader>;", function()
	hui.nav_file(4)
end)

vimp.nnoremap("<leader>t", function()
  local picked_window_id = require('window-picker').pick_window()
  vim.api.nvim_set_current_win(picked_window_id)
end)

--Map blankline
vim.g.indent_blankline_char = "┊"
vim.g.indent_blankline_filetype_exclude = { "help", "packer" }
vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
vim.g.indent_blankline_char_highlight = "LineNr"

-- Treesitter

require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
	},
  indent = {
    enable = true
  },
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
	playground = {
		enable = true,
		disable = {},
		updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
		persist_queries = false, -- Whether the query persists across vim sessions
		keybindings = {
			toggle_query_editor = "o",
			toggle_hl_groups = "i",
			toggle_injected_languages = "t",
			toggle_anonymous_nodes = "a",
			toggle_language_display = "I",
			focus_language = "f",
			unfocus_language = "F",
			update = "R",
			goto_node = "<cr>",
			show_help = "?",
		},
	},
})

-- Telescope
telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<C-u>"] = false,
				["<C-d>"] = false,
			},
		},
		layout_strategy = "vertical",
		file_ignore_patterns = { "node_modules" },
		generic_sorter = require("telescope.sorters").get_fzy_sorter,
		file_sorter = require("telescope.sorters").get_fzy_sorter,
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = false, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
		file_browser = {
			theme = "ivy",
			mappings = {
				["i"] = {
					-- your custom insert mode mappings
				},
				["n"] = {
					-- your custom normal mode mappings
				},
			},
		},
	},
})

telescope.load_extension("fzf")
telescope.load_extension("file_browser")

local fileBrowser = require("telescope").extensions.file_browser.file_browser

vimp.nnoremap({ "silent" }, "<leader>ff", function()
	builtin.find_files()
end)
vimp.nnoremap({ "silent" }, "<leader>fp", function()
  require("leafshade.telescope").projects()
end)
vimp.nnoremap({ "silent" }, "<leader>fb", function()
	fileBrowser({ path = "%:p:h" })
end)
vimp.nnoremap({ "silent" }, "<leader>fh", function()
	builtin.find_files({ hidden = true })
end)

-- Highlight on yank
vim.api.nvim_exec(
	[[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
	false
)

-- Goyo
vim.api.nvim_exec("autocmd! User GoyoEnter Limelight", false)
vim.api.nvim_exec("autocmd! User GoyoLeave Limelight", false)

vim.api.nvim_set_var("neoformat_only_msg_on_error", 1)

-- Prettier
vim.api.nvim_exec(
	"autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html Neoformat prettier",
	false
)

vim.api.nvim_exec("autocmd BufWritePre *.cs | Format", false)

vim.api.nvim_exec([[autocmd FileType cs nnoremap <buffer><silent><leader>r :silent exec "!dotnet run"<CR>]], false)
-- Y yank until the end of line
vim.api.nvim_set_keymap("n", "Y", "y$", { noremap = true })

-- LSP settings
local nvim_lsp = require("lspconfig")

local on_attach = function(_, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

--vimp.nmap("<leader>d", '"_d')
--vimp.nmap("<leader>c", '"_c')

vimp.nnoremap({ "silent" }, "<leader>ev", ":e $MYVIMRC<CR>")

vimp.nnoremap({ "silent" }, "<leader>gd", vim.lsp.buf.declaration)
vimp.nnoremap({ "silent" }, "<leader>gh", vim.lsp.buf.definition)
vimp.nnoremap({ "silent" }, "K", vim.lsp.buf.hover)
vimp.nnoremap({ "silent" }, "<C-k>", vim.lsp.buf.signature_help)
vimp.nnoremap({ "silent" }, "<leader>gca", vim.lsp.buf.code_action)
vimp.nnoremap({ "silent" }, "<leader>gsd", vim.lsp.diagnostic.show_line_diagnostics)
vimp.nnoremap({ "silent" }, "<leader>q", vim.lsp.diagnostic.set_loclist)
vimp.nnoremap({ "silent" }, "[d", vim.lsp.diagnostic.goto_prev)
vimp.nnoremap({ "silent" }, "]d", vim.lsp.diagnostic.goto_next)

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

--[[ local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.eslint_d, -- eslint or eslint_d
        null_ls.builtins.code_actions.eslint_d, -- eslint or eslint_d
        null_ls.builtins.formatting.prettier -- prettier, eslint, eslint_d, or prettierd
    },
})
--]]

-- Lua
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require("lsp_signature").setup()

nvim_lsp.sumneko_lua.setup({
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = runtime_path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim", "love" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})

-- TSServer
nvim_lsp.tsserver.setup({
	flags = {
		debounce_text_changes = 500,
	},
	capabilities = capabilities,
	init_options = require("nvim-lsp-ts-utils").init_options,
	on_attach = function(client, bufnr)
		local ts_utils = require("nvim-lsp-ts-utils")

		-- defaults
		ts_utils.setup({
			debug = false,
			disable_commands = false,
			enable_import_on_completion = true,

			-- import all
			import_all_timeout = 5000, -- ms
			-- lower numbers = higher priority
			import_all_priorities = {
				same_file = 1, -- add to existing import statement
				local_files = 2, -- git files or files with relative path markers
				buffer_content = 3, -- loaded buffer content
				buffers = 4, -- loaded buffer names
			},
			import_all_scan_buffers = 100,
			import_all_select_source = false,

			-- filter diagnostics
			filter_out_diagnostics_by_severity = {},
			filter_out_diagnostics_by_code = {},

			-- inlay hints
			auto_inlay_hints = false,
			inlay_hints_highlight = "Comment",

			-- update imports on file move
			update_imports_on_move = false,
			require_confirmation_on_move = false,
			watch_dir = nil,
		})

		-- required to fix code action ranges and filter diagnostics
		ts_utils.setup_client(client)

		-- no default maps, so you may want to define some here
		local opts = { silent = true }
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":TSLspRenameFile<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", opts)
	end,
})
nvim_lsp.clangd.setup({ on_attach = on_attach })
nvim_lsp.rust_analyzer.setup({ on_attach = on_attach })

-- OmniSharp
local pid = vim.fn.getpid()
local omnisharp_bin = "/usr/bin/omnisharp"

nvim_lsp.omnisharp.setup({
	on_attach = on_attach,
	cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) },
})

-- Map :Format to vim.lsp.buf.formatting()
vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])

local check_back_space = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
-- Cmpsetup
local cmp = require("cmp")

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	formatting = {
		format = function(entry, vim_item)
			-- fancy icons and a name of kind
			vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind

			-- set a name for each source
			vim_item.menu = ({
				buffer = "[Buffer]",
				nvim_lsp = "[LSP]",
				luasnip = "[LuaSnip]",
				nvim_lua = "[Lua]",
				latex_symbols = "[Latex]",
			})[entry.source.name]
			return vim_item
		end,
	},
	mapping = {
    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-e>"] = cmp.mapping.close(),
		["<c-y>"] = cmp.mapping(
			cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Insert,
				select = true,
			}),
			{ "i", "c" }
		),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<c-q>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
	},
  sorting = {
    comparators = {
      --cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.scopes,
      cmp.config.compare.locality,
      cmp.config.compare.score,
      cmp.config.compare.kind,
      --cmp.config.compare.sort_text,
      --cmp.config.compare.length,
      --cmp.config.compare.order,
    },
  },
	sources = cmp.config.sources({
		{ name = "luasnip" },
		{ name = "nvim_lsp" },
		{
			name = "path",
		},
		{ name = "buffer", keyword_length = 5, max_item_count = 5 }
	}),
	experimental = {
		native_menu = false,
	},
})

