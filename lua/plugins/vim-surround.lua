return {
  'tpope/vim-surround',
  event = 'VeryLazy',
  -- 可选：配置自定义环绕规则（如果需要）
  config = function()
    -- 示例：添加对 Markdown 链接的环绕支持
    -- 可视模式下选中文本后按 S] 会包裹为 [文本](链接)
    vim.cmd([[
      let g:surround_{char2nr(']')} = "[\r](url)"
    ]])

    -- 示例：添加对 HTML 标签的自定义环绕
    -- 按 ysiw< 会生成 <tag>内容</tag>
    vim.cmd([[
      let g:surround_{char2nr('<')} = "<\r>\r</\1>"
    ]])
  end
}
