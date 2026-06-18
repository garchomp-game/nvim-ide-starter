return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    local original_start = vim.treesitter.start
    local bootstrap_parsers = { "lua", "vimdoc", "query" }
    local installing = false

    local function parser_available(lang)
      local ok, loaded = pcall(vim.treesitter.language.add, lang)
      return ok and loaded == true
    end

    local function buffer_lang(bufnr, lang)
      if lang then
        return lang
      end

      bufnr = bufnr == 0 and vim.api.nvim_get_current_buf() or bufnr
      local ft = vim.bo[bufnr].filetype
      if ft == "" then
        return nil
      end

      local get_lang = vim.treesitter.language.get_lang
      return type(get_lang) == "function" and get_lang(ft) or ft
    end

    local function install_bootstrap_parsers()
      if installing or vim.fn.exepath("tree-sitter") == "" then
        return
      end

      local missing = vim.tbl_filter(function(lang)
        return not parser_available(lang)
      end, bootstrap_parsers)

      if #missing == 0 then
        return
      end

      installing = true
      local ok, err = pcall(function()
        require("nvim-treesitter").install(missing):wait(300000)
      end)
      installing = false

      if not ok then
        vim.notify("Treesitter parser install failed: " .. tostring(err), vim.log.levels.WARN)
      end
    end

    local function start_existing_lua_buffers()
      for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[bufnr].filetype == "lua" and parser_available("lua") then
          pcall(original_start, bufnr, "lua")
        end
      end
    end

    -- Neovim 0.12 の標準 lua/help/query ftplugin は vim.treesitter.start()
    -- を直接呼ぶため、parser未導入の初回起動で落ちないようにする。
    vim.treesitter.start = function(bufnr, lang)
      bufnr = bufnr or 0
      local resolved_lang = buffer_lang(bufnr, lang)

      if not resolved_lang then
        return
      end

      if not parser_available(resolved_lang) then
        if vim.tbl_contains(bootstrap_parsers, resolved_lang) then
          install_bootstrap_parsers()
        end

        if not parser_available(resolved_lang) then
          return
        end
      end

      return original_start(bufnr, lang)
    end

    vim.api.nvim_create_autocmd("User", {
      pattern = "MasonToolsUpdateCompleted",
      callback = function()
        install_bootstrap_parsers()
        start_existing_lua_buffers()
      end,
    })

    vim.api.nvim_create_autocmd("VimEnter", {
      once = true,
      callback = function()
        vim.schedule(function()
          install_bootstrap_parsers()
          start_existing_lua_buffers()
        end)
      end,
    })

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
