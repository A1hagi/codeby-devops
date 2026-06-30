terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  cloud_id  = "b1grumhjdv0ph8u3e3ca"
  folder_id = "b1g50h1q6v515sut35sd"
  zone      = "ru-central1-a"
}

# 1. Вызываем модуль данных (укажите ID вашей сети из lesson14)
module "network_info" {
  source     = "./modules/subnet_data"
  network_id = "enpqpu8caa7q9do8t21i" 
}

# 2. Вызываем модуль создания ВМ в зоне А
module "vm_in_zone_a" {
  source     = "./modules/compute_vm"
  vm_name    = "auto-vm-zone-a"
  zone       = "ru-central1-a"
  subnet_map = module.network_info.subnet_zones # Передаем карту подсетей
}
