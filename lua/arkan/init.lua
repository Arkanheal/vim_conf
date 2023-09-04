require("arkan.settings")
require("arkan.mappings")
-- Packer kinda creates lag
-- require("arkan.packer")

local augroup = vim.api.nvim_create_augroup
local RemoveWhiteLinesGroup = augroup("RemoveWhiteLines", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

augroup("setIndent", { clear = true })
autocmd("FileType", {
	group = "setIndent",
	pattern = "make",
	command = "setlocal noexpandtab shiftwidth=8 softtabstop=0",
})
autocmd("FileType", {
	group = "setIndent",
	pattern = { "html", "css", "typescript", "javascript", "c", "haskell" },
	command = "setlocal shiftwidth=2",
})

function R(name)
	require("plenary.reload").reload_module(name)
end

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

autocmd({ "BufWritePre" }, {
	group = RemoveWhiteLinesGroup,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
