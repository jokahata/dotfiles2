#~/.bashrc
bind '"\e[5C": forward-word'
bind '"\e[5D": backward-word'
bind '"\e[1;5C": forward-word'
bind '"\e[1;5D": backward-word'

# https://spin.atomicobject.com/2016/05/28/log-bash-history/
export PROMPT_COMMAND='if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> ~/.logs/bash-history-$(date "+%Y-%m-%d").log; fi'

# Initialize rbenv
eval "$(rbenv init -)"


kill-crashplan() {
    # Seems like the plist name changed, maybe w/ an update? Check both just in case
    local -r files=("/Library/LaunchDaemons/com.crashplan.engine.plist" "/Library/LaunchDaemons/com.code42.service.plist")
    for f in $files; do [ -e "$f" ] && sudo launchctl unload "$f"; done
}

function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

function curb {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}
alias vim='mvim -v'

# Set CLICOLOR if you want Ansi Colors in iTerm2
export CLICOLOR=1

# Set colors to match iTerm2 Terminal Colors
export TERM=xterm-256color

PS1="\[\e[32m\](\$(parse_git_branch)) \[\e[34m\]\h:\W \$ \[\e[m\]"
export PS1

#Start slack in dev mode
alias slackdev="export SLACK_DEVELOPER_MENU=true; /usr/bin/nohup open -a /Applications/Slack.app"


alias svim="sudo vim"
alias vib="vim ~/.bashrc"
alias sib="source ~/.profile"
alias vyab="vim ~/.yabairc"
alias syab="brew services restart yabai"
alias vskhd="vim ~/.skhdrc"
alias sskhd="skhd -r"

alias sbash="source ~/.bashrc"
alias adb="~/Library/Android/sdk/platform-tools/adb"
alias unity-device-log="adb logcat -s Unity ActivityManager PackageManager dalvikvm DEBUG > logcat.txt"
alias adb_rpt_install="~/Documents/Scripts/adb_repeat_install.sh"
alias g="git number"
alias gs="git status"
alias gl="g log --oneline --pretty"
alias gl="g log --oneline"
alias gc="g checkout; gsu"
alias gcb="g checkout -b"
remoteadd () {
	remoteUrl=$(g remote -v | grep origin | head -n 1 | cut -d" " -f 1 | awk -v user=$1 'gsub(/jokahata/, user, $2); {print $2};' | tail -1)
	git remote add $1 $remoteUrl
}

# Pull
alias gpul="g pull"
alias gpulup="g pull upstream"
alias gfup="g fetch upstream"
alias gfo="g fetch origin"
supfetch () {
	if [[ -d wf-react ]]; then
		cd wf-react && git lfs fetch --all && g fetch upstream && cd ..;
	fi
	g fetch upstream;
}

#alias supfetch="cd wf-react && g fetch upstream && cd .. && g fetch upstream"
alias gpulupdev="gfup; g pull upstream development; g submodule update --init --recursive"
alias gcupdev="gfup && gc upstream/development"
alias gpulupm="gfup; g pull upstream master; g submodule update --init --recursive"
alias stapul="g stash && g pull && g stash pop"
alias stapulp="g stash && g pull && g stash pop && gp"
alias gstapul="stapul"
# Merge
alias gm="g merge"
alias gmupdev="gfup; g merge upstream/development"
alias gmupm="gfup; g merge upstream/master"
alias gmom="gfo; g merge origin/master"
alias gcp="g cherry-pick"
alias gcpc="g cherry-pick --continue"
alias gcpa="g cherry-pick --abort"
alias ga="g add"
alias gaa="g add --all"
alias gcm="g commit -m"
alias gc="g checkout"
alias grb="g rebase"
alias grbc="g rebase --continue"
alias grba="g rebase --abort"
alias grbs="g rebase --skip"
alias gf="g fetch"
alias gbd="g branch -D"
alias gbl="g branch --list"
alias gpd="g push --delete"
alias gpu="g push -u"
alias gpuo="g push --set-upstream origin"
alias curbranch="g symbolic-ref --short HEAD"
alias gpuot="g push --set-upstream origin '$(parse_git_branch)'"
alias gp="g push"
alias gd="g diff"
alias gsu="g submodule update --init --recursive"
alias gsta="g stash"
alias gstas="g stash save"
alias gstasi="g stash save --include-untracked"
alias gstai="g stash --include-untracked"
alias gstaik="g stash --include-untracked --keep-index"
alias gstap="g stash pop"
alias gstaa="g stash apply"
alias glfsfix="g rm .gitattributes; g add -A; g reset --hard"
alias logw="adb logcat -s '=w'"
alias logj="adb logcat -s '=w'"

# React Native
alias adbreverse="adb reverse tcp:8081 tcp:8081"
alias adbr="adbreverse"
alias yys="yarn; yarn start;"
alias yup="cd wf-react && yarn && yarn install-pods && cd .."
alias yip="yarn && yarn install-pods"
alias gyup="gsu && yup"
alias yysac="adbreverse; yarn; yarn start --reset-cache;"
alias ysc="yarn start --reset-cache"
alias rnandroid="react-native run-android"
alias rnra="react-native run-android"
alias rnios="react-native run-ios"
alias rnri="react-native run-ios"
alias rn="react-native"
alias rnloga="rn log-android"
alias rnlogi="rn log-ios"
alias scan="wwfr; ./scripts/scanForErrors.sh; cd -"
alias rmnode="wwfrm; rm -rf node_modules/; cd -"
alias ycoco="yarn && cocopods"

alias ssound="sudo killall coreaudiod"
alias sshagent="eval '$(ssh-agent)'"
alias sshadd="ssh-add -K ~/.ssh/id_rsa"
sshagent && sshadd



alias gmomd="gmom && du"
alias du="deployup"
alias yd="yarn deploy"
alias gpyd="git push && yd"
function gpuoyd() {
	gpuo $1
	yd	
}

dder () {
# Go to dervied data
# Iterate fver files except LOg and Index
	for dir in ~/Library/Developer/Xcode/DerivedData/*/
	do
		dir=${dir%*/}
		echo "$dir"
		for projectDir in $dir/
		do
			projectDir=${projectDir%*/}
			echo "    ProjectDir $projectDir"
			for cachingFilePath in $projectDir/*
			do
				cachingFilePath=${cachingFilePath%*/}
				fileName=${cachingFilePath##*/}
				if [[ $fileName =~ ^(Logs|Index|info.plist)$ ]]; then
				       	echo "KEEP $cachingFilePath";
				else
					rm -rf "$cachingFilePath"
				fi
			done
		done
	done
}

gpdu () { git push --delete $1 $2; git push -u $1 $2; }
repush () { gpdu $1 $2; }
gpduo () { git push --delete origin $1; git push -u origin $1; }
repusho () { gpduo $1 $2; }
gbdb () { git branch -D $1; git push origin --delete $1; }
ntest () { gcb test1; }
gbdbpr () { gbdb $1; gbdb ${1%???}; }
gcbupdev () { git fetch upstream development && git checkout upstream/development && git submodule update --init --recursive && git checkout -b $1; }
gcbsupdev () { supfetch && git checkout upstream/development && git submodule update --init --recursive && git checkout -b $1; }
gcbom () { git fetch origin master; git checkout origin/master; git submodule update --init --recursive; git checkout -b $1; }
gcbupm () { git fetch upstream master && git checkout upstream/master && git submodule update --init --recursive && git checkout -b $1; }
# Create a fresh branch off development and cherry pick commits and return to the previous branch
gcbupdevp () { gcbupdevpn $1 $2 && gc @{-2} && gsu; }
# gcbupdevp but without switching branches back
gcbupdevpn () { supfetch && gstas && gcbupdev $1 && gcp $2 && gpuo $1 && gc @{-2} && gsu; }
gcbop () { gstas && gcbom $1 && gcp $2 && gpuo $1; }
gcbupmp () { gstas; gcbupm $1; gcp $2; gpuo $1; gc @{-2}; gsu; }
gbduo () { git branch -D $1; git push origin --delete $1; }

alias rrelink="react-native unlink react-native-screens; react-native link react-native-screens"
alias gct="gc @{-1}"

export USE_CACHE=1
export NDK_CCACHE=/usr/local/bin/ccache

aliasnote () {
	echo "Notes:";
	echo "1. I don't add an alias I've never met."	
	echo "2. It's a history for things that will popup again"
	echo "3. Be mindful of what you add"	
}

posWord () {
	cat $1 | grep Possible | sort > tmp && mv tmp ${1/raw/scrubbed}
}

# bash: Place this in .bashrc.
function iterm2_print_user_vars() {
  iterm2_set_user_var gitBranch $((git branch 2> /dev/null) | grep \* | cut -c3-)
  iterm2_set_user_var currentDir $(pwd | xargs basename)
}
# History
# https://news.ycombinator.com/item?id=18898523
#if [ ! -d ~/.history/$(date -u +%Y/%m/) ]; then
#        mkdir -p ~/.history/$(date -u +%Y/%m/)
#fi
  #cat .history/2016/09/* |sort -n| uniq
#  export HISTFILE="${HOME}/.history/$(date -u +%Y/%m/%d.%H.%M.%S)_${HOSTNAME}_$$"
#  export HISTSIZE=
#  export HISTCONTROL=ignoreboth
#  export HISTCONTROL=erasedups
#  export HISTTIMEFORMAT="%d/%m/%Y-%H:%M:%S"
  #export PROMPT_COMMAND='history -a'
#  export HISTIGNORE='&:bg:fg:clear:ls:pwd:history:exit:make*:* --help:'
#  export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
  histgrep () 
  {
  	grep -r "$@" ~/.history
  	history | grep "$@"
  }

# https://android.jlelse.eu/how-i-reduced-my-android-build-times-by-89-4242e51ce946gs
# Have the adb accessible, by including it in the PATH
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:~/Library/Android/sdk/platform-tools/"

# Setup your Android SDK path in ANDROID_HOME variable
export ANDROID_HOME=~/Library/Android/sdk/

source ./.bashrc_sec
exit_session() {
	. "$HOME/.bash_logout"
}
# trap exit_session SIGHUP
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="~/.sdkman"
[[ -s "~/.sdkman/bin/sdkman-init.sh" ]] && source "~/.sdkman/bin/sdkman-init.sh"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
