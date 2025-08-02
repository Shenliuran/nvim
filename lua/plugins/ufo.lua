if not vim.g.vscode then
  return {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    config = function()
      local ufo = require('ufo')
      
      ufo.setup({
        open_fold_hl_timeout = 0,
        fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
          return virtText
        end
      })
      
      -- 正确的快捷键映射（使用ufo提供的正确函数）
      vim.keymap.set('n', 'zc', ufo.closeFoldsWith, { desc = '折叠当前块' })
      vim.keymap.set('n', 'zo', ufo.openFoldsExceptKinds, { desc = '展开当前块' })
      vim.keymap.set('n', 'zM', ufo.closeAllFolds, { desc = '折叠所有' })
      vim.keymap.set('n', 'zR', ufo.openAllFolds, { desc = '展开所有' })
    end
  }
else
  return {}
end