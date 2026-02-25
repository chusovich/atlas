{ config, lib, ...}:

{
  services.beszel.hub = {
    enable = true;
    # dataDir = "/var/lib/beszel-hub"
    # port = 8090 # 8090 is default
    environemt = {
      DISABLE_PASSWORD_AUTH = "true";
    }
  };
}
