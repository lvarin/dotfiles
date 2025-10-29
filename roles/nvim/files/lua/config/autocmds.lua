-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--

local function set_transparent()
  -- Neovim API (works on modern Neovim): set both gui and cterm bg to none
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NonText", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" }) -- inactive windows
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
  -- endofbuffer/NonText alias
  vim.cmd([[highlight EndOfBuffer guibg=none ctermbg=none]])
end

-- run now and after any colorscheme (defer to be safe)
set_transparent()
vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
  callback = function()
    -- tiny delay to let other autocmds finish
    vim.defer_fn(set_transparent, 10)
  end,
})
