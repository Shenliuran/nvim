return {
  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    
    config = function()
      require("nightfox").setup({
        options = {
          styles = {
            comments = "italic",
            keywords = "bold",
            types = "italic,bold",
          }
        },
        -- 自定义高亮组（覆盖窗口边线颜色）
        groups = {
          -- 所有配色变体（如 nightfox、dayfox 等）共用的配置
          all = {
            -- 1. 普通窗口分隔线（WinSeparator）
            WinSeparator = { fg = "#3b3b48" }, -- 分隔线颜色（深灰色，适配暗色主题）
            -- 可选：如果想要更醒目，可改为蓝色 "#61afef" 或橙色 "#e5c07b"

            -- 2. 浮动窗口边框（FloatBorder）
            FloatBorder = { fg = "#61afef", bg = "none" }, -- 边框蓝色，背景透明
          },
        },
      })
      vim.cmd.colorscheme("carbonfox")
    end,
  },
}
