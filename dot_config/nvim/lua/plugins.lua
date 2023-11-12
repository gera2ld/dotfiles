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
      require'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all"
        ensure_installed = { "typescript", "norg", "vim", "lua" },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- List of parsers to ignore installing (for "all")
        ignore_install = { },

        highlight = {
          enable = true,
          disable = function (lang, buf)
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
    "NeogitOrg/neogit",
    opts = {},
    cmd = 'Neogit',
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional
      "ibhagwan/fzf-lua",              -- optional
    },
  },
  {
    'akinsho/git-conflict.nvim',
    version = '*',
    opts = {},
    event = 'BufReadPost',
  },
  {
    'lewis6991/hover.nvim',
    event = 'BufReadPost',
    config = function()
      require('hover').setup {
        init = function()
          require 'hover.providers.lsp'
        end,
      }

      vim.keymap.set('n', 'K', require('hover').hover, { desc = 'hover.nvim' })
      vim.keymap.set('n', 'gK', require('hover').hover_select, { desc = 'hover.nvim (select)' })
    end,
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
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = 'Neotree',
    event = 'User EditingDirectory',
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
  },
  {
    "nvim-neorg/neorg",
    ft = "norg",
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
              workspaces = {
                notes = "~/notes",
              },
            },
          },
        },
      }
    end,
  },
  {
    "neoclide/coc.nvim",
    branch = "release",
    config = function()
      vim.g.coc_global_extensions = {
        '@yaegassy/coc-marksman',
        '@yaegassy/coc-volar', -- deprecate 'coc-vetur'
        'coc-css',
        'coc-deno',
        'coc-emmet',
        'coc-eslint',
        'coc-floaterm',
        'coc-format-json',
        'coc-git',
        'coc-go',
        'coc-highlight',
        'coc-html',
        'coc-jest',
        'coc-json',
        'coc-lists',
        'coc-markmap',
        'coc-pairs',
        'coc-powershell',
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
  -- {
  --   "folke/neodev.nvim",
  --   ft = 'lua',
  --   opts = {},
  -- },
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
    opts = { open_mapping = [[<c-\>]], direction = 'float' },
    keys = [[<c-\>]],
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
      url_open.setup ({
        deep_pattern = true,
      })
    end,
  },
}