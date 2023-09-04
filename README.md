# markdown-togglecheck

Stupidly simple neovim plugin that toggles task list check boxes in markdown
using treesitter.

## Requirements

This plugin requires my other plugin -
[treesitter-utils](https://github.com/nfrid/treesitter-utils).

## Installation

Use your favorite package manager.

`lazy.nvim`:
```lua
{
  'nfrid/markdown-togglecheck',
  dependencies = { 'nfrid/treesitter-utils' },
  ft = { 'markdown' },
}
```

## Setup

You **don't need** to execute a setup function to use the defaults but in case you
want to redefine them, you can do it with `setup`:

```lua
require('markdown-togglecheck').setup({
  -- create empty checkbox on item without any while toggling
  create = true,
  -- remove checked checkbox instead of unckecking it while toggling
  remove = false,
})
```

## Usage

The plugin does not provide default keybindings.

You should define them yourself:

```lua
-- toggle checked / create checkbox if it doesn't exist
vim.keymap.set('n', '<leader>nn', require('markdown-togglecheck').toggle, { desc = 'Toggle Checkmark' });
-- toggle checkbox (it doesn't remember toggle state and always creates [ ])
vim.keymap.set('n', '<leader>nN', require('markdown-togglecheck').toggle_box, { desc = 'Toggle Checkbox' });
```

If you need dot repeat for this plugin you can use `operatorfunc` to bind the keys
(they'll work the same way but will provide . repeat functionality):

```lua
local function toggle()
    vim.go.operatorfunc = "v:lua.require'markdown-togglecheck'.toggle"
    return 'g@l'
end

local function toggle_box()
    vim.go.operatorfunc = "v:lua.require'markdown-togglecheck'.toggle_box"
    return 'g@l'
end

vim.keymap.set('n', '<leader>nn', toggle, { expr = true, desc = 'Toggle Checkmark' })
vim.keymap.set('n', '<leader>nN', toggle_box, { expr = true, desc = 'Toggle Checkbox' })
```

You also might add some highlight queries yourself for the check boxes. For
example:

```query
;; YOUR_CONFIG/after/queries/markdown/highlights.scm

; inherits: markdown

(task_list_marker_unchecked) @comment
(task_list_marker_checked) @function
```

## Todo

- replace treesitter-utils with new treesitter api
