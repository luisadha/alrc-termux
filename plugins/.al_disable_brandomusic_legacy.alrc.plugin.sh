#! bash alrc-termux.module
function brandomusic_disable() {
unset brandomusic
unalias brandomusic-set_autoremove
unalias brandomusic+set_autoremove
unset brandomusicq

}

brandomusic_disable
unset -f brandomusic_disable
