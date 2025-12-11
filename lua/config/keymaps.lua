-- 公共快捷键（两种环境都生效）
local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

vim.g.mapleader = ' '

-- 公共快捷键（两种环境都生效）
map('n', '<ESC>', '<cmd>nohlsearch<CR>', { desc = '清除搜索高亮' })

-- 仅独立模式生效的快捷键（如分屏操作，VS Code用自身分屏）
if not vim.g.vscode then
  map('n', '<leader>v', ':vsp<CR>', { desc = '垂直分屏'})
  map('n', '<leader>h', ':sp<CR>', { desc = '水平分屏'})

  map("n", "<leader>nl", function() require("noice").cmd("last") end, { desc = 'shows the last message in a popup' })
  map("n", "<leader>nh", function()require("noice").cmd("history") end, { desc = 'shows the message history' })

  -- flash.nvim插件快捷键（仅独立模式生效）
  map('n', 'S', function() require('flash').treesitter() end, { desc = 'Treesitter 跳转' })
else
  map('n', '<leader>v', function() vim.fn.VSCodeNotify('workbench.action.splitEditorRight') end, { desc = '垂直分屏'})
  map('n', '<leader>h', function() vim.fn.VSCodeNotify('workbench.action.splitEditorDown') end, { desc = '水平分屏'})
  -- map('n', '<leader>c', function() vim.fn.VSCodeNotify('workbench.action.closeActiveEditor') end, { desc = '关闭当前分屏'})
  -- flash.nvim插件快捷键（仅独立模式生效）
  map('n', 's', function() require('flash').jump() end, { desc = 'Flash 跳转' })
  -- 代码折叠快捷键（兼容VS Code行为）
  map('n', 'zc', function() vim.fn.VSCodeNotify('editor.fold') end, { desc = '折叠当前区域' })
  map('n', 'zo', function() vim.fn.VSCodeNotify('editor.unfold') end, { desc = '展开当前区域' })
  map('n', 'za', function() vim.fn.VSCodeNotify('editor.toggleFold') end, { desc = '切换折叠状态' })
  map('n', 'zR', function() vim.fn.VSCodeNotify('editor.unfoldAll') end, { desc = '展开所有' })
  map('n', 'zM', function() vim.fn.VSCodeNotify('editor.foldAll') end, { desc = '折叠所有' })
  map('n', 'zC', function() vim.fn.VSCodeNotify('editor.foldRecursively') end, { desc = '折叠当前及子区域' })
  map('n', 'zO', function() vim.fn.VSCodeNotify('editor.unfoldRecursively') end, { desc = '展开当前及子区域' })
  map('n', '<leader>f', function() vim.fn.VSCodeNotify('workbench.view.search') end, { desc = 'VS Code 搜索' })
  map('n', '<leader>t', function() vim.fn.VSCodeNotify('workbench.action.terminal.toggleTerminal') end, { desc = 'VS Code 终端' })
  map('n', '<leader>p', function() vim.fn.VSCodeNotify('workbench.action.showCommands') end, { desc = 'VS Code 命令面板' })
  map('n', '<leader>e', function() vim.fn.VSCodeNotify('workbench.view.explorer') end, { desc = 'VS Code 文件资源管理器' })
  map('n', '<leader>d', function() vim.fn.VSCodeNotify('workbench.view.debug') end, { desc = 'VS Code 调试视图' })
  map('n', '<leader>g', function() vim.fn.VSCodeNotify('workbench.view.scm') end, { desc = 'VS Code 源代码管理' })
  map('n', '<leader>u', function() vim.fn.VSCodeNotify('workbench.action.output.toggleOutput') end, { desc = 'VS Code 源代码管理' })
  map('n', '<leader>y', function() vim.fn.VSCodeNotify('workbench.debug.action.toggleRepl') end, { desc = 'VS Code 调试控制台' })
end
