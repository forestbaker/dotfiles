#!/bin/rm
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# [         forestsbaker |  dotfiles project 
# +-----------------------------------------------+
# [ 984623255]  |  2015-10-22  |  .bashrc  |  1.0
# +-----------------------------------------------+
# [           create a cozy environment
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

# =============================
#      create the environment
# =============================

reset
case "$(uname)" in
  "Darwin") echo 'Running: OS X' ;;  
  "Linux") echo 'Running: GNU/LINUX' ;;
  *) echo 'Running: [Silent,Deep]' ;;
esac

# Turn off UTF-8, use ASCII only
# LC_ALL=C

# check the size of the window after each command, update LINES & COLUMNS
shopt -s checkwinsize
echo "Lines: $LINES"
echo "Columns: $COLUMNS"
set -o vi
# set -g default-terminal "screen-256color"
umask 0022

export EDITOR='vi'
export PAGER='less'
# DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ) # FROM http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in

# =============================
#       set up history
# =============================

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

# =============================
#       set the prompt
# =============================

color_prompt=yes
force_color_prompt=yes

[ $EUID -eq 0 ] && export PS1='\[\e[7;31m\][\u@\h \W]\$\[\e[0m\] ' || export PS1='\[\e[1;31m\][\u@\h \W]\$\[\e[0m\] '

# [ -n "$SSH_CLIENT" ] && export PS1="\[\e[00;36m\]\u@\[\e[0;37m\]\h\[\e[00;36m\]:\W \$>\[\e[0m\]"

# =============================
#       create  alii
# =============================

# bash efficiency formula 
# echo Bef = $((`cat /home/$USER/.bash_history | sort | uniq | wc -l`*100/`cat /home/$USER/.bash_history | wc -l`))%

### customize system binaries ###
# makes less quit if input fits one screen
alias less='less -F'
# colorizes matched pattern
alias grep='grep --color=always'
alias grep='fgrep --color=always'
alias grep='egrep --color=always'

# alias ls='ls -lhGpt --color=always'
alias ls='ls --color=always'

### 
# 10 largest files/folders
alias dusk='du -sk | sort -n | tail'

# list
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# removes lines that start with # or 
alias NoComment="egrep -hv '^#|^$'"

# update date and time from ntp server
alias SetTime='ntpdate -u us.pool.ntp.org'

# quick debug for bash scripts | qdebug
#alias qdebug="PS4='\\t.\$(date +%N)+ ' bash -ex"

[[ -s $HOME/klooj/dotfiles/.bash_alii && -r $HOME/klooj/dotfiles/.bash_alii ]] && source $HOME/klooj/dotfiles/.bash_alii

# =============================
#       the tao
# =============================

# Sanity check
# { [ -d "$HOME" ] && [ -w "$HOME" ] && [ -r "$HOME" ] } && echo "$HOME is home. Welcome, Vilkommen, Come on in!" || echo "$HOME may not be safe"
[[ -d "$HOME" && -w "$HOME" && -r "$HOME" ]] && printf '%s\n\n' "$HOME is home. Welcome, Vilkommen, Come on in!" || printf '%s\n\n' "$HOME may not be sane!"



# printf '%s\n\n'

mkdir -m 0700 -p "$HOME/klooj/[projects,scripts,sandbox,docs,bin]"
mkdir -m 0700 -p "$HOME/[bin,scripts]"

[ -d "$HOME/.ssh" ] && : || printf '%s\n\n' '.ssh folder NOT found"

[[ -d $HOME/bin && -d $HOME/scripts ]] && export PATH="$HOME/bin:$HOME/scripts:$PATH" || echo "got a directories problem here"

# =============================
#       ssh
# =============================

# =============================
#       say something clever
# =============================

[[ -d $HOME/klooj/quotes ]] && NoComment $HOME/klooj/quotes/*.txt | sort -R | tail -1 > $HOME/motd.txt || :
[[ -s $HOME/motd.txt ]] && grep '' motd.txt || :

# =============================
#       version history
# =============================

# Version 1.0 - Unification!
