return {
	"akinsho/bufferline.nvim",
	version = "*",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
		{ "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer" },
		{ "<leader>bn", "<cmd>BufferLineCycleNext<cr>", desc = "次のbufferへ" },
		{ "<leader>bp", "<cmd>BufferLineCyclePrev<cr>", desc = "前のbufferへ" },
		{ "<leader>bf", "<cmd>BufferLinePick<cr>", desc = "bufferを選択" },
		{ "<leader>bd", "<cmd>bdelete<cr>", desc = "Close buffer" },
		{ "<leader>bD", "<cmd>BufferLineCloseOthers<cr>", desc = "他のbufferを閉じる" },
	},
	opts = {
		options = {
			mode = "buffers",
			diagnostics = "nvim_lsp",
			always_show_bufferline = false,
			show_buffer_close_icons = false,
			show_close_icon = false,
			separator_style = "thin",
			offsets = {
				{
					filetype = "neo-tree",
					text = "Files",
					highlight = "Directory",
					separator = true,
				},
			},
		},
	},
}
