return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset= "helix",
    show_help = true,
    show_keys = true,
    trigger_prefix = "<leader>",
    -- 在这里配置 which-key 的基础行为
    icons = {
      breadcrumb = "»", -- 用于导航的符号
      separator = "➜",  -- 按键和描述之间的分隔符
      group = "+",      -- 用于分组的符号
    },
    win = {
      border = "rounded", -- 提示窗口的边框样式
      width = 60,
      height = 10,
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
