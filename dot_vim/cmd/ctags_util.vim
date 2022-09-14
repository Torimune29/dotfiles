:source ~/.vim/cmd/search_mark.vim

" Set Tags
set tags=./tags;  " ; :search tags in project

command! CreateCtagsFromProjectRoot call CreateCtagsFromProjectRoot()

function! CreateCtagsFromProjectRoot() abort
  let g:project_marker_file_name = get(g:, "project_marker_file_name", ".emacs_ctrl.el")
  let l:src_root = SearchMark(g:project_marker_file_name)
  if l:src_root == "\0"
     echo "No mark file found. Please check path."
    return
  endif

  let l:current_path = getcwd()
  cd `=fnameescape(l:src_root)`
  call system("ctags -R ")
  cd `=fnameescape(l:current_path)`
endfunction

au FileWritePost,BufWritePost,FileAppendPost *.c call CreateCtagsFromProjectRoot()
au FileWritePost,BufWritePost,FileAppendPost *.cpp call CreateCtagsFromProjectRoot()
au FileWritePost,BufWritePost,FileAppendPost *.h call CreateCtagsFromProjectRoot()
au FileWritePost,BufWritePost,FileAppendPost *.hpp call CreateCtagsFromProjectRoot()

