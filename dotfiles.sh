# Run this once only

# Git pull dotfiles and symlink them:

git clone https://github.com/tomskopek/dotfiles.git ~/dev/
ln -s ~/dev/dotfiles/.vimrc ~/.vimrc
ln -s ~/dev/dotfiles/.zshrc ~/.zshrc
ln -s ~/dev/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dev/personal/dotfiles/.ideavimrc ~/.ideavimrc

# https://neovim.io/doc/user/nvim.html#nvim-from-vim
