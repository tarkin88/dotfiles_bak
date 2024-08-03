return {
  "nvim-tree/nvim-web-devicons",
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        command_palette = false,      -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,           -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true,        -- add a border to hover docs and signature help
      },
    },
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {
      input = {
        relative = "editor",
        default_prompt = "➤ ",
        win_options = { winhighlight = "Normal:Normal,NormalNC:Normal" },
      },
      select = {
        backend = { "telescope", "fzf", "builtin" },
        builtin = { win_options = { winhighlight = "Normal:Normal,NormalNC:Normal" } },
      },
    },
  },
  { "MunifTanjim/nui.nvim", lazy = true },
  {
    "RRethy/vim-illuminate",
    event = "BufReadPost",
    opts = { delay = 150 },
    config = function(_, opts) require("illuminate").configure(opts) end
  },
  {
    "m-demare/hlargs.nvim",
    event = "VeryLazy",
    opts = {
      color = "#ef9062",
      use_colorpalette = false,
      disable = function(_, bufnr)
        if vim.b.semantic_tokens then return true end
        local clients = vim.lsp.get_active_clients { bufnr = bufnr }
        for _, c in pairs(clients) do
          local caps = c.server_capabilities
          if c.name ~= "null-ls" and caps.semanticTokensProvider and caps.semanticTokensProvider.full then
            vim.b.semantic_tokens = true
            return vim.b.semantic_tokens
          end
        end
      end,
    },
  },
  {
    "onsails/lspkind.nvim" },
  --   opts = {
  --     mode = "symbol",
  --     symbol_map = {
  --       Array = " ",
  --       Boolean = "⊨",
  --       Class = "",
  --       Constructor = "",
  --       Key = "󰷖 ",
  --       Namespace = "",
  --       Null = "NULL",
  --       Number = "#",
  --       Object = "",
  --       Package = "",
  --       Property = "",
  --       Reference = "",
  --       Snippet = "",
  --       String = "",
  --       TypeParameter = "",
  --       Unit = "",
  --     },
  --   },
  --   enabled = vim.g.icons_enabled,
  --   config = function(_, opts)
  --     require("lspkind").init(opts)
  --   end
  -- },
  {
    "cshuaimin/ssr.nvim",
    opts = {
      border = "rounded",
      min_width = 50,
      min_height = 5,
      max_width = 120,
      max_height = 25,
      keymaps = {
        close = "q",
        next_match = "n",
        prev_match = "N",
        replace_confirm = "<cr>",
        replace_all = "<leader><cr>",
      },
    },
    --stylua: ignore
    keys = {
      { "<leader>sr", function() require("ssr").open() end, mode = { "n", "x" }, desc = "Search and Replace (SSR)" },
    },
  },
}
