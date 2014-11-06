# Install into home directory
link:
	ln -nfs "`pwd -LP`" ~/.vim
	ln -nfs "`pwd -LP`"/vimrc.vim ~/.vimrc

# Use bower-lock to manage .bowerlock
lock:
	node ./bin/bower-lock lock
install:
	node ./bin/bower-lock install

.PHONY: install lock update compile
