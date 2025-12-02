#source https://registry.terraform.io/providers/bpg/proxmox/latest/docs/guides/cloud-init

data "local_file" "ssh_public_key" {
  filename = "ssh/ssh-key.pub"
}

resource "proxmox_virtual_environment_file" "user_data_cloud_config" {
  content_type = "snippets"
  datastore_id = "local"
  # machine name
  node_name    = "acervn4640"

  source_raw {
    data = <<-EOF
    #cloud-config
    hostname: test-ubuntu
    timezone: America/Toronto
    users:
      - default
      - name: ubuntu
        groups:
          - sudo
        shell: /bin/bash
        ssh_authorized_keys:
          - ${file("ssh/ssh-key.pub")}
        sudo: ALL=(ALL) NOPASSWD:ALL
    package_update: true
    packages:
      - qemu-guest-agent
      - net-tools
      - curl
    runcmd:
      - systemctl enable qemu-guest-agent
      - systemctl start qemu-guest-agent
      - echo "done" > /tmp/cloud-config.done
    EOF

    file_name = "user-data-cloud-config.yaml"
  }
}