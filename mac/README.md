# mac setup
### 1. Keyboard
Modify caps to be escape

### 2. Trackpad
Tap to Click

### 3. Dock
Automatically hide and show the Dock

### 4. Get [chrome](https://www.google.com/chrome/)

### 5. Get [brew](https://brew.sh/)
This will also get Xcode Command Line Tools

### 6. Start downloading Xcode from the App Store (it’s 13gb so might as well get started)

### 7. Get [iterm2](https://formulae.brew.sh/cask/iterm2)
```console
brew install --cask iterm2)
```

### 8. Get [oh-my-zsh](https://ohmyz.sh/#install) (via curl)

### 9. Get [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh)

### 10. Get all dot files:

Create a ~/dev folder

```console
git clone https://github.com/tomskopek/dotfiles.git ~/dev/
```

### 11. Add ssh keys to GitHub:

1. Add ssh keys to [Github](https://github.com/settings/keys)
2. Check for existing keys
```console
ls -lA ~/.ssh
```
3. Generate ssh keys if not already existing
```console
ssh-keygen -t ed25519 -C "tomskopek@gmail.com”
```
4. Add to Github

### 12. Get pyenv
1. First, get the [Build Dependencies](https://github.com/pyenv/pyenv/wiki#suggested-build-environment) - Note: this seemed to not do anything on Catalina because the dependencies are already met?

### 13. Get the [Powerline10k theme](https://github.com/romkatv/powerlevel10k) for zsh

### 14. Install [nvm](https://github.com/nvm-sh/nvm#installing-and-updating)
1. Install lts version of node
```console
nvm install --lts
```
2. Check it works
```console
node --version
```

### 15. Fzf:
1. Install fzf
```console
brew install fzf
```
2. Install key-bindings and fuzzy completion
```console
$(brew --prefix)/opt/fzf/install
```

### 16. Install fd
```console
brew install fd
```

### 17. Install ripgrep
```console
brew install ripgrep
```

### 18. Install neovim
```console
brew install neovim
```

### 19. Install tmux
```console
brew install tmux
```

Install the tmux plugin manager:
```console
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Install plugins: Open tmux. type prefix + I (capital I, as in Install) to fetch plugins

### 20. Configure neovim:
Note: If you get a packer error, you may need to [install packer](https://github.com/wbthomason/packer.nvim#quickstart) manually (via the git clone command)

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


### 21. Install Yarn
```console
npm install --global yarn
```
