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
<<<<<<< HEAD:bashrc
=======
function _update_ps1() {
	PS1="$(~/.lasypig/powerline-shell.py --cwd-max-depth 3 $? 2> /dev/null)"
}

if [ -z "$SSH_CLIENT" ] && [ -z "$SSH_TTY" ]; then
	if [ "$TERM" != "linux" ]; then
		PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
	fi
fi
>>>>>>> 561125d836920d67cb89679e9be39dd54564be9a:.bashrc

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
alias ack='ack-grep'
alias gvim='gvim 2> /dev/null'
alias svnadd="svn status | grep \"^?\" | awk '{print $2}' | xargs svn add "
alias ctags='ctags -R --c-kinds=+p  --fields=+ias --extra=+q'
alias :q='exit'
alias define='googler -p 127.0.0.1:8087 -n 2 define'
alias dumpobj='/opt/arm-2009q1/bin/arm-none-linux-gnueabi-objdump -S -l -z  -j .text'
alias xo='xdg-open'
<<<<<<< HEAD:bashrc
alias ftpput='ncftpput -u root -p hisome -P 3121'
alias ftpget='ncftpget -u root -p hisome -P 3121'
alias pandoc="pandoc --template=$HOME/Templates/template.tex --latex-engine=xelatex"
alias untar='tar -zxvf'
#alias ping='prettyping --nolegend'
=======
>>>>>>> 561125d836920d67cb89679e9be39dd54564be9a:.bashrc

bind -x '"\C-l":ls -l'

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
addToPATH /opt/arm-2009q1/bin
addToPATH /usr/local/texlive/2013/bin/i386-linux
addToPATH /home/wangxb/misc/node.js/bin

<<<<<<< HEAD:bashrc
export PYTHONPATH=$(echo /usr/lib/llvm-6.0/build/lib/)
export LD_LIBRARY_PATH=$(llvm-config-6.0 --libdir)
=======
export PYTHONPATH=$(echo /usr/lib/llvm-4.0/build/lib/)
export LD_LIBRARY_PATH=$(llvm-config-4.0 --libdir)
>>>>>>> 561125d836920d67cb89679e9be39dd54564be9a:.bashrc

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
			if   [[ $RL =~ ^\ ?M ]]; then C="\033[34m";
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
			else C="\033[34m";
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
    man -S 2:3:1 "$@"
}

# press ctrl-l to ls
bind -x '"\C-l":ls -l'

# disable CapsLock key
setxkbmap -option ctrl:nocaps

<<<<<<< HEAD:bashrc
export GOPATH='/home/wangxb/tmp/Go'
alias tmux="env TERM=xterm-256color tmux"

#eval "$(thefuck --alias)"

# use bat instead of cat
#which bat  > /dev/null
#if [ $? -eq 0 ]; then
#	export BAT_THEME="GitHub"
#	alias cat='bat -n'
#fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

#if [[ -f ~/.lasypig/mcfly.bash ]]; then
#	source ~/.lasypig/mcfly.bash
#fi
=======
# fuck gfw
ps -ef | grep -i XX-Net | grep -iv grep > /dev/null
if [ $? -gt 0 ]; then
	/home/wangxb/misc/XX-Net/start 2> /dev/null &
fi
>>>>>>> 561125d836920d67cb89679e9be39dd54564be9a:.bashrc

export GOPATH='/home/wangxb/tmp/Go'
alias tmux="env TERM=xterm-256color tmux"

eval "$(thefuck --alias)"
