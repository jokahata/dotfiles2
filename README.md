# dotfiles2
### Strategy adopted from https://www.atlassian.com/git/tutorials/dotfiles

```
git init --bare $HOME/.cfg
alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
echo "alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.bashrc
```

Installation
```
alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
git clone --bare git@github.com:jokahata/dotfiles2.git $HOME/.cfg
dotfilessetup.sh
```
