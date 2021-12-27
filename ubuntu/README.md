# linux setup

### 1. Install [Chrome](https://www.google.com/intl/en_ca/chrome/)

### 2. Update apt
```console
sudo apt update && sudo apt upgrade
```

### 3. Install curl
```console
sudo apt install curl
```

### 4. Install Git


```console
sudo apt install git-all
```

Add (ssh keys)[https://github.com/settings/keys] to github

Check for existing keys:
```console
ls -lA ~/.ssh
```

Generate ssh keys if not already existing
```console
ssh-keygen -t ed25519 -C "tomskopek@gmail.com"
```

Add the keys to Github

### 5. Install zsh and [oh-my-zsh](https://ohmyz.sh/#install) so the rest of this process is nicer:
   
```console
sudo apt install zsh
```

Install oh-my-zsh via curl:

```console
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Install zsh-autosuggestions via git clone

```console
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

### 6. Install [brew](https://brew.sh/)
```console
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
After install, follow next steps - including brew install gcc
Log out and log back in (because of .zprofile changes)

### 7. Install pyenv:

Install the [prerequisites](https://github.com/pyenv/pyenv/wiki#suggested-build-environment)

```console
sudo apt-get update; sudo apt-get install make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
```

Install [pyenv using brew](https://github.com/pyenv/pyenv#installation)
```console
brew update
brew install pyenv
```

Finish instructions for shell using [this guide](https://github.com/pyenv/pyenv#basic-github-checkout)
```console
echo 'eval "$(pyenv init --path)"' >> ~/.zprofile
echo 'eval "$(pyenv init -)"' >> ~/.zshrc
```

Log out and log back in

Install python 3.x:
```console
pyenv install --list | grep " 3\.[678]"
```
(scroll up and look for latest 3.x.x version (at the time of writing, was 3.9.7))
```console
pyenv install 3.9.7
```
```console
pyenv global 3.9.7
```

Install python 2.7.x:
```console
pyenv install 2.7.18
```

This is a useful command to see all versions:

```console
pyenv version
```

This is a [helpful article](https://realpython.com/intro-to-pyenv/)

### 8. Install nvm
```console
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
```

Install latest version of node:
```console
nvm install --lts
```

Check that it worked
```console
node --version
```

### 9. Install fzf
```console
brew install fzf
```
```console
$(brew --prefix)/opt/fzf/install
```

### 10. Install ripgrep (needed for fzf/nvim)
```console
brew install ripgrep
```

### 11. Install [neovim via brew](https://github.com/neovim/neovim/wiki/Installing-Neovim#homebrew-on-macos-or-linux)
```console
brew install neovim
```

### 12. Set up neovim!

Check if nvim config dir exists
```console
cd ~/.config
ls -lA | grep nvim
```

Make it if it doesnt
```console
mkdir nvim
```

Use our config:
```console
git clone git@github.com:tomskopek/nvim_config.git ~/.config/nvim
```

Install plugins
```console
nvim
```
```
:PackerInstall
```

Fix python packages: (see :checkhealth provider / :help provider-python)
```console
python3 -m pip install --user --upgrade pynvim
```

### 13. Install xclip so that clipboard works in nvim
```console
sudo apt install xclip
```

### 14. install Kinto
```console
/bin/bash -c "$(wget -qO- https://raw.githubusercontent.com/rbreaves/kinto/HEAD/install/linux.sh || curl -fsSL https://raw.githubusercontent.com/rbreaves/kinto/HEAD/install/linux.sh)"
```

If you have problems, you probably need to log out and log back in using Xorg

You may run into a problem with xkeysnail. if so:
```console
git clone https://github.com/rbreaves/kinto.git
cd kinto
cd xkeysnail
pip3 install --upgrade .
cd ..
./setup.py
```

Install supporting packages
```console
sudo apt install gnome-tweaks gnome-shell-extension-appindicator gir1.2-appindicator3-0.1
```

Note: Not sure this is the right way to fix it, but this might help:
i. use system python3 (sudo which python3)
ii. /usr/bin/python3 ~/.config/kinto/gui/kinto-gui.py
iii. if ModuleNotFoundError: No module named 'distutils.util', then sudo apt install python3-distutils
iv. rerun /usr/bin/python3 ~/.config/kinto/gui/kinto-gui.py

### 15. Get all our dotfiles
```console
git clone https://github.com/tomskopek/dotfiles.git ~/dev/
```

### 16. Install ssh-askpass
```console
sudo apt install ssh-askpass
```

You may need to add this to your dotfiles?
(should be done already in our dotfiles)
```
set SUDO_ASKPASS = /usr/bin/ssh-askpass
```

### 17. Disable caps lock.
Edit: `/etc/default/keyboard`

Add this:
```
XKBOPTIONS="caps:escape"
```

Restart the computer

Note: The full file should look like:

```
# KEYBOARD CONFIGURATION FILE

# Consult the keyboard(5) manual page.

XKBMODEL="pc105"
XKBLAYOUT="us"
XKBVARIANT=""
XKBOPTIONS="caps:escape"

BACKSPACE="guess"
```

### 18. Link everything

```console
ln -s ~/dev/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dev/dotfiles/.ideavimrc ~/.ideavimrc
ln -s ~/dev/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dev/dotfiles/.zshrc ~/.zshrc   <- careful! make sure you have everything you need from there
ln -s ~/dev/dotfiles/.zshrc-mac ~/.zshrc-mac
ln -s ~/dev/dotfiles/.zshrc-ubuntu ~/.zshrc-ubuntu
ln -s ~/dev/dotfiles/ubuntu/kinto.py ~/.config/kinto/kinto.py
```

### 18. Install tmux
```console
brew install tmux
```

Install the tmux plugin manager:
```console
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Install plugins: Open tmux. type prefix + I (capital I, as in Install) to fetch plugins

### 19. Install lazygit
```console
brew install jesseduffield/lazygit/lazygit
```

### 20. Install font-manager
```console
sudo apt install font-manager
```

### 21. Install powerline fonts:
[InconsolataDz](https://github.com/powerline/fonts/blob/master/InconsolataDz/Inconsolata-dz%20for%20Powerline.otf)
[FiraMono](https://github.com/powerline/fonts/blob/master/FiraMono/FuraMono-Medium%20Powerline.otf)

### 22. Set fonts in terminal
Hamburger > Preferences > Profiles(Unamed) > Custom Font

### 23. Install webstorm/Android Studio

Note: on both of these commands, you might need to add the `--classic` option
```console
snap install android-studio 
```
```console
snap install webstorm
```

### 24. Install [java-jre](https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-on-ubuntu-18-04)
```console
sudo apt install default-jre
```
```console
sudo apt install default-jdk
```

### 25. Install [yarn](https://classic.yarnpkg.com/lang/en/docs/install/#debian-stable)
```console
npm install --global yarn
```
