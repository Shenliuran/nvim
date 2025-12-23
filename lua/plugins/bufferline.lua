return {
  "akinsho/bufferline.nvim",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "famiu/bufdelete.nvim",     -- 用于缓冲区关闭逻辑
    "nvim-tree/nvim-web-devicons", -- 提供文件类型图标
    "lewis6991/gitsigns.nvim",  -- 关键：添加 gitsigns 依赖
  },
  keys = {
    -- 切换到上一个/下一个缓冲区
    { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
    { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },

    -- 移动缓冲区位置
    { "<A-h>", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer left" },
    { "<A-l>", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer right" },

    -- 关闭缓冲区
    { "<leader>c", function() require("bufdelete").bufdelete(0, false) end, desc = "Close buffer" },
    { "<leader>C", "<cmd>BufferLineCloseOthers<cr>", desc = "Close other buffers" },

    -- 选择特定位置的缓冲区 (1-9)
    { "<leader>1", "<cmd>BufferLineGoToBuffer 1<cr>", desc = "Go to buffer 1" },
    { "<leader>2", "<cmd>BufferLineGoToBuffer 2<cr>", desc = "Go to buffer 2" },
    { "<leader>3", "<cmd>BufferLineGoToBuffer 3<cr>", desc = "Go to buffer 3" },
    { "<leader>4", "<cmd>BufferLineGoToBuffer 4<cr>", desc = "Go to buffer 4" },
    { "<leader>5", "<cmd>BufferLineGoToBuffer 5<cr>", desc = "Go to buffer 5" },
    { "<leader>6", "<cmd>BufferLineGoToBuffer 6<cr>", desc = "Go to buffer 6" },
    { "<leader>7", "<cmd>BufferLineGoToBuffer 7<cr>", desc = "Go to buffer 7" },
    { "<leader>8", "<cmd>BufferLineGoToBuffer 8<cr>", desc = "Go to buffer 8" },
    { "<leader>9", "<cmd>BufferLineGoToBuffer 9<cr>", desc = "Go to buffer 9" },

    -- 切换到最近使用的缓冲区
    { "<leader>`", "<cmd>BufferLineCyclePrev<cr>", desc = "Last buffer" },
  },
  opts = {
    options = {
      indicator = {
        style = "icon",
        icon = "▎"
      },
      color_icons = true, -- 启用颜色图标
      show_buffer_icons = true,
      show_buffer_close_icons = true,
      show_duplicate_prefix = true, -- 显示重复的缓冲全前缀
      separator_style = "thin", -- 分隔符样式
      
      -- 缓冲区关闭命令：依赖 bufdelete.nvim
      close_command = function(n) require("bufdelete").bufdelete(n, false) end,
      right_mouse_command = function(n) require("bufdelete").bufdelete(n, false) end,
      
      diagnostics = "nvim_lsp",      -- 启用 LSP 诊断
      always_show_bufferline = false,-- 无缓冲区时隐藏 bufferline
      diagnostics_update_in_insert = false,
      
      -- 修正：LSP 诊断图标逻辑
      diagnostics_indicator = function(_, _, diag)
        local icons = {
          Error = " ",
          Warn = " ",
          Info = "󱁯 ",
          Hint = " ",
        }
        local ret = (diag.error and icons.Error .. diag.error .. " " or "")
          .. (diag.warning and icons.Warn .. diag.warning or "")
        return vim.trim(ret)
      end,
      
      -- 侧边栏偏移
      offsets = {
        {
          filetype = "neo-tree",
          text = "Neo-tree",
          highlight = "Directory",
          text_align = "left",
        },
      },

      -- 完善图标获取逻辑
      get_element_icon = function(opts)
        local devicons = require("nvim-web-devicons")
        local icon, hl_group = devicons.get_icon_by_filetype(opts.filetype)
        return icon or "?", hl_group
      end,
    },
  },
  highlights = {
    -- 未选中缓冲区的指示器
    BufferLineIndicator = { fg = "#44475a" },
    -- 选中缓冲区的指示器（高亮）
    BufferLineIndicatorSelected = { fg = "#a6e377", bold = true },
  }
}
