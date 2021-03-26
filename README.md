# dotfiles2
# New version of my dot files
# TODO: Deprecate old repository and write down why

### Strategy adopted from https://www.atlassian.com/git/tutorials/dotfiles

# TODO: Write down setup steps on new computer
```
git init --bare $HOME/.cfg
alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
echo "alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.bashrc
```

# TODO: Add a script to setup automatically

Installation
```
alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
git clone --bare git@github.com:jokahata/dotfiles2.git $HOME/.cfg
dotfilessetup.sh
```
