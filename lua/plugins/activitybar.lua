local function visible_window(match)
	for _, winid in ipairs(vim.api.nvim_list_wins()) do
		local bufnr = vim.api.nvim_win_get_buf(winid)
		if match(bufnr, winid) then
			return true
		end
	end
	return false
end

local function visible_neo_tree_source(source)
	return visible_window(function(bufnr)
		return vim.bo[bufnr].filetype == "neo-tree" and vim.b[bufnr].neo_tree_source == source
	end)
end

return {
	"garchomp-game/activitybar.nvim",
	tag = "v0.1.0",
	lazy = false,
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{ "<leader>pa", "<cmd>ActivityBarToggle<cr>", desc = "ActivityBarを開閉" },
		{ "<leader>pA", "<cmd>ActivityBarTogglePosition<cr>", desc = "ActivityBarの左右を切替" },
	},
	opts = {
		position = "left",
		width = 7,
		item_height = 3,
		auto_open = true,
		pinned = true,
		highlight_definitions = {
			active = { bg = "#3a3a3a" },
		},
		items = {
			{
				id = "files",
				icon = "󰙅",
				label = "Files",
				command = "Neotree toggle reveal",
				active = function()
					return visible_neo_tree_source("filesystem")
				end,
			},
			{
				id = "search",
				icon = "󰱼",
				label = "Search",
				command = "Telescope find_files",
				post_action = false,
				focus_filetype = "TelescopePrompt",
			},
			{
				id = "terminal",
				icon = "",
				label = "Terminal",
				command = "ToggleTerm",
				active = function()
					return visible_window(function(bufnr)
						return vim.bo[bufnr].filetype == "toggleterm" or vim.bo[bufnr].buftype == "terminal"
					end)
				end,
			},
			{
				id = "git",
				icon = "",
				label = "Git",
				command = "Neotree toggle git_status right",
				active = function()
					return visible_neo_tree_source("git_status")
				end,
			},
			{
				id = "diagnostics",
				icon = "",
				label = "Diagnostics",
				command = "Trouble diagnostics toggle",
			},
			{
				id = "lazy",
				icon = "󰒲",
				label = "Lazy",
				command = "Lazy",
			},
			{
				id = "mason",
				icon = "󱌣",
				label = "Mason",
				command = "Mason",
			},
		},
	},
}
