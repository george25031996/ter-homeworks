output "vm_external_ip_address" {
 value = tomap({
   "yandex_compute_instance.platform" = yandex_compute_instance.platform.network_interface.0.nat_ip_address,
    "yandex_compute_instance.wm_db" = yandex_compute_instance.wm_db.network_interface.0.nat_ip_address
 }
 )
 }
   

