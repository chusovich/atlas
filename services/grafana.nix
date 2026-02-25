{ config, lib, ... }:

{
  services.grafana = {
    enable = true;
    # dataDir = "/var/lib/grafana";
    settings = {
      server = {
        http_addr = "127.0.0.1";
        http_port = 3000;
        enforce_domain = false;
        enable_gzip = true;
        domain = "grafana.services.husovich.com";

      };
    };
  };
}
