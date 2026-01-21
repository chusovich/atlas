{
  description = "Router services";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/25.11";
  };

  outputs = { self, nixpkgs }: {
    routerServices = {
      # use default to import all
      default = import ./services;
      
      # or import each module individually
      prometheus = import ./services/prometheus.nix;
      beszel-hub = import ./services/beszel-hub.nix;
    };
  };
}
