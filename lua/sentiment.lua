local config = require("sentiment.config")
local manager = require("sentiment.config.manager")
local autocmd = require("sentiment.autocmd")
local ui = require("sentiment.ui")

local M = {}

---Load and setup the plugin with an optional config table.
---
---NOTE: Calling this disables the builtin matchparen plugin.
---
---@param cfg? Config User config to be applied.
function M.setup(cfg)
  vim.g.loaded_matchparen = 1
  manager.apply(cfg or {})

  if config.can_create_updater() then
    autocmd.create_updater(
      { "CursorMoved", "CursorMovedI" },
      function(args) ui.update(args.buf) end
    )
  end
end

return M
