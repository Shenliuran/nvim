return {
  {
    "neoclide/coc.nvim",
    branch = "release",
    enabled = not vim.g.vscode,
    -- 依赖配置（如果需要）
    dependencies = {
      -- 可选：添加 coc 相关的辅助插件
      -- { "honza/vim-snippets" }, -- 配合 coc-snippets 使用
    },
    -- 配置函数
    config = function()
      if vim.g.vscode then
        vim.g.coc_global_extensions = {
          "coc-snippets",     -- 代码片段
          "coc-prettier",     -- 格式化
        }
        vim.g.coc_disable_diagnostics = true
        vim.g.coc_disable_lsp = true
        vim.opt.completeopt = { "menuone", "noselect" }
        vim.g.coc_eable_hover = false
        vim.g.coc_show_signature_help = false
        vim.g.coc_show_documentation = false
        vim.g.coc_float_config = {
          border = "rounded",
          focusable = false,
          max_width = 80,
          max_height = 20,
          wrap = true,
          close_events = { "BufLeave", "InsertEnter" }
        }
      else
        -- 全局扩展（自动安装）
        vim.g.coc_global_extensions = {
          "coc-snippets",       -- 代码片段
          "coc-prettier",       -- 格式化工具
          "coc-json",           -- JSON 支持
          "coc-tsserver",       -- JS/TS 支持
          "coc-pyright",        -- Python 支持
          "coc-clangd",         -- C/C++ 支持
          "coc-go",             -- Go 支持
          "coc-rust-analyzer",  -- Rust 支持
          -- "coc-lua",            -- Lua 支持
          -- 按需添加其他语言扩展
        }
        
        -- 禁用 coc 的诊断和补全，避免与 VS Code LSP 冲突
        vim.g.coc_disable_diagnostics = true
        vim.g.coc_preselect = true
        vim.g.coc_preselect_mode = "enable"

        -- 键盘映射（遵循 LazyVim 习惯）
        local keymap = vim.keymap
        
        -- 跳转到定义
        keymap.set("n", "gd", "<Plug>(coc-definition)", { silent = true, desc = "Go to definition" })
        
        -- 跳转到引用
        keymap.set("n", "gr", "<Plug>(coc-references)", { silent = true, desc = "Go to references" })
        
        -- 重命名变量
        keymap.set("n", "<leader>rn", "<Plug>(coc-rename)", { silent = true, desc = "Rename variable" })
        
        -- 显示悬浮文档
        keymap.set("n", "K", function()
          if vim.fn.CocAction("hasProvider", "hover") then
            vim.fn.CocActionAsync("doHover")
          else
            vim.cmd("normal! K") -- 降级为内置 K
          end
        end, { silent = true, desc = "Show hover documentation" })
        
        -- 格式化代码
        keymap.set("n", "<leader>cf", "<Plug>(coc-format)", { silent = true, desc = "Format code" })

        -- 在 coc.lua 中添加按键映射配置
        keymap.set("i", "<Tab>", function()
          if vim.fn["coc#pum#visible"]() == 1 then
            return vim.fn["coc#pum#confirm"]()
          else
            return "<Tab>"
          end
        end, { silent = true, expr = true })

        keymap.set("i", "<S-Tab>", function()
          if vim.fn["coc#pum#visible"]() == 1 then
            return vim.fn["coc#pum#prev"](1)
          else
            return "<S-Tab>"
          end
        end, { silent = true, expr = true })
        
        -- 补全设置
        vim.opt.completeopt = { "menu", "menuone", "noselect" }
      end
    end,
  },
}
