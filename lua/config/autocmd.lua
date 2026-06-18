local group = vim.api.nvim_create_augroup("UserCoreTreesitter", { clear = true })

local function parser_available(lang)
	if not (vim.treesitter and vim.treesitter.language and vim.treesitter.language.add) then
		return false
	end

	local ok, loaded = pcall(vim.treesitter.language.add, lang)
	return ok and loaded == true
end

local function parser_lang(bufnr)
	local ft = vim.bo[bufnr].filetype
	if ft == "" then
		return nil
	end

	local get_lang = vim.treesitter.language and vim.treesitter.language.get_lang
	if type(get_lang) == "function" then
		return get_lang(ft)
	end

	return ft
end

vim.api.nvim_create_autocmd("FileType", {
	group = group,
	callback = function(args)
		if not (vim.treesitter and vim.treesitter.start) then
			return
		end

		if vim.bo[args.buf].buftype ~= "" then
			return
		end

		local name = vim.api.nvim_buf_get_name(args.buf)
		if name ~= "" then
			local ok, stats = pcall(vim.uv.fs_stat, name)
			if ok and stats and stats.size > 512 * 1024 then
				return
			end
		end

		local lang = parser_lang(args.buf)
		if not lang or not parser_available(lang) then
			return
		end

		pcall(vim.treesitter.start, args.buf, lang)
	end,
})
