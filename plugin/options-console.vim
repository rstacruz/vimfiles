if !has("gui_running")
    "color jellybeans+

    if has("gui")
      set background=dark
      set t_Co=256

      " color hemisu
      " color Tomorrow-Night
      " color muon
      " color dante
      " color jellybeans+
      " color vydark+
      color snap-vydark+
    else
      color vydark-snapshot
    endif
endif
