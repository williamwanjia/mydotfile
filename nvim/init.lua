vim.g.mapleader = ","


-- Treat .urdf files as XML
vim.filetype.add({
    extension = {
        urdf = "xml",
        sdf = "xml",
    },
})


-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- require("lazy").setup("plugins")

require("config.keymaps")

require("config.options")

vim.cmd.colorscheme "tokyonight"

require('gitsigns').setup()
