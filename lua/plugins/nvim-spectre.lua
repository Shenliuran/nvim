return {
  "nvim-pack/nvim-spectre",
  dependencies = "nvim-lua/plenary.nvim",
  keys = {
    { "<leader>ss", "<cmd>Spectre<CR>", desc = "Spectre: 全局正则替换" },
    { "<leader>sw", "<cmd>lua require('spectre').open_file_search()<CR>", desc = "Spectre: 当前文件搜索替换" },
    { "<leader>sv", mode = "v","<esc><cmd>lua require('spectre').open_visual()<CR>", desc = "Spectre: 可是换选中搜索替换" },
    { "<leader>sf", mode = "v", "<cmd>lua require('spectre').open_file_search()<CR>", desc = "Spectre: 仅当前文件（进阶）"},
  },
  config = function()
    require("spectre").setup({
      open_cmd = "new", -- 打开方式：new 窗口/vsplit 分屏等
      live_update = true, -- 实时更新预览
      line_sep_start = '┌─────────────────────────────────────────',
      result_padding = '󰈿 ',
      line_sep       = '└─────────────────────────────────────────',
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
