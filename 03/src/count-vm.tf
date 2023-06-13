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

resource "yandex_compute_instance" "web" {
  name        = "web-${count.index + 1}"
  platform_id = "standard-v1"
  
  count = 2

  resources {
    cores  = 2
    memory = 1
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type = "network-hdd"
      size = 5
    }   
  }

  metadata = {
    ssh-keys = "ubuntu:${local.ssh_public_key}"
  }

  scheduling_policy { preemptible = true }

  network_interface { 
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [
      yandex_vpc_security_group.example.id 
    ]
  }
  allow_stopping_for_update = true
}