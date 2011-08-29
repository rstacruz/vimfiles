" Sudo write when you forgot to `sudo vim`

com! -nargs=* Sudow w !sudo tee %
