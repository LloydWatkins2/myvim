-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- Bỏ qua các thư mục nặng khi tìm kiếm và quét tệp
vim.opt.wildignore:append({ "*/node_modules/*", "*/.git/*", "*/build/*", "*/target/*", "*/.venv/*" })
-- Tắt tạo file swap tạm thời
vim.opt.swapfile = false

-- Tăng thời gian chờ ghi đệm (giảm số lần Neovim ghi ngầm xuống SSD)
vim.opt.updatetime = 300
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
