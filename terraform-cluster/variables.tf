variable "credentials" {
  type        = string
  description = "The path to the Google Cloud Platform credentials file (in JSON format) to use."
}

variable "project" {
  type        = string
  description = "The Google Cloud Platform project to deploy the Nomad cluster in."
}

variable "region" {
  type = string
}

variable "zone" {
  type = string
}

variable "name" {
  type = string
}

variable "allowlist_ip" {
  type = string
}

variable "manager_instance_type" {
  description = "The compute engine instance type to use for servers."
  default     = "e2-micro"
}

variable "worker_instance_type" {
  description = "The compute engine instance type to use for clients."
  default     = "e2-micro"
}

variable "manager_count" {
  description = "The number of manager to provision."
  default     = "3"
}

variable "worker_count" {
  description = "The number of workers to provision."
  default     = "3"
}

variable "root_block_device_size" {
  description = "The volume size of the root block device."
  default     = 20
}

variable "machine_image" {
  description = "The compute image to use for the server and client machines. Output from the Packer build process."
}

variable "user" {
  type = string
}

variable "privateKeyPath" {
  type = string
}

variable "publicKeyPath" {
  type = string
}
