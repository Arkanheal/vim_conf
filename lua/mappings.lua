vim.cmd('noremap <silent> // :noh<cr>:call clearmatches()<cr>')

local map = function(mode, shortcut, command)
  vim.keymap.set(mode, shortcut, command, { noremap = true, silent = true })
end

local nmap = function(shortcut, command)
  map('n', shortcut, command)
end

local imap = function(shortcut, command)
  map('i', shortcut, command)
end

local vmap = function(shortcut, command)
  map('v', shortcut, command)
end

local cmap = function(shortcut, command)
  map('c', shortcut, command)
end

local tmap = function(shortcut, command)
  map('t', shortcut, command)
end

-- Remap CRTL-C to ESC
imap('<C-c>', '<Esc>')

-- sane regexes
nmap('/', '/\\v')
vmap('/', '/\\v')

-- keep search matches in the middle of the window
nmap('n', 'nzzzv')
nmap('N', 'Nzzzv')

-- Same when jumping around
nmap('g;', 'g;zz')

-- Open a Quickfix window for the last search.
nmap("<leader>?", ":execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>")

-- Begining & End of line in Normal mode
nmap('H', '^')
nmap('L', 'g_')

-- more natural movement with wrap on
nmap('j', 'gj')
nmap('k', 'gk')
vmap('j', 'gj')
vmap('k', 'gk')

-- Easy buffer navigation
nmap('<C-h>', '<C-w>h')
nmap('<C-j>', '<C-w>j')
nmap('<C-k>', '<C-w>k')
nmap('<C-l>', '<C-w>l')

-- Reselect visual block after indent/outdent
vmap('<', '<gv')
vmap('>', '>gv')

-- Line moving around
nmap("<A-j>", ":m+<CR>==")
nmap("<A-k>", ":m-2<CR>==")
vmap("<A-j>", ":m '>+1<CR>gv=gv")
vmap("<A-k>", ":m-2<CR>gv=gv")

-- home and end line in command mode
cmap('<C-a>', '<Home>')
cmap('<C-e>', '<End>')

-- Easy window split; C-w v -> vv, C-w - s -> ss
nmap('vv', '<C-w>v')
nmap('ss', '<C-w>s')
-- when splitting horizontally, move coursor to lower pane
vim.o.splitbelow = true
-- when splitting vertically, mnove coursor to right pane
vim.o.splitright = true

-- PLUGINS

-- Find files using Telescope command-line sugar.
nmap('<leader>e', '<cmd>lua require("telescope.builtin").find_files()<cr>')
nmap('<leader>E', '<cmd>lua require("telescope.builtin").buffers()<cr>')
nmap('<leader>g', '<cmd>lua require("telescope.builtin").commands()<cr>')
nmap('<leader>G', '<cmd>lua require("telescope.builtin").marks()<cr>')
nmap('<leader>C', '<cmd>lua require("telescope.builtin").live_grep()<cr>')
nmap('<leader>h', '<cmd>lua require("telescope.builtin").help_tags()<cr>')
nmap('<leader>H', '<cmd>lua require("telescope.builtin").keymaps()<cr>')
nmap('<leader>r', '<cmd>lua require("telescope.builtin").registers()<cr>')

-- Vim Test
nmap('<leader>t', '<cmd>TestNearest<cr>')
nmap('<leader>T', '<cmd>TestFile<cr>')
nmap('<leader>A', '<cmd>TestSuite<cr>')
nmap('<leader>l', '<cmd>TestLast<cr>')

nmap('<leader>tt', '<cmd>LeetCodeTest<cr>')
nmap('<leader>ts', '<cmd>LeetCodeSubmit<cr>')
nmap('<leader>tl', '<cmd>LeetCodeList<cr>')

-- Markdown Preview
nmap('<leader>p', '<cmd>MarkdownPreview<cr>')

-- LSPZero
nmap('<leader>Rl', '<cmd>LspZeroFormat<cr>');
