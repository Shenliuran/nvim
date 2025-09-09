return {
  "folke/snacks.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "nvim-telescope/telescope.nvim",
  },

  -- 核心修复：先定义图标函数，再在opts中使用
  config = function()
    local devicons = require("nvim-web-devicons")

    -- 1. 提前定义图标函数（在opts之前）
    ---@param func string 功能类型
    ---@return string 图标
    local function get_dashboard_icon(func)
      local icon_map = {
        files = devicons.get_icon("file", nil, { default = true }) .. "📂 ",
        newfile = devicons.get_icon("file", nil, { default = true }) .. "➕ ",
        search = devicons.get_icon("file", nil, { default = true }) .."🔍 ",
        history = devicons.get_icon("history", nil, { default = true }) .. "📃 ",
        config = devicons.get_icon("config", nil, { default = true }) .. "🛠 ",
        session = devicons.get_icon("file", nil, { default = true }) .. "💬 ",
        lazy = devicons.get_icon("file", nil, { default = true }) .. "💤 ",
        quit = devicons.get_icon("file", nil, { default = true }) .."⭕ ",
      }
      return icon_map[func] or "?"
    end

    -- 2. 定义opts（此时get_dashboard_icon已存在）
    local opts = {
      animate = { enabled = true },
      dashboard = {
        preset = {
          pick = function(cmd, opts)
            local telescope = require("telescope.builtin")
            local cmd_handlers = {
              files = telescope.find_files,
              live_grep = telescope.live_grep,
              oldfiles = telescope.oldfiles,
            }
            local handler = cmd_handlers[cmd]
            return handler and function() handler(opts or {}) end or function() end
          end,

          header = [[
        ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
        ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z    
        ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z       
        ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z         
        ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║           
        ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝           
        ]],

          -- stylua: ignore
          keys = {
            { icon = get_dashboard_icon("files"),    key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')()" },
            { icon = get_dashboard_icon("newfile"),  key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = get_dashboard_icon("search"),   key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')()" },
            { icon = get_dashboard_icon("history"),  key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')()" },
            { icon = get_dashboard_icon("config"),   key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})()" },
            { icon = get_dashboard_icon("session"),  key = "s", desc = "Restore Session", section = "session" },
            { icon = get_dashboard_icon("lazy"),     key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
            { icon = get_dashboard_icon("lazy"),     key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = get_dashboard_icon("quit"),     key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
    }

    -- 3. 初始化插件
    require("snacks").setup(opts)
  end,
}
