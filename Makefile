# Install into home directory
link:
	ln -nfs "`pwd -LP`"/vimrc.vim ~/.vimrc
	ln -nfs "`pwd -LP`" ~/.vim

lock:
	node ./bin/bower-lock lock
install:
	node ./bin/bower-lock install

.PHONY: install lock update
