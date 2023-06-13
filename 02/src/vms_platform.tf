variable "vm_db_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "yandex_compute_image"
}

variable "vm_db_compute_instance" {
  type        = string
  default     = "standard-v1"
  description = "yandex_compute_instance2"
}

variable "vm_db_compute_instance_scheduling_policy_preemptible" {
  type        = bool
  default     = true
  description = "compute_instance_scheduling_policy_preemptible"
}

variable "vm_db_compute_instance_network_interface_nat" {
  type        = bool
  default     = true
  description = "compute_instance_network_interface_nat"
}

variable "vm_db_compute_instance_metadata_serial-port-enable" {
  type        = number
  default     = 1
  description = "compute_instance_metadata_serial-port-enable"
}

variable "name3" {
  type        = string
  default     = "netology-develop" 
}

variable "name4" {
  type        = string
  default     = "platform-db" 
}

variable "vm_db_resources" {
type=map
default= {
cpu =2
ram = 2
fraction = 20
}
}