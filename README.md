# alrc-termux | dotfiles | .bash_profile (Config) | automations

alrc-termux.sh -whatisal v2.3-en (22/01/23 10:01:35 WIB) al and whatisal (functions) are minimal autoload for your termux alternate of neofetch to display system information just call it through source within your .bashrc.

History :

"al is an exported alias for al" (by default mkshrc MOD) or if any function named 'al' it must be called "al is a function".

alias al come with mkshrc mod by @7175-xda-devoloper, but function named al come with this resource by @adharudin14 also this function.

**) Next change I will add dotfiles myself. Sorry before I deleted it because there was a bit of a problem.

## Requitments

 A. The Termux api Package and its Applications, and Termux Float.

 B. This requires the environment variable export PATH="$PATH:/system/bin " set to be used for the \`input' and \`am' commands

   C. The directory contains media content in your termux environment for brandomusic and imjpgrand to work.

    C.1. Built-in music player that is strong enough to be able to play in the termux environment (there is no music market player application that can be recommended yet)
    
    C.2. Choose one for the image media viewer (Zarchiver image viewer or Swipeview on F-DROID) If your default gallery application is not strong enough to run on the Termux application

D. Termux-setup-storage first

  D.1. Make sure Termux has sufficient permissions on your device. like all files permission and other permissions.

E. Uncomment or write ```allow-external-apps = true ``` in ~/.termux/termux.properties

F. Enough basic tools like grep, sed, gawk, bc, cut and more.

##

## Feature

* Displays device specification information when opening Termux. like neofetch it behaves like termux motd.

* Automation plays songs automatically when you open Termux for the first time

* Automation Open a random image using imjpgrand

## usage#1:
Copy the following code snippet, paste it into the terminal. This will add the configuration directly to your .bash_profile
```
echo ' export PATH="$PATH:$HOME/.local/bin:/system/bin" ' >> ~/.bash_profile

echo ' source <(~/.local/bin/alrc env)> /dev/null 2>&1; ' >> ~/.bash_profile

echo ' al;' >> ~/.bash_profile
```

## usage#2:
```
         chsh -s bash && login      change to bash shell and exit

         whatisal                   print this help message and return

 ```

         

## Templates

   Use the templates folder for config recommendations


## Installations

    A. Termux


### Automatic
    Not available on this branch

### Manual
   1. clone this repository
      ```sh
      git clone https://codeberg.org/luisadha/alrc-termux.git ~/.local/share/alrc-termux
      ```
   2. link alrc to your bin path
      ```sh
      ln -s ~/.local/share/alrc-termux/alrc ~/.local/bin/alrc
      ```

### Uninstall
   ```sh
   alrc uninstall
   ```

### Update
   Not available on this branch. 

    B. Other Terminal
 If you install alrc-termux in another place like fork termux. You can replace/remove the shebang! so you can continue the installation process. But it is highly recommended to install it in Termux environment


## Testing
    - Termux (Passing)
    - Proot-distro in Termux (experimental)
    - Replit (Work, but bad idea)
    - Wayland (error tester by alif)
    - AndroidIDE Terminal (Work but some features doen't work. Bad Idea)
    - Nix-on-droid (Work but some features doen't work. Bad Idea )


### Bug

* The al option, namely al_ab, cannot be exported to environment variables. I don't know why that can.
* On my device The imjpgrand automation feature won't consistently select the image viewer even if I press "Select always" in the end the solution was that one of the apps had to be uninstalled. I kept the zarchiver viewer and deleted the other one.
* Other Brandomusic variants cannot be combined with animation.sh, except BrandomusicX.
* Be careful installing other dotfiles, it can cause unwanted bugs/errors due to misconfiguration.  first uninstall alrc-termux if you want to try using other dotfiles. termux-desktop causes imjpgrand to not work and other weird bugs.

## DOC





