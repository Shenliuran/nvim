------------------------------------------------- line number -------------------------------------------------
-- 定义模式切换时的行号行为
local number_toggle = vim.api.nvim_create_augroup('NumberToggle', { clear = true })

-- 进入插入模式时：关闭相对行号，仅保留绝对行号
vim.api.nvim_create_autocmd('InsertEnter', {
  group = number_toggle,
  callback = function()
    if vim.opt.number:get() then
      vim.opt.relativenumber = false
    end
  end
})

-- 退出插入模式（回到普通模式）时：重新开启相对行号
vim.api.nvim_create_autocmd('InsertLeave', {
  group = number_toggle,
  callback = function()
    if vim.opt.number:get() then
      vim.opt.relativenumber = true
    end
  end
})

-- 可选：在纯 Neovim 模式下自动启用行号（当不在 VS Code 中时）
vim.opt.number = true         -- 显示行号
vim.opt.relativenumber = true -- 显示相对行号（当前行是绝对行号，上下行为相对行号）
vim.opt.rnu = true            -- 光标移动时保持相对行号更新
vim.opt.numberwidth = 4       -- 行号与内容之间的间距
vim.opt.cursorline = true     -- 光标所在行高亮


-- 自动缩进相关
vim.opt.autoindent = true	  -- 新行自动继承上一行的缩进
vim.opt.smartindent = true	  -- 智能缩进（如代码块自动增加缩进）


------------------------------------------------- highlight -------------------------------------------------
vim.api.nvim_set_hl(0, 'Search', { bg = '#4a5568', fg = '#f6f6f6', bold = true })   -- 自定义搜索结果高亮
vim.api.nvim_set_hl(0, 'Function', { fg = '#b5bd68', italic = true })                 -- 自定义函数名高亮
vim.api.nvim_set_hl(0, 'ErrorMsg', { bg = '#ff5555', fg = '#ffffff' })              -- 自定义错误提示高亮
vim.api.nvim_set_hl(0, 'YankHighlight', { bg = '#35538f', fg = '#ffffff' })         -- 定义复制高亮的颜色

-- 创建自动命令，在复制时高亮选中区域
vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'YankHighlight',
      timeout = 400,  -- 高亮持续时间（毫秒）
      on_visual = true  -- 对可视模式下的复制也生效
    })
  end
})



------------------------------------------------- folding -------------------------------------------------
if not vim.g.vscode then
  -- 启用独立模式下的增强功能
  vim.opt.termguicolors = true  -- 启用真彩色（VS Code可能已处理）
  vim.opt.signcolumn = 'yes'    -- 显示符号列（LSP诊断等）

  -- 独立模式下的额外快捷键（例如插件快捷键）
  vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = '查找文件' })

  -- 确保折叠相关的基础设置
  vim.opt.foldcolumn = '1'      -- 显示折叠列，方便查看折叠状态
  vim.opt.foldenable = false
  vim.opt.foldlevel = 99        -- 打开文件时默认不折叠
  vim.opt.foldlevelstart = 99

  -- 对于使用treesitter的用户，建议设置
  vim.opt.foldmethod = 'expr'
  vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
end