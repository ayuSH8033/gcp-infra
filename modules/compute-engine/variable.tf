
variable "project" {
  type = string
}
variable "region" {
  type = string
}
variable "zone" {
  type = string
}
variable "ip_condition" {
  type = bool
}

variable "net_name" {
  type = string
}
variable "serial_port_condition" {
  type = bool
}

variable "os_login" {
  type = bool
}

variable "source_ranges" {
  type = list
}



variable "name" {
  type = string
}
variable "firewall-name" {
  type = string
}
variable "machine_type" {
  type = string
}
variable "protocol" {
  type = string
}

variable "ports" {
  type = list
}

variable "subnet_name" {
  type = string
}
variable "ip_cidr_range" {
  type = string
}
variable "image" {
  type = string
}