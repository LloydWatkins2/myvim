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
  dependencies = { "mason-org/mason.nvim" },
  config = function()
    require("lspconfig").jdtls.setup({
      handlers = {
        ["$/progress"] = function(_, result, ctx) end,
      },
      -- Disable aggressive formatting on save
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false

        -- Manual format keybind instead (async to avoid blocking)
        vim.keymap.set("n", "<leader>fl", function()
          vim.lsp.buf.format({ async = true })
        end, { noremap = true, buffer = bufnr })
      end,
      -- Reduce JDTLS resource consumption
      settings = {
        java = {
          eclipse = {
            downloadSources = false, -- Don't download source jars constantly
          },
          maven = {
            downloadSources = false,
          },
          referencesCodeLens = {
            enabled = false, -- Disable if it triggers constant re-indexing
          },
          signatureHelp = {
            enabled = true,
          },
          contentProvider = "fernflower", -- Use fernflower for decompiling
          format = {
            enabled = true,
            settings = {
              url = "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml",
            },
          },
        },
      },
    })

    -- Disable format-on-save autocmd to prevent SSD thrashing
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("DisableLspFormatOnSave", { clear = true }),
      pattern = "*.java",
      callback = function()
        -- Format only on manual command, not on every save
      end,
    })
  end,
}
