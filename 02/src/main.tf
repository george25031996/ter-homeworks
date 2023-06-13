resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image
}

resource "yandex_compute_instance" "platform" {
  name        = local.name5
  platform_id = var.vm_web_compute_instance
  resources {
    cores = var.vm_web_resources["cpu"]
    memory = var.vm_web_resources["ram"]
    core_fraction = var.vm_web_resources["fraction"]
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_web_compute_instance_scheduling_policy_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_web_compute_instance_network_interface_nat
  }
  metadata = var.wm_metadata["metadata"]
}

resource "yandex_compute_instance" "wm_db" {
  name        = local.name6
  platform_id = var.vm_db_compute_instance
  
  resources {
    cores = var.vm_db_resources["cpu"]
    memory = var.vm_db_resources["ram"]
    core_fraction = var.vm_db_resources["fraction"]
    }
    boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_db_compute_instance_scheduling_policy_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_db_compute_instance_network_interface_nat
  }
  metadata = var.wm_metadata["metadata"]
}

