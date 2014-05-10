#
# ~/.bashrc
#

# If not running interactively, don't do anything
[ -z "$PS1" ] && return
# [[ $- != *i* ]] && return

PS1='\h:\w\$ '
OS='uname -s'

# My aliases
alias screen='screen -s /bin/bash'
alias wee='weechat-curses'
# if [ "$OS" == 'Linux' ]; then
#     alias ls='ls --color=auto'
# fi
alias cp='cp -iv'
alias python='python2.7'
alias cal='cal -3'
alias sudo='sudo -E'
alias reboot="sudo shutdown -r now"
alias off="sudo shutdown -h now"
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias today='date "+%A, %B %-d, %Y"'
unalias ls > /dev/null 2> /dev/null
alias ll='ls -l'
alias la='ls -A'
alias lla='ls -lA'
alias lS='ls -Ss'
alias las='ls -aSs'
alias lls='ls -lS'
alias llas='ls -lAS'
alias l='ll'
alias lals='llas'
alias lc='ls --color=none'
alias c='clear'
alias brc='vim ~/.bashrc'
alias reload='. ~/.bashrc'
alias back='cd "$OLDPWD"'
alias cu='cd ..'
alias r='reload'
alias b='back'
alias aquamacs='open /Applications/Aquamacs.app/'

# Mis-spelled commands
alias gvb='gdb'
alias gbim='gvim'
alias bim='vim'
alias cim='vim'
alias gvbim='gvim'
alias gbvim='gvim'
alias les='less'
alias relaod='reload'
alias yourt='yaourt'
#PS1='[\u:\h \W]\$ '

# Useful functions

# Extract many files with one command
function extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xvjf $1    ;;
      *.tar.gz)    tar xvzf $1    ;;
      *.tar.xz)    tar Jxvf $1    ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       rar x $1       ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xvf $1     ;;
      *.tbz2)      tar xvjf $1    ;;
      *.tgz)       tar xvzf $1    ;;
      *.zip)       unzip -d `echo $1 | sed 's/\(.*\)\.zip/\1/'` $1;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)           echo "don't know how to extract '$1'" ;;
    esac
  else
    echo "'$1' is not a valid file!"
  fi
}

function up () {
  LIMIT=$1
  P=$PWD/..
  for ((i=1; i < LIMIT; i++))
  do
    P=$P/..
  done
  cd $P
}

function cl () {
  cd "$@" && la;
}

export PATH=/usr/local/mysql/bin:$PATH
export PATH=$HOME/.bin:$HOME/.gem/ruby/2.0.0/bin:$PATH
export CPLUS_INCLUDE_PATH=/usr/local/UnitTest
export EDITOR=vim
export TERM=xterm-256color

export GTEST=/usr/local/gtest
alias gtest="g++ -g -I${GTEST}/include -L${GTEST} -lgtest -lpthread"

# Make sure display get updated when terminal window get resized
shopt -q -s checkwinsize
# Turn on the extended pattern matching features 
shopt -q -s extglob
# Append rather than overwrite history on exit
shopt -s histappend
# Disable [CTRL-D] which is used to exit the shell
set -o ignoreeof
