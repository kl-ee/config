# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

if [ -e /lib/terminfo/x/xterm-256color ]; then
    export TERM='xterm-256color'
else
    export TERM='xterm-color'
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
export CONFIG_DIR=~/config
if [ -f $CONFIG_DIR/bash/.bash_aliases ]; then
    . $CONFIG_DIR/bash/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

if [ -f $CONFIG_DIR/git/.git-completion.sh ]; then
    . $CONFIG_DIR/git/.git-completion.sh
fi

if [ -f $CONFIG_DIR/docker/.docker-completion.sh ]; then
    . $CONFIG_DIR/docker/.docker-completion.sh
fi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=2000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
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

# ANSIcolorcodes
RS="\[\033[0m\]"	#reset
HC="\[\033[1m\]"	#hicolor
UL="\[\033[4m\]"	#underline
INV="\[\033[7m\]"	#inversebackgroundandforeground
FBLK="\[\033[30m\]"	#foregroundblack
FRED="\[\033[31m\]"	#foregroundred
FGRN="\[\033[32m\]"	#foregroundgreen
FYEL="\[\033[33m\]"	#foregroundyellow
FBLE="\[\033[34m\]"	#foregroundblue
FMAG="\[\033[35m\]"	#foregroundmagenta
FCYN="\[\033[36m\]"	#foregroundcyan
FWHT="\[\033[37m\]"	#foregroundwhite
BBLK="\[\033[40m\]"	#backgroundblack
BRED="\[\033[41m\]"	#backgroundred
BGRN="\[\033[42m\]"	#backgroundgreen
BYEL="\[\033[43m\]"	#backgroundyellow
BBLE="\[\033[44m\]"	#backgroundblue
BMAG="\[\033[45m\]"	#backgroundmagenta
BCYN="\[\033[46m\]"	#backgroundcyan
BWHT="\[\033[47m\]"	#backgroundwhite

if [ "$color_prompt" = yes ]; then
    source $CONFIG_DIR/git/.git-prompt.sh
    PROMPT_DIRTRIM=3
    PS1="${debain_chroot:+($debain_chroot)}$RS[$FCYN\u$RS@$FRED\h$RS]$FCYN\w$FMAG\$(__git_ps1)$RS% "
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w \$\[\033[00m\] '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
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

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

#Add to path
PATH=$PATH:~/bin

# Personal settings
export EDITOR="vim"
export VISUAL="vim"
export GREP_COLOR="1;35"

# Temporarily set our compilers
export CC=/usr/bin/gcc-4.8
export CXX=/usr/bin/g++-4.8

