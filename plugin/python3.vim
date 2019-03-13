if $VIM_MINIMAL != '' || $GIT_AUTHOR_DATE != '' | finish | endif

" Assumes:
"    brew install python
"    brew install python3
"    pip install neovim --upgrade
"    pip3 install neovim --upgrade

if filereadable('/usr/local/bin/python')
  let g:python2_host_prog = '/usr/local/bin/python'
endif

if filereadable('/usr/local/bin/python3')
  let g:python3_host_prog = '/usr/local/bin/python3'
endif
