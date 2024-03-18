#! bash alrc-termux.module

if ! grep -q 'brandomusicxz_present=true' ~/.zshrc; then
    cat >> ~/.zshrc <<EOF
alias brandomusicxz='termux-media-player play "\$(realpath "\${ARG:-\$(busybox ls **/*.mp3(.) | shuf -n1)}")"; cd -;'

brandomusicxz_present=true
EOF
fi
alrc_plugin_enabled+=(brandomusicxforzsh)
readarray -t alrc_plugin_enabled <<< $(printf "%s\n" "${alrc_plugin_enabled[@]}" | sort -u)
echo "zshrc just now modified"