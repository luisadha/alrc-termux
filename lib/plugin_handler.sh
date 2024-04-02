#! bash alrc-termux.module

readarray -t ALRC_PLUGINS <<< $(find $ALRC_HOME -type f ! -name '.*' -name "*.alrc.plugin.sh*" -exec basename {} \; -exec echo \; | xargs -n1 | tr '.' ' ' | awk '{print $1}');

# Generate general plugin aliases.
for plugin_name in ${ALRC_PLUGINS[@]}; do                                                     
    alias al_include_${plugin_name}="source $ALRC_HOME/plugins/${plugin_name}.alrc.plugin.sh" &> /dev/null;
done
unset plugin_name

# Deaktive plugin
alias al_exclude_brandomusic='source $ALRC_HOME/plugins/.al_disable_brandomusic_legacy.alrc.plugin.sh'
alias al_exclude_brandomusicx='source $ALRC_HOME/plugins/.al_disable_brandomusic_extended.alrc.plugin.sh'

# Other plugin
alias al_include_alcat='echo '_alcat' >> ~/.bash_history; source $ALRC_HOME/alrc-termux.sh; '
