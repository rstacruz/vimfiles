if globpath(&rtp, "plugin/startify.vim") == ""
  finish
endif

let g:startify_files_number           = 5
let g:startify_relative_path          = 1
let g:startify_change_to_dir          = 1
let g:startify_session_autoload       = 1
let g:startify_session_persistence    = 0
let g:startify_session_delete_buffers = 1

if !exists('g:startify_bookmarks')
  let g:startify_bookmarks = []
endif

" let g:startify_commands = [
"   \ [ 'Edit notes', ':e __NOTES' ],
"   \ ]

let g:startify_list_order = [ 'dir' ]
  " \ [' → Sessions'],
  " \ 'sessions',
  " \ [' → LRU'],
  " \ 'dir',
  " \ [' → Commands'],
  " \ 'commands',
  " \ ]

" \ [' → Bookmarks'],
" \ 'bookmarks',

let g:startify_custom_header = [
  \ " ",
  \ '  ╻ ╻   ╻   ┏┳┓',
  \ '  ┃┏┛   ┃   ┃┃┃',
  \ '  ┗┛    ╹   ╹ ╹',
  \ '  ',
  \ ] +
  \ map(split(system('bash -c "if [ -e ./__NOTES ]; then cat ./__NOTES; fi"'), '\n'), '"   ". v:val')

" let g:startify_custom_header = [
"       \ "",
"       \ "                   NdhyhdN",
"       \ "              Nho:.`     `:soooymN",
"       \ "           Ny/`                 `./yN",
"       \ "         h/``         `..:::.``    `-sN",
"       \ "       y-```     `.:/oydmmmdhs+:.`  ``-d",
"       \ "     m:```      ./sdMMMMMMMMMNmy+:`   ``s",
"       \ "    h.         `/yNMMMMMMMMMMMNds+:.   ``:N",
"       \ "   h`          -+hNMMMMMMMMMMMNmyo+:.`    -m",
"       \ "  d`          `/omMMMMMMMMMMMMNdyo+:-`     .d",
"       \ " N.          `-/osyhmNMMMMNNh/-.`..```      .N",
"       \ " +            `.----:+sdNmy+/:/sso+/-`       +",
"       \ " .        `.-//+oo++osodMMdos+//--:....      .",
"       \ "N`      `/++/-.:.-ooodhmMMNhhdhy+++::/:.      N",
"       \ "d       :ooooosydmNMMNddMMNyyNMMMNNmmdy+-    `N",
"       \ "N.     `/oshNMMMMMMMMmydMMMmhdMMMMMMMNhso-   s",
"       \ " h     `/oymNMMMMMMMMhh++s+/oymMMMMMMNdys:  :N",
"       \ "  :    `:+ydmMMMMMMMMdyysdhoshNMMMMMNmdys:``m",
"       \ "  N:   `.+ohdmNMNNdhssssymdysos+oymNmdyso:.s",
"       \ "    :  ../oyhdmNNy:-://+yyys////::ymhysso``",
"       \ "    m.  `-osyhdmmh+syyyys//+osyhsoyyssso- .",
"       \ "     N:   :osyyyhyyhdmNmdhhdNmdhyoooooo-  :",
"       \ "      N:   :oosssyyhhddddhyooooo++++++/   /",
"       \ "        +  .ooooooooo+/:/:-:-:://++++//  .y",
"       \ "         + .ooossoo+++/+//////+++++++++ :m",
"       \ "         Ny:ooosssssoooo+++++++++++++++:h"
"       \ ]

