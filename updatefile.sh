#/bin/bash

# update nvim files
echo "Updating ~/.config/nvim/init.vim ..."
cp ~/.config/nvim/init.vim ./nvim
echo "Updating ~/.config/nvim/autoload/shy.vim ..."
cp ~/.config/nvim/autoload/shy.vim ./nvim/autoload
echo "Updating ~/.config/nvim/autoload/plug.vim ..."
cp ~/.config/nvim/autoload/plug.vim ./nvim/autoload
