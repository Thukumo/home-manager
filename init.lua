vim.opt.number = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
require('lualine').setup()
require('accelerated-jk').setup()
vim.api.nvim_set_keymap('n', 'J', '<Plug>(accelerated_jk_gj)', {})
vim.api.nvim_set_keymap('n', 'K', '<Plug>(accelerated_jk_gk)', {})
require('nvim-autopairs').setup {}
vim.diagnostic.config({ virtual_text = false })
require('tiny-inline-diagnostic').setup()
-- require('tabset').setup()
require('nvim-treesitter.configs').setup {
  indent = {
    enable = true,
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
require('hlchunk').setup({
  chunk = {
    enable = true
  },
  indent = {
    enable = true
  },
  line_num = {
    enable = true
  },
})

vim.g.hellshake_yano = {
  useJapanese = true,
  useHintGroups = true,
  highlightSelected = true,
  useNumericMultiCharHints = true,
  enableTinySegmenter = true,
  singleCharKeys = "ASDFGNM@;,.",
  multiCharKeys = "BCEIOPQRTUVWXYZ",
  -- highlightHintMarker = {bg = "yellow", fg = "#57FD14"},
  highlightHintMarker = {bg = "yellow", fg = "Blue"},
  highlightHintMarkerCurrent = {bg = "Red", fg = "White"},
  perKeyMinLength = {
    w = 3,
    b = 3,
    e = 3,
  },
  defaultMinWordLength = 3,
  perKeyMotionCount = {
    w = 1,
    b = 1,
    e = 1,
    h = 2,
    j = 2,
    k = 2,
    l = 2,
  },
  motionCount = 3,
  japaneseMinWordLength = 3,
  segmenterThreshold = 4,
  japaneseMergeThreshold = 4,
}
-- vim.api.nvim_create_autocmd("VimEnter", {
--   pattern = "*",
--   once = true,
--   desc = "Start ZenMode on launch",
--   callback = function()
--     require("zen-mode").toggle({
--       lualine = {
--         enabled = false
--       },
--     })
--   end,
-- })

-- for idx, val in next, {"rust_analyzer"} do
--   vim.lsp.config(val, {})
--   vim.lsp.enable(val)
-- end
require('mason-lspconfig').setup({
  -- このリストに追記する
  ensure_installed = {
    "rust_analyzer",
    "nil_ls",
    "lua_ls",
    "clangd",
    "gopls"
  },
})

-- Add other language servers here
