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

    require("lspconfig").pylsp.setup({
      handlers = {
        ["$/progress"] = function(_, result, ctx) end,
      },
      -- Disable aggressive formatting on save
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false

        -- Manual format keybind with external formatters (async to avoid blocking)
        vim.keymap.set("n", "<leader>fl", function()
          -- Use external formatters instead of LSP
          vim.cmd("silent !black % && isort %")
          vim.cmd("e!") -- Reload file after formatting
        end, { noremap = true, buffer = bufnr })
      end,
      -- Reduce pylsp resource consumption and disable expensive plugins
      settings = {
        pylsp = {
          -- Disable all formatters from running on save
          formatCommand = {},
          plugins = {
            -- Disable expensive linters/formatters that thrash disk
            pycodestyle = { enabled = false },
            pydocstyle = { enabled = false },
            autopep8 = { enabled = false },
            yapf = { enabled = false },
            black = { enabled = false }, -- Don't format on save
            isort = { enabled = false }, -- Don't sort imports on save
            pylint = { enabled = false }, -- Disable pylint (slow)
            flake8 = { enabled = false }, -- Disable flake8 (slow)
            mccabe = { enabled = false }, -- Disable McCabe complexity checker
            -- Keep these enabled but lightweight
            pyflakes = { enabled = true }, -- Fast syntax checking
            rope = { enabled = false }, -- Disable rope (can be slow)
            -- Optionally use fast linters only
            pyls_mypy = { enabled = false }, -- mypy is slow, disable
          },
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
