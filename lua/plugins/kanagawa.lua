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
        overrides = function(colors) -- add/modify highlights
            return {}
        end,
        theme = "dragon",              -- Load "wave" theme
        background = {               -- map the value of 'background' option to a theme
            dark = "dragon",           -- try "dragon" !
            light = "lotus"
        },
      })
      vim.cmd.colorscheme("kanagawa")
    end,
  },
}
