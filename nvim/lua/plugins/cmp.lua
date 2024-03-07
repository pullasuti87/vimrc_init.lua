--------------------------------------------
-- NVIM-CMP => A completion engine plugin for neovim written in Lua. Completion sources are
-- installed from external repositories and "sourced".
-- https://github.com/hrsh7th/nvim-cmp

-- custom configuration
-- 09/2023 added custom keyword_length to css, html
-- 01/2024 added copilot sources

require("luasnip.loaders.from_vscode").lazy_load()

local cmp = require("cmp")
local luasnip = require("luasnip")
local select_opts = { behavior = cmp.SelectBehavior.Select }

-- autocompletion pop-up window behavior
vim.opt.completeopt = { "menu", "menuone", "noselect" }

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	sources = {
		{ name = "path" },
		{ name = "copilot", group_index = 4 },
		{ name = "buffer", keyword_length = 3 },
		{ name = "luasnip", keyword_length = 2 },
		{ name = "nvim_lsp", keyword_length = 3 },
	},
	window = {
		documentation = cmp.config.window.bordered(),
	},
	formatting = {
		fields = { "menu", "abbr", "kind" },
		format = function(entry, item)
			local menu_icon = {
				nvim_lsp = "λ",
				luasnip = "⋗",
				buffer = "Ω",
				path = "◇",
			}

			item.menu = menu_icon[entry.source.name]
			return item
		end,
	},
	mapping = {

		["<CR>"] = cmp.mapping.confirm({ select = true }),

		["<Tab>"] = cmp.mapping(function(fallback)
			local col = vim.fn.col(".") - 1

			if cmp.visible() then
				cmp.select_next_item(select_opts)
			elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
				fallback()
			else
				cmp.complete()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item(select_opts)
			else
				fallback()
			end
		end, { "i", "s" }),
	},
})

-- custom completion to certain filetypes
cmp.setup.filetype({ "css", "html" }, {
	sources = {
		{ name = "path" },
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "luasnip" },
	},
})
