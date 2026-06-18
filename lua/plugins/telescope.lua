return {
	"nvim-telescope/telescope.nvim",
	event = "VeryLazy",
	cmd = "Telescope",
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "ファイル検索" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "全文検索" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "buffer検索" },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "help検索" },
		{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "最近のファイル" },
		{ "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "カーソル下を検索" },
		{ "<leader>f/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "現在buffer内検索" },
		{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "キーマップ検索" },
		{ "<leader>fc", "<cmd>Telescope commands<cr>", desc = "コマンド検索" },
		{ "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "診断検索" },
		{ "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git commit検索" },
		{ "<leader>gC", "<cmd>Telescope git_bcommits<cr>", desc = "現在bufferのcommit検索" },
		{ "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "Git管理ファイル検索" },
		{ "<leader>gS", "<cmd>Telescope git_status<cr>", desc = "Git status検索" },
	},
	opts = {
		defaults = {
			-- Default configuration for telescope goes here:
			-- config_key = value,
			mappings = {
				i = {
					-- map actions.which_key to <C-h> (default: <C-/>)
					-- actions.which_key shows the mappings for your picker,
					-- e.g. git_{create, delete, ...}_branch for the git_branches picker
					["<C-h>"] = "which_key",
				},
			},
		},
		pickers = {
			-- Default configuration for builtin pickers goes here:
			-- picker_name = {
			--   picker_config_key = value,
			--   ...
			-- }
			-- Now the picker_config_key will be applied every time you call this
			-- builtin picker
		},
		extensions = {
			-- Your extension configuration goes here:
			-- extension_name = {
			--   extension_config_key = value,
			-- }
			-- please take a look at the readme of the extension you want to configure
		},
	},
}
