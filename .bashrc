#
# ~/.bashrc
#

# If not running interactively, don't do anything
[ -z "$PS1" ] && return
# [[ $- != *i* ]] && return

PS1='\h:\w\$ '
OS='uname -s'

# My aliases
source ~/.bashrc.aliases

# Useful functions
source ~/.bashrc.functions

export PATH=/usr/local/mysql/bin:$PATH
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

# Specific for OSX
if [ `uname -s` == Darwin ]
then source ~/.bashrc.darwin
fi


