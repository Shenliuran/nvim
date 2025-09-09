return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000, -- 确保主题优先加载
  config = function()
    require("catppuccin").setup({
      -- 1. 选择主题风格（latte/frappe/macchiato/mocha，默认 mocha）
      flavor = "mocha", -- 深色主题推荐：mocha；浅色主题推荐：latte

      -- 2. 全局配置
      background = {
        light = "latte", -- 浅色模式使用 latte
        dark = "mocha",  -- 深色模式使用 mocha
      },
      transparent_background = false, -- 是否透明背景（true 则不显示背景色）
      show_end_of_buffer = false,     -- 是否显示缓冲区末尾的 ~ 符号
      term_colors = true,             -- 启用终端颜色
      dim_inactive = {
        enabled = false,              -- 是否弱化非活动窗口
        shade = "dark",
        percentage = 0.15,
      },
      no_italic = false,              -- 禁用斜体
      no_bold = false,                -- 禁用粗体
      no_underline = false,           -- 禁用下划线

      -- 3. 自定义颜色（覆盖主题默认色）
      color_overrides = {
        mocha = {
          base = "#1e1e2e", -- 背景色
          mantle = "#181825", -- 更暗的背景（如状态栏）
          crust = "#11111b", -- 最暗的背景（如边框）
          text = "#f5e0dc", -- 文本色
          -- 可添加其他颜色覆盖，如：
          -- blue = "#89b4fa",
          -- pink = "#f5c2e7",
        },
      },

      -- 4. 自定义高亮组（针对特定元素调整样式）
      highlight_overrides = {
        mocha = function(mocha)
          return {
            -- 示例：调整注释颜色
            Comment = { fg = mocha.overlay1 },
            -- 示例：调整函数名颜色
            Function = { fg = mocha.blue, bold = true },
            -- 示例：调整光标行背景
            CursorLine = { bg = mocha.mantle },
          }
        end,
      },

      -- 5. 集成其他插件（关键！确保主题对插件生效）
      integrations = {
        -- LazyVim 常用插件集成
        nvim_tree = true,       -- neo-tree 文件树
        bufferline = true,      -- bufferline 标签栏
        lualine = true,         -- lualine 状态栏
        telescope = true,       -- telescope 搜索
        which_key = true,       -- which-key 快捷键提示
        cmp = true,             -- nvim-cmp 自动补全
        gitsigns = true,        -- gitsigns Git 状态
        treesitter = true,      -- treesitter 语法高亮
        indent_blankline = {    -- indent-blankline 缩进线
          enabled = true,
          scope_color = "surface2", -- 缩进范围颜色
          colored_indent_levels = false,
        },
        -- 可选：其他插件集成
        -- dap = true,           -- nvim-dap 调试
        -- dap_ui = true,        -- dap-ui 调试界面
        -- notify = true,        -- nvim-notify 通知
      },
    })

    -- 激活主题
    vim.cmd.colorscheme("catppuccin")
  end,
}
