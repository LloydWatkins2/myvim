return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function(_, opts)
    -- Ép sử dụng gcc (đã đi kèm với build-essential trên Linux Mint)
    require("nvim-treesitter.install").compilers = { "gcc" }
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
