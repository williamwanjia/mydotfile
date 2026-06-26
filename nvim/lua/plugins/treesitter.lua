return {
    -- {
    --     "nvim-treesitter/nvim-treesitter",
    --     branch = "main",
    --     build = ":TSUpdate",
    --     config = function()
    --         local config = require("nvim-treesitter.configs")
    --         config.setup({
    --             ensure_installed = { "c", "lua", "python", "bash", "yaml", "json", "html", "css", "markdown", "markdown_inline" },
    --             highlight = { enable = true },
    --             indent = { enable = true },
    --         })
    --     end
    -- }
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,             -- does not support lazy loading
        build = ":TSUpdate",
        main = "nvim-treesitter", -- updated module name
        init = function()
            -- Highlighting (replaces highlight = { enable = true })
            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    pcall(vim.treesitter.start)
                end,
            })

            -- Install parsers once, skip already-installed ones
            local ensure_installed = {
                "python", "lua", "bash", "c",
                "html", "css", "javascript", "typescript",
                "json", "yaml", "markdown", "markdown_inline",
                "vim", "vimdoc", "query",
            }
            local already_installed = require("nvim-treesitter.config").get_installed()
            local to_install = vim.tbl_filter(function(p)
                return not vim.tbl_contains(already_installed, p)
            end, ensure_installed)
            if #to_install > 0 then
                require("nvim-treesitter").install(to_install)
            end
        end,
    },

}
