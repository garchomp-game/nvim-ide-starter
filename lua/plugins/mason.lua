-- mason.lua: Mason による開発ツールの一元管理
-- LSP設定は ~/.config/nvim/lsp/ + vim.lsp.config で管理
-- フォーマッタ・リンターは mason-tool-installer で不足分をインストール

return {
	-- Mason 本体
	{
		"williamboman/mason.nvim",
		lazy = false,
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
		opts = {
			ensure_installed = {
				"lua_ls",
				"ts_ls",
				"html",
				"cssls",
				"bashls",
				"emmet_ls",
				"jsonls",
			},
			-- mason-lspconfig v2 では automatic_installation は廃止。
			-- ensure_installed で導入し、vim.lsp.enable() は automatic_enable に任せる。
			automatic_enable = true,
		},
	},

	-- フォーマッタ・リンターのインストール
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		lazy = false,
		dependencies = {
			"williamboman/mason.nvim",
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
