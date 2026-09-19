-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Quản lý file & cửa sổ
map("n", "<C-s>", ":w<CR>", opts) -- Lưu file giống VS Code
map("n", "<C-a>", "ggVG", opts) -- Chọn toàn bộ văn bản (Select All)
map("i", "<C-s>", "<Esc>:w<CR>a", opts) -- Lưu file khi đang ở chế độ Insert

-- Tìm kiếm và thay thế
map("n", "<C-f>", "/", opts) -- Tìm kiếm nhanh
map("n", "<C-h>", ":%s/", opts) -- Thay thế (Find & Replace)

-- Thao tác dòng (Line operations)
map("n", "<A-Down>", ":m .+1<CR>==", opts) -- Di chuyển dòng xuống (Alt + Mũi tên)
map("n", "<A-Up>", ":m .-2<CR>==", opts) -- Di chuyển dòng lên
map("v", "<A-Down>", ":m '>+1<CR>gv=gv", opts)
map("v", "<A-Up>", ":m '<-2<CR>gv=gv", opts)

-- Đóng tab / cửa sổ
map("n", "<C-w>", ":bd<CR>", opts) -- Đóng buffer hiện tại

-- ========================================
-- CUT (Ctrl + X)
-- ========================================

-- Visual mode
map("v", "<C-x>", '"+d', {
  desc = "Cut to system clipboard",
})

-- Normal mode (cắt dòng hiện tại)
map("n", "<C-x>", '"+dd', {
  desc = "Cut line to system clipboard",
})

-- ========================================
-- FIND & REPLACE (Ctrl + H)
-- ========================================

map("n", "<C-h>", ":%s/", {
  desc = "Find and replace",
})

map("i", "<C-h>", "<Esc>:%s/", {
  desc = "Find and replace",
})

-- ========================================
-- CLOSE BUFFER / FILE (Ctrl + W)
-- ========================================

-- Đóng buffer hiện tại mà không làm đóng cửa sổ Neovim (giống như đóng tab VS Code)
map("n", "<C-w>", "<cmd>bdelete<CR>", {
  desc = "Close current buffer",
})

map("i", "<C-w>", "<Esc><cmd>bdelete<CR>", {
  desc = "Close current buffer",
})

-- ========================================
-- MOVE LINES (Normal & Insert mode)
-- ========================================

-- Alt + Up (Di chuyển dòng lên ở chế độ Normal)
map("n", "<A-Up>", ":m .-2<CR>==", {
  desc = "Move line up",
})

-- Alt + Down (Di chuyển dòng xuống ở chế độ Normal)
map("n", "<A-Down>", ":m .+1<CR>==", {
  desc = "Move line down",
})

-- Alt + Up / Down trong chế độ Insert
map("i", "<A-Up>", "<Esc>:m .-2<CR>==gi", {
  desc = "Move line up",
})

map("i", "<A-Down>", "<Esc>:m .+1<CR>==gi", {
  desc = "Move line down",
})

-- ========================================
-- DUPLICATE LINE / SELECTION (Shift + Alt + Down)
-- ========================================

-- Nhân bản dòng ở Normal mode
map("n", "<A-S-Down>", "yyp", {
  desc = "Duplicate line",
})

-- Nhân bản vùng chọn ở Visual mode
map("v", "<A-S-Down>", "yPgv", {
  desc = "Duplicate selection",
})

-- ========================================
-- NEW FILE (Ctrl + N)
-- ========================================

-- Normal mode
map("n", "<C-n>", ":e ", {
  desc = "New file",
})

-- Insert mode
map("i", "<C-n>", "<Esc>:e ", {
  desc = "New file",
})

-- ========================================
-- DELETE BOLD LINES (Ctrl + A then Delete)
-- ========================================

-- Lưu ý: Phím kết hợp nhiều bước như Ctrl+A rồi đến Delete (hoặc Backspace)
-- trong terminal thường bị giới hạn về mặt nhận diện mã phím (keycode sequence).
-- Tuy nhiên, bạn có thể gán một phím tắt độc lập (ví dụ: Ctrl + Shift + D hoặc Ctrl + Backspace)
-- để xóa tất cả các dòng chứa văn bản in đậm (markdown bold: **text**) trong toàn bộ file:

map("n", "<C-S-d>", ":g/\\*\\*.*\\*\\//d<CR>", {
  desc = "Delete all lines with bold text",
})

map("i", "<C-S-d>", "<Esc>:g/\\*\\*.*\\*\\//d<CR>a", {
  desc = "Delete all lines with bold text",
})

-- ========================================
-- UNDO (Ctrl + Z)
-- ========================================

map("n", "<C-z>", "u", { desc = "Undo" })
map("i", "<C-z>", "<C-o>u", { desc = "Undo" })
map("v", "<C-z>", "u", { desc = "Undo" })

-- ========================================
-- REDO (Ctrl + Shift + Z)
-- ========================================

map("n", "<C-y>", "<C-r>", { desc = "Redo" })
map("i", "<C-y>", "<C-o><C-r>", { desc = "Redo" })
map("v", "<C-y>", "<C-r>", { desc = "Redo" })
vim.keymap.set("n", "<leader>bh", function()
  Snacks.dashboard()
end, { desc = "Open Dashboard" })

-- Diagnostics
vim.keymap.set("n", "<leader>dd", vim.diagnostic.open_float, { desc = "Show diagnostic" })
vim.keymap.set("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "Diagnostics list" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
