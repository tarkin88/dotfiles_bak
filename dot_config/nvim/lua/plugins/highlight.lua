return {
  "brenoprata10/nvim-highlight-colors",
  opts = {
    render = 'foreground',
  },
  config = function(_, opts)
    require("nvim-highlight-colors").setup(opts)
  end

}
