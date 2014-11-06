# Install into home directory
link:
	ln -nfs "`pwd -LP`" ~/.vim
	ln -nfs "`pwd -LP`"/vimrc.vim ~/.vimrc

# Use bower-lock to manage .bowerlock
lock:
	node ./bin/bower-lock lock
	node ./bin/make-script > bin/install
install:
	./bin/install

.PHONY: install lock update compile
