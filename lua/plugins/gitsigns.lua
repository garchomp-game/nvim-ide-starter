local utils = require("utils")

-- Gitsignsの設定をローカル変数に分割
local gitsigns_opts = {
	-- シンボルの定義
	signs = {
		add = { text = "│" },
		change = { text = "│" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "┆" },
	},
	signcolumn = true, -- `:Gitsigns toggle_signs` で切り替え可能
	numhl = false, -- `:Gitsigns toggle_numhl` で切り替え可能
	linehl = false, -- `:Gitsigns toggle_linehl` で切り替え可能
	word_diff = false, -- `:Gitsigns toggle_word_diff` で切り替え可能
	attach_to_untracked = true,
	current_line_blame = false, -- `:Gitsigns toggle_current_line_blame` で切り替え可能
}

-- プラグイン設定の返却
return utils.setup_non_termux_config(function()
	return {
		"lewis6991/gitsigns.nvim",
		event = { "BufRead", "BufNewFile" }, -- BufRead と BufNewFile イベント時にプラグインを読み込む
		cmd = "Gitsigns",
		keys = {
			{ "<leader>gn", "<cmd>Gitsigns next_hunk<cr>", desc = "次のGit hunkへ" },
			{ "<leader>gp", "<cmd>Gitsigns prev_hunk<cr>", desc = "前のGit hunkへ" },
			{ "<leader>gh", "<cmd>Gitsigns preview_hunk<cr>", desc = "Git hunkをプレビュー" },
			{ "<leader>gH", "<cmd>Gitsigns preview_hunk_inline<cr>", desc = "Git hunkをインライン表示" },
			{ "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>", desc = "Git hunkをstage" },
			{ "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", desc = "Git hunkを戻す" },
			{ "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<cr>", desc = "stageを取り消す" },
			{ "<leader>gb", "<cmd>Gitsigns blame_line<cr>", desc = "行のblameを表示" },
			{ "<leader>gB", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "行blameを切替" },
			{ "<leader>gd", "<cmd>Gitsigns diffthis<cr>", desc = "Git diffを表示" },
			{ "<leader>gD", "<cmd>Gitsigns diffthis ~1<cr>", desc = "前commitとの差分" },
			{ "<leader>gw", "<cmd>Gitsigns toggle_word_diff<cr>", desc = "単語差分を切替" },
			{ "<leader>gq", "<cmd>Gitsigns setqflist<cr>", desc = "Git hunkをquickfixへ" },
			{
				"<leader>gs",
				function()
					require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end,
				mode = "v",
				desc = "選択範囲をstage",
			},
			{
				"<leader>gr",
				function()
					require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end,
				mode = "v",
				desc = "選択範囲を戻す",
			},
		},
		opts = gitsigns_opts,
	}
end)
