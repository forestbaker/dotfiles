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

#export EDITOR PAGER WORKING_DIRECTORY
readonly EDITOR='vi'
readonly PAGER='less'

# DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ) - https://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
# Above is an overly complicated way to do: 
H_Dir="$(/bin/pwd -P)"

export H_Projects="${HOME}/klooj/projects"
export H_Dotfiles="${HOME}/klooj/dotfiles"
export H_Library="${HOME}/klooj/dotfiles/lib"
export H_Quoth="${HOME}/klooj/dotfiles/quoth"

export Lib_Alii="${HOME}/klooj/dotfiles/lib/.alii"
export Lib_System="${HOME}/klooj/dotfiles/lib/.system"
export Lib_Format="${HOME}/klooj/dotfiles/lib/.format"

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
[ $EUID -eq 0 ] && export PS1='\[\e[7;31m\][\u@\h \W]\$\[\e[0m\] ' || export PS1='\[\e[1;31m\][\u@\h \W]\$\[\e[0m\] '
# [ -n "$SSH_CLIENT" ] && export PS1=''\[\e[00;36m\]\u@\[\e[0;37m\]\h\[\e[00;36m\]:\W \$>\[\e[0m\] '

#====| section }==========================================================>
#				load shell alias library
#=========================================================================>

[[ -s "${HOME}/klooj/dotfiles/lib/.alii" && -r "${HOME}/klooj/dotfiles/lib/.alii" ]] && source "${HOME}/klooj/dotfiles/lib/.alii"

#====| section }==========================================================>
#				functions
#=========================================================================>

[[ -s "${HOME}/klooj/dotfiles/lib/.alii" && -r "${HOME}/klooj/dotfiles/lib/.alii" ]] && source "$Lib_Format"

#====| section }==========================================================>
#				the tao
#=========================================================================>

# set the time if root
[[ $EUID -eq 0 ]] && SetTime || printf '%s\n\n' "Hide not your talents. They for use were made. What's a sundial in the shade? -Benji Frankles"

# sanity check $HOME
# { [ -d "$HOME" ] && [ -r "$HOME" ] && [ -w "$HOME" ] } && echo "$HOME is home. Welcome, Vilkommen, Come on in!" || echo "$HOME may not be safe"
[[ -d $HOME && -w $HOME && -r $HOME ]] && printf '%s\n\n' "$HOME is home. Bienvenue, Vilkommen, Come on in!" || printf '%s\n\n' "$HOME may not be sane! Get a hotel!"

# create folders, add to path
mkdir -m 0700 -p "$HOME"/klooj/{projects/{sand,doc,bin},dotfiles/{lib,quoth}}
export PATH="$HOME/klooj/projects/bin:$PATH" || :

printf '%s\n\n' "Screen Length & Width: $COLUMNS x $LINES"

#====| section }==========================================================>
#				configure ssh
#=========================================================================>

[[ -d $HOME/.ssh ]] && : || printf '%s\n\n' '.ssh folder NOT found'

#====| section }==========================================================>
#				say something clever
#=========================================================================>

[[ -d $H_Quoth ]] && NoComment ${H_Quoth}/*.txt | sort -R | tail -1 > $HOME/motd.txt || :
[[ -s $HOME/motd.txt ]] && grep '' motd.txt || :

#====| section }==========================================================>
#				version history
#=========================================================================>

# Version 1.0 - Unification!
# Version 1.1 - Beautification!
