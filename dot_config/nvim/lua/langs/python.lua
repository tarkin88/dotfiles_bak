return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts) vim.list_extend(opts.ensure_installed, { "python" }) end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "pyright",
        "ruff-lsp",
      },
    },
    config = function(_, opts) require("mason-lspconfig").setup(opts) end,
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    opts = {
      ensure_installed = {
        "black",
        "isort",
        "pylint",
      },
    },
    config = function(_, opts)
      require("mason").setup()
      local mr = require "mason-registry"
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then p:install() end
      end
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    dependencies = {
      "mason.nvim",
    },
    config = function()
      local nls = require "null-ls"

      nls.setup {
        debounce = 150,
        sources = {
          nls.builtins.formatting.black.with {
            extra_args = { "--line-length", "120" },
          },
          nls.builtins.formatting.isort.with {
            extra_args = { "--profile", "black" },
          },
          nls.builtins.diagnostics.pylint.with {
            extra_args = { "--max-line-length", "120" },
          },
          nls.builtins.code_actions.refactoring,
        },
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "openFilesOnly",
              },
            },
          },
        },
      },
      setup = {},
    },
  },
  {
    "ranelpadon/python-copy-reference.vim",
    keys = {
      { "<leader>rp", "<cmd>PythonCopyReferencePytest<cr>", desc = "Copy reference as pytest formart" },
      { "<leader>ri", "<cmd>PythonCopyReferenceImport<cr>", desc = "Copy reference as importformart" },
    },
  },
  -- {
  --   "linux-cultist/venv-selector.nvim",
  --   cmd = "VenvSelect",
  --   opts = function(_, opts)
  --     return vim.tbl_deep_extend("force", opts, {
  --       name = {
  --         "venv",
  --         ".venv",
  --         "env",
  --         ".env",
  --       },
  --     })
  --   end,
  --   keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv" } },
  -- },
  {
    "wookayin/semshi",
    build = ":UpdateRemotePlugins",
    -- version = "*",    -- Recommended to use the latest release
    init = function() -- example, skip if you're OK with the default config
      vim.g["semshi#error_sign"] = false
      -- vim.cmd [[ doautocmd SemshiInit FileType python ]]
    end,
    config = function() end,
  },
  -- {
  --   "https://codeberg.org/esensar/nvim-dev-container",
  --   opts = {
  --     attach_mounts = {
  --       always = true,
  --       neovim_config = {
  --         enabled = true,
  --         options = { "readonly" }
  --       },
  --       neovim_data = {
  --         enabled = false,
  --         options = {}
  --       },
  --       -- Only useful if using neovim 0.8.0+
  --       neovim_state = {
  --         enabled = false,
  --         options = {}
  --       },
  --     },
  --   },

  --   config = function(_, opts)
  --     require("devcontainer").setup(opts)
  --   end
  -- },
}
