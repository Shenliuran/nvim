return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip"
  },
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    -- 1. 设置补全源 (Sources)
    -- 优先级从上到下递减
    opts.sources = cmp.config.sources({
      { name = "nvim_lsp", priority = 1000 }, -- LSP 补全
      { name = "luasnip", priority = 750 },   -- Snippet 补全
      { name = "buffer", priority = 500 },    -- 当前缓冲区文本
      { name = "path", priority = 250 },      -- 文件路径补全
    })

    -- 2. 自定义按键映射 (Mappings)
    opts.mapping = cmp.mapping.preset.insert({
      -- 保留 LazyVim 默认的上下滚动和取消
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-e>"] = cmp.mapping.abort(),
      
      -- 自定义：Ctrl+n/p 选择上一个/下一个
      ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),

      -- 自定义：Enter 键确认选中项
      -- select = true 表示即使没手动选中，按 Enter 也会选中第一个
      ["<CR>"] = cmp.mapping.confirm({ select = true }),

      -- 自定义：Tab 键
      -- 逻辑：如果有补全菜单 -> 选下一项；如果有 Snippet -> 跳转；否则 -> 输入 Tab
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { "i", "s" }),

      -- 自定义：Shift-Tab 键 (反向选择)
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    })

    -- 3. 美化窗口 (Borders)
    -- 给补全菜单和文档窗口加上圆角边框
    opts.window = {
      completion = cmp.config.window.bordered({
        border ='rounded'
      }),
      documentation = cmp.config.window.bordered({
        border ='rounded',
      }),
    }

    -- 4. 实验性功能：幽灵文本 (Ghost Text)
    -- 开启后会在当前行显示最可能的补全预览
    opts.experimental = {
      ghost_text = true,
    }
  end,
}

