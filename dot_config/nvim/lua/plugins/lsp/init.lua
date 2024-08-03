return {
  -- {
  --   "folke/neodev.nvim",
  --   lazy = true,
  -- },
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      -- { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
      -- { "j-hui/fidget.nvim",  config = true },
      "williamboman/mason.nvim",
      {
        "williamboman/mason-lspconfig.nvim",
        opts = {
          ensure_installed = {
            "marksman",
            "jsonls",
            "sumneko_lua",
            "yamlls",
          },
        },
        config = function(_, opts)
          require("mason-lspconfig").setup(opts)
        end
      },
      "hrsh7th/cmp-nvim-lsp",
    },
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = { callSnippet = "Replace" },
              telemetry = { enable = false },
              hint = {
                enable = false,
              },
            },
          },
        },
        dockerls = {},
      },
      setup = {
        lua_ls = function(_, _)
          local lsp_utils = require "plugins.lsp.utils"
          lsp_utils.on_attach(function(client, buffer)
            -- stylua: ignore
            if client.name == "lua_ls" then
              vim.keymap.set("n", "<leader>dX", function() require("osv").run_this() end,
                { buffer = buffer, desc = "OSV Run" })
              vim.keymap.set("n", "<leader>dL", function() require("osv").launch({ port = 8086 }) end,
                { buffer = buffer, desc = "OSV Launch" })
            end
          end)
        end,
      },
    },
    config = function(plugin, opts) require("plugins.lsp.servers").setup(plugin, opts) end,
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    opts = {
      ensure_installed = {
        "marksman",
        "stylua",
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
        sources = {
          nls.builtins.formatting.stylua,
          nls.builtins.completion.spell,
          nls.builtins.diagnostics.shellcheck,
          nls.builtins.diagnostics.yamllint,
        },
      }
    end,
  },
  {
    "utilyre/barbecue.nvim",
    event = "VeryLazy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    config = true,
  },
}
