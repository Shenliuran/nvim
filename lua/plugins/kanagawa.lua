-- ~/.config/nvim/lua/plugins/colors.lua
return {
  -- 安装 kanagawa.nvim
  {
    "rebelot/kanagawa.nvim",
    lazy = false, -- 强制加载（避免延迟加载导致配色闪烁）
    priority = 1000, -- 最高优先级加载配色
    config = function()
      -- 配置 kanagawa 选项
      require("kanagawa").setup({
        compile = true,             -- enable compiling the colorscheme
        undercurl = true,            -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true},
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false,         -- do not set background color
        dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
        terminalColors = true,       -- define vim.g.terminal_color_{0,17}
        colors = {                   -- add/modify theme and palette colors
            palette = {},
            theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        -- 核心：覆盖 cmdline 相关高亮组
        overrides = function(colors)
          local palette = colors.palette -- kanagawa 内置调色板
          return {
            -- ============== Cmdline 各类型弹窗适配 ==============
            -- 1. 命令型 Cmdline（输入 : 开头的命令）
            NoiceCmdlinePopupNormal = { bg = palette.sumiInk1 },
            NoiceCmdlinePopupBorder = { fg = palette.waveAqua, bg = palette.sumiInk0 },
            NoiceCmdlinePopupTitle = { fg = palette.fujiWhite, bg = palette.sumiInk1 },
            NoiceCmdlinePrompt = { fg = palette.springGreen, bg = palette.sumiInk1, bold = true }, -- 提示符（:）

            -- 2. 搜索型 Cmdline（输入 / 或 ? 开头的搜索）
            NoiceCmdlinePopupNormalSearch = { bg = palette.sumiInk1 },
            NoiceCmdlinePopupBorderSearch = { fg = palette.carpYellow, bg = palette.sumiInk0 }, -- 解决你当前的边框异常
            NoiceCmdlinePopupTitleSearch = { fg = palette.fujiWhite, bg = palette.sumiInk1 }, -- 搜索标题（Search）
            NoiceCmdlinePromptSearch = { fg = palette.carpYellow, bg = palette.sumiInk1, bold = true }, -- 搜索提示符（/）

            -- 5. 输入型 Cmdline（如 :input 提示输入）
            NoiceCmdlinePopupNormalInput = { bg = palette.sumiInk1 },
            NoiceCmdlinePopupBorderInput = { fg = palette.waveAqua, bg = palette.sumiInk0 },
            NoiceCmdlinePopupTitleInput = { fg = palette.fujiWhite, bg = palette.sumiInk1 },
          }
        end,
        theme = "dragon",              -- Load "wave" theme
        background = {               -- map the value of 'background' option to a theme
            dark = "dragon",           -- try "dragon" !
            light = "lotus"
        },
      })
      -- vim.cmd.colorscheme("kanagawa")
    end,
  },
}
