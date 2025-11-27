return {
  "lewis6991/gitsigns.nvim",
  opts = {
    -- 基础配置（同步骤 2，可复用）
    signs = {
      add = { text = "＋" },
      change = { text = "⇅" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    },
    signcolumn = true,
    current_line_blame = true, -- 开启当前行 Blame（实时显示修改人/时间）
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
  },
  -- 自定义快捷键 + 高级配置
  config = function(_, opts)
    -- 加载 gitsigns 并应用 opts 配置
    require("gitsigns").setup(opts)

    -- 绑定快捷键（使用 LazyVim 内置的 which-key 自动注册，按 <leader>gh 触发）
    local keymap = vim.keymap.set
    local gs = package.loaded.gitsigns -- 缓存 gitsigns 模块

    -- 1. 跳转差异（Hunk）
    keymap("n", "]c", function()
      if vim.wo.diff then return "]c" end
      vim.schedule(function() gs.next_hunk() end)
      return "<Ignore>"
    end, { expr = true, desc = "Next Git Hunk" })

    keymap("n", "[c", function()
      if vim.wo.diff then return "[c" end
      vim.schedule(function() gs.prev_hunk() end)
      return "<Ignore>"
    end, { expr = true, desc = "Prev Git Hunk" })

    -- 2. 操作 Hunk（stage/reset/preview）
    keymap("n", "<leader>ghs", gs.stage_hunk, { desc = "Stage Git Hunk" }) -- 暂存当前 Hunk
    keymap("n", "<leader>ghr", gs.reset_hunk, { desc = "Reset Git Hunk" }) -- 重置当前 Hunk
    keymap("v", "<leader>ghs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Stage Selected Hunk" })
    keymap("v", "<leader>ghr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Reset Selected Hunk" })
    keymap("n", "<leader>ghS", gs.stage_buffer, { desc = "Stage Entire Buffer" }) -- 暂存整个文件
    keymap("n", "<leader>ghu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk" }) -- 撤销暂存
    keymap("n", "<leader>ghR", gs.reset_buffer, { desc = "Reset Entire Buffer" }) -- 重置整个文件
    keymap("n", "<leader>ghp", gs.preview_hunk, { desc = "Preview Git Hunk" }) -- 预览 Hunk 差异
    keymap("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, { desc = "Blame Line (Full)" }) -- 显示完整 Blame 信息
    keymap("n", "<leader>ghd", gs.diffthis, { desc = "Diff This Buffer" }) -- 显示当前文件与 HEAD 的差异
    keymap("n", "<leader>ghD", function() gs.diffthis("~") end, { desc = "Diff This Buffer (~)" }) -- 显示当前文件与上一版本的差异
  end,
}
