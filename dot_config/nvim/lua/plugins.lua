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
        ensure_installed = {
          'astro',
          'lua',
          'svelte',
          'typescript',
          'vim',
          'vue',
        },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- List of parsers to ignore installing (for "all")
        ignore_install = {},

        highlight = {
          enable = true,
          disable = function(_lang, buf)
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
      -- https://github.com/nvim-tree/nvim-tree.lua/issues/2438#issuecomment-1848866750
      filesystem_watchers = {
        enable = true,
        debounce_delay = 50,
        ignore_dirs = {
          "node_modules"
        },
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
        -- 'coc-rls',
        'coc-snippets',
        'coc-tsserver',
        'coc-yank',
        -- 'coc-zls',
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
    event = "VeryLazy",
    config = function()
      require('aerial').setup({
        backends = { 'lsp', 'treesitter', 'markdown', 'man' },
        on_attach = function(bufnr)
          vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
          vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
        end,
        -- Optional dependencies
        dependencies = {
          "nvim-treesitter/nvim-treesitter",
          "nvim-tree/nvim-web-devicons"
        },
        cmd = { 'AerialOpen', 'AerialToggle' },
      })
      vim.keymap.set('n', '<space>o', '<cmd>AerialOpen<CR>', { silent = true, nowait = true })
    end,
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
      local tig      = Terminal:new({ cmd = 'tig --submodule=diff', count = 9 })

      function __TigToggle()
        local cwd = vim.fn.expand('%:p:h')
        if vim.fn.isdirectory(cwd) ~= 0 then
          tig.dir = cwd
        else
          tig.dir = nil
        end
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
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "<leader>j", mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",         mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",         mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",         mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>",     mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
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
        deep_pattern = true,
      })
      vim.keymap.set("n", "gx", "<cmd>URLOpenUnderCursor<cr>", { silent = true, noremap = true })
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
    'gera2ld/remotely.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      local REMOTELY_HANDLER_URL = os.getenv('REMOTELY_HANDLER_URL')
      local REMOTELY_HANDLER_LIST = os.getenv('REMOTELY_HANDLER_LIST')
      if not REMOTELY_HANDLER_URL or not REMOTELY_HANDLER_LIST then
        return
      end
      local r = require('remotely')
      local setup = function(name)
        return {
          url = REMOTELY_HANDLER_URL,
          curlOpts = { '-H', 'content-type: application/json' },
          preprocess = function(_, args)
            return {
              body = {
                prompt = name,
                input = args.input,
              },
            }
          end,
          postprocess = function(_, data)
            return data.text
          end,
        }
      end
      local handlerList = r.util.split(REMOTELY_HANDLER_LIST, ' ')
      local handlers = {}
      for _, name in ipairs(handlerList) do
        handlers[name] = setup(name)
      end
      r.setup({
        handlers = handlers,
      })
    end,
    event = 'VeryLazy',
  },
  {
    "johmsalas/text-case.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("textcase").setup({})
      require("telescope").load_extension("textcase")
    end,
    keys = {
      { "ga.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "v" }, desc = "Telescope" },
    },
  }
}
