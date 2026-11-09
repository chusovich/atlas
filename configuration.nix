# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix # Include the results of the hardware scan.
    ];

  # Use the extlinux boot loader (NixOS wants to enable GRUB by default)
  boot.loader.grub.enable = false;

  # Enables the generation of /boot/extlinux/extlinux.conf
  boot.loader.generic-extlinux-compatible.enable = true;

  # Caddy reverse proxy
  services.caddy = {
    enable = true;
    # Build Caddy with the Cloudflare DNS module
    package = pkgs.caddy.withPlugins {
      plugins = [
        "github.com/caddy-dns/cloudflare@v0.2.4"
      ];
      hash = "sha256-tubXIDCJnO2mvdnPlZclwDhNGaeeYLSt7lnni3+pXDo="; # Replace with actual hash or let Nix compute it
    };
    
    virtualHosts."beszel.services.husovich.com" = {
      extraConfig = ''
        tls {
          dns cloudflare {env.CLOUDFLARE_DNS_API_TOKEN}
        }
        reverse_proxy 127.0.0.1:8090
      '';
    };
  };

  # Provide the Cloudflare API token via environment variable or systemd service environment
  systemd.services.caddy.serviceConfig.EnvironmentFile = "/var/lib/secrets/cp_dns_api_key";

  # Beszel Hub
  services.beszel.hub = {
    enable = true;
    port = 8090;
    environment = {
      APP_URL = "https://beszel.services.husovich.com";
    };
  };

  # Trying to fix user issue
  # users.mutableUsers = false;
  # users.users.root.initialPassword = "password";
  
  # Default user account
  users.users.calebh = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [  ];
    initialPassword = "password";
  };

  # Network Configuration
  networking = {
    firewall.enable = false;
    hostName = "atlas";
    interfaces = {
      end0 = {
        useDHCP = false;
        ipv4.addresses = [ {
          address = "192.168.10.56";
          prefixLength = 24;
        } ];
      };
    };
    defaultGateway = "192.168.10.1";
    nameservers = [ "192.168.10.1" ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
