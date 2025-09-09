return {
  "romgrk/barbar.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- 图标支持（必需）
    "lewis6991/gitsigns.nvim", -- 可选：显示 Git 状态
  },
  event = "BufReadPre", -- 缓冲区加载前触发
  keys = {
    -- 2. 快捷键配置（常用操作）
    { "<A-,>", "<cmd>BufferPrevious<cr>", desc = "切换到上一个缓冲区" },
    { "<A-.>", "<cmd>BufferNext<cr>", desc = "切换到下一个缓冲区" },
    { "<A-<>", "<cmd>BufferMovePrevious<cr>", desc = "向前移动缓冲区标签" },
    { "<A->>", "<cmd>BufferMoveNext<cr>", desc = "向后移动缓冲区标签" },
    { "<A-1>", "<cmd>BufferGoto 1<cr>", desc = "切换到第 1 个缓冲区" },
    { "<A-2>", "<cmd>BufferGoto 2<cr>", desc = "切换到第 2 个缓冲区" },
    { "<A-3>", "<cmd>BufferGoto 3<cr>", desc = "切换到第 3 个缓冲区" },
    { "<A-4>", "<cmd>BufferGoto 4<cr>", desc = "切换到第 4 个缓冲区" },
    { "<A-5>", "<cmd>BufferGoto 5<cr>", desc = "切换到第 5 个缓冲区" },
    { "<A-6>", "<cmd>BufferGoto 6<cr>", desc = "切换到第 6 个缓冲区" },
    { "<A-7>", "<cmd>BufferGoto 7<cr>", desc = "切换到第 7 个缓冲区" },
    { "<A-8>", "<cmd>BufferGoto 8<cr>", desc = "切换到第 8 个缓冲区" },
    { "<A-9>", "<cmd>BufferGoto 9<cr>", desc = "切换到第 9 个缓冲区" },
    { "<A-0>", "<cmd>BufferLast<cr>", desc = "切换到最后一个缓冲区" },
    { "<A-c>", "<cmd>BufferClose<cr>", desc = "关闭当前缓冲区" },
    { "<A-p>", "<cmd>BufferPin<cr>", desc = "固定当前缓冲区（不被循环切换影响）" },
    { "<leader>bb", "<cmd>BufferOrderByBufferNumber<cr>", desc = "按编号排序标签" },
    { "<leader>bd", "<cmd>BufferOrderByDirectory<cr>", desc = "按目录排序标签" },
    { "<leader>bl", "<cmd>BufferOrderByLanguage<cr>", desc = "按文件类型排序标签" },
  },
  opts = {
    -- 3. 外观与行为配置
    animation = true, -- 切换标签时的动画效果
    auto_hide = false, -- 只有一个缓冲区时是否隐藏标签栏
    tabpages = true, -- 显示 tab 页指示器
    closable = true, -- 标签是否可关闭
    clickable = true, -- 标签是否可点击切换
    semantic_letters = true, -- 按标签首字母快速跳转（如 <leader>b + 首字母）

    -- 4. 图标配置（使用 nvim-web-devicons）
    icons = {
      -- 缓冲区状态图标
      buffer_index = false, -- 不显示缓冲区编号
      buffer_number = false, -- 不显示缓冲区数字
      button = "✕", -- 关闭按钮图标
      -- 不同状态的颜色（支持高亮组或十六进制色）
      color_icons = true, -- 启用颜色图标
      default_icon = {
        icon = "󰈙", -- 默认文件图标
        name = "Default",
      },

      -- 5. Git 状态图标（依赖 gitsigns.nvim）
      gitsigns = {
        added = { enabled = true, icon = "+" },
        changed = { enabled = true, icon = "~" },
        deleted = { enabled = true, icon = "-" },
      },

      -- 6. 诊断状态图标
      diagnostics = {
        [vim.diagnostic.severity.ERROR] = { enabled = true, icon = "" },
        [vim.diagnostic.severity.WARN] = { enabled = true, icon = "" },
        [vim.diagnostic.severity.INFO] = { enabled = true, icon = "" },
        [vim.diagnostic.severity.HINT] = { enabled = true, icon = "" },
      },
    },

    -- 7. 与其他插件的兼容性
    sidebar_filetypes = {
      -- 为 neo-tree 等侧边栏插件预留空间
      [ "neo-tree" ] = { event = "BufWipeout" }, -- 当 neo-tree 关闭时刷新标签栏
    },
  },
}
