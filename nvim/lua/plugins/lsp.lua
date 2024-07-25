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
                ensure_installed = { "lua_ls", "pyright", "pylsp" },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")
            lspconfig.pyright.setup({ capabilities = capabilities })
            lspconfig.lua_ls.setup({ capabilities = capabilities })
            lspconfig.pylsp.setup({ capabilities = capabilities })

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
