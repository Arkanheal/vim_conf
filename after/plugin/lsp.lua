require("neodev").setup({
	override = function(root_dir, library)
		if require("neodev.util").has_file(root_dir, "~/personal/eisenhower.nvim/") then
			library.enabled = true
			library.plugins = true
		end
	end,
})

local lsp = require("lsp-zero")
local lspconfig = require("lspconfig")

lsp.preset("recommended")

lsp.ensure_installed({
	"tsserver",
	"eslint",
	"lua_ls",
	"rust_analyzer",
	"yamlls",
})

-- Fix Undefined global 'vim'
lspconfig.lua_ls.setup({
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

lspconfig.tsserver.setup({})

lspconfig.gopls.setup({
	filetypes = { "go", "gomod", "gotmpl", "gowork" },
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
	end,
})

lspconfig.hls.setup({
	settings = {
		haskell = {
			formattingProvider = "fourmolu",
		},
	},
})

lspconfig.yamlls.setup({
	settings = {
		yaml = {
			keyOrdering = false,
			format = true,
			schemas = {
				["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
			},
		},
	},
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
	["<C-y>"] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
})

-- disable completion with tab
cmp_mappings["<Tab>"] = nil
cmp_mappings["<S-Tab>"] = nil

lsp.setup_nvim_cmp({
	mapping = cmp_mappings,
})

lsp.set_preferences({
	suggest_lsp_servers = false,
	sign_icons = {
		error = "E",
		warn = "W",
		hint = "H",
		info = "I",
	},
})

lsp.on_attach(function(_, bufnr)
	local opts = { buffer = bufnr, remap = false }

	-- if client.name == "eslint" then
	-- 	vim.cmd(":LspStop('eslint')")
	-- 	return
	-- end

	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
	vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
	vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
	vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
	-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, opts)
end)

lsp.setup()

vim.diagnostic.config({
	virtual_text = true,
})
