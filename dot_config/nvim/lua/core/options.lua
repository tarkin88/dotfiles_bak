local opt = vim.opt
local cache_dir = vim.env.HOME .. "/.cache/nvim/"

opt.autoindent = true
opt.backupdir = cache_dir .. "backup/"
opt.breakindentopt = "shift:2,min:20"
opt.cmdheight = 0
opt.colorcolumn = "100"
opt.completeopt = "menu,menuone,noselect"
opt.directory = cache_dir .. "swap/"
opt.expandtab = true
opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
opt.grepprg = "rg --vimgrep --no-heading --smart-case"
opt.hidden = true
opt.history = 2000
opt.ignorecase = true
opt.infercase = true
opt.laststatus = 3
opt.linebreak = true
opt.list = true
opt.listchars = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←"
opt.magic = true
opt.number = true
opt.pumblend = 10
opt.pumheight = 15
opt.redrawtime = 1500
opt.relativenumber = true
opt.ruler = false
opt.scrolloff = 2
opt.shiftwidth = 2
opt.shortmess:append("cC")
opt.showbreak = "↳ "
opt.showcmd = false
opt.showmode = false
opt.showtabline = 0
opt.sidescrolloff = 5
opt.signcolumn = "yes"
opt.smartcase = true
opt.smarttab = true
opt.spellfile = cache_dir .. "spell/en.uft-8.add"
opt.spelloptions = "camel"
opt.splitkeep = vim.fn.has "nvim-0.9" == 1 and "screen" or nil
opt.swapfile = false
opt.tabstop = 2
opt.termguicolors = true
opt.textwidth = 100
opt.timeout = true
opt.timeoutlen = 500
opt.ttimeout = true
opt.ttimeoutlen = 10
opt.undodir = cache_dir .. "undo/"
opt.undofile = true
opt.updatetime = 100
opt.viewdir = cache_dir .. "view/"
opt.virtualedit = "block"
opt.whichwrap = "h,l,<,>,[,],~"
opt.wildignorecase = true
opt.winblend = 10
opt.winwidth = 30

vim.opt.backspace:append { "nostop" }
if vim.fn.has "nvim-0.9" == 1 then
  vim.opt.diffopt:append "linematch:60"
end
vim.g.loaded_python3_provider = 0
vim.g.codelens_enabled = true
vim.g.markdown_recommended_style = 0

vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
