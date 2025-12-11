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
        lua_ls = {
          cmd = { "lua-language-server" },
          root_markers = { ".luarc.json" },
          filetype = { "lua" },
          settings = {
            Lua = {
              runtime = {
                version ='LuaJIT'
              }
            }
          }
        },
        pyright = {},
        ts_ls = {}, -- 空配置则使用默认
      },
    },
    config = function(_, opts)
      local lspconfig = vim.lsp.config

      local load_servers = function(server, config)
        lspconfig[server] = {
          cmd = config.cmd,
          root_markers = config.root_markers,
          filetype = config.filetype,
          settings = config.settings
        }
        vim.lsp.enable(server)
      end

      for server, config in pairs(opts.servers) do
        load_servers(server, config)
      end

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client:supports_method('testDocument/completion') then
            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
          end
        end
      })
      vim.cmd("set completeopt+=noselect")
    end,
  },
}

