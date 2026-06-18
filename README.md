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
- `nvim-treesitter` の構文ハイライト
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

必要なLSP/formatter/parserは `mason.nvim` と `nvim-treesitter` で管理します。

## Installation

```sh
git clone <this-repository-url> ~/.config/nvim
nvim
```

初回起動後、必要なツールを入れます。

```vim
:Lazy sync
:MasonToolsInstall
:TSInstall vim vimdoc lua javascript typescript tsx json markdown markdown_inline html css bash
```

`mason-tool-installer` と `nvim-treesitter` の起動時自動インストールは無効にしています。起動や終了時に裏でインストールが走って固まったように見えるのを避けるためです。

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
- `=` はVim標準のインデント操作として残し、formatは `<leader>f` にしています。
- Git差分の左端表示は `gitsigns.nvim` が担当します。
- 上部のtabはVimのtabpageではなくbuffer一覧です。`gt` / `gT` はVim標準のtabpage移動として残しています。

## License

MIT License
