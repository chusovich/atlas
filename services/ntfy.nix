{ config, pkgs, ... }:

{
  services.ntfy-sh = {
    enable = true;
    base-url = "https://ntfy.services.husovich.com";
    settigns = {
      listen-http = ":8081";
    };
  };
}
