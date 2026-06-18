-- lazydev.nvim: Neovim Lua 設定向けの Lua LS 補助
return {
  'folke/lazydev.nvim',
  ft = 'lua',
  opts = {
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  },
}
