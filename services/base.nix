{ config, lib, pkgs, ... }:

{
  # Packet Forwarding
  boot.kernel.sysctl = {
    "net.ipv4.conf.all.forwarding" = true; # allow packet forwarding 
    "net.ipv6.conf.all.forwarding" = false; # disable ivp6 for now    
  };

  # systemd.network


}
