let s:plugged = expand('~/.vim/plugged')
call plug#begin(s:plugged)

" Install fzf globally at ~/.fzf so it can be used without vim
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Powerful comment functions
Plug 'scrooloose/nerdcommenter'
Plug 'chrisbra/NrrwRgn'

" Asynchronous search and view
Plug 'dyng/ctrlsf.vim'
Plug 'embear/vim-foldsearch'

" Highlight trailing whitespaces
Plug 'ntpeters/vim-better-whitespace'

" Open file path with line and column
Plug 'wsdjeg/vim-fetch'

" Git
Plug 'tpope/vim-fugitive'

" Diff words asynchronously, enhancing the inherent diff
Plug 'rickhowe/diffchar.vim'

" Support sudo in neovim
Plug 'lambdalisue/suda.vim'

" Jump anywhere
if has('nvim')
  Plug 'phaazon/hop.nvim'
endif

" Run shell commands asynchronously in the background
Plug 'skywind3000/asyncrun.vim'

" Visualize undo history
Plug 'mbbill/undotree'

" Translator
Plug 'voldikss/vim-translator'

" Scratch window
Plug 'mtth/scratch.vim'

" Animate window resizing
Plug 'camspiers/animate.vim'

" Draw ASCII boxes
Plug 'gyim/vim-boxdraw'

" Run tests on different granularities
Plug 'vim-test/vim-test'

" Coc.nvim
if !$VIM_DISABLE_COC_NVIM
  Plug 'neoclide/coc.nvim', { 'branch': 'release' }
endif

" Snippets data, will be loaded by coc-snippets
Plug 'honza/vim-snippets'

" View and search LSP symbols in a sidebar, use with coc.nvim by `:Vista coc`
Plug 'liuchengxu/vista.vim'

" languages
Plug 'editorconfig/editorconfig-vim'
Plug 'sheerun/vim-polyglot'
if g:enable_treesitter
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
endif

" UI
Plug 'itchyny/lightline.vim'
Plug 'justinmk/vim-dirvish'
Plug 'kristijanhusak/vim-dirvish-git'
Plug 'voldikss/vim-floaterm'

" Markdown
Plug 'godlygeek/tabular'
" Plug 'preservim/vim-markdown'

" Theme
Plug 'joshdick/onedark.vim'

call plug#end()

" FZF {{{
let g:fzf_command_prefix = 'FZF'
" }}}

" nerdcommenter {{{
" Add a space after the left delimiter and before the right delimiter
let g:NERDSpaceDelims = 1
" }}}

" onedark {{{
if ($COLORTERM == 'truecolor')
  "Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
  "If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
  "(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
  "if (empty($TMUX))
    if (has("nvim"))
      "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
      let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    endif
    "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
    "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
    " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
    if (has("termguicolors"))
      set termguicolors
    endif
  "endif
endif
colo onedark
" }}}

" ctrlsf.vim {{{
let g:ctrlsf_auto_close = {
      \ "normal" : 0,
      \ "compact": 0
      \}
let g:ctrlsf_extra_backend_args = {
      \ 'rg': '--hidden -g "!.git"',
      \ }
" }}}

" vim-better-whitespace {{{
let g:better_whitespace_enabled = 1
" }}}

" hop.nvim {{{
if has('nvim')
lua << EOF
  require'hop'.setup()
EOF
endif
" }}}

" vim-polyglot {{{
" leafOfTree/vim-svelte-plugin
let g:vim_svelte_plugin_use_typescript = 1
" }}}

" treesitter {{{
if g:enable_treesitter
lua << EOF
  require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all"
    ensure_installed = { "typescript" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- List of parsers to ignore installing (for "all")
    ignore_install = { },

    highlight = {
      enable = true,
      disable = { 'markdown' },
      additional_vim_regex_highlighting = false,
    },

    indent = {
      enable = true,
    },
  }
EOF
endif
" }}}

" lightline {{{
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'relativepath', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }
" }}}

" vim:sw=2:sts=2:fdm=marker:
