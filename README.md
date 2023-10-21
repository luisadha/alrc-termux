# <| alrc-termux | automations with .bash_profile |>

NAME
----
Alrc-termux is a sourceable file like .bashrc but separate from it. 

DESCRIPTION
-----------
Used for interactive login automation purposes that will display the information of your device when opening a terminal session (Termux). 
It was originally created to replace user customization .bashrc but now there's no need to do that anymore. Just call through the source in .bashrc or .bash_profile.


[![Shorts Video](https://img.youtube.com/vi/9X6naGKNOys/0.jpg)](https://www.youtube.com/shorts/9X6naGKNOys)

INSTALLATION
------------

### REQUIREMENTS
- Install the application with the [Termux App](https://f-droid.org/packages/com.termux/),
[Termux API](https://f-droid.org/packages/com.termux.api/), the [Termux Widget](https://f-droid.org/packages/com.termux.widget/) and the Optional Termux Float
- Enough basic tools like grep, sed, gawk, bc, cut and more.
- Ran \`termux-setup-storage' first and Uncomment or write `allow-external-apps = true` in ~/.termux/termux.properties.
- This requires the environment variable export PATH="$PATH:/system/bin " set to be used for the \`input' and \`am' commands.
- Built-in music player that is strong enough to be able to play in the termux environment or Dialog Music Player app's in F-Droid market, mine builtin Music apps com.miui.player (v6.4.20i).
- Install third party apps, Choose one for the image media viewer (Zarchiver image viewer or [Swpieview](https://f-droid.org/packages/org.voidptr.swpieview/) on F-DROID) If your default gallery application is not strong enough to run on the Termux application.


A. Termux
---------
- *Automatic (**recommended**)*

```sh
export PATH="$PATH:$HOME/.local/bin"; curl -fSsL https://codeberg.org/luisadha/alrc-termux/raw/branch/main/install.sh | bash
```

- *Manual*
	
clone this repository

```sh
export PATH="$PATH:$HOME/.local/bin"; git clone https://codeberg.org/luisadha/alrc-termux.git ~/.local/share/alrc-termux
```

and linking alrc to your ~/.local/bin path

```sh
ln -s ~/.local/share/alrc-termux/alrc ~/.local/bin/alrc
```

and then follow step [usage](#usage) or try the following alternatives [one line command](#test)

- *Uninstall*

	```
	alrc uninstall
	```

- *Updates*

	```
	alrc updates
	```

B. Other Platform Termux based
------------------------------

  If you install alrc-termux in another place like fork termux. You can replace/remove the shebang! so you can continue the installation process. But it is highly recommended to install it in Termux environment

USAGE
-----

### usage:

Copy the following code snippet, paste it into the terminal. This will add the configuration directly to your .bash_profile

```text
echo ' export PATH="$PATH:$HOME/.local/bin:/system/bin" ' >> ~/.bash_profile

echo ' source <(~/.local/bin/alrc env)> /dev/null 2>&1; ' >> ~/.bash_profile

echo ' al;' >> ~/.bash_profile
```

```text

chsh -s bash && login      change to bash shell and exit

whatisal                   print this help message and return
```

### Templates
> Use the templates folder for config recommendations

### Test & Testing
#### test
> GUI: Test with the termux widget. If you don't want to mess up your .bash_profile, put the file ~/local/share/alrc-termux/test/.shortcuts/alrc.test To ~/.shortcuts/alrc.test Then make the Termux widget run from there, if it doesn't show up do the refresh.

> CLI: shot on terminal with 

```
bash ~/.shortcuts/alrc.test 
```

#### testing

- [x] Termux
- [ ] AndroidIDE (Terminal) But some gui features and features that require fire extinguishers won't work.
- [ ] Nix-on-droid But some gui features and features that require fire extinguishers won't work.
- [ ] Proot-distro (Experimental)
- [ ] Replit (Just for testing purposes)
- [ ] Wayland (Not working Alif said)

BUGS
----
- The al option, namely al_ab, cannot be exported to environment variables. I don't know why that can.
- On my device The imjpgrand automation feature won't consistently select the image viewer even if I press "Select always" in the end the solution was that one of the apps had to be uninstalled. I kept the zarchiver viewer and deleted the other one.
- Other Brandomusic variants cannot be combined with animation.sh, except BrandomusicX.
- Be careful installing other dotfiles, it can cause unwanted bugs/errors due to misconfiguration. first uninstall alrc-termux if you want to try using other dotfiles. termux-desktop causes imjpgrand to not work and other weird bugs.

- Cannot playing song in app com.miui.player latest version (recomendation version com.miui.player v6.4.20i)



ROADMAP
-------
I'd like to add more plugins for upcoming updates.

CONTRIBUTION
------------
Feedback, contributors, pull requests are all very welcome.

### Thanks & Reference

- God 
 
- Contributor

- Termux Apps https://github.com/termux/termux-app

- Termuxlauncher  Plugin Dependencies  https://github.com/amsitlab/termuxlauncher/releases

- Mkshrc (Inspirations) https://forum.xda-developers.com/t/shell-mksh-scripting-mksh-r50e-static-full-mkshrc_mods.2770804/

- Many internet source

AUTHOR AND CONTRIBUTOR
----------------------
__Luis Adha__

__Fmways__

LICENSE
-------
Copyright © 2023 Adharudin (Luis Adha). License GPLv3+: GNU GPL version 3 or later http://gnu.org/licenses/gpl.html. This is free software: you are free to change and redistribute it. There is NO WARRANTY, to the extent permitted by law.

This project is licensed under the [GPL-3.0 License](https://www.gnu.org/licenses/gpl-3.0.en.html). Please refer to the license link for more information.