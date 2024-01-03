

variable "project" {
  type = string
}
variable "region" {
  type = string
}
variable "zone" {
  type = string
}
variable "google_credentials" {
  type = string
}
variable "logging-bucket" {
  type = string
}
variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "origin" {
  type = list
}
variable "method" {
  type = list
}
