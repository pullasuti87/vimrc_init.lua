local cmd = vim.cmd
local keymap = vim.api.nvim_set_keymap
local map = vim.keymap.set
--------------------------------------------
-- CUSTOM KEYMAPS

keymap("v", "<C-c>", '"+y', { noremap = true }) -- copy selected text to clipboard
keymap("n", "<C-p>", '"+p', { noremap = true }) -- paste text from clipboard

keymap("n", "<Space>t", ":below split | term<CR>:resize 6<CR>", { noremap = true, silent = true }) -- open terminal
keymap("t", "<C-b>", "<C-\\><C-n>", { noremap = true }) -- exit terminal mode to normal mode
keymap("n", "<Space>e", ":Explore<CR>", { noremap = true, silent = true }) -- open netrw
keymap("n", "<Space>d", ":Termdebug<CR>", { noremap = true, silent = true }) -- open debugger

keymap("n", "<Space>w", "<C-w><C-w>", { noremap = true, silent = true }) -- navigate between windows

keymap('n', '<M-.>', ':bnext<CR>', { noremap = true, silent = true }) -- next buffer
keymap('n', '<M-,>', ':bprev<CR>', { noremap = true, silent = true }) -- prev nuffer

keymap("n", "<CR>", ":noh<CR><CR>", { noremap = true, silent = true }) -- removes last highlight

---- telescope
map("n", "<leader>f", require("telescope.builtin").find_files, {})
map("n", "<leader>g", require("telescope.builtin").live_grep, {})
map("n", "<leader>b", require("telescope.builtin").buffers, {})
map("n", "<leader>h", require("telescope.builtin").help_tags, {})

---- vanilla autopairing
keymap("i", "(<CR>", "()<Left>", { noremap = true, silent = true })
keymap("i", "[<CR>", "[]<Left>", { noremap = true, silent = true })
keymap("i", "{<CR>", "{}<Left>", { noremap = true, silent = true })
keymap("i", '"<CR>', '""<Left>', { noremap = true, silent = true })
keymap("i", "<<CR>", "<><Left>", { noremap = true, silent = true })
keymap("i", "'<CR>", "''<Left>", { noremap = true, silent = true })

----------------------------------------------
-- CUSTOM COMMANDS

-- format Python
cmd([[
autocmd FileType python nnoremap <buffer> <Space>f :silent !black %<CR><CR>
]])
-- format JavaScript/TypeScript
cmd([[
autocmd FileType javascript,typescript,json,markdown nnoremap <buffer> <Space>f :silent !npx prettier --write %<CR><CR>
]])
-- format Lua
cmd([[
autocmd FileType lua nnoremap <buffer> <Space>f :silent !npx stylua %<CR><CR>
]])
-- format for C/C++
cmd([[
autocmd FileType c,cpp nnoremap <buffer> <Space>f :silent !clang-format -style=file -i %<CR><CR>
]])
-- format for GO
cmd([[
autocmd FileType go,gomod,gowork,gotmpl nnoremap <buffer> <Space>f :silent !gofmt -w %<CR><CR>
]])

-- save session
cmd("command! Save mksession! session.vim")
-- load session
cmd("command! Load source session.vim")

-- toggle copilot suggestions
cmd([[
autocmd FileType * nnoremap <C-s> :lua require('copilot.suggestion').toggle_auto_trigger()<CR>:echo 'Copilot suggestions toggled'<CR>
]])

--  filter entire file
cmd([[
command! -nargs=1 Filter execute 'silent %!fmt -w ' .. <args>
]])

--  indent entire file
cmd([[
command! -nargs=0 Indent execute 'silent normal gg=G'
]])
