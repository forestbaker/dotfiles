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
#[ -z "$PS1" ] && return || :
#[ "$0" contains - ] && return || :

case "$-" in
  *i*) ;;
  *) return ;;
esac

#====| section }==========================================================>
#				create the environment
#=========================================================================>

#reset
case "$(uname)" in
  "Darwin") echo 'Running: OS X' ;;  
  "Linux") echo 'Running: GNU/LINUX' ;;
  *) echo 'Running: Silent/Deep' ;;
esac

# Turn off UTF-8, use ASCII only
# LC_ALL=C

#set -o notify
#set -o braceexpand

# check the length/width of the shell and update $LINES & COLUMNS
shopt -s checkwinsize
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
#               shell command history settings
#=========================================================================>

shopt -s histappend

# add this to ignore leading whitespace [ \t]*
export HISTIGNORE='&:history:ls:ps:ps -A:[bf]g:exit'
export HISTCONTROL='ignoredups:ignoreboth'
export HISTTIMEFORMAT='[%Y/%m/%d %H:%M] '
export HISTSIZE='10000'
export HISTFILESIZE='20000'
export PROMPT_COMMAND="history -a"
export TIMEFORMAT='%R'

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
#				load shell alias library
#=========================================================================>

# check for 
[[ -s $HOME/klooj/dotfiles/.shell_alii && -r $HOME/klooj/dotfiles/.shell_alii ]] && source "${HOME}"/klooj/dotfiles/.shell_alii

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
#				configure ssh
#=========================================================================>

[[ -d $HOME/.ssh ]] && : || printf '%s\n\n' '.ssh folder NOT found'

#====| section }==========================================================>
#				say something clever
#=========================================================================>

[[ -d $HOME/klooj/quotes ]] && NoComment $HOME/klooj/quotes/*.txt | sort -R | tail -1 > $HOME/motd.txt || :
[[ -s $HOME/motd.txt ]] && grep '' motd.txt || :

#====| section }==========================================================>
#				the tao
#=========================================================================>

# set the time if root
[[ $EUID -eq 0 ]] && SetTime || printf '%s\n\n' "Hide not your talents. They for use were made. What's a sundial in the shade? -Benji Frankles"

# sanity check $HOME
# { [ -d "$HOME" ] && [ -r "$HOME" ] && [ -w "$HOME" ] } && echo "$HOME is home. Welcome, Vilkommen, Come on in!" || echo "$HOME may not be safe"
[[ -d $HOME && -w $HOME && -r $HOME ]] && printf '%s\n\n' "$HOME is home. Bienvenue, Vilkommen, Come on in!" || printf '%s\n\n' "$HOME may not be sane! Get a hotel!"


mkdir -m 0700 -p "$HOME"/klooj/{projects,scripts,sandbox,docs,bin,dotfiles,lib,quotes}
mkdir -m 0700 -p "$HOME"/{bin,scripts}

[[ -d $HOME/bin && -d $HOME/scripts ]] && export PATH="$HOME/bin:$HOME/scripts:$PATH" || :

printf '%s\n\n' "Screen Length & Width: $COLUMNS x $LINES"

#====| section }==========================================================>
#				version history
#=========================================================================>

# Version 1.0 - Unification!
# Version 1.1 - Beautification!
