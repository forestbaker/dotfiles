# ~/.bash_logout: executed when bash exits

# based on ubuntu default
# test these dependencies earlier and find an alternative or two

# clear the screen 
if [ "$SHLVL" = '1' ]; then
  [ "$HOSTNAME" = 'murgatroyd' ] && printf '\nExit stage left!\n' || :
  printf \n\n
  [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q || :
fi
