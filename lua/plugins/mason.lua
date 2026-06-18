-- mason.lua: Mason による開発ツールの一元管理
-- LSP server一覧と共通設定は lua/config/lsp.lua で管理
-- フォーマッタ・リンターは mason-tool-installer で不足分をインストール

return {
	-- Mason 本体
	{
		"williamboman/mason.nvim",
		lazy = false,
		keys = {
			{ "<leader>pm", "<cmd>Mason<cr>", desc = "Masonを開く" },
		},
		opts = {
			ui = {
				border = "rounded",
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},

	-- Mason ↔ LSP 連携
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		dependencies = {
			"williamboman/mason.nvim",
		},
		opts = function()
			return {
				ensure_installed = require("config.lsp").server_names(),
				-- mason-lspconfig v2 では automatic_installation は廃止。
				-- ensure_installed で導入し、vim.lsp.enable() は automatic_enable に任せる。
				automatic_enable = true,
			}
		end,
		config = function(_, opts)
			require("config.lsp").setup()
			require("mason-lspconfig").setup(opts)
		end,
	},

	-- フォーマッタ・リンターのインストール
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		lazy = false,
		dependencies = {
			"williamboman/mason.nvim",
		},
		keys = {
			{ "<leader>pM", "<cmd>MasonToolsInstallSync<cr>", desc = "Mason toolsを同期" },
		},
		opts = {
			ensure_installed = {
				-- フォーマッタ
				"stylua", -- Lua (conform.nvim)
				"biome", -- JS/TS/JSON (conform.nvim + nvim-lint)
				"prettier", -- CSS/HTML/Markdown (conform.nvim)
			},
			auto_update = false,
			run_on_start = true,
		},
	},
}
