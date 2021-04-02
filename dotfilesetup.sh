
if ! command mvim &> /dev/null; then
  brew cask install macvim
fi

# Install FiraFont for sweet looking code
brew tap homebrew/cask-fonts
brew install --cask font-fira-code

if [[ ! -d "~/.joconf/" ]]; then
 mkdir "~/.joconf/"
fi
if [[ ! -f "~/.jconf/osx-browse.el" ]]; then
  curl -k https://raw.githubusercontent.com/rolandwalker/osx-browse/master/osx-browse.el --output ~/.joconf/
fi

