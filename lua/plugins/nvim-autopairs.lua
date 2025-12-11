return {
  "windwp/nvim-autopairs",
  event = "InsertEnter", -- 在插入模式时加载
  config = function()
    local autopairs = require("nvim-autopairs")
    
    -- 基本配置
    autopairs.setup({
      check_ts = true, -- 启用 Treesitter 检查（智能识别代码结构）
      ts_config = {
        lua = { "string", "source" }, -- Lua 文件中在字符串和源码里启用
        javascript = { "string", "template_string" }, -- JS 中的字符串和模板字符串
      },
      disable_filetype = { "TelescopePrompt", "spectre_panel" }, -- 禁用的文件类型
      fast_wrap = { -- 快速包裹功能（按 <M-e> 触发）
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0, -- 从当前光标位置偏移
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
      },
    })

    vim.api.nvim_create_autocmd("InsertEnter", {
      callback = function()
        autopairs.enable()
      end
    })
  end,
}
