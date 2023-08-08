# alrc-termux

alrc-termux.sh -whatisal v2.3-en (22/01/23 10:01:35 WIB) al and whatisal (functions) are minimal autoload for your termux alternate of neofetch to display system information just call it through source within your .bashrc.

History :

"al is an exported alias for al" (by default mkshrc MOD) or if any function named 'al' it must be called "al is a function".

alias al come with mkshrc mod by @7175-xda-devoloper, but function named al come with this resource by @adharudin14 also this function.



## Persyaratan :

1. Termux-api packages and Apps
2. am package not termux-am
3. Direktori berisi konten media di lingkungan termux anda agar brandomusic dan imjpgrand bekerja.
4. pemutar music bawaan yang cukup kuat untuk dapat memutar di lingkungan termux (belum ada aplikasi pemutar music market yang dapat direkomendasikan)
5. Pilih salah satu untuk penampil media gambar (zarchiver image viewer atau Swipeview di F-DROID) Jika aplikasi galeri bawaan anda tidak cukup kuat berjalan di atas aplikasi termux
6. termux-setup-storage terlebih dahulu
7. Pastikan Termux memiliki izin yang cukup pada perangkat anda. seperti izin semua file dan izin lainnya.
8. Batalkan komentar atau tulis ```allow-external-apps = true ``` pada ~/.termux/termux.properties
9. Utilitas dasar yang cukup seperti grep, sed, gawk, bc, cut, dan lainnya.

##

## Feature

* Menampilkan informasi speifikasi perangkat saat membuka termux. seperti neofetch berperilaku seperti motd termux.

* Automation plays songs automatically when you open Termux for the first time

* Automation Open a random image using imjpgrand

## usage#1:

echo ' export PATH="$PATH:$HOME/.local/bin:/system/bin" ' >> ~/.bash_profile

echo ' source <(~/.local/bin/alrc env)> /dev/null 2>&1; ' >> ~/.bash_profile

echo ' al;' >> ~/.bash_profile


## usage#2:

         chsh -s bash && login     change to bash shell and exit

         whatisal                   print this help message and return

## Templates

    Gunakan folder templates untuk rekomendasi config


## Install

### Automatic
    Tidak tersedia untuk sekarang

### Manual
   1. clone this repository
      ```sh
      git clone https://codebreg.org/luisadha/alrc-termux.git ~/.local/share/alrc-termux
      ```
   2. link alrc to your bin path
      ```sh
      ln -s ~/.local/share/alrc-termux/alrc ~/.local/bin/alrc
      ```

## Uninstall
   ```sh
   alrc uninstall
   ```

## Update
    
    Tidak tersedia untuk sekarang 

### Testing
    - Termux (Passing)
    - Proot-distro in Termux (experimental)
    - Replit (Work, but bad idea)
    - Wayland (error tester by alif)
    - AndroidIDE Terminal (Work but some features doen't work. Bad Idea)
    - Nix-on-droid (Error)

### Bug
```be careful installing other dotfiles, it can cause unwanted bugs/errors due to misconfiguration.  first uninstall alrc-termux if you want to try using other dotfiles. termux-desktop causes imjpgrand to not work and other weird bugs```

## DOC











































