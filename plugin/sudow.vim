" Sudo write when you forgot to `sudo vim`
" http://www.commandlinefu.com/commands/view/1204/save-a-file-you-edited-in-vim-without-the-needed-permissions

com! -nargs=* Sudow w !sudo tee >/dev/null %
