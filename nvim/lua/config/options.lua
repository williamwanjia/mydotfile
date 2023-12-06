-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- One such option is the 'hidden' option, which allows you to re-use the same
-- window and switch from an unsaved buffer without saving it first. Also allows
-- you to keep an undo history for multiple files when re-using the same window
-- in this way. Note that using persistent undo also lets you undo in multiple
-- files even in the same window, but is less efficient and is actually designed
-- for keeping undo history after closing Vim entirely. Vim will complain if you
-- try to quit without saving, and swap files will keep you safe if your computer
-- crashes.

opt.hidden = true

-- Better command-line completion
opt.wildmenu = true

-- Show partial commands in the last line of the screen
opt.showcmd = true

-- Highlight searches (use <C-L> to temporarily turn off highlighting; see the
-- mapping of <C-L> below)
opt.hlsearch = true

-- Use case insensitive search, except when using capital letters
opt.ignorecase = true
opt.smartcase = true

-- Allow backspacing over autoindent, line breaks and start of insert action
opt.backspace = "indent,eol,start"

-- When opening a new line and no filetype-specific indenting is enabled, keep
-- the same indent as the line you're currently on. Useful for READMEs, etc.
opt.autoindent = true

-- Stop certain movements from always going to the first character of a line.
-- While this behaviour deviates from that of Vi, it does what most users
-- coming from other editors would expect.
opt.startofline = false

-- Display the cursor position on the last line of the screen or in the status
-- line of a window
opt.ruler = true

-- Always display the status line, even if only one window is displayed
opt.laststatus = 2

-- Instead of failing a command because of unsaved changes, instead raise a
-- dialogue asking if you wish to save changed files.
opt.confirm = true

-- Enable use of the mouse for all modes
opt.mouse = "a"

-- Set the command window height to 2 lines, to avoid many cases of having to
-- 'press <Enter> to continue'
opt.cmdheight = 2

opt.number = true
opt.relativenumber = true

opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true

opt.compatible = false

opt.list = true -- show space and tabs chars
--opt.listchars = { tab = "▸·", space = "⎵", eol = "⏎", trail = "×" } -- make tab, etc visible
-- Showing space doesn't look nice and seems to slow down nvim
opt.listchars = { tab = "▸·", eol = "⏎", trail = "×" } -- make tab, etc visible

-- setting for column wide
opt.colorcolumn = "80"

opt.textwidth = 79

opt.spelllang = "en_us"

vim.g.mapleader = ","

vim.g.tagbar_sort = 0
vim.g.tagbar_width = 40
