#! /bin/bash

# Symlink nvim folder into ~/.config
ln -s $PWD/nvim $HOME/.config/nvim

# Import iterm settings into iTerm
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "${PWD}/com.googlecode.iterm2.plist"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
