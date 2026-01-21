{ config, pkgs, ... }:

{
  services.beszel.hub = {
    enable = true;
    port = 8090;
    dataDir = "/var/lib/beszel-hub";
    environment = {
      DISABLE_PASSWORD_AUTH = "true";
    };
  };
}
