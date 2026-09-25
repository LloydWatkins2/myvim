-- bootstrap lazy.nvim, LazyVim and your plugins
-- bootstrap lazy.nvim, LazyVim and your plugins

local powershell_cmd = "powershell"

-- Thiết lập các tùy chọn hệ thống để tương thích hoàn toàn với PowerShell
vim.opt.shell = powershell_cmd
vim.opt.shellcmdflag =
  "-NoProfile -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8; $ProgressPreference='SilentlyContinue';"
vim.opt.shellredir = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
vim.opt.shellquote = ""
vim.opt.shellxquote = ""

require("config.lazy")

-- Xác định phiên bản PowerShell bạn đang dùng (pwsh cho PowerShell 7+, powershell cho bản mặc định)

require("nvim-web-devicons").setup({
  default = true,
})
