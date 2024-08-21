vim.g.mapleader = ","

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- require("lazy").setup("plugins")

require("config.keymaps")

require("config.options")

vim.cmd.colorscheme "tokyonight"

require('gitsigns').setup()
