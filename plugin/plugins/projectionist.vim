if globpath(&rtp, "plugin/projectionist.vim") == "" | finish | endif

if exists('g:projectionist_heuristics') == "0"
  let g:projectionist_heuristics = {}
endif

" Rails app/services/
call extend(g:projectionist_heuristics, {
\   "app/services/*.rb|_(rails_services)": {
\     "app/services/*.rb": {
\       "type": "service"
\     }
\   },
\ })

" Rails JavaScript behaviors using onmount
call extend(g:projectionist_heuristics, {
\   "app/assets/javascripts/behaviors/*.js|app/assets/javascripts/behaviors/*/*.js|_(rails_behaviors)": {
\     "app/assets/javascripts/behaviors/*.js": {
\       "type": "behavior",
\       "template": [
\         "/*",
\         " * {basename|capitalize|blank}",
\         " */",
\         "",
\         "$.onmount('.{basename|underscore}', function () {",
\         "});"
\       ]
\     }
\   }
\ })

" Rails CSS files
call extend(g:projectionist_heuristics, {
\   "app/assets/stylesheets/*.scss|app/assets/stylesheets/*/*.scss|_(rails_scss)": {
\     "app/assets/stylesheets/*.scss": {
\       "type": "css",
\       "template": [
\         "/*",
\         " * {basename|capitalize|blank}",
\         " */",
\         "",
\         ".{basename|underscore} {",
\         "}"
\       ]
\     }
\   }
\ })

" Node.js projects (generic)
call extend(g:projectionist_heuristics, {
\   "package.json|_(node_lib_test)": {
\     "lib/*.js": {
\       "type": "lib",
\       "alternate": [
\         "test/{}_test.js",
\         "test/lib/{}_test.js",
\         "test/{}",
\         "test/lib/{}_test.js"
\       ]
\     },
\     "test/*_test.js": {
\       "type": "test",
\       "alternate": [
\         "lib/{}.js",
\         "{}.js"
\       ],
\       "template": [
\         "'use strict'",
\         "",
\         "describe('{basename|blank}', function () {",
\         "  it('works', function () {",
\         "  })",
\         "})"
\       ]
\     }
\   }
\ })

" Node.js projects (generic)
call extend(g:projectionist_heuristics, {
\   "package.json|_(node_bin)": {
\     "bin/*": {
\       "type": "bin",
\       "template": [
\         "#!/usr/bin/env node"
\       ]
\     }
\   }
\ })

" Vim: stuff
call extend(g:projectionist_heuristics, {
\   "*.vim|*/*.vim|_(vim)": {
\     "autoload/*.vim": {
\       "type": "autoload"
\     },
\     "UltiSnips/*.snippets": {
\       "type": "ultisnip"
\     },
\     "colors/*.vim": {
\       "type": "colorscheme"
\     },
\     "plugin/*.vim": {
\       "type": "plugin"
\     },
\     "ftdetect/*.vim": {
\       "type": "ftdetect"
\     },
\     "ftplugin/*.vim": {
\       "type": "ftplugin"
\     }
\   }
\ })
