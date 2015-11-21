#!/bin/rm

# Dedicated to Ken Thompson & Dennis Ritchie
# and Linus Torvalds & Richard Stallman
# The architects of humanites greatest collaborative achievement

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# [         forestsbaker |  dotfiles project 
# +-----------------------------------------------+
# [ 984623255]  |  2015-10-22  |  .bashrc  |  1.0
# +-----------------------------------------------+
# [           create a cozy environ
# +-----------------------------------------------+
# [ caveat emptor | tempus fugit | ars gratia artis
# [         rident stolidi verba Latina
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# stop non-interactive scripts from using this
#[ -z "$PS1" ] && return

case "$-" in
  *i*) ;;
  *) return;;
esac

#====| section }==========================================================>
#				create the environment
#=========================================================================>

reset
case "$(uname)" in
  "Darwin") echo 'Running: OS X' ;;  
  "Linux") echo 'Running: GNU/LINUX' ;;
  *) echo 'Running: Silent/Deep' ;;
esac

# Turn off UTF-8, use ASCII only
# LC_ALL=C

#set -o notify
#set -o braceexpand

# check the size of the window after each command, update LINES & COLUMNS
shopt -s checkwinsize
echo "Lines: $LINES"
echo "Columns: $COLUMNS"
set -o vi
# set -g default-terminal "screen-256color"
umask 0022

# export is portable
export EDITOR='vi'
export PAGER='less'

# DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ) - https://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
# Above is an overly complicated way to do: 
WORKING_DIRECTORY="$(/bin/pwd -P)"

#====| section }==========================================================>
#				shell command history settings
#=========================================================================>

shopt -s histappend

# add this to ignore leading whitespace [ \t]*
export HISTIGNORE='&:history:ls:ps:ps -A:[bf]g:exit'
export HISTCONTROL=ignoredups:ignoreboth
export HISTTIMEFORMAT='[%Y/%m/%d %H:%M] '
export HISTSIZE=10000
export HISTFILESIZE=20000
export PROMPT_COMMAND="history -a"
export TIMEFORMAT=%R

#bind 'set completion-ignore-case on'
#bind 'set mark-symlinked-directories on'

#====| section }==========================================================>
#				set the prompt
#=========================================================================>

export color_prompt=yes
export force_color_prompt=yes

# fancy this up with case 
[[ $EUID -eq 0 ]] && export PS1='\[\e[7;31m\][\u@\h \W]\$\[\e[0m\] ' || export PS1='\[\e[1;31m\][\u@\h \W]\$\[\e[0m\] '
# [ -n "$SSH_CLIENT" ] && export PS1=''\[\e[00;36m\]\u@\[\e[0;37m\]\h\[\e[00;36m\]:\W \$>\[\e[0m\] '

#====| section }==========================================================>
#				create  alii
#=========================================================================>

# bash efficiency formula 
# echo Bef = $((`cat /home/$USER/.bash_history | sort | uniq | wc -l`*100/`cat /home/$USER/.bash_history | wc -l`))%

### customize system binaries ###
# makes less quit if input fits within one screen
alias less='less -F'
# colorize pattern match
alias grep='grep --color=always'
alias grep='fgrep --color=always'
alias grep='egrep --color=always'

# list
# alias ls='ls -lhGpt --color=always'
alias ls='ls --color=always'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

### 
# 10 largest files/folders
alias dusk='du -sk | sort -n | tail'

# removes lines that start with # or 
alias NoComment="egrep -hv '^#|^$'"

# update date and time from ntp server
alias SetTime='ntpdate -u us.pool.ntp.org &'

# quick debug for bash scripts | qdebug
#alias qdebug="PS4='\\t.\$(date +%N)+ ' bash -ex"

# not portable [[
[[ -s $HOME/klooj/dotfiles/.bash_alii && -r $HOME/klooj/dotfiles/.bash_alii ]] && source $HOME/klooj/dotfiles/.bash_alii

#====| section }==========================================================>
#				functions
#=========================================================================>

# kill a process by name
# needs more work - use pgrep and pkill 
pskill() {
  if [ -z "$1" ]; then
    echo -e "\e[0;31;1mUsage: pskill [processName]\e[m"
  else
    ps -au "$USER" | grep -i "$1" | awk '{print kill -9 $1}' | sh
  fi
}

#====| section }==========================================================>
#				the tao
#=========================================================================>

[[ $EUID -eq 0 ]] && SetTime || echo "Hide not your talents. They for use were made. What's a sundial in the shade? -Benji Frankles"

# Sanity check
# { [ -d "$HOME" ] && [ -w "$HOME" ] && [ -r "$HOME" ] } && echo "$HOME is home. Welcome, Vilkommen, Come on in!" || echo "$HOME may not be safe"
[[ -d $HOME && -w $HOME && -r $HOME ]] && printf '%s\n\n' "$HOME is home. Bienvenue, Vilkommen, Come on in!" || printf '%s\n\n' "$HOME may not be sane! Get a hotel!"

# printf '%s\n\n'

mkdir -m 0700 -p "$HOME"/klooj/{projects,scripts,sandbox,docs,bin,dotfiles,lib,quotes}
mkdir -m 0700 -p "$HOME"/{bin,scripts}

[[ -d $HOME/bin && -d $HOME/scripts ]] && export PATH="$HOME/bin:$HOME/scripts:$PATH" || echo 'got a directory problem here'

#====| section }==========================================================>
#				configure ssh
#=========================================================================>

[[ -d $HOME/.ssh ]] && : || printf '%s\n\n' '.ssh folder NOT found'

#====| section }==========================================================>
#				say something clever
#=========================================================================>

[[ -d $HOME/klooj/quotes ]] && NoComment $HOME/klooj/quotes/*.txt | sort -R | tail -1 > $HOME/motd.txt || :
[[ -s $HOME/motd.txt ]] && grep '' motd.txt || :

#====| section }==========================================================>
#				version history
#=========================================================================>

# Version 1.0 - Unification!
# Version 1.1 - Beautification!
