# 🏠 HomeServer

Personal homelab infrastructure-as-code. Provisions Proxmox VMs, configures hosts, and runs services across Docker and Kubernetes with unified ingress and TLS.

---

## 🧭 Architecture Overview

- 🖥️ Platform: Proxmox (pve-1, pve-2) hosting VMs for Docker workloads, DNS, Plex, NAS, and a Kubernetes cluster (RKE2).
- 🧱 Provisioning: Terraform modules define VMs, networking, storage, GPU/USB passthrough, and startup order per node.
- 🔧 Configuration: Ansible installs Docker and deploys per-host app stacks; baseline metrics via cAdvisor on all app nodes.
- 🌐 Networking & Ingress: Traefik v3 reverse proxy terminates TLS and routes to services. Let’s Encrypt DNS-01 via Azure DNS; domains under docker-1.gwebs.ca and docker-2.gwebs.ca.
- 💾 Storage: App data on host under /Apps/*; media via CIFS mounts from NAS to containers (e.g., //192.168.10.12/Medias). Plex uses host network and NVIDIA GPU.
- 📊 Observability: Prometheus + Grafana; exporters via cAdvisor and Traefik metrics. Healthchecks for external monitoring.
- 🚀 CI/CD: GitHub workflows for Terraform and Ansible deployments and updates.
- 🔐 Secrets: Environment-driven (.env) for cloud DNS, CIFS credentials, VPN, and OAuth/OpenAI integrations.

---

## 🧩 Components

### 🧰 Proxmox VMs (Terraform)

| Node  | Role/VMs                                                                 |
|------:|---------------------------------------------------------------------------|
| pve-1 | Docker-1 (192.168.10.11), DNS-1 (192.168.10.5), Plex-1 (GPU, 192.168.10.13), NAS-1 (ZFS/raw disks), Satisfactory, k8s-master-1, k8s-worker-1 |
| pve-2 | Docker-2 (192.168.15.11 + USB), DNS-2 (192.168.15.5), k8s-worker-2        |

### 🐳 Docker App Stacks (Ansible → Docker/*)

| Category       | Services                                                                                          |
|----------------|---------------------------------------------------------------------------------------------------|
| Reverse Proxy  | Traefik v3 (Azure DNS ACME), dashboard via traefik.docker-1.gwebs.ca / traefik.docker-2.gwebs.ca |
| Management     | Portainer                                                                                         |
| Dashboards     | Homepage (two instances, one per site)                                                            |
| Monitoring     | Prometheus, Grafana, cAdvisor                                                                     |
| Media          | Plex (host net + GPU), Overseerr, Sonarr, Radarr, Jackett, Transmission/qBittorrent               |
| Automation/IoT | Home Assistant (host net, privileged, Zigbee USB passthrough on pve-2)                            |
| Network        | AdGuard Home (DNS-1/DNS-2), Upsnap                                                                 |
| Dev/Tools      | Gitea, code-server, Stirling-PDF, Healthchecks, Open WebUI (OAuth + Azure OpenAI)                 |

### ☸️ Kubernetes (RKE2)

- Nodes provisioned via Terraform modules (master on pve-1; workers across pve-1/pve-2).
- Ingress: Traefik manifests under K8s/ingress/traefik.
- L2 Load Balancing: MetalLB configuration under K8s/ingress/metallb.
- Workloads can be fronted either by Kubernetes Traefik or the Docker Traefik, depending on routing strategy.

---

## 🛠️ Tools & Technologies

| Layer          | Tools                                                                                       |
|----------------|----------------------------------------------------------------------------------------------|
| Infra          | Proxmox                                                                                    |
| Provisioning   | Terraform (bpg/proxmox provider; moduleized VM defs; provider aliases pve1, pve2)          |
| Config Mgmt    | Ansible (host bootstrap, per-host app maps, conditional restart/pull)                       |
| Containers     | Docker Compose (per-app in Docker/*)                                                        |
| Ingress & TLS  | Traefik v3 (Let’s Encrypt via Azure DNS; HTTP→HTTPS redirects)                              |
| Observability  | Prometheus, Grafana, cAdvisor                                                               |
| CI/CD          | GitHub Actions (Terraform/Ansible workflows, updates)                                       |

---

## 🌍 Domains & Routing

- Core zones: docker-1.gwebs.ca, docker-2.gwebs.ca (and app subdomains).
- TLS: Certificates via ACME DNS-01 (Azure DNS), persisted under /Apps/Traefik/letsencrypt.

---

## 🔁 High-level Data Flows

```text
Client ──TLS──► Traefik ──► Docker services (or K8s ingress) ──► App containers
             
Media apps ──CIFS──► NAS-1 share (//192.168.10.12/Medias)

Exporters (cAdvisor/Traefik) ──► Prometheus ──► Grafana
```

