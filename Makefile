# Install into home directory
install:
	ln -nfs "`pwd -LP`"/vimrc.vim ~/.vimrc
	ln -nfs "`pwd -LP`" ~/.vim

# Update lockfile
lock: .bowerlock

.bowerlock: bower.json
	node bin/bower-lock

# Install from the lock file
bower:
	node bin/bower-lock install

.PHONY: install lock .bowerlock
