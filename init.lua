vim.g.mapleader = " "

-- Neovim 0.11+ の標準 ftplugin は一部 filetype で vim.treesitter.start()
-- を直接呼ぶ。parser がない環境でも起動自体は止めない。
if vim.treesitter and vim.treesitter.start and not vim.g.nvim_ide_starter_ts_start_guard then
	vim.g.nvim_ide_starter_ts_start_guard = true
	local treesitter_start = vim.treesitter.start

	vim.treesitter.start = function(...)
		local ok, result = pcall(treesitter_start, ...)
		if ok then
			return result
		end

		local msg = tostring(result)
		if
			msg:find("Parser could not be created", 1, true)
			or msg:find("no parser", 1, true)
			or msg:find("No parser", 1, true)
			or msg:find("no such language", 1, true)
		then
			return
		end

		error(result, 0)
	end
end

local utils = require("utils")
local config_root = vim.fs.dirname(debug.getinfo(1, "S").source:gsub("^@", ""))
local data = vim.fn.stdpath("data")
local lazypath = data .. "/lazy/lazy.nvim"

local function bundled_parser_paths()
	local paths = {}
	local user_data = vim.fs.normalize(vim.fn.stdpath("data"))
	local user_config = vim.fs.normalize(vim.fn.stdpath("config"))

	local function is_user_path(path)
		path = vim.fs.normalize(path)
		return path == user_data
			or vim.startswith(path, user_data .. "/")
			or path == user_config
			or vim.startswith(path, user_config .. "/")
	end

	for _, path in ipairs(vim.opt.rtp:get()) do
		if vim.uv.fs_stat(path .. "/parser") and not is_user_path(path) then
			paths[#paths + 1] = path
		end
	end
	return paths
end

local function prefer_bundled_parsers()
	local user_site = vim.fn.stdpath("data") .. "/site"
	if vim.uv.fs_stat(user_site .. "/parser") then
		vim.opt.rtp:remove(user_site)
		vim.opt.rtp:append(user_site)
	end
end

local configs = {
	defaults = { lazy = true },
	rocks = { enabled = false }, -- luarocks 不要（使うプラグインなし）
	dev = {
		path = vim.env.DEV_PLUGIN_PATH or vim.fn.expand("~/workspace"),
	},
	performance = {
		rtp = {
			-- lazy.nvim の runtimepath reset 後も、Neovim package が同梱する
			-- Treesitter parser path と現在の設定rootは残す。
			paths = vim.list_extend({ config_root }, bundled_parser_paths()),
		},
	},
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
prefer_bundled_parsers()
if utils.get_is_initial_setup_done() then
	pcall(vim.cmd, "close")
end
require("config")
