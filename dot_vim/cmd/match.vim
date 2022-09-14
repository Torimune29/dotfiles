let s:default_pattern = "all_match"

function! s:is_default(pattern)
  try
    return type(a:pattern) != type([]) && type(a:pattern) != type({}) && a:pattern =~ s:default_pattern
  catch
    return 0
  endtry
endfunction

function! s:is_match(case, pattern)
  try
    return (type(a:case) == type([]) ? count(map(copy(a:case), "s:is_default(a:pattern[v:key]) || v:val ==# a:pattern[v:key]"), 1) == len(a:case) : a:case =~ a:pattern)
  catch
    return 0
  endtry
endfunction

command! -nargs=1 Match
\   let match_src = <args>
\|  let is_matched = 0
\|  let _ = s:default_pattern

command! -nargs=? EndMatch
\   unlet match_src
\|  unlet is_matched
\|  unlet _
\|  if !empty(<q-args>) && has_key(l:, "match_result")
\|    let <args> = match_result
\|    unlet match_result
\|  endif


function! s:pattern(src)
  return matchstr(a:src, '\s*\zs.*\ze\s*=>.*')
endfunction

function! s:expr(src)
  return matchstr(a:src, '.*=>\s*\zs.*\ze\s*')
endfunction

command! -nargs=1 Case
\   if !is_matched && (s:is_default(eval(s:pattern(<q-args>))) || s:is_match(match_src, eval(s:pattern(<q-args>))))
\|    try
\|      execute "let match_result=" s:expr(<q-args>)
\|    catch
\|      execute s:expr(<q-args>)
\|    endtry
\|    let is_matched = 1
\|  endif
