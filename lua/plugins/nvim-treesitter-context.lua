return {
  "nvim-treesitter/nvim-treesitter-context",
  dependencies = "nvim-treesitter/nvim-treesitter", -- 依赖treesitter
  config = function()
    require("treesitter-context").setup({
      enable = true, -- 启用插件
      max_lines = 0, -- 0 = 无行数限制（显示完整函数上下文）
      min_window_height = 0,
      line_numbers = true,
      -- 高亮当前函数体的样式（可选：背景色/边框）
      patterns = { -- 匹配的语法节点（函数/类/方法等）
        default = {
          "function",
          "method",
          "class",
          "for", -- 可选：也显示循环体
          "if_statement", -- 可选：显示if块
        },
      },
      -- 自定义高亮样式（当前函数体上下文的颜色）
      highlight = {
        "CursorLine", -- 复用光标行高亮，也可自定义
        -- 或自定义："TSContext"
      },
      -- 显示函数体的分隔线
      separator = "-", -- 也可设为 "─" "│" 等字符
    })

    -- 自定义 TSContext 高亮组（如果不用 CursorLine）
    vim.api.nvim_set_hl(0, "TSContext", { bg = "#3b3b48", bold = true })
  end,
}
