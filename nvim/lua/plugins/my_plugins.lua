-- stylua: ignore
return {

    {"https://github.com/preservim/tagbar"},

    -- {
    --   "catppuccin/nvim",
    --   name = "catppuccin",
    --   lazy = false,
    --   priority = 1000,
    -- },

    {
      "nvim-neorg/neorg",
      build = ":Neorg sync-parsers",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        require("neorg").setup {
          load = {
            ["core.defaults"] = {},
            ["core.concealer"] = {},
            ["core.dirman"] = {
              config = {
                workspaces = {
                  notes = "~/Documents/neorgnotes",
                },
                default_workspace = "notes",
              },
            },
          },
        }

        vim.wo.foldlevel = 99
        vim.wo.conceallevel = 2
      end,
    },
    -- to format MD, rst tables
    -- slow for large table, might need to find another one
    {
      "dhruvasagar/vim-table-mode",
    },
}
