return {
  {
    "mason-org/mason.nvim",
    enabled = true,
    cmd = "Mason",
      keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
      build = ":MasonUpdate",
      opts_extend = { "ensure_installed" },
      opts = {
        ensure_installed = {
          "stylua",
          "shfmt",
        },
      },
      ---@param opts MasonSettings | {ensure_installed: string[]}
      config = function(_, opts)
        require("mason").setup(opts)
        local mr = require("mason-registry")
        mr:on("package:install:success", function()
          vim.defer_fn(function()
            -- trigger FileType event to possibly load this newly installed LSP server
            require("lazy.core.handler.event").trigger({
              event = "FileType",
              buf = vim.api.nvim_get_current_buf(),
            })
          end, 100)
        end)
    
        mr.refresh(function()
          for _, tool in ipairs(opts.ensure_installed) do
            local p = mr.get_package(tool)
            if not p:is_installed() then
              p:install()
            end
          end
        end)
      end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    enabled = true,
    dependencies = { "mason-org/mason.nvim" }
  },
  -- 禁用 LazyVim 默认的 LSP 配置
  {
    "neovim/nvim-lspconfig",
    enabled = true,
    dependencies = {
      'saghen/blink.cmp',
      'mason-org/mason-lspconfig.nvim'
    },
    opts = {
      servers = {
        lua_ls = {},
        pyright = {
          settings = {
            python = {
              analysis = { typeCheckingMode = "basic", autoImportCompletions = true },
            },
          },
        },
        ts_ls = {}, -- 空配置则使用默认
      },
    },
    config = function(_, opts)
      local lspconfig = require('lspconfig')
      -- local lspconfig = vim.lsp.config
      local mason_lspconfig = require('mason-lspconfig')
      
      local on_attach = function(client, bufnr)
        local map = vim.keymap.set
        local opts = { noremap = true, silent = true, buffer = bufnr }
        map("n", "gd", vim.lsp.buf.definition, opts)
        map("n", "K", vim.lsp.buf.hover, opts)
        map("n", "<leader>rn", vim.lsp.buf.rename, opts)
        map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        map("n", "<leader>d", vim.diagnostic.goto_next, opts)
      end

      for server, config in pairs(opts.servers) do
        -- passing config.capabilities to blink.cmp merges with the capabilities in your
        -- `opts( server ).capabilities, if you've defined it
        config = vim.tbl_deep_extend("force", { on_attach = on_attach }, config)
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end

      vim.diagnostic.config({
        float = { border = "rounded" },
        severity_sort = true
      })
    end,
  },
}

