# dotfiles2
# New version of my dot files
# TODO: Deprecate old repository and write down why

### Strategy adopted from https://www.atlassian.com/git/tutorials/dotfiles

### Setup on new computer
Run this command in your terminal
```
if [[ ! -d "$HOME/.cfg" ]]; then
  git clone --bare git@github.com:jokahata/dotfiles2.git $HOME/.cfg
fi
alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
cfg checkout || {
  # Backup any conflicting files if necessary
  mkdir -p .cfg-backup && \
  cfg checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
  xargs -I{} mv {} .cfg-backup/{}
  cfg checkout
}
source ~/.bashrc
```
