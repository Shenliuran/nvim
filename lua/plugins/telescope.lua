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
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "全局实时文本搜索" })
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "全局查找文件" })

    local function live_grep_in_directory()
      -- 弹出一个输入框让用户输入目录路径
      vim.ui.input({prompt = "搜索目录: "}, function(dir)
        -- 检查用户是否输入内容
        if dir and dir ~= "" then
          -- 调用 live_grep，并将 search_dirs 设置为用户输入的目录
          -- 这样会自动继承上面 setup 中为 live_grep 配置的 additional_args
          builtin.live_grep({
            search_dirs = { dir },
          })
        end
      end)
    end

    vim.keymap.set('n', '<leader>fG', live_grep_in_directory, {
      desc = "在指定目录中搜索文本"
    })
  end,
}
