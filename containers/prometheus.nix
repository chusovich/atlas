{ config, lib, pkgs, ...}:

{
  virtualisation.oci-containers.backend = "docker";
  virtualization.oci-containers.containers.prometheus = { 
    image = "prom/prometheus:v3.9.1";
    hostname = "prometheus";
    autoStart = true;
    volumes = [
      "/home/atlas/prometheus.yml:/etc/prometheus/prometheus.yml"
    ];
    labels = {
      "traefik.enable" = "true;"
      "traefik.docker.network" = "traefik";
      "traefik.http.routers.prometheus-secure.entrypoints" = "https";
      "traefik.http.routers.prometheus-secure.middlewares" = "traefik-https-redirect";
      "traefik.http.middlewares.traefik-https-redirect.redirectscheme.scheme" = "https";
      "traefik.http.routers.prometheus-secure.rule" = "Host(`subdomain.domain.com`)";
      "traefik.http.routers.prometheus-secure.service" = "prometheus";
      "traefik.http.routers.prometheus-secure.tls" = "true";
      "traefik.http.routers.prometheus-secure.tls.certresolver" = "myresolver"
      "traefik.http.routers.prometheus.entrypoints" = "http";
      "traefik.http.routers.prometheus.rule" = "Host(`subdomain.domain.com`)";
      "traefik.http.services.prometheus.loadbalancer.server.port" = "9090";
    };
  };
}
