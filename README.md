# markdown-togglecheck

Stupidly simple neovim plugin that toggles task list check boxes in markdown
using treesitter.

## Requirements

I've tested it only on `0.8` version.

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

You should define one for `require('markdown-togglecheck').toggle()`:

```lua
-- toggle checked / create checkbox if it doesn't exist
vim.api.nvim_set_keymap('n', '<leader>nn', require('markdown-togglecheck').toggle)
-- toggle checkbox (it doesn't remember toggle state and always creates [ ])
vim.api.nvim_set_keymap('n', '<leader>nN', require('markdown-togglecheck').toggle_box)
```

You also might add some highlight queries yourself for the check boxes. For
example:

```query
;; YOUR_CONFIG/after/queries/markdown/highlights.scm

; inherits: markdown

(task_list_marker_unchecked) @comment
(task_list_marker_checked) @function
```
