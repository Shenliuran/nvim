return {
  'saghen/blink.cmp',
  event = { 'BufReadPost', 'BufNewFile' },
  version = '1.*',
  dependencies = { 'xzbdmw/colorful-menu.nvim', opts = {} },
  opts = {
    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
      },
      trigger = { show_on_keyword = true }
    },
    appearance = {
      use_nvim_cmp_as_default = false,
    },
    keymap = {
      ['<Tab>'] = {
        function(cmp)
          if cmp.snippet_active() then return cmp.accept()
          else return cmp.select_and_accept() end
        end,
        'snippet_forward',
        'fallback',
      }
    }
  },
}
