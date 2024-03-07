--------------------------------------------
-- NETRW => Neovim's built-in file explorer
-- changes:
-- 08/23 hack added

local g = vim.g

-- disable annoying "Netrw banner" on startup
g.netrw_banner = 0
-- default size of the netrw window when it's opened
g.netrw_winsize = 25
--displays files and directories as a simple list
g.netrw_liststyle = 0
