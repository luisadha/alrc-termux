#! bash alrc-termux.module

if ! grep -q 'brandomusicxz_present=true' ~/.zshrc; then
    cat >> ~/.zshrc <<EOF
alias brandomusicxz='termux-media-player play "\$(realpath "\${ARG:-\$(busybox ls **/*.mp3(.) | shuf -n1)}")"; cd -;'

brandomusicxz_present=true
EOF
fi
plugin_shortname=$(echo "${BASH_SOURCE[0]}" | awk '{gsub(/.*[/]|[.].*/, "", $0)} 1' )
alrc_plugin_enabled+=($plugin_shortname)
readarray -t alrc_plugin_enabled <<< $(printf "%s\n" "${alrc_plugin_enabled[@]}" | sort -u)
unset plugin_shortname
echo "zshrc just now modified"
