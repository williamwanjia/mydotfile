-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
return {
    --
    --     {
    --       "rebelot/kanagawa.nvim",  -- neorg needs a colorscheme with treesitter support
    --       {
    --         "nvim-treesitter/nvim-treesitter",
    --         build = ":TSUpdate",
    --         opts = {
    --           highlight = { enable = true },
    --         },
    --         config = function(_, opts)
    --           require("nvim-treesitter.configs").setup(opts)
    --         end,
    --       },
    --     },
    --     -- {
    --     --     "vhyrro/luarocks.nvim",
    --     --     priority = 1000, -- We'd like this plugin to load first out of the rest
    --     --     config = true, -- This automatically runs `require("luarocks-nvim").setup()`
    --     -- },
    --     {
    --       "nvim-neorg/neorg",
    --       version = "v7.0.0", -- This is the important part!
    --       -- build = ":Neorg sync-parsers",
    --       dependencies = { "nvim-lua/plenary.nvim" },
    --       -- dependencies = { "luarocks.nvim" },
    --       config = function()
    --         require("neorg").setup {
    --           load = {
    --             ["core.defaults"] = {},
    --             ["core.concealer"] = {},
    --             ["core.dirman"] = {
    --               config = {
    --                 workspaces = {
    --                   notes = "~/Documents/neorgnotes",
    --                 },
    --                 default_workspace = "notes",
    --               },
    --             },
    --           },
    --         }
    --
    --         vim.wo.foldlevel = 99
    --         vim.wo.conceallevel = 2
    --       end,
    --     },
    --     -- to format MD, rst tables
    --     {
    --       "dhruvasagar/vim-table-mode",
    --     },
}
