# Install into home directory
link:
	ln -nfs "`pwd -LP`" ~/.vim
	ln -nfs "`pwd -LP`"/vimrc.vim ~/.vimrc

lock:
	vim +"PlugSnapshot ./bin/install" +qa

install:
	./bin/install

.PHONY: install link
