-- stylua: ignore
-- Change some configurations of the plugins come with LazyVim
return {

  -- {
  --   "echasnovski/mini.comment",
  --   event = "VeryLazy",
  --   opts = {
  --     options = {
  --       custom_commentstring = nil     },
  --   },
  -- },
  {
    "folke/tokyonight.nvim",
    opts = {
        styles = {
          floats = "transparent",
        },
    },
    config = true,
  }
}
