-- Concise way to escape termcodes
local function t(str)
    -- Adjust boolean arguments as needed
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- Completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

require'lspconfig'.rust_analyzer.setup {
  capabilities = capabilities,
}
vim.opt.completeopt = { 'menuone', 'noselect' }

require('compe').setup {
  enabled = true,
  autocomplete = true,
  documentation = true,

  source = {
    path = true,
    buffer = true,
    nvim_lsp = true,
    vsnip = true,
  }
}

vim.api.nvim_set_keymap('i', '<C-Space>', 'compe#complete()', { noremap = true, silent = true, expr = true })
vim.api.nvim_set_keymap('i', '<CR>', [[ compe#confirm('<CR>') ]], { noremap = true, silent = true, expr = true })

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn['vsnip#available'](1) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn['vsnip#jumpable'](-1) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    -- If <S-Tab> is not working in your terminal, change it to <C-h>
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", { expr = true })
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
