return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      clangd = {
        cmd = {
          "clangd",
          "--background-index",
          "-j=2", -- Giới hạn chỉ dùng 2 luồng CPU/Disk thay vì vắt cạn hệ thống
        },
      },
    },
  },
}