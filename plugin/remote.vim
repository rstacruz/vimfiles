if exists('v:servername') && $NVIM_LISTEN_ADDRESS != v:servername
  echomsg "You are nesting neovim, careful"
endif
