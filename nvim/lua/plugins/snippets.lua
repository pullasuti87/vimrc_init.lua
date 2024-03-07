local ls = require("luasnip")
-- some shorthands...
local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node

ls.add_snippets("c", {
	-- For loop snippet in C
	snip({ trig = "for", namr = "for_loop", dscr = "for_loop" }, {
		text("for"),
	}),
})



