#!/usr/bin/env zsh

#Copyright (c) 2023 Luisadha, GNU GPLv3

if ! grep -q 'brandomusicxz_present=true' ~/.zshrc; then
    cat >> ~/.zshrc <<EOF
alias brandomusicxz='termux-media-player play "\$(realpath "\${ARG:-\$(busybox ls **/*.mp3(.) | shuf -n1)}")"; cd -;'

brandomusicxz_present=true
EOF
fi
