vim.g.mapleader = " "

-- Neovim 0.12 の標準 lua/help/query ftplugin は vim.treesitter.start()
-- を直接呼ぶ。初回セットアップ前に parser がなくても起動を止めない。
if not vim.g.nvim_ide_starter_ts_start_guard then
  vim.g.nvim_ide_starter_ts_start_guard = true
  local treesitter_start = vim.treesitter.start

  vim.treesitter.start = function(...)
    local ok, result = pcall(treesitter_start, ...)
    if ok then
      return result
    end

    local msg = tostring(result)
    if msg:find("Parser could not be created", 1, true)
        or msg:find("no such language", 1, true) then
      return
    end

    error(result)
  end
end

local utils = require("utils")
local data = vim.fn.stdpath("data")
local lazypath = data .. "/lazy/lazy.nvim"
local configs = {
  defaults = { lazy = true },
  rocks = { enabled = false },  -- luarocks 不要（使うプラグインなし）
  dev = {
    path = vim.env.DEV_PLUGIN_PATH
  }
}

if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
  utils.set_is_initial_setup_done(true)
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins", configs)
if utils.get_is_initial_setup_done() then
  pcall(vim.cmd, "close")
end
require 'config'

-- Neovim 0.11+ 組み込みの vim.lsp.config を使ったLSP有効化
-- 各サーバーの設定は ~/.config/nvim/lsp/ に配置
vim.lsp.enable({
  'lua_ls',
  'ts_ls',
  'html',
  'cssls',
  'bashls',
  'emmet_ls',
  'jsonls',
})
