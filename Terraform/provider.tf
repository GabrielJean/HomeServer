provider "proxmox" {
  endpoint  = var.pm_api_url
  username  = var.pm_user
  password  = var.pm_password
  insecure  = true
}
