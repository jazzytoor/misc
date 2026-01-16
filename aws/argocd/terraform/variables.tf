variable "service" {
  type = string
}

variable "region" {
  type = string
}

variable "domain" {
  type = string
}

variable "sso" {
  type      = map(string)
  sensitive = true
}
