variable "location" { default = "East US" }
variable "rg_name"  { default = "rg-aks-gitops" }
variable "aks_name" { default = "aks-gitops" }
variable "acr_name" {
  description = "ACR name must be globally unique and 5-50 characters, only letters and numbers."
  default     = "acrgitopsdemo12345"
}
variable "node_count" { default = 2 }
variable "node_size"  { default = "Standard_B2ms" }
variable "log_analytics_workspace_name" { default = "log-aks-gitops" }
