--------------------------------------------
-- LSPCONFIG.NVIM => A collection of common configurations for Neovim's built-in language server client.
-- https://github.com/neovim/nvim-lspconfig

-- lsp configs:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

-- custom configuration
-- changes:
-- 08/23 added Lua, C/C++ and Markdown servers
-- 08/23 added custom cmds
-- 09/23 added html and cssls language servers
-- 09/23 commented out on_attach function

local lspconfig = require("lspconfig")

-- LSP servers
local lsp_servers = {
	{ server = "pylsp", filetypes = { "python" } },
	{ server = "tsserver", filetypes = { "javascript", "typescript" } },
	{ server = "gopls", filetypes = { "go", "gomod", "gowork", "gotmpl" } },
	{
		server = "clangd",
		filetypes = { "c", "cpp" },
		settings = {
			gopls = {
				analyses = {
					unusedparams = true,
				},
				staticcheck = true,
				gofumpt = true,
			},
		},
	},
	{
		server = "lua_ls",
		filetypes = { "lua" },
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
				},
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
					checkThirdParty = false,
				},
				telemetry = {
					enable = false,
				},
			},
		},
	},
	{ server = "html", filetypes = { "html" } },
	{ server = "cssls", filetypes = { "css", "scss", "less" } },
	{ server = "emmet_ls", filetypes = { "css", "eruby", "html", "less", "sass", "scss", "svelte", "pug", "vue" } },
}

-- Shared capabilities for all servers
local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()

for _, cfg in ipairs(lsp_servers) do
	lspconfig[cfg.server].setup({
		capabilities = lsp_capabilities,
		flags = { allow_incremental_sync = false, debounce_text_changes = 150 },
		filetypes = cfg.filetypes,
		settings = cfg.settings or {},
	})
end

-- diagnostic options globally, ":help vim.diagnostic.config" for more
-- advanced customization options
vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = true,
	severity_sort = true,
})

-- show line diagnostics automatically in hover window
-- vim.opt.updatetime = 250
-- vim.api.nvim_create_autocmd(
-- 	{ "CursorHold", "CursorHoldI" },
-- 	{ pattern = "*", command = "lua vim.diagnostic.open_float(nil, {focus=false})" }
-- )

---- makes diagnostic errors/warnings blend to the transparent background
---- vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = "#cc241d" })
---- vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = "#d79921" })
---- vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = "#689d6a" })
