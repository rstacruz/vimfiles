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
      \ "                               +//////////++",
      \ "                          +:::-:-----:::::::://+ ",
      \ "                      /:---------------------::::/++++o    ",
      \ "                   /:------.-.--------------------:----:://o  ",
      \ "                 :---------...------------------::-.------::/o ",
      \ "               :--------.---------..-------:/++///:-..---::::/+  ",
      \ "             :-------...-.---....-------::/+osossso/:..---:::://o   are u",
      \ "           /--------..........--------::/+osysyyyyyso/-..-:::::/+o    batman",
      \ "          :---.--.-........----:::::::/+oosyyyhhhhhyys+-..-/:://++ ",
      \ "         :---.-..-........---::::/:://oosyyyyhhhhhhhhys+:..-+//++++ ",
      \ "         :.-.............---://///:/+ossyyyyyhhhhhMMMhhyo:--//:++++ ",
      \ "        +---...........---:/++++//++ossyyyyyyyhhhMMMMMhhys:-:/:/+++ ",
      \ "        /---.-........--::/+oo++++osssssssyyyhhMMMMMMMMMhhs::::/++++ ",
      \ "        /--..-.......--://oooooo+ssssssyyyyhhhMMMMMMMMMMMMho::::/+++ ",
      \ "        :--..-....--.-:/+ooooosssyyyyyyyyyyhhhyyysssssyhMMMho:--/+++ ",
      \ "        /--......----://++oooosssyyyyyhhyyyssoooooosssyyyMmMho.-:+++o ",
      \ "         ---....-////:-:::::::/++ossyyyyyssssoossssyyyhhyhhMMy-.-/++/ ",
      \ "         ---..``:+o+:---:::::::://++oosyso+++///++++oooo+/::/s::./++/ ",
      \ "         ----``.-/---://+++++o++ooo+--::/:/oo++oo/++ssosys::oMh+-:++/+ ",
      \ "         ----``.:/--/oo+/+///+so+oss/.///-yysooossssyyhhhh+ommmy::++/+ ",
      \ "         :.--``-sss-+o+/+oo++oooosss//yyy/ohyyssyyyhhhhhMMoyMmmM+:/o     thats",
      \ "         /.-...-sss++ooooosssssssss+:oyyhh+shhhyyyyhhhhhMh+MmmmMs//    shite m8 ",
      \ "          ----.-syss/osssyyyyyyyso+:ossyhhhs+syyyyyyyyysssMmmmMMy++ ",
      \ "           +/-.-syysso++ooooooo++//+ssyhhMMhysooooosssyyhMmmmmMMhs  ",
      \ "             :-:oyyyssyysssssssssoosssyyhhhhhMyyyyyhhhhMMMmmmmMMhy  ",
      \ "              :/osyyyyyyyyyyyyyysosso+osyysoshyyhhhhhhMMMMMMMMMMhs ",
      \ "              +/+syyyyyyyyyyhyyysssssossyyyhhhhhhhhhhhMMMMMMMMMMh  ",
      \ "               ++syyyyyyyyyyyyyysssssssyyyhhhhhMhhhhhhMMMMMMMMMM  ",
      \ "                +ssyyyyyyyyyyssssssssssyyyyyhhhhhssyhhhMMMMMMMM  ",
      \ "     oi          hyyyyyyyyyyysso++oooossssyyyyhhhyyyhhMMMMMMMMM ",
      \ "                   yyyyyyyyyyyssooossssyyyyhhhMMMMMhhhhMMMMMMM   r you batman?",
      \ "                    yyyyyyyyyyssssssyyyyyyyyhhMMMMMMMhMMMMMMM  ",
      \ "      ya m8          ssssssyyysssssyyyyyyyyhhhMMMMMMMMhMMhhhM ",
      \ "                      ssssssssssyyyyyyyyyyhhhMMMMMMMMhhhhhhMMM",
      \ "                       soooossssssyyyyyyyyyhhhhhhhhhhhhhhhMMMMM+::/ym",
      \ "                      ysoooooooooossssssssyyyyyyyhhhhhhhMMhMMMM/..-:+y",
      \ "                    o/.ooossoooooooooooossssssyyyyhhhhhhhMMMMMMs-`-:++om",
      \ "                o:-.-.`+oooosssooooooooossssssyyyyyhhhhhhMMMMMho:.-/+++sM",
      \ "             o:--`..`:ooooossssssooooooosssssyyyhhhhhhMMMMMhs/--:/++://+oM",
      \ "                                  [ d · v i m ]"
      \ ]

