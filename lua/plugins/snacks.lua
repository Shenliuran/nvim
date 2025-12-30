return {
  "folke/snacks.nvim",
  -- 调整加载时机：确保依赖加载后再初始化
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",      -- 图标依赖
    "nvim-telescope/telescope.nvim",    -- 搜索依赖
    "folke/persistence.nvim",           -- 会话管理依赖
    "nvim-lua/plenary.nvim",            -- 补充必要工具函数依赖
  },
  config = function()
    -- 1. 加载依赖（带错误处理，避免依赖缺失导致初始化失败）
    local status_devicons, devicons = pcall(require, "nvim-web-devicons")
    local status_telescope, telescope = pcall(require, "telescope.builtin")
    local status_persistence, persistence = pcall(require, "persistence")

    -- 检查核心依赖是否加载成功
    if not status_devicons then
      vim.notify("缺少依赖: nvim-web-devicons", vim.log.levels.ERROR)
      return
    end
    if not status_telescope then
      vim.notify("缺少依赖: telescope.builtin", vim.log.levels.ERROR)
      return
    end

    -- 2. 图标函数（保持逻辑，增强容错）
    local function get_dashboard_icon(func)
      local icon_map = {
        files = "",
        newfile = "",
        search = "",
        history = "",
        config = "",
        session = "",
        lazy = "󰒲",
        quit = "",
      }
      return icon_map[func] or "? "
    end

    -- 3. 主配置（合并优化）
    local opts = {
      animate = { enabled = true },
      dashboard = {
        -- 自动显示仪表盘（无文件打开时）
        auto_show = true,
        preset = {
          -- 简化pick函数（复用已加载的telescope）
          pick = function(cmd, opts)
            local cmd_handlers = {
              files = telescope.find_files,
              live_grep = telescope.live_grep,
              oldfiles = telescope.oldfiles,
            }
            local handler = cmd_handlers[cmd]
            return handler and function() handler(opts or {}) end or function() end
          end,

          -- 优化header格式（统一缩进）
          header = [[
          ██╗     ██╗██╗   ██╗██████╗  █████╗ ███╗   ██╗██╗   ██╗██╗███╗   ███            Z
          ██║     ██║██║   ██║██╔══██╗██╔══██╗████╗  ██║██║   ██║██║████╗ ████        Z    
          ██║     ██║██║   ██║██████╔╝███████║██╔██╗ ██║██║   ██║██║██╔████╔██     z       
          ██║     ██║██║   ██║██╔══██╗██╔══██║██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██   z         
          ███████╗██║╚██████╔╝██║  ██║██║  ██║██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██             
          ╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═             
          ]],

          -- 快捷键配置（保持功能，增强可读性）
          keys = {
            { icon = "",    key = "f", desc = "Find File", action = function() telescope.find_files() end },
            { icon = "",  key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = "",   key = "g", desc = "Find Text", action = function() telescope.live_grep() end },
            { icon = "", key = "t", desc = "Find Todo", action = ":TodoTelescope"},
            { icon = "",  key = "r", desc = "Recent Files", action = function() telescope.oldfiles() end },
            { icon = "",   key = "c", desc = "Config", action = function() telescope.find_files({ cwd = vim.fn.stdpath("config") }) end },
            { 
              icon = "",  
              key = "s", 
              desc = "Session", 
              -- 会话操作增强（判断persistence是否加载）
              action = status_persistence and function()
                vim.ui.select({ "保存会话", "恢复上次会话" }, { prompt = "会话操作" }, function(choice)
                  if choice == "保存会话" then
                    persistence.save()
                    vim.notify("会话已保存")
                  elseif choice == "恢复上次会话" then
                    persistence.load()
                    vim.notify("已恢复上次会话")
                  end
                end)
              end or function() vim.notify("会话依赖未加载", vim.log.levels.WARN) end
            },
            { icon = "",     key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
            { icon = "󰒲",     key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = "",     key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
    }

    -- 4. 仅初始化一次插件（移除重复的setup）
    local status_snacks, snacks = pcall(require, "snacks")
    if status_snacks then
      snacks.setup(opts)
    else
      vim.notify("snacks.nvim 加载失败: " .. snacks, vim.log.levels.ERROR)
      return
    end

    -- 5. 快捷键配置（确保插件初始化后再设置）
    vim.keymap.set("n", "<leader>sd", function()
      require("snacks").dashboard()
    end, { desc = "打开Snacks仪表盘" })
  end,
}
