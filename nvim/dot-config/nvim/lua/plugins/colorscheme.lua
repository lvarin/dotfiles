return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = function()
    vim.o.background = "dark" -- or "light" if you prefer
    vim.cmd.colorscheme("gruvbox")
  end,
}
