-- snacks.nvim: Folke の統合ユーティリティ
return {
	"folke/snacks.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		-- 右上の通知ポップアップは、初心者向けcoreでは無効にする。
		-- 有効化したい場合は true に変更する。
		notifier = { enabled = false },
		-- 大きなファイルの高速表示
		quickfile = { enabled = true },
		-- 初心者向けには標準のsign/number列を保つ
		statuscolumn = { enabled = false },
		-- カーソル下の単語ハイライト（vim-illuminate の代替）
		words = { enabled = true },
		-- インデントガイド（indent-blankline の代替）
		indent = { enabled = true },
		-- 入力UIは dressing.nvim で管理（競合回避）
		input = { enabled = false },
	},
	keys = {
		{
			"]]",
			function()
				require("snacks").words.jump(vim.v.count1)
			end,
			desc = "次の参照",
			mode = { "n", "t" },
		},
		{
			"[[",
			function()
				require("snacks").words.jump(-vim.v.count1)
			end,
			desc = "前の参照",
			mode = { "n", "t" },
		},
		{
			"<leader>wn",
			function()
				require("snacks").words.jump(vim.v.count1)
			end,
			desc = "次の参照",
		},
		{
			"<leader>wp",
			function()
				require("snacks").words.jump(-vim.v.count1)
			end,
			desc = "前の参照",
		},
	},
}
