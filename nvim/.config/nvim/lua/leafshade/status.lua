vim.cmd [[  packadd lsp-status.nvim ]]

local lsp_status = require("lsp-status");

lsp_status.config {
    select_symbol = function(cursor_pos, symbol)
      if symbol.valueRange then
        local value_range = {
          ["start"] = {
            character = 0,
            line = vim.fn.byte2line(symbol.valueRange[1])
          },
          ["end"] = {
            character = 0,
            line = vim.fn.byte2line(symbol.valueRange[2])
          }
        }

        return require("lsp-status.util").in_range(cursor_pos, value_range)
      end
    end,

    indicator_errors = '',
    indicator_warnings = '',
    indicator_info = '🛈',
    indicator_hint = '!',
    indicator_ok = '',
    spinner_frames = {'⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷'},
  }

lsp_status.register_progress()


local function lspProgress(_, buffer)

  local buffer_clients = vim.lsp.buf_get_clients(buffer.bufnr)
  local buffer_client_set = {}
  for _, v in pairs(buffer_clients) do
    buffer_client_set[v.name] = true
  end

  local all_messages = lsp_status.messages()

  do
    return #all_messages
  end

  for _, msg in ipairs(all_messages) do
    if msg.name and buffer_client_set[msg.name] then
      local contents
      if msg.progress then
        contents = msg.title
        if msg.message then
          contents = contents .. ' ' .. msg.message
        end

        if msg.percentage then
          contents = contents .. ' (' .. msg.percentage .. ')'
        end

         if msg.spinner then
           contents = config.spinner_frames[(msg.spinner % #config.spinner_frames) + 1] .. ' ' .. contents
         end
      elseif msg.status then
        contents = msg.content
      else
        contents = msg.content
      end

      return ' ' .. contents .. ' '
    end
  end

end


local RELOAD = require('plenary.reload').reload_module

RELOAD('el')
require('el').reset_windows()

local builtin = require('el.builtin')
local extensions = require('el.extensions')
local sections = require('el.sections')
local subscribe = require('el.subscribe')
local lsp_statusline = require('el.plugins.lsp_status')

local fileIcon = subscribe.buf_autocmd(
      "el_file_icon",
      "BufRead",
      function(_, buffer)
        return " " .. extensions.file_icon(_, buffer) .. " "
      end
    )

local generator = function()


    return {
      extensions.gen_mode { format_string = " %s " },
      fileIcon,
      "%f",
      sections.split,
      function()
        return lsp_status.status()
      end
    }

end

require('el').setup { generator = generator }
