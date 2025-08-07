terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
    }
  }
}




provider "proxmox" {
  alias     = "pve1"
  endpoint  = var.pve1_api_url
  api_token = var.pve1_api_token
}



provider "proxmox" {
  alias     = "pve2"
  endpoint  = var.pve2_api_url
  api_token = var.pve2_api_token
}