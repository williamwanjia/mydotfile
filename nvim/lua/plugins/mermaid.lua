return {
    {
        "kevalin/mermaid.nvim",
        -- dependencies = { { "nvim-treesitter/nvim-treesitter", branch = "main" }, },
        config = function()
            require("mermaid").setup()

            -- Install the Tree-sitter parser:
            -- :TSInstall mermaid
        end,
    },
}
