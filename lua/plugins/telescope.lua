return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("telescope").setup({
      defaults = {
        -- 全局忽略模式：忽略 .git 目录及其中的所有文件
        file_ignore_patterns = {
          ".git/", -- 关键配置：忽略 .git 目录
          "node_modules/", -- 可选：忽略其他不需要的目录
        },
      },
      pickers = {
        live_grep = {
          additional_args = function()
            return {
              "--glob", "!.git/*",  -- 忽略 .git 目录下的所有内容
              "--glob", "!*.log",   -- 可选，忽略日志文件
            }
          end
        }
      }
    })

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "实时文本搜索" })
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "查找文件" })
  end,
}
