return {
  { "nvim-lua/plenary.nvim", module = "plenary" },
  { "famiu/bufdelete.nvim",  cmd = { "Bdelete", "Bwipeout" }, keys = { { "<A-Down>", "<cmd>Bdelete<cr>" } } },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "BufReadPre",
    config = true,
  },
  { "nathom/filetype.nvim", event = "BufRead" },
  {
    "numToStr/Comment.nvim",
    keys = { { "gc", mode = { "n", "v" } }, { "gb", mode = { "n", "v" } } },
    opts = function()
      return {
        ignore = "^$",
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
      }
    end,
  },
  -- {
  --   "iamcco/markdown-preview.nvim",
  --   opt = true,
  --   build = function() vim.fn["mkdp#util#install"]() end,
  --   ft = "markdown",
  --   cmd = { "MarkdownPreview" },
  --   dependencies = { "zhaozg/vim-diagram", "aklt/plantuml-syntax" },
  -- },
}
