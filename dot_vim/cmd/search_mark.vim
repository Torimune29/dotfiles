if !exists("*SearchMark")
  function SearchMark(file_name) abort
    let l:current_path = getcwd()
    let l:maxdir = 5
    let l:i = 0
    let l:root_path = "\0"
    while l:i < l:maxdir
      if filereadable(a:file_name)
        let l:root_path = getcwd()
        break
      else
        cd `='../'`
      endif
      let i = i + 1
    endwhile
    return l:root_path
    cd `=fnameescape(l:current_path)`
  endfunction
endif
