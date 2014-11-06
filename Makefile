# Install into home directory
link:
	ln -nfs "`pwd -LP`" ~/.vim
	ln -nfs "`pwd -LP`"/vimrc.vim ~/.vimrc

# Use bower-lock to manage .bowerlock and ./bin/install
lock:
	node ./bin/lock
install:
	node ./bin/install

.PHONY: install lock link
