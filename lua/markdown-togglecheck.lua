local ts = require('nvim-treesitter.ts_utils')
local utils = require('treesitter-utils')

local M = {}

---@class ToggleCheckOptions
---@field create boolean
---@field remove boolean

---@type ToggleCheckOptions
M.opts = {
  create = true,
  remove = false,
}

---@param opts ToggleCheckOptions
M.setup = function(opts)
  M.opts = vim.tbl_deep_extend('force', M.opts, opts or {})
end

M.toggle_box = function()
  local node = ts.get_node_at_cursor(nil, true)
  local item = utils.find_parent_node(node, 'list_item')
  if (not item) then
    return
  end

  local unchecked = utils.find_child_node(item, 'task_list_marker_unchecked')
  local checked = utils.find_child_node(item, 'task_list_marker_checked')
  local box = checked or unchecked

  if box then
    utils.set_node_text(box, {})
    local marker = item:child()
    utils.set_node_text(marker, utils.get_node_text(marker):sub(1, 1))
    return
  end

  local content = utils.find_child_node(item, 'paragraph')
  if not content then return end
  local text = utils.get_node_text(content)

  text[1] = '[ ] ' .. text[1]
  utils.set_node_text(content, text)
end

M.toggle = function()
  local node = ts.get_node_at_cursor(nil, true)
  local item = utils.find_parent_node(node, 'list_item')
  if (not item) then
    return
  end

  local unchecked = utils.find_child_node(item, 'task_list_marker_unchecked')
  if unchecked then
    utils.set_node_text(unchecked, '[x]')
    return
  end

  local checked = utils.find_child_node(item, 'task_list_marker_checked')
  if checked then
    if M.opts.remove then
      M.toggle_box()
    else
      utils.set_node_text(checked, '[ ]')
    end
    return
  end

  if M.opts.create then
    M.toggle_box()
  end
end

return M
