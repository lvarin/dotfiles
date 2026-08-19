return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    config = function()
      -- set keymaps
      local keymap = vim.keymap

      keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Tree explorer" })
    end,
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        use_libuv_file_watcher = true,
      },
    },
    lazy = false, -- neo-tree will lazily load itself
  }
}
