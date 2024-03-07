--------------------------------------------
-- COPILOT.LUA  => This Copilot plugin is the pure lua replacement for github/copilot.vim.
-- Copilot suggestions will be displayed as a ghost test in the buffer.

-- custom configuration
-- 01/2024 added copilot_cmp
-- 2/2024 added removed copilot_cmp
-- 2/2024 added fix for the lua callback bug

require("copilot").setup({
	cmd = "Copilot",
	event = "InsertEnter",
	suggestion = {
		auto_trigger = true,
		debounce = 300,
		-- keymaps are not ideal
		keymap = {
			accept = "<c-l>",
			next = "<c-j>",
			prev = "<c-k>",
			dismiss = "<c-h>",
		},
	},
    -- fixes a bug of nil value in lua callback
	filestypes = { Vimspector = false },
})
