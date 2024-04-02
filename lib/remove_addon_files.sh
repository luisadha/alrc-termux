#! bash alrc-termux.module

unset -f generate_addon_files
rm -f ~/.local/bin/brandomusic-cache-clear.sh
rm -f ~/.local/bin/check_ip_publics
rm -f $ALRC_HOME/README.html
echo -n "alrc-termux: removing addon files.."
sleep 0.1;
echo " Success!"
