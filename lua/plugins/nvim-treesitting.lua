return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  init = function()
    -- Trỏ trực tiếp compiler về clang
    vim.env.CC = "clang"
    vim.env.CXX = "clang++"

    -- Truyền cờ target UCRT64/MinGW qua CFLAGS/CXXFLAGS
    -- Cách này giúp clang tìm thấy <stdlib.h> và không bị Zig can thiệp
    vim.env.CFLAGS = "--target=x86_64-w64-windows-gnu"
    vim.env.CXXFLAGS = "--target=x86_64-w64-windows-gnu"
  end,
  opts = {
    ensure_installed = {
      "python",
      "bash",
      "java",
      "lua",
      "vim",
      "vimdoc",
      "toml",
      "tsx",
      "markdown",
      "markdown_inline",
    },
    highlight = { enable = true },
    indent = { enable = true },
  },
}