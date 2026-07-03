terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

variable "network_id" {
  type        = string
  description = "ID целевой VPC сети"
}

data "yandex_vpc_subnet" "all" {
  for_each  = toset(["public-subnet", "private-subnet"])
  name      = each.value
}

output "subnet_zones" {
  value = {
    # Троеточие в конце собирает все ID подсетей одной зоны в список: { "ru-central1-a" = ["id1", "id2"] }
    for s in data.yandex_vpc_subnet.all : s.zone => s.id...
  }
}
