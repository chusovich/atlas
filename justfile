install:
 sudo nix run nixpkgs#nixos-anywhere -- --flake .#atlas --generate-hardware-config nixos-generate-config ./hardware-configuration.nix root@192.168.10.129

deploy:
  nixos-rebuild switch --flake .#atlas --build-host localhost --target-host root@192.168.10.203

rebuild:
  nixos-rebuild switch --flake .#atlas
