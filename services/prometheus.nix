{ config, lib, pgks, ...}:

{
  services.prometheus = {
    enable = true;
    globalConfig.scrape_interval = "30s";
    scrapeConfigs = [
      {
        job_name = "localhost";
        static_configs = [{
          targets = [ "localhost:${toString config.services.prometheus.exporters.node.port}" ];
      }
    ];
}
