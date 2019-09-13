# Manual steps:

# Remap Caps-Lock to Esc: Settings > Keyboard > Modifier Keys

# Setup Github SSH: https://help.github.com/en/articles/adding-a-new-ssh-key-to-your-github-account

# install ohmyzsh with curl: 
# sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# install zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# install powerline font: https://github.com/powerline/fonts
# set iterm2 to have powerline font (profiles > text > change font)
# I'm using 12pt Meslo LG M Regular for Powerline

# migrate from vim to nvim with 
# touch ~/.config/nvim/init.vim
# add this to your new init.vim file
# set runtimepath^=~/.vim runtimepath+=~/.vim/after
# let &packpath = &runtimepath
# source ~/.vimrc

echo "Starting setup"

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
brew update

PACKAGES=(
    git
    node
    npm
    python3
    the_silver_searcher
    ripgrep
    fzf
    tmux
    vim
    neovim
    zsh
    wget
    curl
)

echo "Installing packages..."
brew install ${PACKAGES[@]}

echo "Cleaning up..."
brew cleanup

echo "Installing cask..."
brew tap caskroom/cask

CASKS=(
    flux
    google-chrome
    iterm2
    slack
    spectacle
    vlc
    spotify
    nordvpn
)

echo "Installing cask apps..."
brew cask install ${CASKS[@]}

echo "Installing fonts..."
brew tap caskroom/fonts

FONTS=(
    font-roboto
    font-clear-sans
)

brew cask install ${FONTS[@]}

echo "Installing pynvim (python3 support for vim for deoplete)..."
pip3 install --user pynvim

echo "Configuring git..."
git config --global user.email "tomskopek@gmail.com"
git config --global user.name "tomskopek"

echo "Cloning tpm (tmux plugin manager)"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "Configuring OSX..."

# Set fast key repeat rate
defaults write NSGlobalDomain KeyRepeat -int 0

# Require password as soon as screensaver or sleep mode starts
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Show filename extensions by default
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Enable tap-to-click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Disable "natural" scroll
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

#"Disable annoying backswipe in Chrome"
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false

echo "Setup complete!"

