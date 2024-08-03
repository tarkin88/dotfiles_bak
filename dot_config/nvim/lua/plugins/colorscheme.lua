return {
  "neanias/everforest-nvim",
  version = false,
  lazy = false,
  priority = 1000,
  opts = {
    italics = true,
    diagnostic_text_highlight = true,
  },
  config = function(_, opts)
    local theme = require("everforest")

    theme.setup(opts)
    theme.load()
  end,
}
