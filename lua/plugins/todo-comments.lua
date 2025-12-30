return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    -- keywords recognized as todo comments
    -- TODO: test
  },
  config = function(_, opts)
    require("todo-comments").setup(opts)
    local keymap = vim.keymap.set

    keymap("n", "]t", function()
      require("todo-comments").jump_next()
    end, { desc = "Next todo comment" })
    
    keymap("n", "[t", function()
      require("todo-comments").jump_prev()
    end, { desc = "Previous todo comment" })
    
    keymap("n", "]t", function()
      require("todo-comments").jump_next({keywords = { "ERROR", "WARNING" }})
    end, { desc = "Next error/warning todo comment" })

    keymap("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Todo Telescope" })

  end
}
