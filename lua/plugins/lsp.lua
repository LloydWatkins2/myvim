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
      pyright = {},
      ruff_lsp = {},
    },
  },
  dependencies = { "mason-org/mason.nvim", "williamboman/mason-lspconfig.nvim" },
  config = function()
    require("lspconfig").jdtls.setup({
      handlers = {
        ["$/progress"] = function(_, result, ctx) end,
      },
      cmd = {
        "jdtls",
        -- Pass each JVM argument with the --jvm-arg= prefix
        "--jvm-arg=-XX:+UseParallelGC",
        "--jvm-arg=-XX:GCTimeRatio=4",
        "--jvm-arg=-XX:AdaptiveSizePolicyWeight=90",
        "--jvm-arg=-Dsun.zip.disableMemoryMapping=true",
        "--jvm-arg=-Xmx4G",
        "--jvm-arg=-Xms100m",
      },
      -- Disable aggressive formatting on save
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false

        -- Manual format keybind with external formatter (async to avoid blocking)
        vim.keymap.set("n", "<leader>fl", function()
          -- Use google-java-format instead of LSP
          vim.cmd("silent !google-java-format -i %")
          vim.cmd("e!") -- Reload file after formatting
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

    require("lspconfig").pyright.setup({
      handlers = {
        ["$/progress"] = function(_, result, ctx) end,
      },
      -- Disable aggressive formatting on save
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false

        -- Manual format keybind with ruff
        vim.keymap.set("n", "<leader>fl", function()
          vim.cmd("silent !ruff format %")
          vim.cmd("e!") -- Reload file after formatting
        end, { noremap = true, buffer = bufnr })
      end,
      settings = {
        python = {
          analysis = {
            typeCheckingMode = "basic",
            diagnosticMode = "openFilesOnly",
            autoImportCompletions = true,
          },
        },
      },
    })

    require("lspconfig").ruff_lsp.setup({
      handlers = {
        ["$/progress"] = function(_, result, ctx) end,
      },
      init_options = {
        settings = {
          args = {},
        },
      },
    })

    -- Disable format-on-save autocmd to prevent SSD thrashing
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("DisableLspFormatOnSave", { clear = true }),
      pattern = { "*.java", "*.py" },
      callback = function()
        -- Format only on manual command, not on every save
      end,
    })
  end,
}
