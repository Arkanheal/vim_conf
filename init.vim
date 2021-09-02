" fisa-nvim-config
" http://nvim.fisadev.com
" version: 10.0

" ============================================================================
" Vim-plug initialization
" Avoid modify this section, unless you are very sure of what you are doing

let vim_plug_just_installed = 0
let vim_plug_path = expand('~/.config/nvim/autoload/plug.vim')
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    silent !mkdir -p ~/.config/nvim/autoload
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif

" Obscure hacks done, you can now modify the rest of the .vimrc as you wish :)

" ============================================================================
" Active plugins
" Has to be loaded first hand
"
let g:polyglot_disabled = ['latex']

" You can disable or add new ones here:

" this needs to be here, so vim-plug knows we are declaring the plugins we
" want to use
call plug#begin('~/.config/nvim/plugged')
" Wanna test those out
Plug 'aurieh/discord.nvim', { 'do': ':UpdateRemotePlugins'}

" Now the actual plugins:
" Needed for pretty much everything
Plug 'preservim/tagbar'

" Better file browser
Plug 'preservim/nerdtree'|
            \ Plug 'Xuyuanp/nerdtree-git-plugin' |
            \ Plug 'ryanoasis/vim-devicons'

" Override configs by directory
Plug 'arielrossanigo/dir-configs-override.vim'

" Tag automation on exit (probably needed for CoC)
Plug 'craigemery/vim-autotag'

" Search results counter
Plug 'vim-scripts/IndexedSearch'

" Code and files fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Code commenter
Plug 'preservim/nerdcommenter'

" Colorscheme packs
Plug 'flazz/vim-colorschemes'

" Automatically close parenthesis, etc
Plug 'Townk/vim-autoclose'

" Pending tasks list
Plug 'fisadev/FixedTaskList.vim'

" Better language packs
Plug 'sheerun/vim-polyglot'

" Paint css colors with the real color
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

" Relative numbering of lines (0 is the current line) 
Plug 'myusuf3/numbers.vim'

" Vim dwm (Tile manager qTile like)
Plug 'spolu/dwm.vim'

" Folds
Plug 'tweekmonster/braceless.vim'

" Surround
Plug 'tpope/vim-surround'

" Apparently reads mind
" Plug 'codota/tabnine-vim'

" Conquer of Completion (pretty much the holy grail)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Lightline
Plug 'itchyny/lightline.vim'

" Git integration
Plug 'tpope/vim-fugitive'

" LaTeX plugin
Plug 'lervag/vimtex'

" Generate html in a simple way
Plug 'mattn/emmet-vim'

" Git/mercurial/others diff icons on the side of the file lines
Plug 'mhinz/vim-signify'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Tell vim-plug we finished declaring plugins, so it can load them
call plug#end()

" ============================================================================
" Install plugins the first time vim runs

if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif

" ============================================================================
" Vim settings and mappings
" You can edit them as you wish

" tabs and spaces handling
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set encoding=UTF-8
"
" Leader
let mapleader = ","

" Remap Esc to leave terminal mode
tnoremap <Esc> <C-\><C-n>

" show line numbers
set nu

" fold method
set fdm=marker

" Removing insert because of lightline
set noshowmode

" Remove ugly vertical lines on window division
set fillchars+=vert:▌

" Set clipboard to basic copy/paste
set clipboard=unnamedplus

" Set mouse if mouse exists
if has('mouse')
    set mouse=a
endif

set termguicolors

" use 256 colors when possible
if (&term =~? 'mlterm\|xterm\|xterm-256\|screen-256') || has('nvim')
	let &t_Co = 256
    colorscheme gruvbox
else
    colorscheme delek
endif

set cursorline
highlight CursorLine ctermbg=240

" Max line-length
set colorcolumn=120,100,80
highlight ColorColumn ctermbg=233

" Change highlight color
hi Search cterm=None ctermfg=white ctermbg=black

" save as sudo
ca w!! w !sudo tee "%"

" External commands
autocmd FileType python nnoremap <leader>bl :!black %<CR>

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" clear search results
nnoremap <silent> // :noh<CR>

" clear empty spaces at the end of lines on save of python files
autocmd BufWritePre *.py :%s/\s\+$//e

" fix problems with uncommon shells (fish, xonsh) and plugins running commands
set shell=/bin/bash

" Figure out the system Python for Neovim.
if exists("$VIRTUAL_ENV")
    let g:python3_host_prog=substitute(system("which -a python3 | head -n2 | tail -n1"), "\n", '', 'g')
else
    let g:python3_host_prog=substitute(system("which python3"), "\n", '', 'g')
endif

" ============================================================================
" Plugins settings and mappings
" Edit them as you wish.

" Tagbar -----------------------------

" toggle tagbar display
map <F4> :TagbarToggle<CR>
" autofocus on tagbar open
let g:tagbar_autofocus = 1

" NERDTree -----------------------------

" toggle nerdtree display
map <F3> :NERDTreeToggle<CR>
" toggle nerdtree with GIT as root
map <Leader><F3> :NERDTreeToggleVCS<CR>
" open nerdtree with the current file selected
nmap ,t :NERDTreeFind<CR>
" don't show these file types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']

" Git NERDTree
let g:NERDTreeGitStatusUseNerdFonts = 1

" Fzf ------------------------------

" Fzf - Mappings
"
" file finder mapping
nmap ,e :Files<CR>
" Buffer finder mapping
nmap ,E :Buffers<CR>
" tags (symbols) in current file finder mapping
nmap ,g :BTag<CR>
nmap ,G :Tags<CR>
" general code finder in current file mapping
nmap ,f :BLines<CR>
" general code finder in all files mapping
nmap ,F :Lines<CR>
" added Ag finder
nmap ,C :Ag<CR>
" commands finder mapping
nmap ,c :Commands<CR>
" Help index
nmap ,h :Helptags<CR>
" Keybinds (normal mode)
nmap ,H :Maps<CR>
" Snippets (Ultisnips needed)
nmap ,s :Snippets<CR>
" Marks (TODO: use marks)
nmap ,S :Marks<CR>

" Temporary Bullshit
" nmap ,P :Colors<CR>

nnoremap <C-k> :History/<cr>

" Fzf - Configuration

" I don't like pop-up thing
let g:fzf_layout = { 'down' : '40%' }
let g:fzf_preview_window = ['right:80%:hidden', 'ctrl-i']

" Colors
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'CursorLine'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
let g:fzf_tags_command = 'ctags -R'

" NERDCommenter

let g:NERDSpaceDelims = 1

" Tasklist ------------------------------

map <F2> :TaskList<CR>

" Numbers.vim

nmap <C-j> :NumbersToggle<CR>

" DWM

nmap ,j :call DWM_Rotate(0)<CR>
nmap ,k :call DWM_Rotate(1)<CR>

" Braceless --------------------------------

autocmd FileType python,coffee BracelessEnable +indent +fold

" Signify ------------------------------

" this first setting decides in which order try to guess your current vcs
" UPDATE it to reflect your preferences, it will speed up opening files
let g:signify_vcs_list = [ 'git', 'hg' ]
" mappings to jump to changed blocks
nmap <leader>sn <plug>(signify-next-hunk)
nmap <leader>sp <plug>(signify-prev-hunk)
" nicer colors
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227

" vimTeX -------------------------------
let g:vimtex_compiler_progname = 'nvr'
let g:tex_flavor = 'latex'

" Markdown preview
let vim_markdown_preview_github=1

" COC (I mean I have a fcking flamethrower to light a candle here)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

" shift+tab cycles backwards 
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Enter to confirm completion
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Lightline conf
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'tagbar' ] ]
    \ },
    \ 'component': {
    \   'tagbar': '%{tagbar#currenttag("[%s]", "", "f")}',
    \ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#head',
    \   'cocstatus' : 'coc#status',
    \   'currentfunction': 'CoCCurrentFunction'
    \ },
    \ }
