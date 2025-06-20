return {
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        keys = {
            { "<C-t>", "<cmd>NvimTreeToggle<cr>", desc = "NeoTree" },
        },
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            view = { relativenumber = true, width = 44 }
        },
        -- config = function()
        --     require("nvim-tree").setup({ view = { relativenumber = true } })
        -- end,
    },
    -- Example for neo-tree.nvim
    {
        "nvim-neo-tree/neo-tree.nvim",
        lazy = false,
        -- keys = {
        --     { "<C-t>", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
        -- },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        opts = {
            event_handlers = {
                event = "neo_tree_buffer_enter",
                handler = function(arg)
                    -- vim.opt_local.relativenumber = true
                    vim.cmd([[
                        setlocal relativenumber
                    ]])
                end,
            },
            window = { number = true, relativenumber = true, }
        },
        config = true,
        -- config = function()
        --   require("neo-tree").setup()
        -- end,
    },

    -- which-key helps you remember key bindings by showing a popup
    -- with the active keybindings of the command you started typing.
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        dependencies = {
            "echasnovski/mini.icons"
        },
        opts = {
            plugins = { spelling = true },
            spec = {
                {
                    mode = { "n", "v" },
                    { "<leader><tab>", group = "tabs" },
                    { "<leader>b",     group = "buffer" },
                    { "<leader>c",     group = "code" },
                    { "<leader>f",     group = "file/find" },
                    { "<leader>g",     group = "git" },
                    { "<leader>gh",    group = "hunks" },
                    { "<leader>q",     group = "quit/session" },
                    { "<leader>s",     group = "search" },
                    { "<leader>u",     group = "ui" },
                    { "<leader>w",     group = "windows" },
                    { "<leader>x",     group = "diagnostics/quickfix" },
                    { "[",             group = "prev" },
                    { "]",             group = "next" },
                    { "g",             group = "goto" },
                    { "gs",            group = "surround" },
                },
            },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)
            -- wk.register(opts.defaults)
        end,
    },

    -- buffer remove
    {
        "echasnovski/mini.bufremove",

        keys = {
            {
                "<leader>bd",
                function()
                    local bd = require("mini.bufremove").delete
                    if vim.bo.modified then
                        local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()),
                            "&Yes\n&No\n&Cancel")
                        if choice == 1 then -- Yes
                            vim.cmd.write()
                            bd(0)
                        elseif choice == 2 then -- No
                            bd(0, true)
                        end
                    else
                        bd(0)
                    end
                end,
                desc = "Delete Buffer",
            },
            -- stylua: ignore
            { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
        },
    },

    -- {
    --   'akinsho/bufferline.nvim',
    --   version = "*",
    --   dependencies = 'nvim-tree/nvim-web-devicons',
    --   config = true,
    -- },

    -- Try a different buffer line
    {
        "willothy/nvim-cokeline",
        lazy = false,
        dependencies = {
            "nvim-lua/plenary.nvim",        -- Required for v0.4.0+
            "kyazdani42/nvim-web-devicons", -- If you want devicons
            "stevearc/resession.nvim"       -- Optional, for persistent history
        },
        opts = {
            buffers = {
                new_buffers_position = 'number',
            },
            sidebar = {
                filetype = { 'NvimTree', 'neo-tree' },
                components = {
                    {
                        text = function(buf)
                            return buf.filetype
                        end,
                        fg = vim.g.terminal_color_3,
                        bg = function() return require('cokeline.hlgroups').get_hl_attr('NvimTreeNormal', 'bg') end,
                        bold = true,
                    },
                }
            },
        }
    },

    { "https://github.com/preservim/tagbar" },

    {
        "nvim-lualine/lualine.nvim",
        lazy = false,
        opts = {
            options = {
                globalstatus = true,
            },
        },
    },

    {
        "echasnovski/mini.indentscope",
        version = false, -- wait till new 0.7.0 release to put it back on semver
        -- event = "LazyFile",
        lazy = false,
        opts = {
            symbol = "│",
            options = { try_as_border = true },
        },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "help",
                    "alpha",
                    "dashboard",
                    "neo-tree",
                    "Trouble",
                    "trouble",
                    "lazy",
                    "mason",
                    "notify",
                    "toggleterm",
                    "lazyterm",
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
    },
    -- {
    --   'rmagatti/auto-session',
    --   config = function()
    --     require("auto-session").setup {
    --       log_level = "error",
    --       auto_session_suppress_dirs = { "~/", "~/Downloads", "/"},
    --     }
    --   end,
    -- },
    {
        "echasnovski/mini.pairs",
        config = true
    },
    {
        'echasnovski/mini.surround',
        version = '*',
        config = true,
    },
}
