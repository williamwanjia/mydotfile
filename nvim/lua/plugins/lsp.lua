-- mini version
return {

    {
        "williamboman/mason.nvim",
        lazy = false,
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "pyright", "pylsp", "clangd" },
                -- automatic_installation = false,
                automatic_enable = false,
            })
        end,
        dependencies = {
            "williamboman/mason.nvim",
        },
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Use the new API if available (Neovim 0.11+)

            vim.lsp.config("clangd", {
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--completion-style=detailed",
                    "--header-insertion=never",
                },
            })

            vim.lsp.enable("pyright")
            vim.lsp.enable("lua_ls")
            vim.lsp.enable("clangd")

            -- === LSP Keymaps ===
            local opts = { noremap = true, silent = true }
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition", unpack(opts) })
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action", unpack(opts) })
        end,
    },
    {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        opts = {},
        config = function(_, opts)
            require("lsp_signature").setup(opts)
        end,
    },
    {
        "nvimtools/none-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "nvim-lua/plenary.nvim",
            "nvimtools/none-ls-extras.nvim",
        },
        config = function()
            local null_ls = require("null-ls")

            null_ls.setup({
                sources = {
                    require("none-ls.diagnostics.flake8"),
                },
            })
        end,
    },
    {
        "stevearc/aerial.nvim",
        event = "VeryLazy",
        config = function()
            require("aerial").setup({
                layout = {
                    default_direction = "right", -- opens on the right side
                    min_width = 30,
                    max_width = 40,
                },
                attach_mode = "window",                         -- reopen on window change
                backends = { "lsp", "treesitter", "markdown" }, -- which symbol providers to use
                show_guides = true,
                highlight_on_hover = true,
                autojump = false,
            })

            -- Optional: auto-open Aerial when LSP attaches
            -- vim.api.nvim_create_autocmd("LspAttach", {
            --     callback = function(args)
            --         local bufnr = args.buf
            --         local client = vim.lsp.get_client_by_id(args.data.client_id)
            --         require("aerial").on_attach(client, bufnr)
            --         -- require("aerial").attach(bufnr)
            --     end,
            -- })
        end,
        keys = {
            { "<leader>ao", "<cmd>AerialToggle!<CR>", desc = "Toggle Aerial Outline" },
            { "<leader>af", "<cmd>AerialFocus<CR>",   desc = "Focus Aerial" },
            { "[a",         "<cmd>AerialPrev<CR>",    desc = "Previous symbol" },
            { "]a",         "<cmd>AerialNext<CR>",    desc = "Next symbol" },
        },
    },

}
