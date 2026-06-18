return {
	-- amongst your other plugins
	"akinsho/toggleterm.nvim",
	event = "VeryLazy",
	cmd = { "ToggleTerm", "ToggleTermToggleAll", "TermExec" },
	version = "*",
	keys = {
		[[<c-\>]],
		{ "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "ターミナルを開閉" },
		{ "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "水平ターミナルを開閉" },
		{ "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "垂直ターミナルを開閉" },
		{ "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "フロートターミナルを開閉" },
		{ "<leader>ta", "<cmd>ToggleTermToggleAll<cr>", desc = "全ターミナルを開閉" },
	},
	config = function()
		function _G.set_terminal_keymaps()
			local opts = { buffer = 0 }
			vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
			vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
			vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
			vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
			vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
			vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
			vim.keymap.set("t", "<C-p>", [[<Up>]], opts) -- ここに追加
			vim.keymap.set("t", "<C-n>", [[<Down>]], opts) -- ここに追加
		end
		require("toggleterm").setup({
			open_mapping = [[<c-\>]],
		})
		-- if you only want these mappings for toggle term use term://*toggleterm#* instead
		vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
	end,
}
