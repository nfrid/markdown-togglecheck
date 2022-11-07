# markdown-togglecheck

Stupidly simple neovim plugin that toggles task list check boxes in markdown
using treesitter.

## Requirements

I've tested it only on `0.8` version.

The plugin requires my other plugin - `treesitter-utils`.

## Installation

Use your favorite package manager. Mine is `packer.nvim`:

```lua
use({
  'NFrid/markdown-togglecheck',
  requires = 'NFrid/treesitter-utils',
})
```

## Usage

The plugin does not provide default keybindings.

You should define one for `require('markdown-togglecheck').toggle()`:

```lua
vim.api.nvim_set_keymap('n', '<leader>nn', require('markdown-togglecheck').toggle)
```
