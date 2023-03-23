local Autocmd = require("sentiment.Autocmd")
local ui = require("sentiment.ui")

local M = {}

local timer = nil

local renderer = Autocmd.new({
  name = "renderer",
  desc = "Render pair",
  events = {
    "BufWinEnter",
    "WinScrolled",
    "ModeChanged",
    "CursorMoved",
    "CursorMovedI",
  },
  callback = function() timer = ui.render() end,
})

---Start rendering pairs.
function M.start_rendering()
  if renderer:exists() then return end

  for _, win in ipairs(vim.api.nvim_list_wins()) do
    timer = ui.render(win)
  end

  renderer:create()
end

---Stop rendering pairs.
function M.stop_rendering()
  if not renderer:exists() then return end

  renderer:remove()
  if timer ~= nil and timer:is_active() then timer:close() end

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    ui.clear(buf)
  end
end

return M
