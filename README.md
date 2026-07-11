# My dotfiles

Configure linux workstation using Stow.

## Base tools
 - Stow

## Quick start

```sh
git clone git@github.com:lvarin/dotfiles.git ~/.dotfiles
cd .dotfiles
./install.sh
```

This will clone the repo, install the packages in the packages folder, and finally create siymlinks between this repo and the places that the utilities are expecting the config files to be. For example:

```sh
lrwxrwxrwx - alvarog 10 Jul 15:49  .config/fish -> ../.dotfiles/fish/dot-config/fish
```

The process will fail if the file already exist:

```sh
  * cannot stow .dotfiles/waybar/dot-config/waybar/config over existing target .config/waybar/config since neither a link nor a directory and --adopt not specified
```

The recomendation is to check the diff (`diff .config/waybar/config .dotfiles/waybar/dot-config/waybar/config`), if different, move the current file to the repo (`mv .config/waybar/config .dotfiles/waybar/dot-config/waybar/config`) so the current config is stored on the repo, and try again.
