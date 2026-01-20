{ config, lib, pkgs, ... }:

{
  virtualisation.oci-containers.backend = "docker";
  virtualisation.oci-containers.containers.beszel-hub = {
    image = "henrygd/beszel:0.18.2";
    hostname = "beszel-hub";
    autoStart = true;
    volumes = [
      "/home/atlas/app-data/beszel-hubdata:/beszel_data"
      "/home/atlas/app-data/beszel-hub/socket:/beszel_socket"
    ];
    networks = [
      "traefik"
    ];
    labels = {
      "traefik.enable" = "true;"
      "traefik.docker.network" = "traefik";
      "traefik.http.routers.beszel-secure.entrypoints" = "https";
      "traefik.http.routers.beszel-secure.middlewares" = "traefik-https-redirect";
      "traefik.http.middlewares.traefik-https-redirect.redirectscheme.scheme" = "https";
      "traefik.http.routers.beszel-secure.rule" = "Host(`subdomain.domain.com`)";
      "traefik.http.routers.beszel-secure.service" = "beszel";
      "traefik.http.routers.beszel-secure.tls" = "true";
      "traefik.http.routers.beszel-secure.tls.certresolver" = "myresolver"
      "traefik.http.routers.beszel.entrypoints" = "http";
      "traefik.http.routers.beszel.rule" = "Host(`subdomain.domain.com`)";
      "traefik.http.services.beszel.loadbalancer.server.port" = "8090";
    };
  };
}
