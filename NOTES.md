## eunuch

    :Unlink
    :Move new/file.js
    :Mkdir assets

## unity

    ,t    outline
    ,ua   all files

## vinegar/netrw

    -     back
    .     open in command line
    !     open in command line

    D     delete
    d     mkdir
    R     rename
    %     new file

    o     open in horiz split
    v     open in vert split
    t     open in tab

    ^O    back to editing

    i     change view (tree!)

    mf    mark file
    mm    move here

## nerdtree

    ,N    open tree

    o     open
    i     open in split
    t     open in tab
    T     open in tab, silently

## splitjoin

    gS    expand to multiple lines
    gJ    collapse

eg:

    <div>xxx</div>

    <div>
      xxx
    </div>

## coffeescript

    ,C    preview compiled form (:CoffeeWatch)

## vimr

    cmd-shift-o   fuzzy find
    cmd-1/0       sidebar show/hide

## ack.vim

    :Ack searchterm

    go    preview

    o     open file
    O     open file and close ack list

    t     open in tab
    T     open in tab, background

## mileszs/ack.vim

    :Ack <pattern>

## junegunn/goyo.vim

`:Goyo` enters zen mode

## moll/vim-node

Allows `gf` on `require('./xyz')`

    gf    Go to file
    [I    search for keyword

## tpope/vim-sleuth

Auto-detects tab/space settings

## tpope/vim-rails

* Enables `gf`

Commands:

     :A   alternate file
     :R   related file

Alt/related files:

    model                :A test    :R schema
    controller method    :A test    :R view
    template             :A test    :R controller

Abbreviations:

    AC::   ActionController
    AR::   ActiveRecord
    ...

    logd(  logger.debug
    logi(  logger.info
    ...

    pa[    params
    re(    redirect_to
    rp(    render partial:
    rst(   respond_to

Extracting partials:

 * Go to visual mode in a view, and `:Rextract home/foo_partial`
 * Works for models too (concerns)

App:

    :Econtroller <file>  # app/controllers/*_controller.rb
    :Ehelper             # app/helpers/*_helper.rb
    :Emodel <file>       # app/models/*.rb
    :Ejob <file>         # app/jobs/*_job.rb
    :Emailer <file>      # app/mailers/*.rb

DB:

    :Emigration <file> # db/migrations/*.rb
    :Eschema           # db/schema.rb
    
Lib:

    :Elib <file>  # lib/*.rb
    :Elib         # Gemfile
    :Etask <file> # lib/tasks/*.rake

Assets:

    :Estylesheet
    :Ejavascript

Views:

    :Eview
    :Elayout

Test:

    :Espec
    :Eunittest
      # test/{unit,models,helpers}/*_test.rb
      # spec/{unit,models,helpers}/*_spec.rb

    :Efunctionaltest
      # test/{functional,controllers,mailers}/*_test.rb
      # spec/{functional,controllers,mailers}/*_spec.rb

    :Eintegrationtest
      # test/integration/*_test.rb
      # spec/{features,requests,integration}/*_spec.rb
      # features/*.feature

Config:

    :Einitializer <file>      # config/initializers/*.rb
    :Elocale                  # config/locales/*.yml
    :Eenvironment             # application.rb
    :Eenvironment development # config/environments/*.rb

    :Efixtures
    :Efunctionaltest

## Also see

* https://github.com/terryma/dotfiles/blob/master/.vimrc
* https://github.com/vyorkin/dots/tree/master/tag-vim/vim/vundles

