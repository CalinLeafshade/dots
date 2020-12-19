--     __             __     _               _
--    / /  ___  __ _ / _|___| |__   __ _  __| | ___
--   / /  / _ \/ _` | |_/ __| '_ \ / _` |/ _` |/ _ \
--  / /__|  __/ (_| |  _\__ \ | | | (_| | (_| |  __/
--  \____/\___|\__,_|_| |___/_| |_|\__,_|\__,_|\___|
--
--  Filename:   init.lua
--  Github:     https://github.com/CalinLeafshade/dots/
--  Maintainer: Steve Poulton (Calin Leafshade)

local RELOAD = require("plenary.reload").reload_module

RELOAD("leafshade")

require("leafshade.globals")

local opt = vim.opt
local api = vim.api

vim.g.forest_night_transparent_background = 1

api.nvim_command [[ syntax enable ]]
api.nvim_command [[ colorscheme forest-night ]]

vim.g.mapleader = ","

opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.expandtab = true

opt.hidden = true
opt.number = true
opt.relativenumber = true
opt.showcmd = true
opt.cursorline = true
opt.showmatch = true
opt.autoindent = true
opt.cindent = true
opt.wrap = false
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.belloff = "all"
opt.mouse = "n"

opt.cmdheight = 2
opt.updatetime = 300

opt.incsearch = true
opt.hlsearch = false


require("leafshade.plugins")
require("leafshade.autocomplete")
require("leafshade.bindings")
require("leafshade.rename")

require("leafshade.telescope")
require("leafshade.telescope.mappings")

require("leafshade.status")

-- TODO find a better place for these

vim.g["prettier#config#single_quote"] = "false"
vim.g["prettier#config#trailing_comma"] = "none"
vim.g["prettier#autoformat"] = 0
api.nvim_command [[autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html Prettier]]

api.nvim_command [[nnoremap <leader>ev :e ~/.config/nvim/init.lua<CR>]]
api.nvim_command [[nnoremap <leader>sv :luafile ~/.config/nvim/init.lua<CR>]]

