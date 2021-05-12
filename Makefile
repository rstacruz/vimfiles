setup: link install
install:
	nvim +PlugInstall +PlugClean +qa
update:
	nvim +PlugInstall +CocUpdateSync +PlugUpdate +PlugUpgrade +PlugClean +PlugDiff
link:
	if test ! -d ~/.vim; then ln -nfs ~/.config/nvim ~/.vim; fi
	ln -nfs ~/.config/nvim/init.vim ~/.vimrc
i: install
u: update
l: link
