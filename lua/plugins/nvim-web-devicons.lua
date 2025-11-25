return {
  "nvim-tree/nvim-web-devicons",
  opts = {
    -- 1. 全局默认配置
    default = true, -- 当没有匹配的图标时，是否使用默认图标（false 则不显示）
    color_icons = true, -- 是否为图标染色（false 则使用终端默认颜色）
    strict = true, -- 严格模式：仅使用已定义的图标（避免自动生成未知图标）
    override = nil, -- 全局覆盖图标（优先级低于下面的 `override_by_*`）

    -- 2. 按「文件类型」自定义图标（例如：vim、python、javascript）
    override_by_filetype = {
      -- 示例1：自定义 Vim 配置文件图标
      vim = {
        icon = "", -- 图标（需确保你的 Nerd Font 支持，可查 Nerd Font 图标表）
        color = "#019833", -- 图标颜色（十六进制/RGB）
        name = "Vim", -- 图标名称（可选，用于语义识别）
      },
      -- 示例2：自定义 Python 文件图标
      python = {
        icon = "🐍", -- 用 emoji 或 Nerd Font 图标（如 ""）
        color = "#3776AB",
        name = "Python",
      },
      -- 示例3：自定义 TypeScript 文件图标
      typescript = {
        icon = "",
        color = "#3178C6",
        name = "TypeScript",
      },
      -- 示例4：自定义 Markdown 文件图标
      markdown = {
        icon = "",
        color = "#0085D1",
        name = "Markdown",
      },
    },

    -- 3. 按「文件扩展名」自定义图标（优先级高于 `override_by_filetype`）
    -- 适合特殊扩展名（如 .env、.eslintrc）
    override_by_extension = {
      -- 示例1：自定义 .env 文件图标
      env = {
        icon = "🔒",
        color = "#FBBF24",
        name = "Env",
      },
      -- 示例2：自定义 .eslintrc 配置文件图标
      eslintrc = {
        icon = "",
        color = "#4B32C3",
        name = "EslintConfig",
      },
      -- 示例3：自定义 .jsonc（JSON 注释版）图标
      jsonc = {
        icon = "🔧",
        color = "#0066B8",
        name = "Jsonc",
      },
      -- 示例4：自定义 .vue 文件图标
      vue = {
        icon = "﵂",
        color = "#4FC08D",
        name = "Vue",
      },
    },

    -- 4. 自定义「文件夹」图标（LazyVim 中常用，配合 neo-tree/telescope）
    -- 需单独通过 `set_icon` 方法配置（因为文件夹图标不属于文件类型/扩展名）
    -- 这里通过 `config` 函数延迟配置，确保覆盖默认
  },
  config = function(_, opts)
    local devicons = require("nvim-web-devicons")
    devicons.setup(opts)

    -- 额外：自定义文件夹图标（适用于 neo-tree、bufferline 等）
    devicons.set_icon({
      [".git"] = { -- 隐藏文件夹（如 .git）
        icon = "",
        color = "#F14C28",
        name = "GitFolder",
      },
      node_modules = { -- 特殊文件夹
        icon = "",
        color = "#8C6C3E",
        name = "NodeModules",
      },
      src = { -- 源码文件夹
        icon = "",
        color = "#61AFEF",
        name = "SourceFolder",
      },
    })
  end,
}
