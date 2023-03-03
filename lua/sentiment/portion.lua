---@class Portion
---@field private win window
---@field private buf buffer
---@field private viewport tuple<integer, integer>
---@field private lines string[]
---@field private cursor tuple<integer, integer>
local Portion = {}

function Portion.new(win)
  local instance = setmetatable({}, { __index = Portion })

  instance.win = win
  instance.buf = vim.api.nvim_win_get_buf(instance.win)
  instance.viewport = {
    vim.fn.line("w0", instance.win),
    vim.fn.line("w$", instance.win),
  }
  instance.lines = vim.api.nvim_buf_get_lines(
    instance.buf,
    instance.viewport[1] - 1,
    instance.viewport[2],
    true
  )
  instance.cursor = vim.api.nvim_win_get_cursor(instance.win)
  instance.cursor[2] = instance.cursor[2] + 1

  return instance
end

function Portion:iter(reverse)
  local coefficient = reverse and -1 or 1

  local cursor = vim.deepcopy(self.cursor)
  cursor[2] = cursor[2] - coefficient

  return function()
    local line = self.lines[cursor[1] - self.viewport[1] + 1]
    cursor[2] = cursor[2] + coefficient
    if reverse and (cursor[2] < 1) or (cursor[2] > #line) then
      cursor[1] = cursor[1] + coefficient
      if
        reverse and (cursor[1] < self.viewport[1])
        or (cursor[1] > self.viewport[2])
      then
        return nil
      end

      line = self.lines[cursor[1] - self.viewport[1] + 1]
      cursor[2] = reverse and #line or 1
    end

    return cursor, line:sub(cursor[2], cursor[2])
  end
end

return Portion
