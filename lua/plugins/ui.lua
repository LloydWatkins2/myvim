return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "mocha", -- Sử dụng biến thể mocha
      transparent_background = false,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
        keywords = { "bold" }, -- Cú pháp của catppuccin sử dụng mảng chuỗi
        functions = { "bold" },
      },
      -- Tùy chỉnh màu nền cho statusline (tương đương on_colors của tokyonight)
      custom_highlights = function(colors)
        return {
          StatusLine = { bg = colors.none },
        }
      end,
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
