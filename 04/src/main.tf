terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=0.13"
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}

#создаем облачную сеть
/*resource "yandex_vpc_network" "develop" {
  name = "develop"
}*/


/*module "vpc" {
  source              = "git@github.com:terraform-yc-modules/terraform-yc-vpc.git"
  network_name        = "develop"
  network_description = "Test network created with module"
  private_subnets = [{
    name           = "develop-ru-central1-a"
    zone           = "ru-central1-a"
    v4_cidr_blocks = ["10.0.1.0/24"]
  }
  ]
}
*/

module "vpc_dev" {
  source       = "./vpc"
  env_name     = "develop"
  zone = "ru-central1-a"
  cidr = ["10.0.1.0/24"]
}

#создаем подсеть
/*resource "yandex_vpc_subnet" "develop" {
  name           = "develop-ru-central1-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.1.0/24"]
}*/

module "test-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "develop"
  network_id     = module.vpc_dev.network_id
  subnet_zones   = ["ru-central1-a"]
  subnet_ids     = [module.vpc_dev.subnet_id]
  instance_name  = "web"
  instance_count = 2
  image_family   = "ubuntu-2004-lts"
  public_ip      = true
  metadata = {
    user-data = data.template_file.userdata.rendered
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${local.ssh_public_key}"
  }
}





