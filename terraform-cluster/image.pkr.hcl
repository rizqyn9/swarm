locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

variable "project" {
  type = string
}

variable "zone" {
  type = string
}

source "googlecompute" "build" {
  image_name   = "docker-swarm-${local.timestamp}"
  project_id   = var.project
  source_image = "ubuntu-2004-focal-v20230724"
  ssh_username = "packer"
  zone         = var.zone
}

build {
  sources = ["sources.googlecompute.build"]

  provisioner "shell" {
    script           = "./scripts/setup.sh"
  }
}