# nvim-ide-starter

Vim/Neovimを初めて使う人向けの、軽めのIDEライクなNeovim設定です。

目的は「最初から開発に必要なものは揃っているが、Vim本来の基本操作を大きく壊さない」ことです。

## Features

- `lazy.nvim` によるプラグイン管理
- `neo-tree.nvim` のサイドバー
- `activitybar.nvim` によるクリック可能なランチャー
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
git clone https://github.com/garchomp-game/nvim-ide-starter.git ~/.config/nvim
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

プラグイン由来の主要操作は、基本的に `<leader>` からも実行できます。Neo-tree内では `<Space>` 単体のノード開閉を無効化し、leader prefixとして使いやすくしています。ノードを開く/閉じる時は `<CR>` を使ってください。

File tree:

| Key | Action |
|---|---|
| `<C-n>` | ファイルツリーを開閉 |
| `<leader>e` | ファイルツリーを開閉 |
| `<leader>E` | 現在のファイルをファイルツリーで表示 |
| `<leader>o` | ファイルツリーへ移動 |
| `<leader>be` | bufferツリーを開閉 |
| `<leader>ge` | Git statusツリーを開閉 |

Buffers:

| Key | Action |
|---|---|
| `<Tab>` | 次のbufferへ |
| `<S-Tab>` | 前のbufferへ |
| `<leader>bn` | 次のbufferへ |
| `<leader>bp` | 前のbufferへ |
| `<leader>bf` | bufferを選択 |
| `<leader>bd` | 現在のbufferを閉じる |
| `<leader>bD` | 他のbufferを閉じる |

Find:

| Key | Action |
|---|---|
| `<leader>ff` | ファイル検索 |
| `<leader>fg` | 全文検索 |
| `<leader>fb` | buffer検索 |
| `<leader>fh` | help検索 |
| `<leader>fr` | 最近のファイル |
| `<leader>fw` | カーソル下の単語を検索 |
| `<leader>f/` | 現在buffer内を検索 |
| `<leader>fk` | キーマップ検索 |
| `<leader>fc` | コマンド検索 |
| `<leader>fd` | 診断検索 |

Terminal:

| Key | Action |
|---|---|
| `<C-\>` | ターミナルを開閉 |
| `<leader>vt` | vertical terminal |
| `<leader>tt` | ターミナルを開閉 |
| `<leader>th` | 水平ターミナルを開閉 |
| `<leader>tv` | 垂直ターミナルを開閉 |
| `<leader>tf` | フロートターミナルを開閉 |
| `<leader>ta` | 全ターミナルを開閉 |

ターミナル内で閉じる時は、`<Esc>` でterminal-normal modeに抜けてから同じ `<leader>t...` を使います。

Code / diagnostics:

| Key | Action |
|---|---|
| `<leader>f` | format |
| `<leader>cf` | format |
| `<leader>cl` | lint |
| `<leader>xx` | 診断一覧 |
| `<leader>xX` | 現在bufferの診断一覧 |
| `<leader>xl` | location listをTroubleで表示 |
| `<leader>xq` | quickfixをTroubleで表示 |
| `gd` | 定義へ移動 |
| `gD` | 宣言へ移動 |
| `gi` | 実装へ移動 |
| `gr` | 参照一覧 |
| `K` | hover |
| `<leader>rn` | rename |
| `<leader>ca` | code action |

Git:

| Key | Action |
|---|---|
| `<leader>gc` | commit検索 |
| `<leader>gC` | 現在bufferのcommit検索 |
| `<leader>gf` | Git管理ファイル検索 |
| `<leader>gS` | Git status検索 |
| `<leader>gn` | 次のGit hunkへ |
| `<leader>gp` | 前のGit hunkへ |
| `<leader>gh` | Git hunkをプレビュー |
| `<leader>gH` | Git hunkをインライン表示 |
| `<leader>gs` | Git hunkをstage |
| `<leader>gr` | Git hunkを戻す |
| `<leader>gu` | stageを取り消す |
| `<leader>gb` | 行のblameを表示 |
| `<leader>gB` | 行blameを切替 |
| `<leader>gd` | Git diffを表示 |
| `<leader>gD` | 前commitとの差分 |
| `<leader>gw` | 単語差分を切替 |
| `<leader>gq` | Git hunkをquickfixへ |

Plugin/tools:

| Key | Action |
|---|---|
| `<leader>?` | キーマップを表示 |
| `<leader>pl` | Lazyを開く |
| `<leader>ps` | pluginを同期 |
| `<leader>pu` | pluginを更新 |
| `<leader>pa` | ActivityBarを開閉 |
| `<leader>pA` | ActivityBarの左右を切替 |
| `<leader>pm` | Masonを開く |
| `<leader>pM` | Mason toolsを同期 |

Words:

| Key | Action |
|---|---|
| `]]` | 次の参照へ |
| `[[` | 前の参照へ |
| `<leader>wn` | 次の参照へ |
| `<leader>wp` | 前の参照へ |

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
- `activitybar.nvim` は `garchomp-game/activitybar.nvim` の `v0.1.0` タグを読み込みます。
- ActivityBarはデフォルト左端固定です。`<leader>pA` で左右を切り替えられます。
- Neo-treeなどのpanelを開いた場合は、ActivityBarを端へ同期的に再配置してちらつきを抑えます。
- ActivityBarの薄いgray背景は、各itemの `active` 関数で制御しています。toggleではない項目には `active` を付けていません。

### ActivityBarをAIで設定する時の考え方

ActivityBarは補助UIです。プラグイン本体にNeo-treeやTelescope専用処理を持たせず、各itemの設定で連携します。AIに設定を頼む時は、以下を伝えると調整しやすいです。

```text
activitybar.nvimのitemを追加したいです。

実行したいコマンド: <cmd>...
表示したいアイコン: ...
これは開閉式のUIですか: yes/no
開いているか判定できるfiletypeやbuffer変数: ...
Telescopeのようにpromptへfocusが必要ですか: yes/no

既存のitems配列に追加できるLua tableを返してください。
```

Telescopeのようなfloating pickerは、ActivityBar側の再配置処理でfocusを奪わないように `post_action = false` と `focus_filetype = "TelescopePrompt"` を指定します。Neo-treeのような開閉式UIは、visible windowを見て `active` を返す関数を付けます。

## Troubleshooting

Luaファイルを開いた時に `Parser could not be created ... language "lua"` が出る場合は、Neovim本体に同梱されるparserが見えていない可能性があります。まず `:checkhealth vim.treesitter` と `:messages` を確認してください。通常のNeovim 0.11+ packageでは Lua / Vimdoc / Markdown などの基本parserは本体に同梱されています。

## License

MIT License
