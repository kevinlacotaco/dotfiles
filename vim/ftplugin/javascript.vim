set foldmethod=syntax
set foldlevelstart=99
set foldlevel=99
syn region javaScriptCommentFold start="/\*" end="\*/" transparent keepend extend fold
set foldtext=GetFoldedHeader()
function! GetFoldedHeader()
  let numlines_folded = v:foldend - v:foldstart + 1
  let line_num = v:foldstart
  let firstline = getline(v:foldstart)

  let charline = matchstr(firstline, '^\s*\(<[^!]\|\w\+\)[^{}]*')

  " Handle javadoc style comments, display the javadoc summary as the foldtext
  if match(firstline, '^\s*\/\*\*') == 0
    if match(firstline, '^\s*\/\*\*\s*$') == 0
      let charline = substitute(getline(v:foldstart+1), '^\s*\**\s*', '(doc) ', '')
      let charline = substitute(charline, '\..*$', '.', '')
    else
      let charline = substitute(firstline, '\s*\/\*\*\s*', '', '')
    endif
  else
    " handle the special case of multiple single line comments
    if match(firstline, '^\s*\/\/') == 0
      if match(getline(v:foldend), '^\s*\/\/') == 0
        let charline = substitute(firstline, '\s*\/*\s*', '', '')
      endif
    else
      let charline = matchstr(firstline, '^\s*\(<[^!]\|\w\+\)[^{}]*')
      while strlen(charline) == 0 && line_num < v:foldend
        let line_num = line_num + 1
        let charline = matchstr(getline(line_num), '^\s*\(<[^!]\|\w\+\)[^{}]*')
      endw
    endif
  endif

  let preamble = printf("[%d lines folded]:", numlines_folded)
  return printf("%-20s%s", preamble, substitute(charline, '^\s*', '', ''))
endfunction
