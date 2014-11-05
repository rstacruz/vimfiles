# Install into home directory
install:
	ln -nfs "`pwd -LP`"/vimrc.vim ~/.vimrc
	ln -nfs "`pwd -LP`" ~/.vim

# Update lockfile
lock: .bowerlock

.bowerlock: bower.json
	node ./support/lock.js > $@

# Install from the lock file
bower:
	mv bower.json bower.json~
	cp .bowerlock bower.json
	bower install
	mv bower.json~ bower.json

.PHONY: install lock .bowerlock
