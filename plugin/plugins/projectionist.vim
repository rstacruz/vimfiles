if globpath(&rtp, "plugin/projectionist.vim") == "" | finish | endif

if exists('g:projectionist_heuristics') == "0"
  let g:projectionist_heuristics = {}
endif

" Rails: app/services/
call extend(g:projectionist_heuristics, {
\   "app/services/*.rb|_(rails-services)": {
\     "app/services/*.rb": {
\       "type": "service",
\       "template": [
\         "class {camelcase|colons}",
\         "end"
\       ]
\     }
\   },
\ })

" Rails: app/forms/
call extend(g:projectionist_heuristics, {
\   "app/forms/*.rb|_(rails-forms)": {
\     "app/forms/*.rb": {
\       "type": "form"
\     }
\   },
\ })

" Rails: JavaScript behaviors using onmount
call extend(g:projectionist_heuristics, {
\   "app/assets/javascripts/behaviors/*.js|app/assets/javascripts/behaviors/*/*.js|_(rails-behaviors)": {
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

" Rails: CSS files
call extend(g:projectionist_heuristics, {
\   "app/assets/stylesheets/*.scss|app/assets/stylesheets/*/*.scss|_(rails-scss)": {
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

" Node: projects (generic)
call extend(g:projectionist_heuristics, {
\   "package.json|_(node-projects)": {
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
\     },
\     "bin/*": {
\       "type": "bin",
\       "template": [
\         "#!/usr/bin/env node"
\       ]
\     },
\     "docs/*.md": {
\       "type": "doc",
\       "template": [
\         "# {basename|blank|capitalize}"
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
\     "doc/*.txt": {
\       "type": "doc"
\     },
\     "ftplugin/*.vim": {
\       "type": "ftplugin"
\     }
\   }
\ })
