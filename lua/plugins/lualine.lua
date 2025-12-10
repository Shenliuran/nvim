return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      vim.o.statusline = " "
    else
      vim.o.laststatus = 0
    end
  end,
  opts = function()
    -- 移除LazyVim的require逻辑，使用标准require
    vim.o.laststatus = vim.g.lualine_laststatus

    local opts = {
      options = {
        theme = "auto",
        globalstatus = vim.o.laststatus == 3,
        disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },

        lualine_c = {
          -- 替换LazyVim.root_dir()为通用实现
          {
            function()
              return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
            end,
            icon = "",
            separator = ""
          },
          {
            "diagnostics",
          },
          -- 替换LazyVim.pretty_path()为简化版本
          { "filename", path = 1 }, -- 1表示显示相对路径
        },
        lualine_x = {
          -- 移除Snacks.profiler.status()（如果没有该插件）
          -- 移除noice相关配置（如果没有该插件）
          -- 移除dap相关配置（如果没有该插件）
          { "filetype", icon_only = true, separator = " ", padding = { left = 1, right = 0 } },
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = { fg = "#ff9e64" }, -- 替换为具体颜色值
          },
          {
            "diff",
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
        },
        lualine_y = {
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
        lualine_z = {
          function()
            return " " .. os.date("%R")
          end,
        },
      },
      extensions = { "neo-tree", "lazy", "fzf" },
    }

    -- 移除trouble.nvim相关配置（避免依赖LazyVim.has()）
    return opts
  end,
}

