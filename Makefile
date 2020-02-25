setup: link install
install:
	nvim +PlugInstall +PlugClean +qa
update:
	nvim +PlugInstall +CocUpdateSync +PlugUpdate +PLugUpgrade +PlugClean +PlugDiff
link:
	ln -nfs ~/.config/nvim ~/.vim
	ln -nfs ~/.config/nvim/init.vim ~/.vimrc
i: install
u: update
l: link
