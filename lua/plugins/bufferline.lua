return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  -- 补充依赖：确保 bufdelete（关闭缓冲区）和 web-devicons（图标）存在
  dependencies = {
    "famiu/bufdelete.nvim",     -- 用于缓冲区关闭逻辑
    "nvim-tree/nvim-web-devicons", -- 提供文件类型图标
  },
  keys = {
    -- { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
    -- { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
    -- { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
    -- { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
    { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
    { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    -- { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
    -- { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    -- { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
    -- { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
  },
  opts = {
    options = {
      -- 缓冲区关闭命令：依赖 bufdelete.nvim
      close_command = function(n) require("bufdelete").bufdelete(n, false) end,
      right_mouse_command = function(n) require("bufdelete").bufdelete(n, false) end,
      
      diagnostics = "nvim_lsp",      -- 启用 LSP 诊断
      always_show_bufferline = false,-- 无缓冲区时隐藏 bufferline
      diagnostics_update_in_insert = false,
      
      -- 自定义诊断图标（替代原 LazyVim 依赖）
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
      
      -- 侧边栏偏移（如 neo-tree、snacks 布局）
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
      
      -- 完善图标获取逻辑：返回「图标 + 高亮组」（符合 bufferline 预期）
      get_element_icon = function(opts)
        local devicons = require("nvim-web-devicons")
        local icon, hl_group = devicons.get_icon_by_filetype(opts.filetype)
        return icon or "?", hl_group -- 缺失时用 "?" + 默认高亮
      end,
    },
  },
  config = function(_, opts)
    -- 先配置 Neovim 原生诊断（替代原 bufferline 弃用选项）
    vim.diagnostic.config({
      update_in_insert = true, -- 插入模式下更新诊断
    })
    
    -- 初始化 bufferline
    require("bufferline").setup(opts)
    
    -- 自动命令：缓冲区增减时刷新 bufferline（防止数据异常）
    vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
      callback = function()
        vim.schedule(function()
          pcall(require("bufferline").setup, opts) -- pcall 防止错误中断流程
        end)
      end,
    })
  end,
}
