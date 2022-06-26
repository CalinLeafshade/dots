local finders = require "telescope.finders"
local conf = require("telescope.config").values
local pickers = require "telescope.pickers"
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local projectsPicker = function(opts)

  local projects = {
    "~/repos/coaching-culture/",
    "~/repos/videoworks/",
    "~/repos/aika/",
    "~/repos/oak-stack/",
    "~/repos/pixyl/",
    "~/repos/climbr"
  }

  pickers.new(opts, {
    prompt_title = "Projects",
    finder = finders.new_table {
      results = projects,
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        if selection == nil then
          print "[telescope] Nothing currently selected"
          return
        end

        actions.close(prompt_bufnr)
        vim.cmd("chdir " .. selection[1])
        print("Active directory changed")
      end)
      return true
    end,
  }):find()
end

return {
  projects = projectsPicker
}
