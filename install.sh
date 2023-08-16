#! /bin/bash

# Symlink nvim folder into ~/.config
# if you run this twice it creates symlinks in symlinks, so don't
ln -s $PWD/nvim $HOME/.config/nvim

# ...and zshrc into ~/
ln -si $PWD/.zshrc $HOME/.zshrc

# Import iterm settings into iTerm
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "${PWD}/com.googlecode.iterm2.plist"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
