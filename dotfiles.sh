# Run this once only

# Git pull dotfiles and symlink them:

git clone https://github.com/tomskopek/dotfiles.git ~/dev/
ln -s ~/dev/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dev/dotfiles/.ideavimrc ~/.ideavimrc
ln -s ~/dev/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dev/dotfiles/.zshrc ~/.zshrc
ln -s ~/dev/dotfiles/.zshrc-mac ~/.zshrc-mac
ln -s ~/dev/dotfiles/.zshrc-ubuntu ~/.zshrc-ubuntu

# https://neovim.io/doc/user/nvim.html#nvim-from-vim
