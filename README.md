# nvim-ide-starter

Vim/Neovimを初めて使う人向けの、軽めのIDEライクなNeovim設定です。

目的は「最初から開発に必要なものは揃っているが、Vim本来の基本操作を大きく壊さない」ことです。

## Features

- `lazy.nvim` によるプラグイン管理
- `neo-tree.nvim` のサイドバー
- `bufferline.nvim` のbuffer tab
- `telescope.nvim` のファイル検索/全文検索
- `toggleterm.nvim` の内蔵ターミナル
- Neovim組み込みLSP + `mason.nvim`
- `blink.cmp` の補完
- Neovim組み込みTreesitterの構文ハイライト
- `conform.nvim` のフォーマット
- `nvim-lint` のlint
- `gitsigns.nvim` のGit差分表示
- `which-key.nvim` のキーマップ補助
- `trouble.nvim` の診断リスト
- `vimdoc-ja` の日本語ヘルプ

## Requirements

- Neovim 0.11+
- Git
- ripgrep (`rg`)
- Node.js / npm
- unzip, curl or wget
- Nerd Font

必要なLSP/formatterは `mason.nvim` で管理します。TreesitterはNeovim組み込み機能を使い、同梱parserがあるfiletypeだけ自動で有効化します。

## Installation

```sh
git clone <this-repository-url> ~/.config/nvim
nvim
```

初回起動後、必要なツールを入れます。

```vim
:Lazy sync
:MasonToolsInstallSync
```

`mason-lspconfig` は `ensure_installed` に列挙したLSP serverを通常起動時にインストールし、インストール済みserverを `vim.lsp.enable()` で有効化します。`mason-tool-installer` は formatter/linter を初回起動時に不足分だけインストールします。手動で確実に完了を待ちたい場合は `:MasonToolsInstallSync` を使ってください。

## Keymaps

Leader keyは `<Space>` です。

| Key | Action |
|---|---|
| `<C-n>` | ファイルツリーを開閉 |
| `<leader>e` | 現在のファイルをファイルツリーで表示 |
| `<Tab>` | 次のbufferへ |
| `<S-Tab>` | 前のbufferへ |
| `<leader>bd` | 現在のbufferを閉じる |
| `<leader>ff` | ファイル検索 |
| `<leader>fg` | 全文検索 |
| `<leader>fb` | buffer検索 |
| `<leader>fh` | help検索 |
| `<C-\>` | ターミナルを開閉 |
| `<leader>vt` | vertical terminal |
| `<leader>f` | format |
| `<leader>xx` | 診断一覧 |
| `<leader>xX` | 現在bufferの診断一覧 |
| `gd` | 定義へ移動 |
| `gD` | 宣言へ移動 |
| `gi` | 実装へ移動 |
| `gr` | 参照一覧 |
| `K` | hover |
| `<leader>rn` | rename |
| `<leader>ca` | code action |

Window移動:

| Key | Action |
|---|---|
| `<C-h>` | 左windowへ |
| `<C-j>` | 下windowへ |
| `<C-k>` | 上windowへ |
| `<C-l>` | 右windowへ |

## Core Language Support

初期状態のcore対象は以下です。

- Lua
- JavaScript / TypeScript / React
- HTML / CSS
- JSON / JSONC
- Bash
- Markdown

Java、PHP、DAP、Neogit、Markdown preview、PlantUMLなどはcoreから外しています。必要ならplugin specとLSP設定を追加してください。

## Optional UI

右上に出る通知ポップアップはcoreでは無効にしています。エラー表示や `:messages` / `:CopyMessage` の確認を邪魔しやすいためです。

`snacks.nvim` の通知UIを使いたい場合は [lua/plugins/snacks.lua](lua/plugins/snacks.lua) の以下を変更します。

```lua
notifier = { enabled = true }
```

LSPの進捗表示が欲しい場合は、optional pluginとして `j-hui/fidget.nvim` を追加してください。

## Project Structure

```text
init.lua
lua/
  config/
    init.lua
    mappings.lua
    option.lua
    command.lua
    autocmd.lua
  plugins/
    *.lua
lsp/
  *.lua
ftplugin/
  *.lua
```

## Notes

- `nvim-lspconfig` は使わず、Neovim 0.11+ の `vim.lsp.config` / `vim.lsp.enable` を使います。
- `nvim-treesitter` は使わず、Neovim組み込みの `vim.treesitter.start()` を使います。
- `=` はVim標準のインデント操作として残し、formatは `<leader>f` にしています。
- Git差分の左端表示は `gitsigns.nvim` が担当します。
- 上部のtabはVimのtabpageではなくbuffer一覧です。`gt` / `gT` はVim標準のtabpage移動として残しています。

## Troubleshooting

Luaファイルを開いた時に `Parser could not be created ... language "lua"` が出る場合は、Neovim本体に同梱されるparserが見えていない可能性があります。まず `:checkhealth vim.treesitter` と `:messages` を確認してください。通常のNeovim 0.11+ packageでは Lua / Vimdoc / Markdown などの基本parserは本体に同梱されています。

## License

MIT License
