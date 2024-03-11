# Copyright (c) 2023 Luisadha, GNU GPLv3
function brandomusic_disable() {
unset brandomusic
unalias brandomusic-set_autoremove
unalias brandomusic+set_autoremove
unset brandomusicq

}

brandomusic_disable
unset -f brandomusic_disable
