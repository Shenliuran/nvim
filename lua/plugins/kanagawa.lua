-- ~/.config/nvim/lua/plugins/colors.lua
return {
  -- 安装 kanagawa.nvim
  {
    "rebelot/kanagawa.nvim",
    lazy = false, -- 强制加载（避免延迟加载导致配色闪烁）
    priority = 1000, -- 最高优先级加载配色
    config = function()
      -- 配置 kanagawa 选项
      require("kanagawa").setup({
        -- 可选样式：wave（默认）、dragon、lotus
        style = "dragon",
        -- 透明背景（按需开启）
        transparent = false,
        -- 终端配色同步
        terminalColors = true,
        -- 禁用背景色（适合透明终端）
        dimInactive = true,
        dimInactivePercentage = 0.15,
        -- 自定义颜色（示例）
        colors = {
          palette = {
            -- 覆盖默认调色板颜色
            sumiInk0 = "#16161D", -- 背景色
            fujiWhite = "#DCD7BA", -- 前景色
          },
          theme = {
            all = {
              ui = {
                bg_gutter = "none", -- 取消行号区背景
              },
            },
          },
        },
        -- 自定义高亮组
        overrides = function(colors)
          local theme = colors.theme
          return {
            -- 普通文本高亮
            Normal = { fg = colors.fujiWhite, bg = colors.sumiInk0 },
            -- 注释颜色
            Comment = { fg = colors.oniViolet, italic = true },
            -- 折叠区域
            Folded = { fg = colors.fujiGray, bg = "none", italic = true },
            -- LazyVim 浮动窗口
            FloatBorder = { fg = theme.ui.float.fg, bg = "none" },
            NormalFloat = { bg = "none" },
          }
        end,
      })

      -- 设置默认配色
      vim.cmd.colorscheme("kanagawa")
    end,
  },
}
