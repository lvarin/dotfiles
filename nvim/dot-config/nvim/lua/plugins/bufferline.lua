return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
      require("bufferline").setup({})

     local keymap = vim.keymap

      keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { silent = true })
      keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { silent = true })
      keymap.set("n", "<leader>x", "<cmd>bdelete<CR>", { silent = true })
  end,
}
