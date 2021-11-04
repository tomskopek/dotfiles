# linux setup

1. Install Chrome: https://www.google.com/intl/en_ca/chrome/

2. Update apt: sudo apt update && sudo apt upgrade

3. Get curl: sudo apt install curl

4. Install git: sudo apt install git-all
   4a. Add ssh keys to github
   https://github.com/settings/keys

4b. Check for existing keys:
ls -lA ~/.ssh

4c. Generate ssh keys if not already existing
ssh-keygen -t ed25519 -C "tomskopek@gmail.com"

4d. add to Github

5. Get zsh so the rest of this process is nicer:
   5a. sudo apt install zsh
   5b. oh-my-zsh:
   https://ohmyz.sh/#install
   Install via curl: sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   5c. zsh-autosuggestions
   git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

6. Get brew: https://brew.sh/
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   After install, follow next steps - including brew install gcc
   Log out and log back in (because of .zprofile changes)

7. Get pyenv:
   7a. Get prerequisites: (https://github.com/pyenv/pyenv/wiki#suggested-build-environment)

sudo apt-get update; sudo apt-get install make build-essential libssl-dev zlib1g-dev \
 libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
 libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

7b. Install pyenv using brew (https://github.com/pyenv/pyenv#installation)
brew update
brew install pyenv

7c. Finish instructions for shell here (https://github.com/pyenv/pyenv#basic-github-checkout)
echo 'eval "$(pyenv init --path)"' >> ~/.zprofile
  echo 'eval "$(pyenv init -)"' >> ~/.zshrc
Log out and log back in

7d. install python 3.x:
pyenv install --list | grep " 3\.[678]"
(scroll up and look for latest 3.x.x version (at the time of writing, was 3.9.7))
pyenv install 3.9.7
pyenv global 3.9.7

7e. install python 2.7.x:
pyenv install 2.7.18

7f. some useful commands:
pyenv versions: see all installed versions
Helpful article: https://realpython.com/intro-to-pyenv/

8. Get nvm
   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

8a. get latest version of node:
nvm install --lts

8b. check it worked
node --version

9. Install fzf
   `$ brew install fzf`
   `$(brew --prefix)/opt/fzf/install`

10. Get ripgrep (needed for fzf/nvim)
    `$ brew install ripgrep`

11. get neovim with brew(https://github.com/neovim/neovim/wiki/Installing-Neovim#homebrew-on-macos-or-linux)
    `$ brew install neovim`

12. set up neovim!

11a. check if nvim config dir exists
cd ~/.config
ls -lA | grep nvim

11b. make it if it doesnt
mkdir nvim

11c. use our config:
git clone git@github.com:tomskopek/nvim_config.git ~/.config/nvim

11d. install plugins
nvim
:PackerInstall

11e. fix python packages: (see :checkhealth provider / :help provider-python)
python3 -m pip install --user --upgrade pynvim

12. install xclip so that clipboard works in nvim
    sudo apt install xclip

13. install Kinto
    /bin/bash -c "$(wget -qO- https://raw.githubusercontent.com/rbreaves/kinto/HEAD/install/linux.sh || curl -fsSL https://raw.githubusercontent.com/rbreaves/kinto/HEAD/install/linux.sh)"

13a. if problems, need to log in using Xorg

13b. may run into a problem with xkeysnail. if so:
git clone https://github.com/rbreaves/kinto.git
cd kinto
cd xkeysnail
pip3 install --upgrade .
cd ..
./setup.py

13c. get supporting packages
sudo apt install gnome-tweaks gnome-shell-extension-appindicator gir1.2-appindicator3-0.1

13d. Not sure this is the right way to fix it, but this might help:
13d.i. use system python3 (sudo which python3)
13d.ii. /usr/bin/python3 ~/.config/kinto/gui/kinto-gui.py
13d.iii. if ModuleNotFoundError: No module named 'distutils.util', then sudo apt install python3-distutils
13d. iv. rerun /usr/bin/python3 ~/.config/kinto/gui/kinto-gui.py

14. get all dotfiles
    git clone https://github.com/tomskopek/dotfiles.git ~/dev/

15. install ssh-askpass
    sudo apt install ssh-askpass

15a.
set SUDO_ASKPASS = /usr/bin/ssh-askpass (should be done already in dotfiles)

16. Disable caps lock. Edit: `/etc/default/keyboard`
    XKBOPTIONS="caps:escape"
    restart computer

full file should look like:

```
# KEYBOARD CONFIGURATION FILE

# Consult the keyboard(5) manual page.

XKBMODEL="pc105"
XKBLAYOUT="us"
XKBVARIANT=""
XKBOPTIONS="caps:escape"

BACKSPACE="guess"
```

17. link everything

```
ln -s ~/dev/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dev/dotfiles/.ideavimrc ~/.ideavimrc
ln -s ~/dev/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dev/dotfiles/.zshrc ~/.zshrc   <- careful! make sure you have everything you need from there
ln -s ~/dev/dotfiles/.zshrc-mac ~/.zshrc-mac
ln -s ~/dev/dotfiles/.zshrc-ubuntu ~/.zshrc-ubuntu
```

18. install tmux
    `$ brew install tmux`

19. install lazygit
    `$ brew install jesseduffield/lazygit/lazygit`

20. install font-manager
    `$ sudo apt install font-manager`

21. Get powerline fonts:
    [InconsolataDz](https://github.com/powerline/fonts/blob/master/InconsolataDz/Inconsolata-dz%20for%20Powerline.otf)
    [FiraMono](https://github.com/powerline/fonts/blob/master/FiraMono/FuraMono-Medium%20Powerline.otf)

22. Set fonts in terminal
    Hamburger > Preferences > Profiles(Unamed) > Custom Font

23. Install webstorm/Android Studio
    `$ snap install android-studio` (might need --classic option)
    `$ snap install webstorm` (might need --classic option)

24. Install [java-jre](https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-on-ubuntu-18-04)
    `$ sudo apt install default-jre`
    `$ sudo apt install default-jdk`

25. Install [yarn](https://classic.yarnpkg.com/lang/en/docs/install/#debian-stable)
    `$ npm install --global yarn`
