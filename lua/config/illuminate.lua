local loaded, illuminate = pcall(require, 'illuminate')
if not loaded then
  return
end

vim.cmd [[
  augroup illuminate_augroup
    autocmd!
    autocmd VimEnter * hi illuminatedWord cterm=underline gui=underline
  augroup END
  let g:Illuminate_highlightUnderCursor = 0
]]
