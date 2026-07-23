return {
  {
    "3rd/image.nvim",
    lazy = true,
    ft = { "markdown", "norg", "oil" },
    event = "BufReadPre *.png,*.jpg,*.jpeg,*.gif,*.webp,*.avif",
    opts = {
      -- "kitty" requires kitty terminal with `allow_remote_control yes`
      -- "ueberzugpp" works in most terminals but needs ueberzugpp installed
      backend = "kitty",
      -- "magick_cli" only requires imagemagick (brew/apt install imagemagick)
      -- "magick_rock" requires luarocks + magick rock
      processor = "magick_cli",
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { "markdown", "vimwiki" },
        },
        neorg = { enabled = false },
        typst = { enabled = false },
        html = { enabled = false },
        css = { enabled = false },
      },
      max_width = nil,
      max_height = nil,
      max_width_window_percentage = nil,
      max_height_window_percentage = 50,
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" },
    },
  },
}
