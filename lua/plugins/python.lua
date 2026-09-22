return {
  {
    "linux-cultist/venv-selector.nvim",
    branch = "main",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
    config = function()
      require("venv-selector").setup({
        auto_refresh = true,
      })
    end,
    ft = "python",
    keys = {
      { "<leader>cv", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv" },
    },
  },
}
