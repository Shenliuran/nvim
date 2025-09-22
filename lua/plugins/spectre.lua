return {
  "nvim-pack/nvim-spectre",
  dependencies = "nvim-lua/plenary.nvim",
  keys = {
    { "<leader>sr", "<cmd>Spectre<CR>", desc = "全局正则替换" },
  },
  config = function()
    require("spectre").setup({
      open_cmd = "new", -- 打开方式：new 窗口/vsplit 分屏等
      live_update = true, -- 实时更新预览
      highlight = {
        ui = "String", -- 界面高亮组
        search = "DiffChange", -- 搜索匹配高亮
        replace = "DiffAdd", -- 替换结果高亮
      },
      -- 忽略文件/目录（如 .git、node_modules）
      ignore_file = { "*.log", "node_modules/**/*" },
    })
  end,
} 
