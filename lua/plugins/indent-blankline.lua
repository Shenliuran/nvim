return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  ---@module "ibl"
  ---@type ibl.config
  opts = {},
  config = function()
    local ibl = require("ibl")
    local hooks = require("ibl.hooks")

    -- 定义彩虹缩进的颜色组名称
    local highlight = {
      "RainbowRed",
      "RainbowYellow",
      "RainbowBlue",
      "RainbowOrange",
      "RainbowGreen",
      "RainbowViolet",
      "RainbowCyan",
    }

    -- 注册一个钩子，在颜色方案加载或变化时创建/重置高亮组
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      -- 为每个颜色组定义具体的颜色
      vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
      vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
      vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
      vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
      vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
      vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
    end)

    -- 配置并启用 ibl
    ibl.setup({
      -- 将 scope 的高亮设置为我们定义的彩虹颜色组
      scope = {
        highlight = highlight,
      },
      -- 你可以在这里添加其他 ibl 的配置选项
      -- 例如，配置基础缩进线的样式
      indent = {
        char = "│", -- 缩进线使用的字符
        -- 基础缩进线可以使用一个固定的高亮组，比如 Comment
        -- highlight = "Comment",
      },
    })

    -- 启用基于 extmark 的范围高亮功能
    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  end,
}
