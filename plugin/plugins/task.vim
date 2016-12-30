if globpath(&rtp, "plugin/task.vim") == "" | finish | endif

augroup task
  au!
  au BufNewFile,BufReadPost todo.txt,*.task,*.tasks noremap <silent> <buffer> <leader>k :call Toggle_task_status()<CR>
augroup END
