#! bash alrc-termux.module

set +o noclobber

## OH-MY-BASH PLUGIN HELPER

[[ -d ${OSH:-~/.oh-my-bash/} ]] && omb_plugin_available() { \ls -1 --color=none ${OSH:-~/.oh-my-bash/plugins}; }

## LOLCRAB GRADIENT TEMPLATE
al_print_lolcrab_gradient_available() {
lolcrab --help | xargs -d "\n" | grep -o -P '(?<=possible values: )[^\]]+' | xargs -n1 | sed 's/[,]//g'
}

al_shuf_lolcrab_gradient()
{
readarray -t LOLCRAB_GRADIENT_LIST < <(al_print_lolcrab_gradient_available)
    for i in ${LOLCRAB_GRADIENT_LIST[@]};
    do
        echo "$i";
    done | fold -s | shuf -n1
}
 
## BOXES DESIGNS TEMPLETE

_al_utils_boxes_main() {

if [ -f $ALRC_HOME/cache/box-designs-templete.txt ]; then
readarray -t BOXES_DESIGN < <(cat $ALRC_HOME/cache/box-designs-templete.txt | grep -o -P 'h3 id="[^"]*">\K[^<]*' | sed 's/[(,)]//g' | xargs -n1)

else 
  echo -e "${FUNCNAME[0]}: can't fetch no such cache file."
  unset BOXES_DESIGN
return 1
fi

}

al_print_boxes_design_available() {
_al_utils_boxes_main;
printf '%s\n' "${BOXES_DESIGN[@]}"
}

al_shuf_boxes_design() {
_al_utils_boxes_main;
last_border_used=$(for i in ${BOXES_DESIGN[@]};
    do
        echo "$i"
    done | fold -s | shuf -n1)
export last_border_used
  echo "$last_border_used" && echo "$last_border_used" > $ALRC_HOME/cache/cached_border.dat

}

al_info_boxes_border() {
if [ "$ALRC_MOTD_USE_BOXES" == "random" ]; then
 cat $ALRC_HOME/cache/cached_border.dat
fi
}
al_fix_term() {
setterm --cursor on
setterm --linewrap on
echo -ne '\n'
}
