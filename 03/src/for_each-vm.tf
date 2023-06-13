variable "vm_for_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "yandex_compute_image"
}


variable "vm_for_compute_instance" {
  type        = string
  default     = "standard-v1"
  description = "yandex_compute_instance2"
}

variable "vm_for_compute_instance_scheduling_policy_preemptible" {
  type        = bool
  default     = true
  description = "compute_instance_scheduling_policy_preemptible"
}

variable "vm_for_compute_instance_network_interface_nat" {
  type        = bool
  default     = true
  description = "compute_instance_network_interface_nat"
}

variable "vm_for_compute_instance_metadata_serial-port-enable" {
  type        = number
  default     = 1
  description = "compute_instance_metadata_serial-port-enable"
}

variable "vm_for2_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "yandex_compute_image"
}


variable "vm_for2_compute_instance" {
  type        = string
  default     = "standard-v1"
  description = "yandex_compute_instance2"
}

variable "vm_for2_compute_instance_scheduling_policy_preemptible" {
  type        = bool
  default     = true
  description = "compute_instance_scheduling_policy_preemptible"
}

variable "vm_for2_compute_instance_network_interface_nat" {
  type        = bool
  default     = true
  description = "compute_instance_network_interface_nat"
}

variable "vm_for2_compute_instance_metadata_serial-port-enable" {
  type        = number
  default     = 1
  description = "compute_instance_metadata_serial-port-enable"
}

variable "vm_configurations" {
  type = list(object({
    vm_name = string
    cpu     = number
    ram     = number
    disk    = number
  }))
  default = [
    {
      vm_name = "main"
      cpu     = 2
      ram     = 4
      disk    = 5
    },
    {
      vm_name = "replica"
      cpu     = 4
      ram     = 8
      disk    = 6
    }
  ]
}

resource "yandex_compute_instance" "work2" {
  for_each    = { for vm in var.vm_configurations : vm.vm_name => vm }
  name        = each.value.vm_name
  platform_id = var.vm_for_compute_instance
  resources {
    cores  = each.value.cpu
    memory = each.value.ram
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = "network-hdd"
      size     = each.value.disk
    }
  }
  scheduling_policy {
    preemptible = var.vm_for_compute_instance_scheduling_policy_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_for_compute_instance_network_interface_nat
  }
  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${local.ssh_public_key}"
  }
  depends_on = [yandex_compute_instance.web]
}