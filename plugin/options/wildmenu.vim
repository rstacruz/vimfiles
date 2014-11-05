set wildmenu                    "wmnu:  enhanced ed command completion
set wildignore+=*.~             "wig:   ignore compiled objects and backups
set wig+=*.o,*.obj,*.pyc        "       compiled objects
set wig+=.sass-cache,tmp        "       temp files
set wig+=vendor,log,logs,doc    "       usual directories

"wim:   helps wildmenu auto-completion
set wildmode=longest:full,list:full
