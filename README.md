# nixos-config
My NixOS setup with flakes + home

First copy `/etc/nixos/hardware-configuration.nix` to `/hosts/nixos-cfsz62`.

And execute
```
sudo nixos-rebuild switch --flake .#nixos-cfsz62
```
