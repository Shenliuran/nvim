return {
  "stevearc/aerial.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons"
  },
  config = function()
    require("aerial").setup({
      -- 启用函数体高亮
      highlight_on_hover = true, -- 悬停时高亮函数体
      highlight_on_jump = 300, -- 跳转后高亮300ms
      -- 侧边栏显示的符号类型（只显示函数/类）
      filter_kind = {
        "Class",
        "Constructor",
        "Enum",
        "Function",
        "Interface",
        "Module",
        "Method",
        "Struct",

      },
      -- 自定义高亮样式
      highlight = {
        default = "AerialDefault",
        current = "AerialCurrent", -- 当前函数体的高亮组
      },
    })
    -- 自定义 AerialCurrent 高亮（函数体背景）
    vim.api.nvim_set_hl(0, "AerialCurrent", { bg = "#3b3b48" })
    -- 快捷键：打开/关闭侧边栏
    vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
  end,
}
