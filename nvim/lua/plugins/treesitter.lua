return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local config = require("nvim-treesitter.configs")
            config.setup({
                ensure_installed = { "c", "lua", "python", "bash", "yaml", "json", "html", "css", "markdown", "markdown_inline" },
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    }
}
