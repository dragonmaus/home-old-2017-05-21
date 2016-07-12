augroup filetypedetect
  autocmd BufNewFile,BufRead *.execline setfiletype execline
  autocmd BufNewFile,BufRead *.jsm setfiletype javascript
  autocmd BufNewFile,BufRead *.proto-js setfiletype javascript
  autocmd BufNewFile,BufRead *.rc setfiletype rc
  autocmd BufNewFile,BufRead rcmain setfiletype rc
  autocmd BufNewFile,BufRead ~/lib/profile setfiletype rc
augroup END
