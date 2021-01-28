

output "strapi_server_label" {
  value = digitalocean_droplet.strapi_server.name
}

output "strapi_server_price_monthly" {
  value = digitalocean_droplet.strapi_server.price_monthly
}

output "strapi_server_public_ip" {
  value = digitalocean_droplet.strapi_server.ipv4_address
}

output "strapi_server_private_ip" {
  value = digitalocean_droplet.strapi_server.ipv4_address_private
}

output "strapi_database_label" {
  value = digitalocean_droplet.strapi_database.name
}

output "strapi_database_price_monthly" {
  value = digitalocean_droplet.strapi_database.price_monthly
}

output "strapi_database_public_ip" {
  value = digitalocean_droplet.strapi_database.ipv4_address
}

output "strapi_database_private_ip" {
  value = digitalocean_droplet.strapi_database.ipv4_address_private
}

### The Ansible inventory file
resource "local_file" "AnsibleInventory" {
  content = templatefile("templates/inventory.tmpl",
    {
      strapi-label   = digitalocean_droplet.strapi_server.name,
      strapi-id      = digitalocean_droplet.strapi_server.id,
      strapi-ip      = digitalocean_droplet.strapi_server.ipv4_address,
      database-label = digitalocean_droplet.strapi_database.name,
      database-id    = digitalocean_droplet.strapi_database.id,
      database-ip    = digitalocean_droplet.strapi_database.ipv4_address,
    }
  )
  filename = "../ansible/inventory"
}

### Output vars for Ansible
resource "local_file" "Ansible_All_SSH" {
  content = templatefile("templates/ansible_tf_vars.tmpl",
    {
      public-ssh-key  = var.ssh_key
      db-name         = trimsuffix(digitalocean_droplet.strapi_database.name, "-db")
      db-ip           = digitalocean_droplet.strapi_database.ipv4_address_private
      strapi-app-name = digitalocean_droplet.strapi_server.name
      strapi-url      = element(cloudflare_record.strapi_api_a.*.hostname, 0)
    }
  )
  filename = "../ansible/tf_vars/tf_vars.yml"
}
