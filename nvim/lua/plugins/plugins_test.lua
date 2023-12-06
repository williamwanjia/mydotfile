-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
return {

    {"https://github.com/preservim/tagbar"},

    {"https://github.com/scrooloose/nerdcommenter"},

    {'neoclide/coc.nvim', branch = 'release'},

    -- This plugin is needed to delet buffer
    {
        "famiu/bufdelete.nvim",
        keys = {
            {"Bd", ":w<CR> :Bdelet<CR>", desc = "Save and close the buffer"}
        }
    },

    "rebelot/kanagawa.nvim",  -- neorg needs a colorscheme with treesitter support
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      opts = {
        highlight = { enable = true },
      },
      config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
      end,
    },
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
                  notes = "~/notes",
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
}
