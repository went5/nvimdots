local function load_autocmd()

-- 改行時の自動コメントアウトの無効化
vim.cmd 'autocmd FileType * setlocal formatoptions-=r'
vim.cmd 'autocmd FileType * setlocal formatoptions-=o'

-- 折り畳みの保存と復元
vim.cmd [[
augroup AutoSaveFolds
   autocmd!
   autocmd BufRead * call timer_start(500, {-> execute('silent lua load_view_if_exists()')})
   autocmd BufWritePost * mkview
augroup END
]]

end
load_autocmd()
