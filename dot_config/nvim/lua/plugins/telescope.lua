return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  cmd = "Telescope",
  opts = function()
    local actions = require "telescope.actions"

    return {
      defaults = {
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        border = {},
        borderchars = { "█", " ", "▀", "█", "█", " ", " ", "▀" },

        -- borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        path_display = { shorten = 7 },
      },
      pickers = {
        live_grep = {
          mappings = {
            i = { ["<c-f>"] = actions.to_fuzzy_refine },
          },
        },
        grep_string = {
          mappings = {
            i = { ["<c-f>"] = actions.to_fuzzy_refine },
          },
        },
        find_files = {
          theme = "dropdown",
          previewer = true,
          hidden = true,
          find_command = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--files",
            "--hidden", "-g", "!.git"
          },
          mappings = {
            i = { ["<c-f>"] = actions.to_fuzzy_refine },
          },
        },
        oldfiles = {
          theme = "dropdown",
          previewer = false,
          hidden = true,
          mappings = {
            i = { ["<c-f>"] = actions.to_fuzzy_refine },
          },
        },
        git_status = {
          theme = "dropdown",
        },
        buffers = {
          theme = "dropdown",
          previewer = false,
        },
        lsp_document_symbols = {
          theme = "dropdown",
          mappings = {
            i = { ["<c-f>"] = actions.to_fuzzy_refine },
          },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    }
  end,
  config = function(_, opts)
    local telescope = require "telescope"

    telescope.setup(opts)
    telescope.load_extension "fzf"
  end,
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>",  desc = "Find files" },
    { "<C-p>",      "<cmd>Telescope find_files<cr>",  desc = "Find files" },
    { "<leader>fo", "<cmd>Telescope oldfiles<cr>",    desc = "Old files" },
    { "<leader>fs", "<cmd>Telescope grep_string<cr>", desc = "Search and string" },
    { "<leader>fS", "<cmd>Telescope live_grep<cr>",   desc = "Live serch" },
    { "<A-Up>",     "<cmd>Telescope buffers<cr>",     desc = "Buffers" },
  },
}
