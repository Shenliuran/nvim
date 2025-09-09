return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
    { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
    { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
    { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
    { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
    { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
    { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
    { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
  },
  opts = {
    options = {
      -- 替换 Snacks.bufdelete 为通用删除命令（如果 Snacks 未安装）
      close_command = function(n) require("bufdelete").bufdelete(n, false) end,
      right_mouse_command = function(n) require("bufdelete").bufdelete(n, false) end,
      
      diagnostics = "nvim_lsp",
      always_show_bufferline = false,
      
      -- 手动定义诊断图标（替代 LazyVim.config.icons.diagnostics）
      diagnostics_indicator = function(_, _, diag)
        local icons = {
          Error = "❌ ",
          Warn = "⚠️ ",
          Info = "🔔 ",
          Hint = "💡 ",
        }
        local ret = (diag.error and icons.Error .. diag.error .. " " or "")
          .. (diag.warning and icons.Warn .. diag.warning or "")
        return vim.trim(ret)
      end,
      
      offsets = {
        {
          filetype = "neo-tree",
          text = "Neo-tree",
          highlight = "Directory",
          text_align = "left",
        },
        {
          filetype = "snacks_layout_box",
        },
      },
      
      -- 用 nvim-web-devicons 获取图标（替代 LazyVim.config.icons.ft）
      get_element_icon = function(opts)
        local devicons = require("nvim-web-devicons")
        local icon, _ = devicons.get_icon_by_filetype(opts.filetype)
        return icon or "? " -- 未找到时用默认图标
      end,
    },
  },
  config = function(_, opts)
    require("bufferline").setup(opts)
    
    -- 修复会话恢复时的 bufferline 显示问题（修正笔误）
    vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
      callback = function()
        vim.schedule(function()
          -- 刷新 bufferline 状态（原 nvim_bufferline 是笔误）
          pcall(require("bufferline").setup, opts)
        end)
      end,
    })
  end,
}
