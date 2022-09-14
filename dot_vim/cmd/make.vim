:source ~/.vim/cmd/search_mark.vim
:source ~/.vim/cmd/match.vim


command! -nargs=* Make call s:Make(<f-args>)

command! CMake call s:CMake()

command! ReadyForDockerTest call s:ReadyForDockerTest()
command! ReadyForTransportToGW call s:ReadyForTransportToGW()

function s:Make(...) abort
  let l:type = a:1
  let l:arch = a:2
  let l:command = ""
  if a:0 >= 3
    let l:command = a:3
  endif

  let current_path = getcwd()
  let g:project_marker_file_name = get(g:, "project_marker_file_name", ".emacs_ctrl.el")
  let l:src_root = SearchMark(g:project_marker_file_name)
  if l:src_root == "\0"
    echo "No mark file found. Please check path."
    return
  endif

  if l:type == ""
    Match l:arch
      Case "alt" => cd `=fnameescape(l:src_root)` | cd `='./build/alt'`
      Case "genx86" => cd `=fnameescape(l:src_root)` | cd `='./build/genericx86'`
      Case "ks3453" => cd `=fnameescape(l:src_root)` | cd `='./build/ks3453'`
      Case "qemu" => cd `=fnameescape(l:src_root)` | cd `='./build/qemu'`
      Case "x8664" => cd `=fnameescape(l:src_root)` | cd `='./build/x86_64'`
      Case _ => "make arch error!"
    EndMatch
  elseif l:type == "debug"
    Match l:arch
      Case "alt" => cd `=fnameescape(l:src_root)` | cd `='./build_debug/alt'`
      Case "genx86" => cd `=fnameescape(l:src_root)` | cd `='./build_debug/genericx86'`
      Case "ks3453" => cd `=fnameescape(l:src_root)` | cd `='./build_debug/ks3453'`
      Case "qemu" => cd `=fnameescape(l:src_root)` | cd `='./build_debug/qemu'`
      Case "x8664" => cd `=fnameescape(l:src_root)` | cd `='./build_debug/x86_64'`
      Case _ => "make arch error!"
    EndMatch
  elseif l:type == "release"
    Match l:arch
      Case "alt" => cd `=fnameescape(l:src_root)` | cd `='./build/alt'`
      Case "genx86" => cd `=fnameescape(l:src_root)` | cd `='./build/genericx86'`
      Case "ks3453" => cd `=fnameescape(l:src_root)` | cd `='./build/ks3453'`
      Case "qemu" => cd `=fnameescape(l:src_root)` | cd `='./build/qemu'`
      Case "x8664" => cd `=fnameescape(l:src_root)` | cd `='./build/x86_64'`
      Case _ => "make arch error!"
    EndMatch
  elseif l:type == "test"
    Match l:arch
      Case "alt" => cd `=fnameescape(l:src_root)` | cd `='./build_test/alt'`
      Case "genx86" => cd `=fnameescape(l:src_root)` | cd `='./build_test/genericx86'`
      Case "ks3453" => cd `=fnameescape(l:src_root)` | cd `='./build_test/ks3453'`
      Case "qemu" => cd `=fnameescape(l:src_root)` | cd `='./build_test/qemu'`
      Case "x8664" => cd `=fnameescape(l:src_root)` | cd `='./build_test/x86_64'`
      Case _ => "make arch error!"
    EndMatch
  endif

  make -C . `=fnameescape(l:command)` -j 4

  echo "make complete."
  cd `=fnameescape(current_path)`
endfunction


function s:CMake() abort
  let current_path = getcwd()
  let g:project_marker_file_name = get(g:, "project_marker_file_name", ".emacs_ctrl.el")
  let l:src_root = SearchMark(g:project_marker_file_name)
  if l:src_root == "\0"
    echo "No mark file found. Please check path."
    return
  else
    call s:MakeBuildTree()
    echo "cmake..."
    cd `=fnameescape(l:src_root)` | cd `='./build/alt'`
    call system("cmake -D CMAKE_BUILD_TYPE=RELEASE -D COMPILE_TARGET=EXTGW_ALT -D HOST_CPU=64 ../../")
    cd `=fnameescape(l:src_root)` | cd `='./build/genericx86'`
    call system("cmake -D CMAKE_BUILD_TYPE=RELEASE -D COMPILE_TARGET=EXTGW_GENX86 -D HOST_CPU=64 ../../")
    cd `=fnameescape(l:src_root)` | cd `='./build/ks3453'`
    call system("cmake -D CMAKE_BUILD_TYPE=RELEASE -D COMPILE_TARGET=EXTGW_KS3453 -D HOST_CPU=64 ../../")
    cd `=fnameescape(l:src_root)` | cd `='./build/qemu'`
    call system("cmake -D CMAKE_BUILD_TYPE=RELEASE -D COMPILE_TARGET=EXTGW_QEMU -D HOST_CPU=64 ../../")
    cd `=fnameescape(l:src_root)` | cd `='./build/x86_64'`
    call system("cmake -D CMAKE_BUILD_TYPE=RELEASE -D COMPILE_TARGET=EXTGW_I386 -D HOST_CPU=64 ../../")

    cd `=fnameescape(l:src_root)` | cd `='./build_debug/alt'`
    call system("cmake -D CMAKE_BUILD_TYPE=DEBUG -D COMPILE_TARGET=EXTGW_ALT -D HOST_CPU=64 ../../")
    cd `=fnameescape(l:src_root)` | cd `='./build_debug/genericx86'`
    call system("cmake -D CMAKE_BUILD_TYPE=DEBUG -D COMPILE_TARGET=EXTGW_GENX86 -D HOST_CPU=64 ../../")
    cd `=fnameescape(l:src_root)` | cd `='./build_debug/ks3453'`
    call system("cmake -D CMAKE_BUILD_TYPE=DEBUG -D COMPILE_TARGET=EXTGW_KS3453 -D HOST_CPU=64 ../../")
    cd `=fnameescape(l:src_root)` | cd `='./build_debug/qemu'`
    call system("cmake -D CMAKE_BUILD_TYPE=DEBUG -D COMPILE_TARGET=EXTGW_QEMU -D HOST_CPU=64 ../../")
    cd `=fnameescape(l:src_root)` | cd `='./build_debug/x86_64'`
    call system("cmake -D CMAKE_BUILD_TYPE=DEBUG -D COMPILE_TARGET=EXTGW_I386 -D HOST_CPU=64 ../../")

    cd `=fnameescape(l:src_root)` | cd `='./build_test/alt'`
    call system("cmake -D RELEASE_ENV=$(pwd)/release_for_developer -D COMPILE_TARGET=EXTGW_ALT -D HOST_CPU=64 ../../test")
    cd `=fnameescape(l:src_root)` | cd `='./build_test/genericx86'`
    call system("cmake -D RELEASE_ENV=$(pwd)/release_for_developer -D COMPILE_TARGET=EXTGW_GENX86 -D HOST_CPU=64 ../../test")
    cd `=fnameescape(l:src_root)` | cd `='./build_test/ks3453'`
    call system("cmake -D RELEASE_ENV=$(pwd)/release_for_developer -D COMPILE_TARGET=EXTGW_KS3453 -D HOST_CPU=64 ../../test")
    cd `=fnameescape(l:src_root)` | cd `='./build_test/qemu'`
    call system("cmake -D RELEASE_ENV=$(pwd)/release_for_developer -D COMPILE_TARGET=EXTGW_QEMU -D HOST_CPU=64 ../../test")
    cd `=fnameescape(l:src_root)` | cd `='./build_test/x86_64'`
    call system("cmake -D RELEASE_ENV=$(pwd)/release_for_developer -D COMPILE_TARGET=EXTGW_I386 -D HOST_CPU=64 ../../test")

    echo "cmake Comnplete."
  endif
  cd `=fnameescape(current_path)`
endfunction


function s:MakeBuildTree() abort
  if isdirectory("build")
    echo "Build directory exists. Delete."
    silent !rm -rf build build_debug build_test
  endif
  echo "Make Build directory."
  silent !mkdir build
  silent !mkdir build/alt
  silent !mkdir build/genericx86
  silent !mkdir build/ks3453
  silent !mkdir build/qemu
  silent !mkdir build/x86_64
  silent !mkdir build_debug
  silent !mkdir build_debug/alt
  silent !mkdir build_debug/genericx86
  silent !mkdir build_debug/ks3453
  silent !mkdir build_debug/qemu
  silent !mkdir build_debug/x86_64
  silent !mkdir build_test
  silent !mkdir build_test/alt
  silent !mkdir build_test/genericx86
  silent !mkdir build_test/ks3453
  silent !mkdir build_test/qemu
  silent !mkdir build_test/x86_64
endfunction


function s:ReadyForDockerTest() abort
  " call s:Make("x8664", "clean")
  call s:Make("x8664", "")
  call s:Make("x8664", "release")
  call s:Make("x8664", "debug")

  let current_path = getcwd()
  let g:project_marker_file_name = get(g:, "project_marker_file_name", ".emacs_ctrl.el")
  let l:src_root = SearchMark(g:project_marker_file_name)
  if l:src_root == "\0"
    echo "No mark file found. Please check path."
    return
  else
    echo "cp package files..."
    cd `=fnameescape(l:src_root)` | cd `='./build/x86_64'`
    call system("cp package*.* ~/docker_share/")
    echo "cp package files complete."
  endif

  cd `=fnameescape(current_path)`
endfunction


function s:ReadyForTransportToGW() abort
  let current_path = getcwd()
  let g:project_marker_file_name = get(g:, "project_marker_file_name", ".emacs_ctrl.el")
  let l:src_root = SearchMark(g:project_marker_file_name)
  if l:src_root == "\0"
    echo "No mark file found. Please check path."
    return
  else
    echo "cp package files..."
    cd `=fnameescape(l:src_root)` | cd `='./build/ks3453'`
    silent! rm ~/send/*
    call system("cp package_target_rev*.* ~/send/")
    echo "cp package files complete."
  endif
endfunction
