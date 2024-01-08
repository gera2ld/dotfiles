-- based on https://github.com/wbthomason/dotfiles
return {
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
    lazy = false,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require 'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all"
        ensure_installed = { "typescript", "norg", "vim", "lua", "astro" },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- List of parsers to ignore installing (for "all")
        ignore_install = {},

        highlight = {
          enable = true,
          disable = function(lang, buf)
            local max_filesize = 100 * 1024
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          additional_vim_regex_highlighting = false,
        },

        indent = {
          enable = true,
        },
      }
    end,
  },
  { 'chaoren/vim-wordmotion', event = 'VeryLazy' },
  {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
    init = function()
      vim.g.undotree_SetFocusWhenToggle = 1
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
  },
  {
    'sindrets/diffview.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
  },
  {
    'akinsho/git-conflict.nvim',
    version = '*',
    opts = {},
    event = 'BufReadPost',
  },
  {
    'DNLHC/glance.nvim',
    cmd = 'Glance',
    config = function()
      require('glance').setup {
        detached = true,
        border = { enable = true, top_char = '─', bottom_char = '─' },
        theme = { mode = 'brighten' },
        indent_lines = { icon = '│' },
        winbar = { enable = true },
      }
    end,
  },
  {
    'nvim-tree/nvim-tree.lua',
    cmd = { 'NvimTreeOpen', 'NvimTreeFindFile' },
    opts = {
      git = {
        ignore = false,
      },
      update_focused_file = {
        update_root = true,
      },
    },
  },
  {
    "neoclide/coc.nvim",
    branch = "release",
    config = function()
      vim.g.coc_global_extensions = {
        '@yaegassy/coc-astro',
        '@yaegassy/coc-marksman',
        '@yaegassy/coc-volar', -- deprecate 'coc-vetur'
        'coc-css',
        'coc-deno',
        'coc-emmet',
        'coc-eslint',
        'coc-format-json',
        'coc-git',
        'coc-go',
        'coc-highlight',
        'coc-html',
        'coc-jest',
        'coc-json',
        'coc-lists',
        'coc-lua',
        'coc-markmap',
        'coc-pairs',
        -- 'coc-powershell', -- too large, > 300MB
        'coc-prettier',
        'coc-pyright',
        'coc-reveal',
        'coc-rls',
        'coc-snippets',
        'coc-svelte',
        -- 'coc-tsserver', -- disabled in favor of coc-volar
        'coc-yank',
        'coc-zls',
      }
      require 'coc'
    end,
    lazy = false,
  },
  {
    "junegunn/fzf",
    build = "./install --bin",
    lazy = false,
  },
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = 'FzfLua',
  },
  {
    'NvChad/nvim-colorizer.lua',
    ft = { 'css', 'javascript', 'vim', 'html', 'lua' },
    opts = {},
  },
  {
    'stevearc/aerial.nvim',
    opts = {
      backends = { 'lsp', 'treesitter', 'markdown', 'man' },
      on_attach = function(bufnr)
        vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
        vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
      end,
    },
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    cmd = { 'AerialOpen', 'AerialToggle' },
  },
  {
    'folke/todo-comments.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    opts = {},
    event = 'BufReadPost',
  },
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup {
        open_mapping = [[<c-/>]],
        direction = 'float',
      }

      local Terminal = require('toggleterm.terminal').Terminal
      local tig      = Terminal:new({ cmd = 'tig', count = 9 })

      function __TigToggle()
        tig:toggle()
      end

      vim.api.nvim_set_keymap('n', '<leader>g', '<cmd>lua __TigToggle()<CR>', { noremap = true, silent = true })
    end,
    keys = { '<c-/>', '<leader>g' },
  },
  {
    'willothy/flatten.nvim',
    opts = {
      window = { open = 'alternate' },
      post_open = function(_bufnr, winnr, _ft, is_blocking)
        if is_blocking then
          require('toggleterm').toggle(0)
        else
          vim.api.nvim_set_current_win(winnr)
        end
      end,
    },
    event = 'TermOpen',
  },
  {
    'stevearc/overseer.nvim',
    opts = {},
    cmd = { 'OverseerRun', 'OverseerToggle' },
  },
  {
    'phaazon/hop.nvim',
    opts = {},
    cmd = 'HopWord',
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
    event = 'VeryLazy',
  },
  {
    "sontungexpt/url-open",
    event = "VeryLazy",
    cmd = "URLOpenUnderCursor",
    config = function()
      local status_ok, url_open = pcall(require, "url-open")
      if not status_ok then
        return
      end
      url_open.setup({
        extra_patterns = {
          -- Markdown autolinks
          {
            pattern = '<([%a%-]*:[^%s]*)>',
          },
          -- Org mode links
          {
            pattern = '%[%[(.*)%]%[.*%]%]',
          },
        },
      })
    end,
  },
  {
    "echasnovski/mini.nvim",
    version = "*",
    event = 'VeryLazy',
    config = function()
      require('mini.surround').setup { search_method = 'cover_or_nearest' }
      require('mini.align').setup { mappings = { start = '', start_with_preview = 'g=' } }
      require('mini.ai').setup { search_method = 'cover_or_nearest' }
      require('mini.bracketed').setup {}
      require('mini.comment').setup { options = { ignore_blank_line = true } }
      require('mini.indentscope').setup {
        symbol = '│',
        options = { try_as_border = true },
        draw = { animation = require('mini.indentscope').gen_animation.none() },
      }
      require('mini.move').setup {}
      require('mini.splitjoin').setup { mappings = { toggle = 'gJ' } }
    end,
  },
  {
    'lukas-reineke/headlines.nvim',
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true, -- or `opts = {}`
    event = 'VeryLazy',
  },
  {
    'nvim-orgmode/orgmode',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter', lazy = true },
      { 'akinsho/org-bullets.nvim',        opts = {} },
    },
    event = 'VeryLazy',
    config = function()
      -- Load treesitter grammar for org
      require('orgmode').setup_ts_grammar()

      -- Setup treesitter
      require('nvim-treesitter.configs').setup({
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { 'org' },
        },
        ensure_installed = { 'org' },
      })

      -- Setup orgmode
      require('orgmode').setup({
        org_agenda_files = '~/orgfiles/**/*',
        org_default_notes_file = '~/orgfiles/refile.org',
      })
    end,
  },
  {
    'lambdalisue/suda.vim',
    event = 'VeryLazy',
  },
  {
    'NoahTheDuke/vim-just',
    lazy = false,
  },
  {
    'gera2ld/ai.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    opts = {
      api_key = os.getenv('GEMINI_API_KEY'),
      locale = 'en',
      alternate_locale = 'zh',
    },
    event = 'VeryLazy',
  },
}
