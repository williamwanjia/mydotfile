return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup({
            size = 20,
            hide_numbers = true,
            shade_terminals = true,
            start_in_insert = true, -- 🔹 Always start in insert mode
            direction = "float",
            float_opts = {
                border = "curved",
            },
        })

        -- Normal mode mapping
        vim.keymap.set("n", "<leader>te", "<cmd>ToggleTerm<cr>",
            { noremap = true, silent = true, desc = "Toggle floating terminal" })

        -- Terminal mode mapping
        vim.keymap.set("t", "<leader>te", [[<C-\><C-n><cmd>ToggleTerm<cr>]],
            { noremap = true, silent = true, desc = "Toggle floating terminal" })
    end,
}
