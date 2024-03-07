--------------------------------------------
-- CUSTOM STATUSLINE => My very own custom statusline for Neovim.
-- changes:
-- 08/23 made the main function
-- 09/23 added git branch name

local M = {}
local modes = {
	c = " COMMAND",
	i = " INSERT",
	n = " NORMAL",
	t = " TERMINAL",
	v = " VISUAL",
	[""] = "VISUAL-BLOCK",
	V = "VISUAL LINE",
	-- there are more of these, but not sure if they are needeed...
}

-- shows mode fullname if founded
local function ShowModeName()
	return modes[vim.fn.mode()] or " UNKNOWN"
end

-- shows git branch if founded
local function ShowGitBranch()
	-- path of the current buffers folder
	local bufname = vim.fn.expand("%:p:h")
	-- makes "git branch" command without error messages
	local handle = io.popen("git -C " .. bufname .. " branch --show-current 2>/dev/null")
	if handle then
        -- read output
		local result = handle:read("*a")
		handle:close()
        -- remove whitespace
        result = result:gsub("%s", "")
		if result  ~= "" then
			return "" .. result .. ""
		else
			return ""
		end
	end
end

-- define a function to get the current date and time
function GetDate()
    return os.date("%Y-%m-%d")
end

-- function that handles all the parts in statusline
function M.statusline()
	local parts = {}

	-- show the mode name
	table.insert(parts, " " .. ShowModeName())

	-- if file is modified, show indicator
	if vim.bo.modified then
		table.insert(parts, " [+]")
	end

	-- testing custom separator
	table.insert(parts, " | ")

	-- adds git branch
	table.insert(parts, "" .. ShowGitBranch())

	-- shows file path in the center
	table.insert(parts, '%="%f"')

	-- line and column numbers 
	table.insert(parts, "%= %l:%c ")

	-- show date
    -- 	table.insert(parts, "" .. GetDate())

    -- display the filetype
	-- table.insert(parts, "[" .. vim.bo.filetype .. "] ")

	-- STILL UNDER CONSTRUCTION

	return table.concat(parts, "")
end

return M
------------------------------------------
-- this is needed to get the number of current buffer
-- print(vim.fn.bufnr('%'))
