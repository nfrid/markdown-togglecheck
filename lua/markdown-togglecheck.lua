local ts = require('nvim-treesitter.ts_utils')
local utils = require('treesitter-utils')

local M = {}

M.toggle = function()
  ---@type TSNode
  ---@diagnostic disable-next-line: assign-type-mismatch
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
    utils.set_node_text(checked, '[ ]')
    return
  end
end

return M
