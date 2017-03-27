augroup filetypedetect
  autocmd BufNewFile,BufRead *.boot setfiletype clojure
  autocmd BufNewFile,BufRead *.execline setfiletype execline
  autocmd BufNewFile,BufRead *.jsm setfiletype javascript
  autocmd BufNewFile,BufRead *.proto-js setfiletype javascript
  autocmd BufNewFile,BufRead *.rc setfiletype rc
  autocmd BufNewFile,BufRead rcmain setfiletype rc
  autocmd BufNewFile,BufRead ~/lib/profile setfiletype rc
  autocmd BufNewFile,BufRead VagrantFile setfiletype ruby
augroup END
