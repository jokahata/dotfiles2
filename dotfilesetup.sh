
if ! command mvim &> /dev/null; then
				brew cask install macvim
fi

# Install zsh
if [[ ! -d ~/.oh-my-zsh ]]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# Setup passion theme 
brew install coreutils
if [[ ! -f ~/.oh-my-zsh/custom/passion.zsh-theme ]]; then
	git clone git@github.com:ChesterYue/ohmyzsh-theme-passion.git
	cp ohmyzsh-theme-passion/passion.zsh-theme .oh-my-zsh/custom/passion.zsh-theme
	rm -rf ./ohmyzsh-theme-passion
fi


