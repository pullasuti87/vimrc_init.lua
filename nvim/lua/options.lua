local api = vim.api
local bo = vim.bo
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt
---------------------------------------------
-- STARTUP AND COMMANDS

--[
-- disable builtin plugins
-- local disabled_built_ins = {
-- }

-- loop that handles disabling
-- for _, plugin in pairs(disabled_built_ins) do
-- 	g["loaded_" .. plugin] = 1
-- end
--]

cmd([[colorscheme rose-pine]]) -- add colorscheme
cmd([[packadd termdebug]]) -- add default debugger
cmd([[set title]]) -- set title
cmd([[set noshowmode]]) -- don't show the mode under statusline

-- line highlighting only in the active buffer
cmd([[autocmd BufEnter,WinEnter * setlocal cursorline]])
cmd([[autocmd BufLeave,WinLeave * setlocal nocursorline]])

cmd([[autocmd VimEnter * hi WinSeparator guifg=#31748f]]) -- custom  color for WinSeparator

-- set winbar to show file path --> floating window would be very cool
-- cmd([[autocmd BufEnter,WinEnter * setlocal winbar=""]])
-- cmd([[autocmd BufLeave,WinLeave * setlocal winbar=%=%m\ %f]])
--------------------------------------------
-- GENERAL SETTINGS

opt.statusline = "%!v:lua.require'plugins.statusline'.statusline()" -- custom statusline
opt.laststatus = 3 -- last window will have a status line

opt.titlestring = "%F" -- shows path and file name in terminal

g.termdebug_wide = 1 --better layout for the debugger

opt.termguicolors = true -- enables 24-bit colors
opt.background = "dark" -- colormode for colorscheme

opt.textwidth = 80 -- maximum width for line wrapping
-- opt.colorcolumn = "80" -- highlight a vertical line at column 80

opt.number = true -- shows row number
opt.relativenumber = true -- show line number to relative to cursor position
opt.scrolloff = 8 -- scrolling shows upcoming lines
opt.cursorline = true -- highlights cursorline
opt.signcolumn = "yes" -- show extra column on left side

opt.tabstop = 4 -- number of spaces for each tab character
opt.softtabstop = 4 -- number of spaces when using the '<<' and '>>' commands
opt.shiftwidth = 4 -- number of spaces for each level of indentation
opt.expandtab = true -- spaces instead of tabs for indentation

opt.ignorecase = true -- ignores uppercase
opt.linebreak = true -- stop words being broken on wrap

opt.incsearch = true -- enable incremental search, highlighting matches as you type

bo.swapfile = false -- doesn't save to the buffer
opt.backup = false -- no backups are created
opt.undodir = fn.stdpath("config") .. "/undodir/" -- separate file
opt.undofile = true -- saving all the changes separate file

opt.mouse = "a" -- enables mouse

opt.updatetime = 50 -- time for triggering the automatic commands
--------------------------------------------
-- TRANSPARENT BACKGROUND (not in use)

-- api.nvim_set_hl(0, "Normal", {fg = NONE})
-- api.nvim_set_hl(0, "SignColumn", {fg = NONE})
