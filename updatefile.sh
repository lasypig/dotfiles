#/bin/bash

# update dotfiles
DOTFILES=".ackrc .bashrc .bvirc .gtktermrc  .npmrc .vimrc .wgetrc"
for f in $DOTFILES; do
	echo "Updating ~/$f ..."
	cp ~/$f .
done

# update nvim files
echo "Updating ~/.config/nvim/init.vim ..."
cp ~/.config/nvim/init.vim ./nvim
echo "Updating ~/.config/nvim/autoload/shy.vim ..."
cp ~/.config/nvim/autoload/shy.vim ./nvim/autoload
