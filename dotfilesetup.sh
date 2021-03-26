
if ! command mvim &> /dev/null; then
  brew cask install macvim
fi

# Install FiraFont for sweet looking code
brew tap homebrew/cask-fonts
brew install --cask font-fira-code

