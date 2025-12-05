return {
  "folke/persistence.nvim",
  event = "BufReadPre", -- 打开文件前加载插件
  opts = {
    dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"), -- session 保存路径
    options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals" }, -- 保存的内容
    pre_save = nil, -- 保存前的回调（可选）
  },
  -- 快捷键配置（按习惯调整）
  keys = {
    { "<leader>qs", function() require("persistence").save() end, desc = "Save Session" }, -- 手动保存
    { "<leader>ql", function() require("persistence").load() end, desc = "Load Last Session" }, -- 加载最近 session
    { "<leader>qd", function() require("persistence").stop() end, desc = "Stop Auto-Save" }, -- 关闭自动保存
    { "<leader>qr", function() require("persistence").load({ last = false }) end, desc = "Load Session" }, -- 选择加载
  },
}
