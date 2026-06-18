-- which-key.nvim: キーバインドヘルパー
-- <leader> を押すと利用可能なキーバインドが一覧表示される
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "キーマップを表示",
		},
	},
	opts = {
		preset = "helix", -- モダンな表示スタイル
		spec = {
			{ "<leader>b", group = "buffer" },
			{ "<leader>c", group = "code/quickfix" },
			{ "<leader>f", group = "find/format" },
			{ "<leader>g", group = "git" },
			{ "<leader>l", group = "location list" },
			{ "<leader>p", group = "plugins/tools" },
			{ "<leader>t", group = "terminal" },
			{ "<leader>w", group = "words" },
			{ "<leader>x", group = "diagnostics" },
		},
	},
}
