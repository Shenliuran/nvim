return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  opts = {
    mode = 'inline',
    labels = 'asdfjklghnmzxcvb', -- 标签字符集

    -- 🌟 重点：将原来的 highlight.label 迁移到 label 字段下
    label = {
      -- 标签的样式配置（替代原来的 highlight.label）
      bg = '#ff5e87',    -- 标签背景色
      fg = '#ffffff',    -- 标签前景色
      bold = true,       -- 标签是否加粗
    },

    -- 其他高亮配置（current/backdrop 仍保留在 highlight 中）
    highlight = {
      current = { bg = '#00c853', fg = '#000000' }, -- 当前匹配项高亮
      backdrop = true, -- 半透明背景（增强标签可见性）
    },

    search = {
      multi_window = true,
      wrap = true,
    },

    keys = {
      f = false,
      F = false,
      t = false,
      T = false,
      ['/'] = false,
    },

    window = {
      wrap = true,
    },
  },
  keys = {
    { 's', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = 'Flash 跳转' },
    { 'S', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end, desc = 'Treesitter 跳转' },
    { 'r', mode = 'o', function() require('flash').remote() end, desc = '远程 Flash 跳转' },
    { 'R', mode = { 'o', 'x' }, function() require('flash').treesitter_search() end, desc = 'Treesitter 搜索' },
  },
}