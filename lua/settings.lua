HOME = os.getenv("HOME")

vim.g.mapleader = ','

-- basic settings
vim.opt.encoding = 'utf-8'
vim.opt.backspace = 'indent,eol,start'
vim.opt.completeopt = 'menuone,noselect'
vim.opt.history = 1000
vim.opt.startofline = true
vim.opt.clipboard='unnamedplus'

-- Mapping waiting time
vim.opt.timeout = false
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 100

-- Display
vim.opt.termguicolors = true
-- Remove -- INSERTION/REPLACE on last line
vim.opt.showmode = false
-- show matching brackets
vim.opt.showmatch  = true
-- always show 3 rows from edge of the screen
vim.opt.scrolloff = 3
-- stop syntax highlight after x columns for performance
vim.opt.synmaxcol = 300
-- always show status line
vim.opt.laststatus = 2

-- do not display white characters
vim.opt.list = false
vim.opt.foldenable = false
-- limit folding to 4 levels
vim.opt.foldlevel = 4
-- use language syntax to generate folds (unsure if efficient)
vim.opt.foldmethod = 'syntax'
-- do not wrap lines even if very long
vim.opt.wrap = false
-- show if there's no eol char
vim.opt.eol = false
-- character to show when line is broken
vim.opt.showbreak= '↪'

-- Sidebar
-- line number on the left
vim.opt.number = true
-- always reserve 3 spaces for line number
vim.opt.numberwidth = 3
 -- keep 1 column for plugins
vim.opt.signcolumn = 'yes'
vim.opt.modelines = 0
-- display command in bottom bar
vim.opt.showcmd = true

-- Search
-- starts searching as soon as typing, without enter needed
vim.opt.incsearch = true
-- ignore letter case when searching
vim.opt.ignorecase = true
-- case insentive unless capitals used in search
vim.opt.smartcase = true

-- delay before showing matching parenthesis/brackets/etc.
vim.opt.matchtime = 2
vim.opt.mps = table.insert(vim.opt.mps, "(:),{:},[:],<:>")

-- White characters
vim.opt.autoindent = true
vim.opt.smartindent = true
-- 1 tab = 2 spaces (except for python see below)
vim.opt.tabstop = 2
-- indentation rule
vim.opt.shiftwidth = 2
-- see fo-table
vim.opt.formatoptions = 'qnj1'
-- expand tab to spaces
vim.opt.expandtab = true

-- Backup files
-- use backup files
vim.opt.backup = true
vim.opt.writebackup = false
-- do not use swap file
vim.opt.swapfile = false
-- undo files
vim.opt.undodir = HOME .. '/.vim/tmp/undo//'
-- backups
vim.opt.backupdir = HOME .. '/.vim/tmp/backup//'
-- swap files
vim.opt.directory = '/.vim/tmp/swap//'

-- File type specific formatting
vim.cmd([[
  au FileType python                  set ts=4 sw=4
  au BufRead,BufNewFile *.md          set ft=mkd tw=80 syntax=markdown
  au BufRead,BufNewFile *.ppmd        set ft=mkd tw=80 syntax=markdown
  au BufRead,BufNewFile *.markdown    set ft=mkd tw=80 syntax=markdown
  au BufRead,BufNewFile *.slimbars    set syntax=slim
]])

-- Commands mode
-- on TAB, complete options for system command
vim.opt.wildmenu = true
-- ignore file on wildcards completion
vim.opt.wildignore = 'deps,.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,.DS_Store,*.aux,*.out,*.toc'

-- Only show cursorline in the current window and in normal mode
vim.cmd([[
  augroup cline
      au!
      au WinLeave * set nocursorline
      au WinEnter * set cursorline
      au InsertEnter * set nocursorline
      au InsertLeave * set cursorline
  augroup END
]])

-- Colorscheme
vim.cmd('colorscheme tokyonight')
vim.g.tokyonight_style = 'night'
vim.o.background = 'dark'

-- Python
vim.cmd([[
  autocmd FileType python,coffee BracelessEnable +indent +fold
]])
vim.g.python3_host_prog = '/usr/bin/python3'
