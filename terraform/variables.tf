variable "do_api_key" {
  type        = string
  description = "DO API key."
}

variable "ssh_key" {
  type        = string
  description = "The new SSH key you generated with ssh-keygen."
}

variable "ssh_key_id" {
  type        = string
  description = "Existing SSH key already in DO."
}

variable "region" {
  type        = string
  description = "The physical location of the resources."
  default     = "sfo2"
}

variable "cloudflare_enabled" {
  type        = bool
  description = "Define if Cloudflare records should be created."
  default     = false
}

variable "cloudflare_email" {
  type        = string
  description = "Email Address used for Cloudflare account."
  default     = "test@test.com"
}

variable "cloudflare_api_key" {
  type        = string
  description = "Cloudflare API Key used to create DNS records."
  default     = "12345abc"
}

variable "cloudflare_zone_id" {
  type        = string
  description = "Cloudflare Zone ID to use for record creation."
  default     = ""
}

variable "strapi_srv_domain" {
  type        = string
  description = "Subdomain used for the Strapi Server."
  default     = "api"
}

variable "instance_os" {
  type        = string
  description = "The Operating system installed on the servers."
  default     = "72067660"
}

variable "instance_tag" {
  type        = string
  description = "Tag assigned to the instances."
  default     = "strapi"
}

variable "strapi_size" {
  type        = string
  description = "The size of the DO strapi instance"
  default     = "s-1vcpu-2gb"
}

variable "strapi_label" {
  type        = string
  description = "The label assigned to the strapi instance"
  default     = "my-strapi-srv"
}

variable "strapi_ipv6" {
  type        = bool
  description = "Enable IPv6 on the strapi instance"
  default     = false
}

variable "strapi_backups" {
  type        = bool
  description = "Enable auto backup on the database instance, warning this cost 4$ per month"
  default     = false
}

variable "database_size" {
  type        = string
  description = "The size of the DO database instance"
  default     = "s-2vcpu-4gb"
}

variable "database_label" {
  type        = string
  description = "The label assigned to the database instance"
  default     = "my-strapi-db"
}

variable "database_backups" {
  type        = bool
  description = "Enable auto backup on the database instance, warning this cost 4$ per month"
  default     = false
}
