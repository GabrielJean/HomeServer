
variable "pve1_api_url" {
  description = "Proxmox API URL for node 1"
  type        = string
}

variable "pve1_api_token" {
  description = "Proxmox API token for node 1 (format: terraform@pve!provider=token)"
  type        = string
  sensitive   = true
}

variable "pve2_api_url" {
  description = "Proxmox API URL for node 2"
  type        = string
}

variable "pve2_api_token" {
  description = "Proxmox API token for node 2 (format: terraform@pve!provider=token)"
  type        = string
  sensitive   = true
}