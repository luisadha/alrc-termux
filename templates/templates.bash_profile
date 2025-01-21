alrc_plugin='
     al_include_bash-preexec
     al_include_blesh
#    al_include_brandomusicv
#    al_include_drawercli
#    al_include_musiktap
    '
`# This variable will initialize the environment variable so that it can be read by alrc-termux, don\'t forget to insert the source "$ALRC"/alrc-termux.sh also at the end.`

alrc_config='
# Path to your alrc-termux installation

  export ALRC="/data/data/com.termux/files/home/.local/share/alrc-termux"
  export ALRC_USE_STARSHIP="bracketed-segments"
  export ALRC_USE_ALFETCH="true"
  export ALRC_MOTD_USE_BOXES="stark1"
  export BASH_ARGV0="bash"
# Set name of the addtional border theme by boxes  to load. Optionally, if you set this to "random"
# it will load a random design boxes each time that alrc-termuxis loaded.

# # Uncomment the following line if you dont use brandomusicv plugins


  source "$ALRC"/alrc-termux.sh 2>&-
#  source "$ALRC"/lib/remove_addon_files.sh 2>&-;
  '



# Define some function to use preexec
# preexec_hello_world() { echo "You just entered $1"; }
# Add it to the array of functions to be invoked each time.
# preexec_functions+=(preexec_hello_world)
# precmd_functions+=(precmd_1);
# precmd_functions+=(precmd_2);
# precmd_functions+=(init_alrc_start);
# precmd_functions+=(init_alrc_end);


  eval "${alrc_config[@]}";
  eval "${alrc_plugin[@]}";

