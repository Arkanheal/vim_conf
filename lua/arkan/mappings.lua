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

local xmap = function(shortcut, command)
  map('x', shortcut, command)
end

nmap('<leader>pv', vim.cmd.Ex)

-- Remap CRTL-C to ESC
imap('<C-c>', '<Esc>')

-- Line moving around
vmap("<A-j>", ":m '>+1<CR>gv=gv")
vmap("<A-k>", ":m '<-2<CR>gv=gv")

-- keep search matches in the middle of the window
nmap('n', 'nzzzv')
nmap('N', 'Nzzzv')
nmap('J', 'mzJ`z')
nmap('<C-d>', '<C-d>zz')
nmap('<C-u>', '<C-u>zz')

xmap('<leader>p', "\"_dP")

nmap('<leader>y', "\"+y")
vmap('<leader>y', "\"+y")
nmap('<leader>Y', "\"+Y")

nmap('<leader>d', "\"_d")
vmap('<leader>d', "\"_d")

nmap("Q", "<nop>")

nmap("<C-k>", "<cmd>cnext<CR>zz")
nmap("<C-j>", "<cmd>cprev<CR>zz")
nmap("<leader>k", "<cmd>lnext<CR>zz")
nmap("<leader>j", "<cmd>lprev<CR>zz")

nmap("<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
nmap("<leader>x", "<cmd>!chmod +x %<CR>")
nmap("<leader>m", "<cmd>!make run<CR>")
