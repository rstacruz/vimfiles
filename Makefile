install:
	ln -nfs "`pwd -LP`"/vimrc.vim ~/.vimrc
	ln -nfs "`pwd -LP`" ~/.vim

.bowerlock.json: bower.json
	node ./support/lock.js > $@
