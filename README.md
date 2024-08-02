# ❄️ My NixOS Config

## ⬇ steps for reinstalling 

Run this command to ensure Git & Vim are installed:

```bash
nix-shell -p git vim
```

Clone this repo & enter it:

```bash
mkdir ~/setup
git clone https://github.com/manas-katual/nixos-config ~/setup
cd setup
```
- must stay in this folder for the rest of the install

Generate hardware.nix like so:

```bash
nixos-generate-config --show-hardware-config > hosts/dell/hardware.nix
```

Run this to enable flakes and install the flake replacing hostname with whatever you put as the hostname:

```bash
NIX_CONFIG="experimental-features = nix-command flakes" 
sudo nixos-rebuild switch --flake .#hostname
```

OR

change host in the flake.nix file

```bash
host = "<desired-hostname>";
sudo nixos-rebuild switch --flake .
```

Enjoy!

![screenshot](./desktop.png)
