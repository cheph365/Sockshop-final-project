# Define input variables
variable "node_count" {
  description = "Number of nodes in the Kubernetes cluster"
  type        = number
  # You can set a default value if needed
  default = 2
}

variable "username" {
  description = "Username for the Kubernetes cluster nodes"
  type        = string
  # You can set a default value if needed
  default = "azureadmin"
}
variable "location" {
  type    = string 
  default = "West Europe"    
}