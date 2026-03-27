return {
  "numToStr/Comment.nvim",
  keys = { "gc", "gcc", "gbc" }, -- lazy-load on comment commands
  config = function()
    require("Comment").setup({
      --- Add extra options here
      padding = true, -- space between `//` and text
      sticky = true,  -- keeps comment on the line after motion
      ignore = "^$",  -- ignore empty lines
    })
  end,
}
