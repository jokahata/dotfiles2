source ~/.bashrc
alias vim="mvim -v"
export ANDROID_HOME=/Users/jokahata/Library/Android/sdk/
export PATH=$PATH:/usr/local/Cellar/node/10.4.1/bin/
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:~/.local/bin
export PATH=$PATH:/Users/jokahata/.gem/ruby/2.3.0/bin
export PATH=$PATH:/Users/jokahata/workspace/utilities/git-number
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.rbenv/shims:$PATH"
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/jokahata/.sdkman"
[[ -s "/Users/jokahata/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/jokahata/.sdkman/bin/sdkman-init.sh"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

