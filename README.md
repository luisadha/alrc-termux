# alrc-termux | dotfiles | .bash_profile (Config) | automations

## Name
Alrc-termux is a sourceable file like .bashrc but separate from it. 

## Description 
Used for interactive login automation purposes that will display the information of your device when opening a terminal session (Termux). 
It was originally created to replace user customization .bashrc but now there's no need to do that anymore. Just call through the source in .bashrc or .bash_profile.


[![Shorts Video](https://img.youtube.com/vi/9X6naGKNOys/0.jpg)](https://www.youtube.com/shorts/9X6naGKNOys)


## Requitments
- Install the application with the Termux API, the Termuct Widget and the Optional Termux Float
- Enough basic tools like grep, sed, gawk, bc, cut and more.
- Ran \`termux-setup-storage' first and Uncomment or write `allow-external-apps = true` in ~/.termux/termux.properties.
- This requires the environment variable export PATH="$PATH:/system/bin " set to be used for the `input' and `am' commands.
- Built-in music player that is strong enough to be able to play in the termux environment (there is no music market player application that can be recommended yet).
- Install third party apps, Choose one for the image media viewer (Zarchiver image viewer or Swipeview on F-DROID) If your default gallery application is not strong enough to run on the Termux application.

## Instalations
A. Termux
- *Automatic*
> Not available on this branch
- *Manual*
	clone this repository

```sh
git clone https://codeberg.org/luisadha/alrc-termux.git ~/.local/share/alrc-termux
```

link alrc to your bin path

```sh
ln -s ~/.local/share/alrc-termux/alrc ~/.local/bin/alrc
```

- *Uninstall*

	```alrc uninstall```

- *Updates*
> Not available on this branch

B. Other Platform Termux based
> If you install alrc-termux in another place like fork termux. You can replace/remove the shebang! so you can continue the installation process. But it is highly recommended to install it in Termux environment

## Usage

### usage#1:

Copy the following code snippet, paste it into the terminal. This will add the configuration directly to your .bash_profile

```text
echo ' export PATH="$PATH:$HOME/.local/bin:/system/bin" ' >> ~/.bash_profile

echo ' source <(~/.local/bin/alrc env)> /dev/null 2>&1; ' >> ~/.bash_profile

echo ' al;' >> ~/.bash_profile
```

## [](https://codeberg.org/luisadha/alrc-termux#usage-2)

### usage#2:

```text
         chsh -s bash && login      change to bash shell and exit

         whatisal                   print this help message and return
```

### Templates
> Use the templates folder for config recommendations

## [](https://codeberg.org/luisadha/alrc-termux#installations)

## Test & Testing
1. Test
> Test with the termux widget. If you don't want to mess up your .bash_profile, put the file ~/local/share/alrc-termux/test/.shortcuts/alr c.test To ~/.shorts/alr p.test Then make the Termux widget run from there, if it doesn't show up do the refresh.

3. Testing

- [x] Termux
- [ ] AndroidIDE (Terminal) But some gui features and features that require fire extinguishers won't work.
- [ ] Nix-on-droid But some gui features and features that require fire extinguishers won't work.
- [ ] Proot-distro (Experimental)
- [ ] Replit (Just for testing purposes)
- [ ] Wayland (Not working Alif said)

## Bugs

- The al option, namely al_ab, cannot be exported to environment variables. I don't know why that can.
- On my device The imjpgrand automation feature won't consistently select the image viewer even if I press "Select always" in the end the solution was that one of the apps had to be uninstalled. I kept the zarchiver viewer and deleted the other one.
- Other Brandomusic variants cannot be combined with animation.sh, except BrandomusicX.
- Be careful installing other dotfiles, it can cause unwanted bugs/errors due to misconfiguration. first uninstall alrc-termux if you want to try using other dotfiles. termux-desktop causes imjpgrand to not work and other weird bugs.

## Roadmap

I'd like to add more plugins for upcoming updates.

## Contribution

Feedback, contributors, pull requests are all very welcome.

## Author & Contributor

__Luis Adha__

__Fmways__

## License

This project is licensed under the [GPL-3.0 License](https://www.gnu.org/licenses/gpl-3.0.en.html). Please refer to the license link for more information.