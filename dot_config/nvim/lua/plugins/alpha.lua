return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    local alpha = require "alpha"
    local startify = require "alpha.themes.startify"
    local opts = {
      layout = {
        {
          type = "text",
          val = {
            [[                                  __                ]],
            [[     ___     ___    ___   __  __ /\_\    ___ ___    ]],
            [[    / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
            [[   /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
            [[   \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
            [[    \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
          },
          opts = {
            hl = "Type",
            shrink_margin = false,
          },
        },
        { type = "padding", val = 10 },

        startify.section.mru_cwd,
        startify.section.mru,
        startify.section.session,
      },
      opts = {
        margin = 5,
      },
    }
    alpha.setup(opts)
  end,
}
