vim.cmd [[  packadd lsp-status.nvim ]]

local RELOAD = require('plenary.reload').reload_module

RELOAD('el')
require('el').reset_windows()

local builtin = require('el.builtin')
local extensions = require('el.extensions')
local sections = require('el.sections')
local subscribe = require('el.subscribe')

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
      "%f"
    }

end

require('el').setup { generator = generator }
