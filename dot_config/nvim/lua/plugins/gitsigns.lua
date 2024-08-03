return
{
  "lewis6991/gitsigns.nvim",
  event = "BufReadPre",
  opts = {
    current_line_blame = false,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
      virt_text_priority = 100,
    },
    signs = {
      add = {
        text = "▍",
      },
      change = {
        text = "▍",
      },
      delete = {
        text = "▸",
      },
      topdelete = {
        text = "▾",
      },
      changedelete = {
        text = "▍",
      },
    },
  },
  keys = {
    { "<leader>gl", "<cmd>Gitsigns blame_line<cr>",                desc = "Git blame" },
    { "<leader>gd", "<cmd>Gitsigns diffthis<cr>",                  desc = "Diff This" },
    { "<leader>gt", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "toggle_current_line_blame" },
    { "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>",              desc = "preview_hunk" }
  }
  ,
  config = function(_, opts)
    require('gitsigns').setup(opts)
  end
}
