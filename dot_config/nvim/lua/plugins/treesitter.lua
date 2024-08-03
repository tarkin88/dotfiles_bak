local vim = vim
local opt = vim.opt

return {
  "nvim-treesitter/nvim-treesitter",
  version = false,
  dependencies = {
    "HiPhish/rainbow-delimiters.nvim",
    "JoosepAlviste/nvim-ts-context-commentstring",
    "RRethy/nvim-treesitter-endwise",
    {
      "andymass/vim-matchup",
      lazy = false,
      enabled = true,
      init = function() vim.g.matchup_matchparen_offscreen = { method = "popup" } end,
    },
  },
  build = ":TSUpdate",
  event = "BufReadPost",
  opts = {
    sync_install = false,
    ensure_installed = {
      "bash",
      "dockerfile",
      "html",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "regex",
      "vim",
      "yaml",
    },
    highlight = { enable = true, disable = { "css" }, },
    indent = {
      enable = false,
      disable = { "python" },
    },
    matchup = {
      enable = true,
    },
    -- rainbow = { enable = true },
    endwise = {
      enable = true,
    },
    autopairs = { enable = true },
    -- incremental_selection = {
    --   enable = true,
    --   keymaps = {
    --     init_selection = "gnn",
    --     node_incremental = "grn",
    --     scope_incremental = "grc",
    --     node_decremental = "grm",
    --   },
    -- },
  },
  config = true
  -- config = function(_, opts)
  --   require("nvim-treesitter.configs").setup(opts)

  -- Treesitter based folding
  -- vim.opt.foldlevel = 20
  -- vim.opt.foldmethod = "expr"
  -- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

  -- vim.api.nvim_create_autocmd("FileType", {
  --   callback = function(_)
  --     local parsers = require 'nvim-treesitter.parsers'

  --     local lang = parsers.get_buf_lang()
  --     if parsers.get_parser_configs()[lang] and not parsers.has_parser(lang) then
  --       vim.schedule_wrap(function()
  --         vim.cmd("TSInstall " .. lang)
  --       end)()
  --     end
  --   end,
  -- })
  -- end
}
