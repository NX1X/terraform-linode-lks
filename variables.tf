variable "linode_token" {
  description = "Your Linode API token"
  type        = string
}

variable "region" {
  description = "The region where resources will be created"
  type        = string
  default     = "fr-par"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = list(string)
  default     = ["dev"]
}
