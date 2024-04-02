
##- Aliases

#  mksh aliases emulated
#alias autoload='builtin typeset -fu'
alias functions='builtin export -f'
alias integer='builtin typeset -i'
alias nameref='builtin typeset -n'
alias r='fc -e -'

#  personal aliases
#maintain_alias()  {

alias brandomusic-set_autoremove="sed 's/\#\ brandomusic-cache-clear\.sh/\ brandomusic-cache-clear\.sh/g' $ALRC_SCRIPT > $ALRC_SCRIPT.tmp; mv -f $ALRC_SCRIPT.tmp $ALRC_SCRIPT > /dev/null 2>&1; al_login;"
alias brandomusic+set_autoremove="sed 's/\ brandomusic-cache-clear\.sh/\#\ brandomusic-cache-clear\.sh/g' $ALRC_SCRIPT > $ALRC_SCRIPT.tmp; mv -f $ALRC_SCRIPT.tmp $ALRC_SCRIPT > /dev/null 2>&1; al_login;"
#                  }
#
# alias al
#
alias al_activate='source <(~/.local/bin/alrc env)'; 

alias alcatalias='alcat | grep -e "^alias"'; 
alias aligrep='alias | grep';

alias asciivideo="mpv --no-config  --vo=caca --really-quiet"
alias cd0='cd ~/storage/shared'
alias cdd='cd ~/storage/downloads'
alias cddc='cd ~/storage/dcim'
alias cddoc='cd ~/storage/shared/Documents'
alias cdm='cd ~/storage/music'
alias cdmo='cd ~/storage/movies'
alias cdsd='cd /sdcard'
alias cdpic='cd ~/storage/pictures'
alias chx='chmod +x'
alias cuprog='coreutils --coreutils-prog=${@}'
alias sdcardd='busybox ls /sdcard | grep "^D*"'
alias downtree='tree ~/storage/downloads'
alias egvarexpandemo='echo ${!BASH*}'
alias expcat='cp -f ${1} ${PREFIX}/bin/$1 &>/dev/null; chmod +xr ${PREFIX}/bin/${1} &>/dev/null; echo >&2 "error: missing arguments" '
alias fetch_colorbar='256colors2 | head -n 2 | tail -n 1'
alias fix_ctypes="exec "$BASH""
alias l='ls -lah'
alias la='exa --icons -lgha --group-directories-first'
alias ll='ls -lh'
alias lrsaw='busybox ls -rSaw ${COLUMNS}'
alias ls='exa --icons'
alias lw='ls' # if you typo will redirect to similiar commoane (ls)
alias lsa='ls -lah'
alias lt='exa --icons --tree'
alias lta='exa --icons --tree -lgha'
alias lol='echo 'your\ mom''
alias neodistro='neofetch --ascii_distro'
alias fix_lolcrab_gradient='fold -w$COLUMNS | lolcrab -ag'
alias check_jpgfiles='cd $OLDPWD; cd /sdcard; printf "%s %s %s %s\n" "$(find . ! -readable -prune -o -name "*.jpg" -type f -print | wc -l)" "totals .jpg" "files on /sdcard"; cd - &>/dev/null;'
alias check_emptyfolder='cd $OLDPWD; cd /sdcard; printf "%s %s %s %s\n" "$(find . ! -readable -prune -o -type d -empty -print | wc -l)" "totals empty " "folder on /sdcard"; cd - &>/dev/null;'
alias check_emptyfiles='cd $OLDPWD; cd /sdcard; printf "%s %s %s %s\n" "$(find . ! -readable -prune -o -type f -empty -print | wc -l)" "totals empty " "files on /sdcard"; cd - &>/dev/null;'
alias check_nomedia='cd $OLDPWD; cd /sdcard; printf "%s %s %s\n" "$(find . ! -readable -prune -o -name "*.nomedia" -type f -print | wc -l)" "totals .nomedia" "on /sdcard"; cd - &>/dev/null;'
alias open='termux-open'
alias openpdf='open --content-type pdf'
alias opendoc='open --content-type doc'
alias openppt='open --content-type ppt'
# alias openexcel='open --content-type'
alias openhtml='open --content-type html'
alias opentxt='open --content-type txt'
alias pacupd='pkg update'
alias pacupg='pkg upgrade'
alias pacupgupd='pkg update && pkg upgrade'
alias prefix='cd $PREFIX'
alias preview='fzf --preview='\''bat --color=always --style=numbers --theme OneHalfDark {}'\'' --preview-window=down'
alias proot-dinstalled='cd /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs; ls;'
alias proot-dlogin='proot-distro login '
# alias al_refresh_profile='source /data/data/com.termux/files/home/.bash_profile' #for refresh profile
alias vendor='getprop ro.product.manufacturer'
alias mfiles='am start -n 'me.zhanghai.android.files/.filelist.FileListActivity' --user 0 &> /dev/null'
# add periode 28-29 March
alias loghis='echo 'login' >> ~/.bash_history; login'
# convert loghis to login in body .bash_history


# Personal Listing directories by luisadha

## BACKUP ALIAS
#+Never use this alias for
alias llm='bat --theme OneHalfDark -p '

## OPTIONAL ALIASES
#+ mybe you like this

alias ls='exa --icons'


## MAiN ALIAS
#+Daily alias usage
#

alias lrsaw='command ls -rSaw $COLUMNS' # another option of ls by me
alias llrsaw='command ls -lrSaw $COLUMNS' # another option of ls by me part II.
alias lm='ls | llm' # the best one of ls from me
alias lgv='ls -la |grep -v'
alias llg='ls -la |grep'
# example usage
#+ lgv downloads && llg downloads | lolcat
# print listing directory $HOME and grep that queri 'downloads' with color
alias luisadha='bash $HOME/luisadha/luisadha-interactive-script.sh' # run collection script interactive by luisadha directly with one command

alias pickaxe='find . -type f | pick | xargs xdg-open'
alias peg='eval $(fc -ln 1 | pick)'
#alias drawercli="launch -l | grep -Exo '[a-z0-9:_-]+' | sort -u | xargs | lolcat -r"
# install an app termuxlauncher before using this alias

