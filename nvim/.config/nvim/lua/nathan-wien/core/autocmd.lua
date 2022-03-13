vim.cmd([[
  function! PackerAutoCompile()
    exec "luafile $MYVIMRC"
    exec "PackerCompile"
  endfunction

  augroup packer_compile
    autocmd BufWritePost */.config/nvim/*.lua call PackerAutoCompile()
  augroup END
]])
