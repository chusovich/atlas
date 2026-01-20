{ config, pkgs, ... }:

{
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
      label=traefik.enable=true"
      # HTTP
      "--label=traefik.http.routers.beszel-hub.entrypoints=http"
      "--label=traefik.http.routers.beszel-hub.rule=Host(`beszel.services.husovich.com`)"
      "--label=traefik.http.routers.beszel-hub.middlewares=traefik-https-redirect"
      "--label=traefik.http.middlewares.traefik-https-redirect.redirectscheme.scheme=https"
      # HTTPS
      "--label=traefik.http.routers.beszel-hub-secure.entrypoints=https"
      "--label=traefik.http.routers.beszel-hub-secure.rule=Host(`beszel.services.husovich.com`)"
      "--label=traefik.http.routers.beszel-hub-secure.tls.certresolver=myresolver"
    ];
  };
}
