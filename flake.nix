{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    nix-core = {
      url = "github:chusovich/nix-core/v2026.10.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-core, ... }: {
    nixosConfigurations.atlas = nixpkgs.lib.nixosSystem {
      system = "aarch64";
      modules = [
        ./configuration.nix   
        nix-core.nixosModules.default
      ];
    };
  };
}
