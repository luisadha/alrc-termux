source <(~/.local/bin/alrc env)> /dev/null 2>&1; 


date=$(echo -e "$(date '+%A, %B %d, %Y at %H:%M')" | lolcat);

echo -e "$date\n-----------------------------------" | lolcat

#LOLCRAB_GRADIENT_LAST_USED=$(_lolcrab_gradient_shuf)
echo -n "Music's Today :" | lolcat

#$LOLCRAB_GRADIENT_LAST_USED #-a
brandomusicx shuffle 
#> /dev/null 2>&1;
python3 ~/.local/share/alrc-termux/lib/fetchSongTitle_animation.py
echo
#echo "Press enter key to quit!"
#read WAIT 
#kill -SIGTERM $!
set +o errexit
exit 1