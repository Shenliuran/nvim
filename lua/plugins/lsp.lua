return {
  -- 禁用 LazyVim 默认的 LSP 配置
  { "neovim/nvim-lspconfig", enabled = true },
  { "williamboman/mason.nvim", enabled = true },
  { "williamboman/mason-lspconfig.nvim", enabled = true },
  { "hrsh7th/nvim-cmp", enabled = true }, -- 禁用内置补全，使用 coc 的补全
}
