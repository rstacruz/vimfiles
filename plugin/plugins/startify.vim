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

let g:startify_commands = [
  \ [ 'Edit notes', ':e __NOTES' ],
  \ ]

let g:startify_list_order = [
  \ [' → Sessions'],
  \ 'sessions',
  \ [' → LRU'],
  \ 'dir',
  \ [' → Commands'],
  \ 'commands',
  \ ]

" \ [' → Bookmarks'],
" \ 'bookmarks',

let g:startify_custom_header = [
  \ " ",
  \ "                _",
  \ "         __   _(_)_ __ ___",
  \ "         \\ \\ / / | '_ \` _ \\ ",
  \ '          \ V /| | | | | | |',
  \ '(╯°□°)╯︵  \_/ |_|_| |_| |_|',
  \ '  ',
  \ ] +
  \ map(split(system('bash -c "if [ -e ./__NOTES ]; then cat ./__NOTES; fi"'), '\n'), '"   ". v:val')

let g:startify_custom_header = [
      \ "                                  mddhhhddm",
      \ "                            dys+//////////++oshm",
      \ "                       mhs+:::-:-----:::::::://+h",
      \ "                    ds/:---------------------::::/++++osydm",
      \ "                 my/:------.-.--------------------:----:://oym",
      \ "               do:---------...------------------::-.------::/oh",
      \ "             h+:--------.---------..-------:/++///:-..---::::/+sm",
      \ "           mo:-------...-.---....-------::/+osossso/:..---:::://od",
      \ "          d/--------..........--------::/+osysyyyyyso/-..-:::::/+om",
      \ "         h:---.--.-........----:::::::/+oosyyyhhhhhyys+-..-/:://++s",
      \ "        m:---.-..-........---::::/:://oosyyyyhhhhhhhhys+:..-+//++++m",
      \ "        s:.-.............---://///:/+ossyyyyyhhhhhdddhhyo:--//:++++h",
      \ "        +---...........---:/++++//++ossyyyyyyyhhhdddddhhys:-:/:/+++s",
      \ "        /---.-........--::/+oo++++osssssssyyyhhdddddddddhhs::::/++++m",
      \ "        /--..-.......--://oooooo+ssssssyyyyhhhddddddddddddho::::/+++d",
      \ "        :--..-....--.-:/+ooooosssyyyyyyyyyyhhhyyysssssyhdddho:--/+++s",
      \ "        /--......----://++oooosssyyyyyhhyyyssoooooosssyyydmdho.-:+++om",
      \ "        s---....-////:-:::::::/++ossyyyyyssssoossssyyyhhyhhddy-.-/++/d",
      \ "        h---..``:+o+:---:::::::://++oosyso+++///++++oooo+/::/s::./++/y",
      \ "        m----``.-/---://+++++o++ooo+--::/:/oo++oo/++ssosys::odh+-:++/+m",
      \ "         ----``.:/--/oo+/+///+so+oss/.///-yysooossssyyhhhh+ommmy::++/+d",
      \ "         :.--``-sss-+o+/+oo++oooosss//yyy/ohyyssyyyhhhhhddoydmmd+:/ossm",
      \ "         /.-...-sss++ooooosssssssss+:oyyhh+shhhyyyyhhhhhdh+dmmmds//sd",
      \ "         s----.-syss/osssyyyyyyyso+:ossyhhhs+syyyyyyyyysssdmmmddy++y",
      \ "          s+/-.-syysso++ooooooo++//+ssyhhddhysooooosssyyhdmmmmddhssd",
      \ "           md:-:oyyyssyysssssssssoosssyyhhhhhdyyyyyhhhhdddmmmmddhysm",
      \ "             o:/osyyyyyyyyyyyyyysosso+osyysoshyyhhhhhhddddddddddhsh",
      \ "             m+/+syyyyyyyyyyhyyysssssossyyyhhhhhhhhhhhddddddddddhym",
      \ "              m++syyyyyyyyyyyyyysssssssyyyhhhhhdhhhhhhddddddddddyh",
      \ "               y+ssyyyyyyyyyyssssssssssyyyyyhhhhhssyhhhdddddddddd",
      \ "                hhyyyyyyyyyyysso++oooossssyyyyhhhyyyhhdddddddddm",
      \ "                  dyyyyyyyyyyyssooossssyyyyhhhdddddhhhhdddddddd",
      \ "                   hyyyyyyyyyyssssssyyyyyyyyhhdddddddhddddddddm",
      \ "                    hssssssyyysssssyyyyyyyyhhhddddddddhddhhhdd",
      \ "                     dssssssssssyyyyyyyyyyhhhddddddddhhhhhhddd",
      \ "                      dsoooossssssyyyyyyyyyhhhhhhhhhhhhhhhddddd+::/ym",
      \ "                      ysoooooooooossssssssyyyyyyyhhhhhhhddhdddd/..-:+y",
      \ "                 myoo/.ooossoooooooooooossssssyyyyhhhhhhhdddddds-`-:++om",
      \ "                o:-.-.`+oooosssooooooooossssssyyyyyhhhhhhdddddho:.-/+++sd",
      \ "             o:--`..`:ooooossssssooooooosssssyyyhhhhhhdddddhs/--:/++://+od",
      \ "                                  [ d · v i m ]"
      \ ]

