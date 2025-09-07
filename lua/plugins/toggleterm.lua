return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 20, -- 水平终端高度
      open_mapping = [[<leader>tt]], -- 快捷键打开/关闭终端
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "horizontal", -- 默认为水平分屏（可改为 vertical/float）
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved", -- 浮动窗口边框
        winblend = 0,
      },
    })
  end,
}
