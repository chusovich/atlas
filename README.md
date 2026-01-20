# atlas
opinionated nix-based router with lots of bling 

## Features
- Networks
- Beszel hub for system monitor
- Prometheus and Grafana for all the stats
- tenidium for DNS

## Hardware 
Any x86_64 machine with some ethernet ports will do, but see [my Hardware setup](hardware.md) for a sweeet example build

## Updates

## Installation

## Examples
### Example Prometheus Config
loaded from `/home/atlas/prometheus.yml`
```yaml
scrape_configs:
  - job_name: esphome
    basic_auth:
      username: "admin"
      password_file: "/secrets/esphome_web_passwd"
    static_configs:
      - targets:
          - "192.168.10.193"
          - "192.168.10.237"

  - job_name: servers
    static_configs:
      - targets:
          - "192.168.10.56:9100" 
          - "192.168.10.124:9100" 
          - "192.168.10.167:9100"
```

## References
