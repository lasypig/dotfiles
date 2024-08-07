# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace
HISTTIMEFORMAT="%F %T  "

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;35m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\W\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto --exclude="tags"'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -lF --time-style=long-iso'
alias llh='ls -lhF --time-style=long-iso'
alias la='ls -A'
alias l='ls -CF'

function cd() { builtin cd "$@" && ls; }
function b { cd ..; }

# mine
alias emacs='emacs-25.1.50'
alias rmm='rm -vf *~ .*~ .*.swp'
alias du='du -sh * | sort -rh'
alias ..='cd ..'
alias agi="sudo apt-get install"
alias l.='ls -d .?*'
alias findn='find . -name'
alias LS='find -mount -maxdepth 1 -printf "%.5m %10M %#9u:%-9g %#5U:%-5G %TF_%TR %CF_%CR %AF_%AR %#15s [%Y] %p\n" 2>/dev/null'
alias brt='java -jar ~/.lasypig/BranchMaster.jar'
alias gvim='gvim 2> /dev/null'
alias svnadd="svn status | grep \"^?\" | awk '{print $2}' | xargs svn add "
alias ctags='ctags -R --c-kinds=+p  --fields=+ias --extra=+q --exclude=.ccls-cache'
alias :q='exit'
alias define='googler -p 127.0.0.1:8087 -n 2 define'
alias dump2014obj='/opt/arm-2014.05/bin/arm-none-linux-gnueabi-objdump -S -l -z  -j .text'
alias dumparmobj='/opt/arm-2009q1/bin/arm-none-linux-gnueabi-objdump -S -l -z  -j .text'
alias dumphisiobj='arm-hisiv400-linux-objdump -S -l -z  -j .text'
alias dump626obj='aarch64-mix410-linux-objdump -S -l -z  -j .text'
alias dumpobj='objdump -S -l -z  -j .text'
alias xo='xdg-open'
alias ftpput='ncftpput -u root -p hisome -P 3121'
alias ftpget='ncftpget -u root -p hisome -P 3121'
alias pandoc="pandoc --template=$HOME/Templates/template.tex --pdf-engine=xelatex"
alias untar='tar -zxvf'
#alias ping='prettyping --nolegend'
alias svnchangelog='svn propedit --revprop svn:log'
alias svneditignores='svn pedit svn:global-ignores .'
alias svndiff='svn --diff-cmd=/home/wangxb/.subversion/vimdiff.sh diff'
alias hicp='sshpass scp -P 3122 -o User=root'
alias hinvr='sshpass ssh -l root -p 3122'
alias foobar2000='mpg321'
alias df='df -xsquashfs'
alias playg711='ffplay -nodisp -f alaw -ar 8000 -i'
alias mdreader='glow -p'
alias cp='cp -ig'
alias mv='mv -ig'
alias vim='~/.lasypig/vim'
alias gvim='~/.lasypig/gvim'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

function addToPATH {
  case ":$PATH:" in
    *":$1:"*) :;; # already there
    *) PATH="$PATH:$1";;
  esac
}
addToPATH /lib/x86_64-linux-gnu
addToPATH /home/wangxb/.lasypig
addToPATH /opt/arm-2014.05/bin
addToPATH /usr/local/texlive/2013/bin/i386-linux
addToPATH /home/wangxb/misc/node.js/bin
addToPATH /opt/hisi-linux/x86-arm/arm-hisiv400-linux/target/bin
addToPATH /opt/hisi-linux/x86-arm/aarch64-mix410-linux/bin

export PYTHONPATH=$(echo /usr/lib/llvm-6.0/build/lib/)
export LD_LIBRARY_PATH=$(llvm-config-6.0 --libdir)

if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

#complete -W "wangxb@192.168.168.10:/home/wangxb work core trunk" scp

# ...
rm -f $HOME/.goutputstream-*

# svn editor
export SVN_EDITOR=vim

# start vbox 
#pgrep VirtualBox > /dev/null
#if [ $? -gt 0 ]; then
#	uptm=`cat /proc/uptime | awk  '{printf("%d", $1/60);}'`
#	if [ "$uptm" -lt 10 ]; then
#		virturlbox -startvm win10
#	fi
#fi

#. ~/.lasypig/gibo-completion.bash

#export PAGER="/usr/bin/most -s"

################################################################
# colorize make
################################################################
alias make="color_compile make -j4"
alias arm-none-linux-gnueabi-gcc="color_compile arm-none-linux-gnueabi-gcc"

################################################################
# colorize svn cmd
################################################################
function svn
{
	# rebuild args to get quotes right
	CMD=
	for i in "$@"
	do
		if [[ "$i" =~ \  ]]
		then
			CMD="$CMD \"$i\""
		else
			CMD="$CMD $i"
		fi
	done

	# pad with spaces to strip --nocol
	CMD=" $CMD "
	CMDLEN=${#CMD}

	# parse disabling arg
	CMD="${CMD/ --nocol / }"

	# check if disabled
	test "$CMDLEN" = "${#CMD}"
	NOCOL=$?
	if [ "$SVN_COLOR" != "always" ] && ( [ $NOCOL = 1 ] || [ "$SVN_COLOR" = "never" ] || [ ! -t 1 ] )
	then
		eval $(which svn) $CMD
		return
	fi

	# supported svn actions for "status-like" output
	ACTIONS="add|checkout|co|cp|del|export|remove|rm|st"
	ACTIONS="$ACTIONS|merge|mkdir|move|mv|ren|sw|up"

	# actions that outputs "status-like" data
	if [[ "$1" =~ ^($ACTIONS) ]]
	then
		eval $(which svn) $CMD | while IFS= read -r RL
		do
			if   [[ $RL =~ ^\ ?M ]]; then C="\033[36m";
			elif [[ $RL =~ ^\ ?C ]]; then C="\033[41m\033[37m\033[1m";
			elif [[ $RL =~ ^A ]]; then C="\033[32m\033[1m";
			elif [[ $RL =~ ^D ]]; then C="\033[31m\033[1m";
			elif [[ $RL =~ ^X ]]; then C="\033[37m";
			elif [[ $RL =~ ^! ]]; then C="\033[43m\033[37m\033[1m";
			elif [[ $RL =~ ^I ]]; then C="\033[33m";
			elif [[ $RL =~ ^R ]]; then C="\033[35m";
			else C=
			fi

			echo -e "$C${RL/\\/\\\\}\033[0m\033[0;0m"
		done

	# actions that outputs "diff-like" data
	elif [[ "$1" =~ ^log ]]
	then
		eval $(which svn) $CMD | while IFS= read -r RL
		do
			if   [[ $RL =~ ^$ ]]; then
				continue;
			fi
			if   [[ $RL =~ ^r[0-9] ]]; then C="";
			elif [[ $RL =~ ^-- ]]; then C="\033[35m";
			else C="\033[92m";
			fi

			echo -e "$C${RL/\\/\\\\}\033[0m\033[0;0m"
		done
	else
		eval $(which svn) $CMD
	fi
}

################################################################
# colorize manpage
################################################################
man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[01;31m") \
    LESS_TERMCAP_md=$(printf "\e[01;38;5;74m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[38;5;212m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[04;38;5;146m") \
    man -S 2:3:1:7:8 "$@"
}

# press ctrl-l to ls
bind -x '"\C-l":ls -l'

# disable CapsLock key
setxkbmap -option ctrl:nocaps

export GOPATH='/home/wangxb/tmp/Go'
alias tmux="env TERM=xterm-256color tmux"

#eval "$(thefuck --alias)"

# use bat instead of cat
#which bat  > /dev/null
#if [ $? -eq 0 ]; then
#	export BAT_THEME="GitHub"
#	alias cat='bat -n'
#fi
export FZF_DEFAULT_COMMAND="fd -E '*.o' -E '*.d'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

#if [[ -f ~/.lasypig/mcfly.bash ]]; then
#	source ~/.lasypig/mcfly.bash
#fi

export GOPATH='/home/wangxb/tmp/Go'
alias tmux="env TERM=xterm-256color tmux"

calc() { awk "BEGIN{ print $* }" ;}
sxh () { for i in "${@:2}"; do ssh "$i" "$1"; done ; }
complete -o default -o nospace -W "$(grep -i -e '^host ' ~/.ssh/config | awk '{print substr($0, index($0,$2))}' ORS=' ')" ssh scp sftp

ACK=$(which ack)
function grepc()
{
	if [ $# -eq 1 ]; then
		if [ -n "$ACK" ]; then
			wd=${1/#\//\\b}
			wd=${wd/%\//\\b}
			$ACK --follow --ignore-dir=.ccls-cache --cc "$wd" | $ACK -v "^$"
		else
			grep --color=auto -n -r --include="*.[c]" --include="*.cpp" "$1" *
		fi
	fi
}

function greph()
{
	if [ $# -eq 1 ]; then
		if [ -n "$ACK" ]; then
			wd=${1/#\//\\b}
			wd=${wd/%\//\\b}
			$ACK --follow --ignore-dir=.ccls-cache --hh "$wd" | $ACK -v "^$"
		else
			grep --color=auto -n -r --include="*.h" --include="*.hh" --include="*.hpp" "$1" *
		fi
	fi
}

function grepm()
{
	if [ $# -eq 1 ]; then
		if [ -n "$ACK" ]; then
			$ACK --follow --ignore-dir=.ccls-cache --make "$1" | $ACK -v "^$"
		else
			grep --color=auto -n -r --include="*.mk" --include="Makefile" "$1" *
		fi
	fi
}

. "$HOME/.cargo/env"

alias bd=". bd -si"

function fixheadphone()
{
	pactl set-card-profile 0 output:analog-stereo
	pactl set-sink-port alsa_output.pci-0000_00_1f.3.analog-stereo analog-output-headphones
}


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export NODE_TLS_REJECT_UNAUTHORIZED=0

#if $(which mcfly > /dev/null); then
	#eval "$(mcfly init bash)"
#fi


