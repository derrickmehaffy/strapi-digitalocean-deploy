###################
# Global Settings #
###################
# DO API Key
#do_api_key = "your-do-key"

# If you already have an SSH key on DO
# you can use the same public key and it will not be duplicated
#ssh_key = "ssh-rsa somekey user@host"

# WIP don't use yet
#ssh_key_id = "12345"

# See the following API for Regions: https://developers.digitalocean.com/documentation/v2/#list-all-regions
region = "sfo2" # San Francisco, CA USA

#######################
# Cloudflare Settings #
#######################
# Cloudflare is disabled by default
# you can enable it and set the settings below
cloudflare_enabled = true
cloudflare_email   = "user@example.com"
cloudflare_api_key = "your-api-key"
cloudflare_zone_id = "your-zone-id"
strapi_srv_domain  = "api-test"

#####################
# Instance Settings #
#####################

# See the following API for OS options: https://developers.digitalocean.com/documentation/v2/#list-all-distribution-images
instance_os  = "72067660" # Ubuntu 20.04 LTS x64
instance_tag = "strapi"

##############################
# Strapi App Server Settings #
##############################

# See the following API for Sizes: https://developers.digitalocean.com/documentation/v2/#list-all-sizes
strapi_size    = "s-1vcpu-2gb" # Cost ~10$/month
strapi_label   = "my-strapi-srv"
strapi_ipv6    = false
strapi_backups = false

###################################
# Strapi Database Server Settings #
###################################

# See the following API for Sizes: https://developers.digitalocean.com/documentation/v2/#list-all-sizes
database_size    = "s-2vcpu-4gb" # Cost ~20$/month
database_label   = "my-strapi-db"
database_backups = false
