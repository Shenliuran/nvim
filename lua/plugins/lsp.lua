return {
  -- 禁用 LazyVim 默认的 LSP 配置
  { "neovim/nvim-lspconfig", enabled = false },
  { "williamboman/mason.nvim", enabled = false },
  { "williamboman/mason-lspconfig.nvim", enabled = false },
  { "hrsh7th/nvim-cmp", enabled = false }, -- 禁用内置补全，使用 coc 的补全
}
