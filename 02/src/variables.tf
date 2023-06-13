###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

variable "vm_web_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "yandex_compute_image"
}

variable "vm_web_compute_instance" {
  type        = string 
  default     = "standard-v1"
  description = "yandex_compute_instance"
}
variable "vm_web_compute_instance_scheduling_policy_preemptible" {
  type        = bool
  default     = true
  description = "compute_instance_scheduling_policy_preemptible"
}

variable "vm_web_compute_instance_network_interface_nat" {
  type        = bool
  default     = true
  description = "compute_instance_network_interface_nat"
}

variable "wm_metadata" {
  type = map(object({
    serial-port-enable = number
    ssh-keys = string 
  }))
  default = {
    "metadata" = {
      serial-port-enable = 1
      ssh-keys = ""
    }
  }
}

variable "name1" {
  type        = string
  default     = "netology-develop" 
}

variable "name2" {
  type        = string
  default     = "platform-web" 
}

variable "vm_web_resources" {
type=map
default= {
cpu =2
ram = 4
fraction = 5
}
}
