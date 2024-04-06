return {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  "lewis6991/gitsigns.nvim",

  { "junegunn/fzf.vim", lazy = false },
  { "junegunn/fzf", name = "fzf", lazy = false },

  "nvim-lualine/lualine.nvim",

  "christoomey/vim-tmux-navigator",

  "lfv89/vim-interestingwords",

  "github/copilot.vim",

  {
    "mg979/vim-visual-multi",
    init = function()
      vim.g.VM_leader = '<SPACE><SPACE>'
    end
  },

  { "neoclide/coc.nvim", lazy = false, branch = "release" },

  "tpope/vim-commentary",

  {
    "ggandor/leap.nvim",
    lazy = false,
    config = function()
      require('leap').create_default_mappings()
    end
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = { "rust", "typescript", "c", "lua", "vim", "julia", "javascript", "html" },
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },  
        })
    end
  },

  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {
        update_focused_file = {
        enable = true,
        update_cwd = false,
      },
    }
    end,
  }

}
