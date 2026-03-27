return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
      -- config
      theme = 'doom',
      config = {
        header = {
          "██╗  ██╗   ████╗   ██╗      █████╗ ",
          "██║  ██║  ██  ██╗  ██║     ██║  ██╗",
          "███████║  ██  ██║  ██║     ███████║",
          "██║  ██║  ██  ██║  ██║     ██║  ██║",
          "██║  ██║   ████║   ██████║ ██║  ██║",
          "╚═╝  ╚═╝   ╚═══╝   ╚═════╝ ╚═╝  ╚═╝",
          "",
        },
        center = {
          { action = "ene", desc = " New File", icon = " ", key = "n" },
          { action = function() vim.api.nvim_input("<cmd>Telescope live_grep<cr>") end, desc = " Grep File", icon = " ", key = "f" },
          { action = function() vim.api.nvim_input("<cmd>Telescope find_files<cr>") end, desc = " Find File", icon = " ", key = "f" },
          { action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "l" },
          { action = function() vim.api.nvim_input("<cmd>qa<cr>") end, desc = " Quit", icon = " ", key = "q" },
        },
        vertical_center = true,
        footer = {} --your footer
      }
    }
  end,
  dependencies = { { 'nvim-tree/nvim-web-devicons' } }
}
