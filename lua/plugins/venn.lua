return {
  "jbyuki/venn.nvim",
  -- 可选：配置依赖项，确保稳定运行
  dependencies = {
    "nvim-lua/plenary.nvim", -- 提供一些必要的Lua函数库
  },
  -- 懒加载配置：仅在需要时加载插件
  event = "VeryLazy", -- 或使用 `cmd = { "VBox" }` 仅在首次调用命令时加载
  keys = { -- 定义触发插件加载的快捷键
    { "<leader>vv", mode = { "n", "x" }, desc = "切换Venn.nvim绘图模式" },
  },
  config = function()
    local venn_enabled = vim.b.venn_enabled or false

    -- 删除单个框字符
    local function delete_box()
      -- 最简单的方法：使用 Vim 的 r 命令替换为空格
      vim.cmd('normal! r ')
    end

    -- 删除选中的框字符
    local function delete_selected_boxes()
      local mode = vim.api.nvim_get_mode().mode
      if not (mode == 'v' or mode == 'V' or mode == '') then
        vim.notify("请先选择区域（进入可视模式）", vim.log.levels.WARN)
        return
      end

      -- 执行替换命令
      vim.cmd([[silent! '<,'>s/[-─═|│║┌┐└┘┬┴├┤╭╮╰╯╔╗╚╝+]/ /g]])
      vim.notify("已删除选中区域中的框字符", vim.log.levels.INFO)
    end

    -- 核心函数：切换绘图模式
    local function toggle_venn()
      venn_enabled = not venn_enabled
      vim.b.venn_enabled = venn_enabled -- 缓冲区局部变量
      if venn_enabled then
        -- 启用模式：允许光标自由移动、显示网格线
        vim.opt.virtualedit = "all"
        vim.wo.cursorline = true -- 高亮当前行，辅助对齐
        vim.api.nvim_echo({ { "🖍️ Venn绘图模式 已启用", "WarningMsg" } }, false, {})

        -- 基本图形绘制
        vim.keymap.set('v', 'zb', ':VBox<CR>', { buffer = buf, desc = "Draw box" })
        vim.keymap.set('v', 'zc', ':VCircle<CR>', { buffer = buf, desc = "Draw circle" })
        vim.keymap.set('v', 'zh', ':VH<CR>', { buffer = buf, desc = "Draw horizontal line" })
        vim.keymap.set('v', 'zv', ':VV<CR>', { buffer = buf, desc = "Draw vertical line" })
        vim.keymap.set('v', 'zd', ':VD<CR>', { buffer = buf, desc = "Draw diagonal line" })

        -- 方向绘制（使用可视块模式）
        vim.keymap.set('n', '<M-h>', '<C-v>h:VBox<CR>', { buffer = buf, desc = "Draw box left" })
        vim.keymap.set('n', '<M-j>', '<C-v>j:VBox<CR>', { buffer = buf, desc = "Draw box down" })
        vim.keymap.set('n', '<M-k>', '<C-v>k:VBox<CR>', { buffer = buf, desc = "Draw box up" })
        vim.keymap.set('n', '<M-l>', '<C-v>l:VBox<CR>', { buffer = buf, desc = "Draw box right" })

        -- 删除功能
        vim.keymap.set('n', 'zx', delete_box, { buffer = buf, desc = "Delete box char" })
        vim.keymap.set('v', 'zx', delete_selected_boxes, { buffer = buf, desc = "Delete selected boxe" })
      else
        -- 禁用模式：恢复默认设置
        vim.opt.virtualedit = ""
        vim.wo.cursorline = false
        vim.api.nvim_echo({ { "Venn绘图模式 已关闭", "Comment" } }, false, {})

        -- 删除模式特定的快捷键
        local keys_to_remove = { "H", "J", "K", "L", "b", "f" }
        for _, key in ipairs(keys_to_remove) do
            pcall(function() vim.keymap.del("v", key, { buffer = true }) end)
        end
      end
    end

    -- 主快捷键：切换模式（建议使用 <leader>v）
    vim.keymap.set("n", "<leader>vv", toggle_venn, { desc = "切换ASCII绘图模式 (Venn.nvim)" })
    vim.keymap.set("v", "<leader>vv", toggle_venn, { desc = "切换ASCII绘图模式 (Venn.nvim)" })

    -- 可选：直接绘制命令的快捷键（无需进入模式）
    vim.keymap.set("v", "<leader>vb", "<cmd>'<,'>VBox<cr>", { desc = "绘制选区方框" })
    vim.keymap.set("v", "<leader>vh", "<cmd>'<,'>VBox h<cr>", { desc = "绘制水平线" })
    vim.keymap.set("v", "<leader>vj", "<cmd>'<,'>VBox j<cr>", { desc = "绘制垂直线" })
  end,
}
