variable "azure_storage_account_name" {
  description = "Azure Storage Account Name for Terraform backend"
  type        = string
}

variable "azure_storage_account_key" {
  description = "Azure Storage Account Key for Terraform backend"
  type        = string
  sensitive   = true
}

variable "azure_resource_group_name" {
  description = "Azure Resource Group Name for Terraform backend"
  type        = string
}

variable "azure_storage_container_name" {
  description = "Azure Storage Container Name for Terraform backend"
  type        = string
}

variable "azure_backend_key" {
  description = "Azure backend state file key (blob name)"
  type        = string
  default     = "terraform.tfstate"
}
variable "pm_api_url" {
  description = "Proxmox API URL (e.g. https://proxmox.example.com:8006/api2/json)"
  type        = string
}

variable "pm_user" {
  description = "Proxmox username (e.g. root@pam)"
  type        = string
}

variable "pm_password" {
  description = "Proxmox password"
  type        = string
  sensitive   = true
}

variable "pm_node1" {
  description = "First Proxmox node (main node, e.g. proxmox1)"
  type        = string
}

# variable "pm_node2" {
#   description = "Second Proxmox node (edge node, e.g. proxmox2)"
#   type        = string
# }

variable "template_name" {
  description = "Name of the VM template to clone from"
  type        = string
  default     = "Ubuntu-Cloud"
}

variable "ssh_public_key" {
  description = "Path to SSH public key for cloud-init user"
  type        = string
}

variable "ci_user" {
  description = "Cloud-init username for the VM"
  type        = string
  default     = "gabriel"
}
