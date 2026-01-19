-- 为不同文件类型设置自动缩进
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*", -- 匹配所有文件类型（作为默认配置）
  callback = function()
    -- 默认配置（未特殊指定的文件类型将使用此配置）
    vim.opt_local.shiftwidth = 4    -- 自动缩进的空格数
    vim.opt_local.tabstop = 4       -- 一个 Tab 显示为多少空格
    vim.opt_local.softtabstop = 4   -- 按退格时删除的空格数
    vim.opt_local.expandtab = true  -- 将 Tab 转换为空格
  end,
})

-- Python：通常使用 4 空格缩进
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = true  -- Python 推荐使用空格而非 Tab
  end,
})

-- HTML/CSS/JS/TS：通常使用 2 空格缩进
vim.api.nvim_create_autocmd("FileType", {
  pattern = "html,css,scss,js,ts,json,xml",
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})

-- C/C++：通常使用 4 空格或 Tab（这里以 4 空格为例）
vim.api.nvim_create_autocmd("FileType", {
  pattern = "c,cpp,cxx,h,hh,hpp",
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = true  -- 若团队规范用 Tab，可设为 false
  end,
})

-- Lua：Neovim 配置文件常用 2 空格
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})

-- Go：强制使用 Tab（语言规范要求）
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.opt_local.shiftwidth = 4    -- 自动缩进 4 空格（但实际用 Tab 表示）
    vim.opt_local.tabstop = 4       -- 一个 Tab 显示为 4 空格
    vim.opt_local.expandtab = false -- 保留原生 Tab（Go 规范要求）
  end,
})

-- Makefile：强制使用 Tab（语言规范要求）
vim.api.nvim_create_autocmd("FileType", {
  pattern = "make",
  callback = function()
    vim.opt_local.shiftwidth = 4    -- 自动缩进 4 空格（但实际用 Tab 表示）
    vim.opt_local.tabstop = 4       -- 一个 Tab 显示为 4 空格
    vim.opt_local.expandtab = false -- 保留原生 Tab（Go 规范要求）
  end,
})


-- 替代 :Explore（默认在当前窗口打开 oil）
vim.api.nvim_create_user_command("Explore", function()
  require("oil").open()
end, { desc = "Open oil.nvim (replace native Explore)" })

-- 替代 :Vexplore（垂直分屏打开 oil）
vim.api.nvim_create_user_command("Vexplore", function()
  require("oil").open({ win_options = { split = "vsplit" } })
end, { desc = "Open oil.nvim in vertical split (replace native Vexplore)" })

-- 替代 :Sexplore（水平分屏打开 oil）
vim.api.nvim_create_user_command("Sexplore", function()
  require("oil").open({ win_options = { split = "split" } })
end, { desc = "Open oil.nvim in horizontal split (replace native Sexplore)" })
