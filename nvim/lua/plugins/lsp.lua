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
                ensure_installed = { "lua_ls", "pyright", "pylsp", "black", "flake8" },
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
            local lspconfig = require("lspconfig")
            lspconfig.pyright.setup({ capabilities = capabilities })
            lspconfig.lua_ls.setup({ capabilities = capabilities })
            -- lspconfig.pylsp.setup({
            --     capabilities = capabilities,
            --     settings = {
            --         pylsp = {
            --             plugins = {
            --                 pycodestyle = {
            --                     maxLineLength = 90,
            --                 },
            --             },
            --         },
            --     },
            -- })
            -- require("lspconfig").esbonio.setup({
            --     -- on_attach = on_attach,       -- your existing LSP on_attach
            --     capabilities = capabilities, -- from cmp_nvim_lsp if using completion
            -- })

            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
            vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
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
    }

}

-- Copied somewhere onine, not fully understand yet
-- return {
--
--   { "neovim/nvim-lspconfig",
--     dependencies = {
--       "williamboman/mason.nvim",
--       "williamboman/mason-lspconfig.nvim"
--     },
--     config = function()
--       local capabilities = vim.lsp.protocol.make_client_capabilities()
--       capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
--       require('mason').setup()
--       local mason_lspconfig = require('mason-lspconfig')
--       mason_lspconfig.setup {
--           ensure_installed = { "pyright", "lua_ls"}
--       }
--       require("lspconfig").pyright.setup {
--           capabilities = capabilities,
--       }
--       require("lspconfig").lua_ls.setup({})
--     end
--   },
--
--   { "hrsh7th/nvim-cmp",
--     dependencies = {
--       "hrsh7th/cmp-nvim-lsp",
--       "hrsh7th/cmp-buffer",
--       "L3MON4D3/LuaSnip",
--       "saadparwaiz1/cmp_luasnip",
--       "rafamadriz/friendly-snippets",
--     },
--     config = function()
--       local has_words_before = function()
--         unpack = unpack or table.unpack
--         local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--         return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
--       end
--       local cmp = require('cmp')
--       local luasnip = require('luasnip')
--       require("luasnip/loaders/from_vscode").lazy_load()
--       vim.opt.completeopt = "menu,menuone,noselect"
--       cmp.setup({
--         snippet = {
--           expand = function(args)
--             luasnip.lsp_expand(args.body)
--           end
--         },
--         completion = {
--           autocomplete = false
--         },
--         mapping = cmp.mapping.preset.insert ({
--           ["<Tab>"] = cmp.mapping(function(fallback)
--             if cmp.visible() then
--               cmp.select_next_item()
--             elseif luasnip.expand_or_jumpable() then
--               luasnip.expand_or_jump()
--             elseif has_words_before() then
--               cmp.complete()
--             else
--               fallback()
--             end
--           end, { "i", "s" }),
--           ["<s-Tab>"] = cmp.mapping(function(fallback)
--             if cmp.visible() then
--               cmp.select_prev_item()
--             elseif luasnip.jumpable(-1) then
--               luasnip.jump(-1)
--             else
--               fallback()
--             end
--           end, { "i", "s" }),
--           ["<c-e>"] = cmp.mapping.abort(),
--           ["<CR>"] = cmp.mapping.confirm({ select=true }),
--         }),
--         -- sources for autocompletion
--         sources = cmp.config.sources({
--           { name = "nvim_lsp" }, -- LSP
--           { name = "luasnip" }, -- snippets
--           { name = "buffer" }, -- text within the current buffer
--           { name = "path" }, -- file system paths
--         })
--       })
--     end
--   },
--   {
--     "ray-x/lsp_signature.nvim",
--     event = "VeryLazy",
--     opts = {},
--     config = function(_, opts) require'lsp_signature'.setup(opts) end
--   },
-- }
