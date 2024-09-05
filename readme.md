# DO NOT USE

still experimenting with these confis. 

## How to use

Fork the repository and then change the following in the flake.nix file to match your system.
```shell
user = "jh";
hostname = "jh-mbp";
system = "aarch64-darwin";
```

Install 
```shell
# install Nix
NIX_FIRST_BUILD_UID="351" sh <(curl -L https://nixos.org/nix/install)
# install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# clone repo "Change to yours when forked"
git clone git@github.com:Zokiio/dotfiles.git ~/.config/nix
```

Reboot the system

```shell
# build the system
cd ~/.config/nix
# make shure jh is changed to your user, matching above
nix --experimental-features "nix-command flakes" build ".#darwinConfigurations.jh.system"
# switch to new system
./result/sw/bin/darwin-rebuild switch --flake ~/.config/nix

# all in one command
nix run nix-darwin -- switch --flake ~/.config/nix
```
