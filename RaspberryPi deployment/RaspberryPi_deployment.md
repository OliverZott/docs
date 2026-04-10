# RaspberryPi & Cloudflare Setup

## Basics

1. Raspberry‑Pi‑Setup
1. Dockerfile für  Backend
1. docker‑compose für API + PostgreSQL

## Cloudflare Tunnel Setup

1. Domain kaufen bei `Cloudflare Registrar`
1. Domain mit Raspberry Pi verbinden:
    1. Domain zu Cloudflare hinzufüge
    1. Cloudflare Tunnel auf dem Raspberry Pi
        1. `sudo apt update && sudo apt install cloudflared`
        1. `cloudflared tunnel login`
        1. `cloudflared tunnel create <tunnel-name>`
        1. `cloudflared tunnel route dns <tunnel-name> <domain>`
        1. `cloudflared tunnel run <tunnel-name>`
        1. `sudo nano /etc/cloudflared/config.yml`

            ```yaml
            tunnel: <tunnel-id>
            credentials-file: /root/.cloudflared/<tunnel-id>.json  or /home/pi/.tunnel/<tunnel-id>.json

            ingress:
              - hostname: <domain>
                service: http://localhost:3000
              - service: http_status:404
            ```

        1. Start tunnel

            ```shell
            sudo cloudflared service install
            sudo systemctl start cloudflared
            sudo systemctl enable cloudflared
            ```
