return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    -- ハイライトは Neovim 組み込み機能を使用。
    -- パーサーが未インストールなら何もせず、起動時の自動ダウンロードは避ける。
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local max_filesize = 512 * 1024 -- 512 KB
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
        if ok and stats and stats.size > max_filesize then
          return
        end

        pcall(vim.treesitter.start, args.buf)
      end,
    })
  end,
}
