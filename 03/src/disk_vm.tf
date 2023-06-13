resource "yandex_compute_disk" "disk2" {
  count      = 3
  name       = "disk2-${count.index + 3}"
  type       = "network-hdd"
  zone       = "ru-central1-a"
  size       = 1
  block_size = 4096
}

resource "yandex_compute_instance" "storage" {
  name        = "storage"
  platform_id = var.vm_for_compute_instance
  resources {
    cores  = 2
    memory = 2
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type = "network-hdd"
      size = 5
    }
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.disk2
    content {
        disk_id = secondary_disk.value.id
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
  depends_on = [ yandex_compute_instance.work2 ]
}
 