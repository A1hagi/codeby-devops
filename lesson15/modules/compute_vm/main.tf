terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

variable "vm_name" {
  type    = string
  default = "lesson15-vm"
}

variable "zone" {
  type        = string
  description = "Зона доступности, где создавать ВМ"
}

variable "subnet_map" {
  # Теперь тип переменной — карта списков строк
  type        = map(list(string))
  description = "Карта подсетей из первого модуля { зона = [id_подсетей] }"
}

data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts"
}

resource "yandex_compute_instance" "vm" {
  name        = var.vm_name
  zone        = var.zone
  platform_id = "standard-v1"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
    }
  }

  network_interface {
    # Автоматически берем первую подсеть [0] для указанной зоны
    subnet_id = lookup(var.subnet_map, var.zone)[0]
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("C:/Users/User/.ssh/id_rsa.pub")}"
  }
}
