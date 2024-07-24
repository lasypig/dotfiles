#/bin/bash

# update nvim files
echo "Updating ~/.config/nvim/init.vim ..."
cp ~/.config/nvim/init.vim.bak ./nvim/init.vim
cp ~/.config/nvim/init.lua ./nvim/init.lua
cp -rf ~/.config/nvim/lua ./nvim
echo "Updating ~/.config/nvim/autoload/shy.vim ..."
cp ~/.config/nvim/autoload/shy.vim ./nvim/autoload
echo "Updating ~/.config/nvim/autoload/plug.vim ..."
cp ~/.config/nvim/autoload/plug.vim ./nvim/autoload
