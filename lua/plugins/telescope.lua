return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x", -- 使用稳定分支
  dependencies = {
    "nvim-lua/plenary.nvim", -- 核心依赖（必须）
    "nvim-tree/nvim-web-devicons", -- 图标支持
    "nvim-telescope/telescope-ui-select.nvim", -- 替换原生ui.select
    "debugloop/telescope-undo.nvim", -- 撤销历史查看
  },
  event = "VeryLazy", -- 延迟加载：在第一个按键触发时加载
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")

    -- 基础配置
    telescope.setup({
      -- 全局默认设置
      defaults = {
        -- 外观
        prompt_prefix = " 🔍 ", -- 搜索提示符
        selection_caret = " ▶️ ", -- 选中项前缀
        multi_icon = " ✅ ", -- 多选标记
        ellipsis_char = "…", -- 文本截断符号

        -- 布局
        layout_strategy = "flex", -- 自适应布局（根据窗口大小切换）
        layout_config = {
          flex = {
            flip_columns = 120, -- 窗口宽度>120时横向布局，否则纵向
          },
          horizontal = {
            preview_width = 0.55, -- 预览窗宽度占比
            prompt_position = "bottom", -- 搜索框在底部
          },
          vertical = {
            preview_height = 0.5, -- 预览窗高度占比
          },
        },

        -- 路径显示
        path_display = { "truncate" }, -- 路径过长时截断显示

        -- 排序
        sorting_strategy = "ascending", -- 结果从上到下排序
        scroll_strategy = "cycle", -- 滚动到边界时循环

        -- 键位映射
        mappings = {
          i = { -- 插入模式
            ["<C-j>"] = actions.move_selection_next, -- 下一项
            ["<C-k>"] = actions.move_selection_previous, -- 上一项
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- 选中项加入快速fix
            ["<Esc>"] = actions.close, -- 关闭窗口
          },
          n = { -- 普通模式
            ["q"] = actions.close, -- 关闭窗口
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },

        -- 历史记录
        history = {
          path = vim.fn.stdpath("data") .. "/telescope_history",
          limit = 100, -- 最多保存100条历史
        },
      },

      -- 自定义选择器
      pickers = {
        -- 查找文件
        find_files = {
          hidden = true, -- 显示隐藏文件（.gitignore等）
          no_ignore = false, -- 不忽略.gitignore中的文件
          -- 自定义路径显示：只显示文件名+父目录
          path_display = function(opts, path)
            local tail = require("telescope.utils").path_tail(path)
            local parent = require("telescope.utils").path_dir(path):match(".+/(.+)$")
            return parent and ("%s/%s"):format(parent, tail) or tail
          end,
        },

        -- 实时文本搜索（需安装ripgrep）
        live_grep = {
          additional_args = function()
            return { "--hidden" } -- 搜索隐藏文件
          end,
          glob_pattern = { -- 排除某些文件类型
            "!*.log",
            "!*.svg",
            "!*.lock",
          },
        },

        -- 缓冲区切换
        buffers = {
          sort_mru = true, -- 按最近使用排序
          ignore_current_buffer = true, -- 忽略当前缓冲区
          mappings = {
            i = { ["<C-d>"] = actions.delete_buffer }, -- 删除缓冲区
            n = { ["d"] = actions.delete_buffer },
          },
        },

        -- LSP诊断
        diagnostics = {
          theme = "dropdown", -- 下拉框样式
          severity_sort = true, -- 按错误级别排序（Error > Warn > Info）
        },
      },

      -- 扩展配置
      extensions = {
        -- 替代原生ui.select（用于LSP代码动作等）
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({
            winblend = 10, -- 窗口半透明
            previewer = false, -- 不显示预览
            layout_config = {
              width = 0.6,
              height = 0.4,
            },
          }),
        },

        -- 撤销历史（可视化查看和恢复）
        undo = {
          use_delta = true, -- 使用delta显示差异
          side_by_side = true, -- 并排显示
          layout_strategy = "vertical",
        },
      },
    })

    -- 加载扩展
    telescope.load_extension("ui-select") -- 启用ui-select
    telescope.load_extension("undo") -- 启用undo扩展

    -- 键位绑定
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "查找文件" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "文本搜索" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "缓冲区" })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "帮助文档" })
    vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "LSP诊断" })
    vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "最近文件" })
    vim.keymap.set("n", "<leader>fu", "<cmd>Telescope undo<CR>", { desc = "撤销历史" })
    vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "查看键位" })
    vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "查找命令" })
  end,
}

