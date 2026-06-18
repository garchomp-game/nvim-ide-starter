-- オプションを設定: キーマップは noremap（再帰的でない）、silent（コマンドの実行時に表示しない）を設定
local opts = { noremap = true, silent = true }

-- ノーマルモードでのウィンドウ切り替え
vim.keymap.set("n", "<c-h>", "<c-w>h") -- ctrl + h で左のウィンドウに切り替え
vim.keymap.set("n", "<c-j>", "<c-w>j") -- ctrl + j で下のウィンドウに切り替え
vim.keymap.set("n", "<c-k>", "<c-w>k") -- ctrl + k で上のウィンドウに切り替え
vim.keymap.set("n", "<c-l>", "<c-w>l") -- ctrl + l で右のウィンドウに切り替え

-- ノーマルモードで <leader> + vt で垂直ターミナルを開く
vim.keymap.set("n", "<leader>vt", function()
	require("utils").VertTerm()
end, opts)

-- Plugin/tool管理
vim.keymap.set("n", "<leader>pl", "<cmd>Lazy<cr>", { noremap = true, silent = true, desc = "Lazyを開く" })
vim.keymap.set("n", "<leader>ps", "<cmd>Lazy sync<cr>", { noremap = true, silent = true, desc = "pluginを同期" })
vim.keymap.set("n", "<leader>pu", "<cmd>Lazy update<cr>", { noremap = true, silent = true, desc = "pluginを更新" })

-- ロケーションリストを開く/閉じる
vim.keymap.set("n", "<leader>lo", "<cmd>lopen<cr>", opts) -- <leader> + lo でロケーションリストを開く
vim.keymap.set("n", "<leader>lc", "<cmd>lclose<cr>", opts) -- <leader> + lc でロケーションリストを閉じる

-- クイックフィックスリストを開く/閉じる
vim.keymap.set("n", "<leader>co", "<cmd>copen<cr>", opts) -- <leader> + co でクイックフィックスリストを開く
vim.keymap.set("n", "<leader>cc", "<cmd>cclose<cr>", opts) -- <leader> + cc でクイックフィックスリストを閉じる

-- クイックフィックスリストに診断情報を設定
vim.keymap.set("n", "<leader>cq", function()
	vim.diagnostic.setqflist()
end, opts)

-- 次の診断に移動
vim.keymap.set("n", "<leader>cn", function()
	vim.diagnostic.goto_next()
end, opts)

-- 前の診断に移動
vim.keymap.set("n", "<leader>cp", function()
	vim.diagnostic.goto_prev()
end, opts)
