if did_filetype()
  finish
endif

let s:cpoptions = &cpoptions
set cpoptions&vim

let s:line = getline(1)
if s:line[0:1] == '#!'
  let s:eol = match(s:line, '#', 2)
  if s:eol > -1
    let s:eol -= 1
  endif
  let s:argv = split(s:line[2:s:eol], '[\t ]\{1,\}')
  let s:name = fnamemodify(s:argv[0], ':t')
  while s:name == 'env'
    call remove(s:argv, 0)
    while s:argv[0] =~ '-.*\|.\+=.*'
      call remove(s:argv, 0)
    endwhile
    let s:name = fnamemodify(s:argv[0], ':t')
  endwhile
  if 0

  elseif s:name == 'execlineb'
    setfiletype execline

  elseif s:name == 'js24'
    setfiletype javascript

  elseif s:name == 'node'
    setfiletype javascript

  elseif s:name == 'rc'
    setfiletype rc

  endif
  unlet s:name
  unlet s:argv
  unlet s:eol
endif
unlet s:line

let &cpoptions = s:cpoptions
unlet s:cpoptions
