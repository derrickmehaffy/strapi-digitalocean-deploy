terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.4.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "2.14.0"
    }
  }
}

# Configure the DO Provider
provider "digitalocean" {
  token = var.do_api_key
}

# Configure Cloudflare
provider "cloudflare" {
  email   = var.cloudflare_email
  api_key = var.cloudflare_api_key
}

resource "cloudflare_record" "strapi_api_a" {
  count   = var.cloudflare_enabled ? 1 : 0
  zone_id = var.cloudflare_zone_id
  name    = var.strapi_srv_domain
  value   = digitalocean_droplet.strapi_server.ipv4_address
  type    = "A"
  ttl     = "1"
  proxied = false
}

# # DO SSH Key
# resource "digitalocean_ssh_key" "strapi_ssh_key" {
#   name       = "strapi-ssh-key"
#   public_key = var.ssh_key
# }

# DO Firewall Rules
resource "digitalocean_firewall" "server" {
  name = "Strapi-Server-Rules"

  droplet_ids = [digitalocean_droplet.strapi_server.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "1337"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "icmp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

resource "digitalocean_firewall" "database" {
  name = "Strapi-Database-Rules"

  droplet_ids = [digitalocean_droplet.strapi_database.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "3306"
    source_addresses = [digitalocean_droplet.strapi_server.ipv4_address_private]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "icmp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

# DO Strapi Server Instance
resource "digitalocean_droplet" "strapi_server" {
  size               = var.strapi_size
  region             = var.region
  image              = var.instance_os
  name               = var.strapi_label
  tags               = [var.instance_tag]
  ipv6               = var.strapi_ipv6
  private_networking = true
  monitoring         = true
  backups            = var.strapi_backups
  ssh_keys           = [var.ssh_key_id]
}

# DO Strapi Database Instance
resource "digitalocean_droplet" "strapi_database" {
  size               = var.database_size
  region             = var.region
  image              = var.instance_os
  name               = var.database_label
  tags               = [var.instance_tag]
  private_networking = true
  monitoring         = true
  backups            = var.database_backups
  ssh_keys           = [var.ssh_key_id]
}
