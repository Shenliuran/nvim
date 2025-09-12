return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- 图标支持
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree", -- 命令模式下通过 :Neotree 触发
  keys = {
    -- 自定义打开/关闭文件树的快捷键
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "打开/关闭文件树" },
    { "<leader>o", "<cmd>Neotree focus<cr>", desc = "聚焦到文件树" },
  },
  config = function()
    require("neo-tree").setup({
      -- 窗口位置（left/right/top/bottom）
      filesystem = {
        position = "left",
        -- 窗口宽度
        width = 30,
      },
      -- 关闭默认的 netrw（vim 内置文件浏览器）
      close_if_last_window = true,
      -- 启用图标（依赖 nvim-web-devicons）
      enable_git_status = true,
      enable_diagnostics = true, -- 显示 LSP 诊断信息
      window = {
        border = "rounded",
        mappings = {
          ["l"] = "open",
          ["h"] = "close",
        }
      }
    })
  end,
}
