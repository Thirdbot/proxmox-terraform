terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.88.0"
    }
  }
}

provider "proxmox" {
  endpoint = "https://10.0.22.165:8006/"
  api_token = "terraform@pve!provider=934de98a-980e-4ba3-a09e-ea48ea7104ad"
  insecure = true

  ssh {
    agent = true
    username = "root"
    password = var.proxmox_password
  }
}