---------------------------------------------
-- MY NEOVIM CONFIGURATION
-- Neovim website: https://neovim.io/
---------------------------------------------
if vim.g.vscode then
--vscode-specific configurations
else
-- A builtin Lua module which byte-compiles and caches Lua files (speeds up load times).
vim.loader.enable()

-- plugins that are in use
require("vim-plug")
-- general configuration
require("options")
-- custom keymaps
require("mappings")
end
