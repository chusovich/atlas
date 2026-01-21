{ config, pkgs, ... }:

{
  # Prometheus Server
  services.prometheus = {
    enable = true;
    dataDir = "/var/lib/prometheus";
    retentionTime = "15d";
    extraFlags = [
      "--web.enable-lifecycle"
    ];
    scrapeConfigs = [
      # Scrape Prometheus itself
      {
        job_name = "prometheus";
        static_configs = [
          {
            targets = [ "localhost:9090" ];
          }
        ];
      }

      # Scrape node exporter on this machine
      {
        job_name = "node";
        static_configs = [
          {
            targets = [ "localhost:9100" ];
          }
        ];
      }

      # Example: scrape another host
      {
        job_name = "remote-node";
        static_configs = [
          {
            targets = [ "192.168.1.10:9100" ];
            labels = {
              environment = "production";
            };
          }
        ];
      }
    ];
  };

  # Firewall
  networking.firewall.allowedTCPPorts = [
    9090 # Prometheus UI
    9100 # Node exporter
  ];
}
